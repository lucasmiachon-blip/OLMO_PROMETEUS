param(
  [ValidateSet("check", "report", "json", "next")]
  [string]$Mode = "check",
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $Root

$Sources = @(
  "https://cmmiinstitute.com/learning/appraisals/levels",
  "https://www.isaca.org/enterprise/cmmi-performance-solutions",
  "https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions",
  "https://docs.github.com/articles/types-of-required-status-checks",
  "https://openssf.org/projects/scorecard/",
  "https://owasp.org/www-project-samm/"
)

$Levels = @(
  [pscustomobject]@{ Level = 0; Name = "Incomplete"; Intent = "Trabalho pode ou nao terminar; nao ha contrato, evidencia ou dono claro." }
  [pscustomobject]@{ Level = 1; Name = "Initial"; Intent = "Funciona por esforco individual, conversa e reatividade. Resultado depende do operador." }
  [pscustomobject]@{ Level = 2; Name = "Managed"; Intent = "Trabalho e planejado, executado, medido e controlado por projeto. Ha harness, backlog, risco, evidencia e rollback." }
  [pscustomobject]@{ Level = 3; Name = "Defined"; Intent = "Processo padronizado e reutilizavel. Procedures, templates, DoD, DoR e arquitetura sao claros e usados de modo consistente." }
  [pscustomobject]@{ Level = 4; Name = "Quantitatively Managed"; Intent = "Qualidade e previsibilidade sao geridas por numeros: lead time, falha de harness, retrabalho, incidentes e cobertura de risco." }
  [pscustomobject]@{ Level = 5; Name = "Optimizing"; Intent = "O sistema melhora continuamente com retros, experimentos controlados e remocao ativa de desperdicio." }
)

$Areas = @(
  [pscustomobject]@{
    Area = "Fronteira e isolamento"
    Current = 3
    Target = 3
    Gap = "Forte para um laboratorio, mas ainda depende de leitura humana dos contratos."
    ProfessionalAction = "Manter harness e branch protection para impedir bypass acidental."
    Evidence = @("AGENTS.md", "PROJECT_CONTRACT.md", "scripts/check.ps1")
  }
  [pscustomobject]@{
    Area = "Git e remoto"
    Current = 2
    Target = 3
    Gap = "Remote existe e commits sao pequenos, mas nao ha CI ou protecao de main."
    ProfessionalAction = "Rodar harness no GitHub Actions e proteger main com check obrigatorio."
    Evidence = @(".git", "scripts/check.ps1")
  }
  [pscustomobject]@{
    Area = "Backlog e planejamento"
    Current = 1
    Target = 2
    Gap = "Trabalho nasce em conversa; nao ha fila priorizada, aceite ou dono por item."
    ProfessionalAction = "Criar backlog minimo com prioridade, risco, aceite, dono e batch."
    Evidence = @("shadow/EVIDENCE-LOG.md")
  }
  [pscustomobject]@{
    Area = "Requisitos e aceite"
    Current = 1
    Target = 2
    Gap = "Muitos artefatos dizem o que fazer, poucos dizem como aceitar ou rejeitar."
    ProfessionalAction = "Adicionar Definition of Ready e Definition of Done por batch/procedure."
    Evidence = @("shadow/WORK-LANES.md")
  }
  [pscustomobject]@{
    Area = "Qualidade"
    Current = 2
    Target = 3
    Gap = "Harness local e bom, mas nao existe garantia remota nem politica de review."
    ProfessionalAction = "CI, diff review antes de push grande e checks por tipo de arquivo."
    Evidence = @("scripts/check.ps1")
  }
  [pscustomobject]@{
    Area = "Seguranca e privacidade medica"
    Current = 1
    Target = 3
    Gap = "Ha politica de nao usar dados sensiveis, mas nao ha classificacao de dados, threat model ou incident log."
    ProfessionalAction = "Criar data-classification, PHI checklist, threat model e incident log."
    Evidence = @("AGENTS.md")
  }
  [pscustomobject]@{
    Area = "Release e mudanca"
    Current = 1
    Target = 2
    Gap = "Nao ha changelog, versao, release note ou criterio para pronto para usar."
    ProfessionalAction = "Criar CHANGELOG.md simples e regra de release local."
    Evidence = @("git")
  }
  [pscustomobject]@{
    Area = "Documentacao"
    Current = 2
    Target = 3
    Gap = "Boa cobertura, mas SOTA-DECISIONS.md ja gera warning de sprawl."
    ProfessionalAction = "Criar indice/arquivo de arquivo morto e dividir decisoes antigas sem perder busca."
    Evidence = @("shadow/SOTA-DECISIONS.md", "shadow/HYGIENE.md")
  }
  [pscustomobject]@{
    Area = "Arquitetura"
    Current = 1
    Target = 3
    Gap = "Ha mapa de arvore, mas nao ha visao C4/ADR curta de componentes e fluxos."
    ProfessionalAction = "Criar architecture note com componentes, inputs, outputs, riscos e invariantes."
    Evidence = @("TREE.md")
  }
  [pscustomobject]@{
    Area = "Produto e valor"
    Current = 1
    Target = 2
    Gap = "O repo prova estrutura, mas pouco mede valor para o medico solo dev."
    ProfessionalAction = "Definir outcome mensal: tempo economizado, risco reduzido, decisoes melhores."
    Evidence = @("shadow/EVIDENCE-LOG.md")
  }
)

$Batches = @(
  [pscustomobject]@{
    Batch = 0
    Status = "applied"
    Target = "L1 -> L2"
    Action = "Criar maturity executable e tornar gap verificavel."
    Acceptance = @("scripts/maturity.ps1 existe", "scripts/check.ps1 executa maturity check", "shadow/MATURITY-GAPS.md nao existe")
    Justification = "Sem policy-as-code, maturidade vira opiniao."
    NegativeCriterion = "Se o script nao for chamado pelo harness, a camada volta a ser aspiracional."
  }
  [pscustomobject]@{
    Batch = 1
    Status = "applied"
    Target = "L2 Managed"
    Action = "Criar estrutura interna self-evolving: backlog, risk register, DoR/DoD e weekly review."
    Acceptance = @("internal/evolution/backlog.json existe", "internal/evolution/risk-register.json existe", "internal/evolution/review.json existe", "scripts/evolve.ps1 valida a estrutura")
    Justification = "Maior gap: trabalho nasce em chat, nao em fila controlada."
    NegativeCriterion = "Se nao houver uso em 2 semanas, reduzir para checklist menor."
  }
  [pscustomobject]@{
    Batch = 2
    Status = "next"
    Target = "L2 Managed"
    Action = "Fechar self-evolution remoto: validar workflow read-only e decidir branch protection de main."
    Acceptance = @(".github/workflows/self-evolution.yml existe", "harness roda em push, pull_request, schedule e workflow_dispatch", "branch protection documentada ou aplicada")
    Justification = "Sem CI, qualidade depende de lembrar de rodar harness."
    NegativeCriterion = "Se CI exigir segredo ou fragilizar Windows paths, manter local e documentar bloqueio."
  }
  [pscustomobject]@{
    Batch = 3
    Status = "planned"
    Target = "L2 -> L3"
    Action = "Criar data-classification, PHI checklist, threat model e incident log."
    Acceptance = @("classes de dado existem", "PHI checklist existe", "threat model existe", "incident log existe")
    Justification = "Projeto de medico precisa privacidade operacional, nao so regra textual."
    NegativeCriterion = "Se nenhum fluxo tocar saude ou dado sensivel, manter checklist minimo."
  }
  [pscustomobject]@{
    Batch = 4
    Status = "planned"
    Target = "L3 Defined"
    Action = "Criar arquitetura curta, ADR index e decompor SOTA-DECISIONS.md."
    Acceptance = @("architecture note existe", "ADR index existe", "SOTA sprawl reduzido")
    Justification = "Reduz sprawl e torna decisao rastreavel."
    NegativeCriterion = "Se aumentar arquivo total sem melhorar busca, reverter."
  }
)

function Test-RepoPath {
  param([string]$Path)
  if ($Path -eq "git") {
    return (Test-Path -LiteralPath ".git" -PathType Container)
  }
  return (Test-Path -LiteralPath $Path)
}

function Get-State {
  $missingEvidence = New-Object System.Collections.Generic.List[string]
  foreach ($area in $Areas) {
    foreach ($path in $area.Evidence) {
      if (-not (Test-RepoPath $path)) {
        $missingEvidence.Add("$($area.Area): $path") | Out-Null
      }
    }
  }

  $failures = New-Object System.Collections.Generic.List[string]
  if ((Split-Path -Leaf $Root) -ne "OLMO_PROMETEUS") { $failures.Add("unexpected repo root: $Root") | Out-Null }
  if (Test-Path -LiteralPath "shadow/MATURITY-GAPS.md") { $failures.Add("maturity layers must be executable; remove shadow/MATURITY-GAPS.md") | Out-Null }
  if (-not (Test-Path -LiteralPath "scripts/maturity.ps1" -PathType Leaf)) { $failures.Add("missing scripts/maturity.ps1") | Out-Null }
  if ((Test-Path -LiteralPath "scripts/check.ps1" -PathType Leaf) -and ((Get-Content -LiteralPath "scripts/check.ps1" -Raw) -notmatch "maturity\.ps1")) {
    $failures.Add("scripts/check.ps1 must execute scripts/maturity.ps1") | Out-Null
  }
  foreach ($requiredEvolutionFile in @("scripts/evolve.ps1", "internal/evolution/backlog.json", "internal/evolution/risk-register.json", "internal/evolution/review.json", ".github/workflows/self-evolution.yml")) {
    if (-not (Test-Path -LiteralPath $requiredEvolutionFile -PathType Leaf)) {
      $failures.Add("missing self-evolution file: $requiredEvolutionFile") | Out-Null
    }
  }
  if ($Levels.Count -ne 6) { $failures.Add("expected CMMI levels 0..5") | Out-Null }
  if (-not ($Batches | Where-Object { $_.Status -eq "next" })) { $failures.Add("no next maturity batch declared") | Out-Null }
  foreach ($batch in $Batches) {
    if (-not $batch.Acceptance -or $batch.Acceptance.Count -eq 0) { $failures.Add("batch $($batch.Batch) missing acceptance") | Out-Null }
    if ([string]::IsNullOrWhiteSpace($batch.NegativeCriterion)) { $failures.Add("batch $($batch.Batch) missing negative criterion") | Out-Null }
  }

  [pscustomobject]@{
    Sources = $Sources
    Levels = $Levels
    Areas = $Areas
    Batches = $Batches
    MissingEvidence = @($missingEvidence)
    Failures = @($failures)
  }
}

$State = Get-State

if ($Mode -eq "json") {
  $State | ConvertTo-Json -Depth 6
  exit 0
}

if ($Mode -eq "next") {
  $State.Batches | Where-Object { $_.Status -eq "next" } | Select-Object Batch, Target, Action, Acceptance, Justification, NegativeCriterion | Format-List
  exit 0
}

if ($Mode -eq "report") {
  Write-Host "Maturity baseline for OLMO_PROMETEUS"
  Write-Host ""
  $State.Areas | Sort-Object Current, Area | Format-Table Area, Current, Target, Gap -Wrap
  Write-Host ""
  $State.Batches | Format-Table Batch, Status, Target, Action -Wrap
  if ($State.MissingEvidence.Count -gt 0) {
    Write-Host ""
    Write-Host "Missing evidence:"
    $State.MissingEvidence | ForEach-Object { Write-Host "- $_" }
  }
  exit 0
}

foreach ($failure in $State.Failures) {
  Write-Host "[FAIL] $failure" -ForegroundColor Red
}

if ($State.MissingEvidence.Count -gt 0) {
  foreach ($missing in $State.MissingEvidence) {
    Write-Host "[WARN] missing evidence: $missing" -ForegroundColor Yellow
  }
}

if ($State.Failures.Count -gt 0) {
  Write-Host "Maturity check failed with $($State.Failures.Count) issue(s)." -ForegroundColor Red
  exit 1
}

Write-Host "[OK] maturity executable baseline passes" -ForegroundColor Green
exit 0
