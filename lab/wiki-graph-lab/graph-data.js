window.WIKI_GRAPH_DATA = {
  "generatedAt": "2026-04-24T00:06:38",
  "projectRoot": "C:/Dev/Projetos/OLMO_PROMETEUS/Prometeus",
  "nodeCount": 35,
  "linkCount": 157,
  "nodes": [
    {
      "id": "wiki-atlas-readme",
      "title": "Atlas",
      "domain": "Atlas",
      "kind": "guide",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Atlas/README.md",
      "tags": [
        "prometeus/atlas",
        "prometeus/graph"
      ],
      "aliases": [
        "atlas",
        "readme"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas"
      ],
      "pathLinks": [],
      "summary": "Espinha dorsal do second brain.",
      "teaser": "Espinha dorsal do second brain. O objetivo desta pasta e deixar o Graph View grande sem virar ruido. Cada nota duravel deve se conectar a pelo menos um atlas, mapa ou conceito. O Graph nao precisa ser pequeno; ele precisa ser legivel.",
      "markdown": "# Atlas\n\nEspinha dorsal do second brain.\n\nO objetivo desta pasta e deixar o Graph View grande sem virar ruido. Cada nota duravel deve se conectar a pelo menos um atlas, mapa ou conceito. O Graph nao precisa ser pequeno; ele precisa ser legivel.\n\nComece por [[Second Brain Atlas]].",
      "outgoing": 1,
      "incoming": 0,
      "degree": 1
    },
    {
      "id": "wiki-atlas-graph-operating-system",
      "title": "Graph Operating System",
      "domain": "Atlas",
      "kind": "topic",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Atlas/Graph Operating System.md",
      "tags": [
        "prometeus/atlas",
        "prometeus/graph"
      ],
      "aliases": [
        "graph-operating-system"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Promotion Gate",
        "Foundation Harness",
        "SOTA Dev Solo"
      ],
      "pathLinks": [],
      "summary": "O Graph View e o second brain visual. Ele deve crescer.",
      "teaser": "O Graph View e o second brain visual. Ele deve crescer. Abra no Obsidian:",
      "markdown": "# Graph Operating System\n\nO Graph View e o second brain visual. Ele deve crescer.\n\n## Configuracao alvo\n\n- Filtro: `path:wiki`.\n- Tags: ligado.\n- Anexos: desligado.\n- Arquivos existentes: ligado.\n- Orfaos: ligado; revisar periodicamente, sem esconder por estetica.\n- Groups: por pasta e por tag quando o volume justificar.\n\n## Abertura correta\n\nAbra no Obsidian:\n\n```text\nC:\\Dev\\Projetos\\OLMO_PROMETEUS\\Prometeus\n```\n\nNao abra `C:\\Dev\\Projetos\\OLMO_PROMETEUS` como vault. O repo e a caixa de seguranca; `Prometeus` e o vault.\n\n## Politica de crescimento\n\n- Nao esconder grafo para parecer limpo.\n- Conectar nota nova a um atlas, sistema ou conceito.\n- Criar MOC pequeno quando um cluster tiver mais de 7 notas.\n- Promover clipping apenas quando houver sintese ou decisao.\n- Usar Canvas para narrativas, nao para substituir o grafo.\n- Mudanca estrutural entra no grafo via [[SOTA Research Gate]], nao como pasta nova.\n- Ideia de agente entra primeiro como [[Agent Module Encapsulation]], nao como runtime.\n\n## Cores\n\n- `Atlas` e `Home`: dourado.\n- `Categories`: laranja.\n- `Notes`: verde-azulado.\n- `References`: azul.\n- `Templates`: cinza.\n- `Buffers`: amarelo.\n\n## Sinal de qualidade\n\nUm grafo grande esta saudavel quando existem hubs visiveis, clusters reconheciveis e poucos nos realmente sem destino.\n\nCluster atual esperado: [[SOTA Research Gate]], [[Agent Module Encapsulation]], [[Promotion Gate]], [[Foundation Harness]] e [[SOTA Dev Solo]].",
      "outgoing": 5,
      "incoming": 3,
      "degree": 8
    },
    {
      "id": "wiki-atlas-knowledge-lifecycle",
      "title": "Knowledge Lifecycle",
      "domain": "Atlas",
      "kind": "topic",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Atlas/Knowledge Lifecycle.md",
      "tags": [
        "prometeus/atlas",
        "prometeus/system"
      ],
      "aliases": [
        "knowledge-lifecycle"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Digest System",
        "Study Track System",
        "Artifact",
        "SOTA Research Gate",
        "Second Brain Atlas",
        "Prometeus Wiki",
        "Promotion Gate",
        "Candidate",
        "Project Log",
        "Evidence Log",
        "Agent Module Encapsulation",
        "Agent Usage Map",
        "Evidence Log",
        "Agent Usage Map"
      ],
      "pathLinks": [],
      "summary": "Fluxo minimo para transformar entrada em conhecimento.",
      "teaser": "Fluxo minimo para transformar entrada em conhecimento. Entrada bruta vem de email, estudo, pesquisa, conversa ou experimento.",
      "markdown": "# Knowledge Lifecycle\n\nFluxo minimo para transformar entrada em conhecimento.\n\n## 1. Captura\n\nEntrada bruta vem de email, estudo, pesquisa, conversa ou experimento.\n\nCasa preferida:\n\n- `private-learning/` para material pessoal ou bruto;\n- `wiki/Clippings/` para clipping local que ainda precisa limpeza.\n\n## 2. Sintese\n\nUma entrada vira nota quando ha aprendizado, decisao ou comportamento futuro.\n\nLinks:\n\n- [[Email Digest System]]\n- [[Study Track System]]\n- [[Artifact]]\n\nSe a entrada pede mudanca estrutural, ela passa antes por [[SOTA Research Gate]].\n\n## 3. Conexao\n\nToda nota duravel entra no Graph por pelo menos um hub:\n\n- [[Second Brain Atlas]]\n- [[Prometeus Wiki]]\n- um sistema vivo;\n- um conceito.\n\n## 4. Revisao\n\nSe a nota virou padrao reutilizavel:\n\n- [[Promotion Gate]]\n- [[Candidate]]\n- [[Project Log]]\n- registrar cada uso real em [[Evidence Log]] (gate quantitativo para `operational`).\n\n## 5. Modularizacao\n\nSe o padrao parece recorrente e poderia virar agente:\n\n- documentar primeiro como [[Agent Module Encapsulation]];\n- consultar [[Agent Usage Map]] para ver se um agente/skill global ja cobre a necessidade;\n- declarar input, output, estado, ferramentas, permissoes e eval;\n- manter como procedimento ate ter 3 usos reais em [[Evidence Log]];\n- promocao para skill real em `.claude/skills/<name>/` exige procedure `operational` (ver contrato em [[Agent Usage Map]]).",
      "outgoing": 12,
      "incoming": 3,
      "degree": 15
    },
    {
      "id": "wiki-atlas-second-brain-atlas",
      "title": "Second Brain Atlas",
      "domain": "Atlas",
      "kind": "topic",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Atlas/Second Brain Atlas.md",
      "tags": [
        "prometeus/atlas",
        "prometeus/graph"
      ],
      "aliases": [
        "second-brain-atlas"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Prometeus Wiki",
        "Graph Operating System",
        "Knowledge Lifecycle",
        "Prometeus.canvas",
        "Foundation Harness",
        "SOTA Research Gate",
        "Workspace Boundary",
        "Email Digest System",
        "Email Triage",
        "Study Track System",
        "Promotion Gate",
        "Evidence Log",
        "Agent Usage Map",
        "SOTA Dev Solo",
        "Agent Module Encapsulation",
        "Artifact",
        "Done",
        "Candidate",
        "Kepano and Karpathy Principles",
        "Clippings",
        "Daily",
        "Attachments",
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Promotion Gate",
        "Foundation Harness"
      ],
      "pathLinks": [],
      "summary": "Este e o mapa principal do second brain. O Graph View e a interface principal; Canvas e apenas uma vitrine curada.",
      "teaser": "Este e o mapa principal do second brain. O Graph View e a interface principal; Canvas e apenas uma vitrine curada. Toda nota nova deve responder:",
      "markdown": "# Second Brain Atlas\n\nEste e o mapa principal do second brain. O Graph View e a interface principal; Canvas e apenas uma vitrine curada.\n\n## Hubs\n\n- [[Prometeus Wiki]]\n- [[Graph Operating System]]\n- [[Knowledge Lifecycle]]\n- [[Prometeus.canvas]]\n\n## Sistemas vivos\n\n- [[Foundation Harness]]\n- [[SOTA Research Gate]]\n- [[Workspace Boundary]]\n- [[Email Digest System]]\n- [[Email Triage]]\n- [[Study Track System]]\n- [[Promotion Gate]]\n- [[Evidence Log]]\n- [[Agent Usage Map]]\n\n## Conceitos\n\n- [[SOTA Dev Solo]]\n- [[Agent Module Encapsulation]]\n- [[Artifact]]\n- [[Done]]\n- [[Candidate]]\n\n## Referencias\n\n- [[Kepano and Karpathy Principles]]\n\n## Buffers\n\n- [[Clippings]]\n- [[Daily]]\n- [[Attachments]]\n\n## Regra\n\nToda nota nova deve responder:\n\n- a qual hub ela se conecta;\n- qual problema ela reduz;\n- se ela e duravel, temporaria ou candidata;\n- qual link futuro ela cria.\n\n## Fronteira atual\n\nO cluster mais importante agora e agentes como modulos encapsulados:\n\n- [[SOTA Research Gate]] decide se a mudanca merece pesquisa e edicao.\n- [[Agent Module Encapsulation]] transforma entusiasmo por agente em contrato verificavel.\n- [[Promotion Gate]] decide se algo pode virar `candidate`.\n- [[Foundation Harness]] impede regressao mecanica.",
      "outgoing": 21,
      "incoming": 9,
      "degree": 30
    },
    {
      "id": "wiki-attachments-readme",
      "title": "Attachments",
      "domain": "Attachments",
      "kind": "guide",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Attachments/README.md",
      "tags": [
        "prometeus/buffer"
      ],
      "aliases": [
        "attachments",
        "readme"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas"
      ],
      "pathLinks": [],
      "summary": "Anexos locais do Obsidian.",
      "teaser": "Anexos locais do Obsidian. Esta pasta e ignorada pelo Git, exceto este README. Se um anexo virar evidencia do projeto, crie uma nota Markdown apontando para ele e decida explicitamente se deve ser versionado.",
      "markdown": "# Attachments\n\nAnexos locais do Obsidian.\n\nEsta pasta e ignorada pelo Git, exceto este README. Se um anexo virar evidencia do projeto, crie uma nota Markdown apontando para ele e decida explicitamente se deve ser versionado.\n\nLink: [[Second Brain Atlas]]",
      "outgoing": 1,
      "incoming": 2,
      "degree": 3
    },
    {
      "id": "wiki-categories-prometeus-wiki",
      "title": "Prometeus Wiki",
      "domain": "Categories",
      "kind": "index",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Categories/Prometeus Wiki.md",
      "tags": [
        "prometeus/category",
        "prometeus/graph"
      ],
      "aliases": [
        "prometeus-wiki"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas",
        "Graph Operating System",
        "Knowledge Lifecycle",
        "SOTA Research Gate",
        "Prometeus.canvas",
        "Foundation Harness",
        "Workspace Boundary",
        "Email Digest System",
        "Email Triage",
        "Study Track System",
        "Promotion Gate",
        "SOTA Dev Solo",
        "Agent Module Encapsulation",
        "Artifact",
        "Done",
        "Candidate",
        "Kepano and Karpathy Principles",
        "Clippings",
        "Daily",
        "Attachments",
        "Project Log",
        "Concept Note",
        "Decision Note",
        "Daily Note",
        "Email Digest"
      ],
      "pathLinks": [],
      "summary": "Mapa central do vault. Use como ponto de partida, nao como taxonomia obrigatoria.",
      "teaser": "Mapa central do vault. Use como ponto de partida, nao como taxonomia obrigatoria. Se uma nota nao merece link, provavelmente ainda e clipping ou rascunho.",
      "markdown": "# Prometeus Wiki\n\nMapa central do vault. Use como ponto de partida, nao como taxonomia obrigatoria.\n\n## Sistemas vivos\n\n- [[Second Brain Atlas]]\n- [[Graph Operating System]]\n- [[Knowledge Lifecycle]]\n- [[SOTA Research Gate]]\n- [[Prometeus.canvas]]\n- [[Foundation Harness]]\n- [[Workspace Boundary]]\n- [[Email Digest System]]\n- [[Email Triage]]\n- [[Study Track System]]\n- [[Promotion Gate]]\n\n## Conceitos\n\n- [[SOTA Dev Solo]]\n- [[Agent Module Encapsulation]]\n- [[Artifact]]\n- [[Done]]\n- [[Candidate]]\n\n## Referencias\n\n- [[Kepano and Karpathy Principles]]\n\n## Buffers\n\n- [[Clippings]]\n- [[Daily]]\n- [[Attachments]]\n\n## Log\n\n- [[Project Log]]\n\n## Templates\n\n- [[Concept Note]]\n- [[Decision Note]]\n- [[Daily Note]]\n- [[Email Digest]]\n\n## Regra\n\nSe uma nota nao merece link, provavelmente ainda e clipping ou rascunho.",
      "outgoing": 24,
      "incoming": 3,
      "degree": 27
    },
    {
      "id": "wiki-clippings-readme",
      "title": "Clippings",
      "domain": "Clippings",
      "kind": "guide",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Clippings/README.md",
      "tags": [
        "prometeus/buffer"
      ],
      "aliases": [
        "clippings",
        "readme"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas"
      ],
      "pathLinks": [],
      "summary": "Conteudo capturado de paginas, emails ou fontes externas.",
      "teaser": "Conteudo capturado de paginas, emails ou fontes externas. Esta pasta e ignorada pelo Git, exceto este README. Antes de promover para `wiki/Notes/` ou `wiki/References/`, limpe o conteudo, remova ruido e registre a fonte.",
      "markdown": "# Clippings\n\nConteudo capturado de paginas, emails ou fontes externas.\n\nEsta pasta e ignorada pelo Git, exceto este README. Antes de promover para `wiki/Notes/` ou `wiki/References/`, limpe o conteudo, remova ruido e registre a fonte.\n\nLink: [[Second Brain Atlas]]",
      "outgoing": 1,
      "incoming": 2,
      "degree": 3
    },
    {
      "id": "wiki-daily-readme",
      "title": "Daily",
      "domain": "Daily",
      "kind": "guide",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Daily/README.md",
      "tags": [
        "prometeus/buffer"
      ],
      "aliases": [
        "daily",
        "readme"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas"
      ],
      "pathLinks": [],
      "summary": "Notas diarias locais do Obsidian.",
      "teaser": "Notas diarias locais do Obsidian. Esta pasta e ignorada pelo Git, exceto este README. Promova apenas aprendizados duraveis para `wiki/Notes/Project Log.md` ou para uma nota de sistema/conceito.",
      "markdown": "# Daily\n\nNotas diarias locais do Obsidian.\n\nEsta pasta e ignorada pelo Git, exceto este README. Promova apenas aprendizados duraveis para `wiki/Notes/Project Log.md` ou para uma nota de sistema/conceito.\n\nLink: [[Second Brain Atlas]]",
      "outgoing": 1,
      "incoming": 2,
      "degree": 3
    },
    {
      "id": "wiki-home",
      "title": "Prometeus Wiki",
      "domain": "Home.md",
      "kind": "note",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Home.md",
      "tags": [
        "prometeus/home",
        "prometeus/graph"
      ],
      "aliases": [
        "home",
        "prometeus-wiki"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Prometeus Vault",
        "Second Brain Atlas",
        "Graph Operating System",
        "Knowledge Lifecycle",
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Prometeus.canvas",
        "Prometeus Wiki",
        "Foundation Harness",
        "Workspace Boundary",
        "Email Digest System",
        "Email Triage",
        "Study Track System",
        "Promotion Gate",
        "Kepano and Karpathy Principles",
        "Promotion Gate",
        "Prometeus.canvas",
        "Graph Operating System",
        "SOTA Research Gate"
      ],
      "pathLinks": [],
      "summary": "Este vault Obsidian se chama `Prometeus` e mora dentro do repo isolado `OLMO_PROMETEUS`. A wiki operacional mora em `wiki/` e usa uma abordagem bottom-up: notas pequenas primeiro, organizacao depois.",
      "teaser": "Este vault Obsidian se chama `Prometeus` e mora dentro do repo isolado `OLMO_PROMETEUS`. A wiki operacional mora em `wiki/` e usa uma abordagem bottom-up: notas pequenas primeiro, organizacao depois. Direcao atual: second brain graph-first. O Graph View deve ser grande e vivo; Canvas e mapa curado opcional.",
      "markdown": "# Prometeus Wiki\n\nEste vault Obsidian se chama `Prometeus` e mora dentro do repo isolado `OLMO_PROMETEUS`. A wiki operacional mora em `wiki/` e usa uma abordagem bottom-up: notas pequenas primeiro, organizacao depois.\n\nDirecao atual: second brain graph-first. O Graph View deve ser grande e vivo; Canvas e mapa curado opcional.\n\nComece por:\n\n- [[Prometeus Vault]]\n- [[Second Brain Atlas]]\n- [[Graph Operating System]]\n- [[Knowledge Lifecycle]]\n- [[SOTA Research Gate]]\n- [[Agent Module Encapsulation]]\n- [[Prometeus.canvas|Mapa visual em Canvas]]\n- [[Prometeus Wiki]]\n- [[Foundation Harness]]\n- [[Workspace Boundary]]\n- [[Email Digest System]]\n- [[Email Triage]]\n- [[Study Track System]]\n- [[Promotion Gate]]\n- [[Kepano and Karpathy Principles]]\n\n## Regra de uso\n\n- Captura crua e pessoal fica em `private-learning/` no repo, fora da wiki versionada.\n- `wiki/Clippings/` e `wiki/Daily/` sao buffers locais ignorados pelo Git.\n- Uma nota so entra no wiki quando muda comportamento futuro.\n- Qualquer coisa migravel passa por [[Promotion Gate]].\n- Nunca escrever fora de `C:\\Dev\\Projetos\\OLMO_PROMETEUS`.\n\n## Abrir\n\nNo Obsidian, abra `C:\\Dev\\Projetos\\OLMO_PROMETEUS\\Prometeus`.\n\nNao abra a raiz `OLMO_PROMETEUS` como vault, senao o nome e a arvore ficam errados.\n\n## Graph View\n\nUse o Graph View como interface principal do second brain. O filtro padrao deve ser:\n\n```text\npath:wiki\n```\n\n- `Atlas`: dourado.\n- `Home`: dourado.\n- `Categories`: laranja.\n- `Notes`: verde-azulado.\n- `References`: azul.\n- `Templates`: cinza.\n- `Buffers`: amarelo.\n\n## Canvas\n\nUse [[Prometeus.canvas|Prometeus Canvas]] como vitrine curada. Ele e manual e bonito, mas nao substitui o grafo.\n\nSe o Graph abrir cinza, confira `Groups`. O Obsidian pode regravar `graph.json` enquanto o Graph esta aberto; nesse caso, reabra o vault e aplique o preset de [[Graph Operating System]].\n\n## Proximo ciclo\n\n1. Capturar entrada.\n2. Se for mudanca estrutural, passar por [[SOTA Research Gate]].\n3. Sintetizar em artefato.\n4. Linkar a um sistema ou conceito.\n5. Rodar `scripts/check.ps1`.\n6. Decidir se fica private, experiment ou candidate.\n\nCoautoria: Lucas + GPT-5.4 (Codex)",
      "outgoing": 13,
      "incoming": 0,
      "degree": 13
    },
    {
      "id": "wiki-maps-readme",
      "title": "Maps",
      "domain": "Maps",
      "kind": "guide",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Maps/README.md",
      "tags": [
        "prometeus/map"
      ],
      "aliases": [
        "maps",
        "readme"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Second Brain Atlas"
      ],
      "pathLinks": [],
      "summary": "Mapas visuais do projeto em Obsidian Canvas.",
      "teaser": "Mapas visuais do projeto em Obsidian Canvas. Use esta pasta para visoes profissionais e navegaveis. O Graph View mostra relacoes emergentes; o Canvas mostra o sistema como boxes organizados, com notas abertas dentro do proprio mapa.",
      "markdown": "# Maps\n\nMapas visuais do projeto em Obsidian Canvas.\n\nUse esta pasta para visoes profissionais e navegaveis. O Graph View mostra relacoes emergentes; o Canvas mostra o sistema como boxes organizados, com notas abertas dentro do proprio mapa.\n\nRegra pratica: Graph View e o second brain principal; Canvas e vitrine curada para explicar o sistema. Nao reduza o grafo para caber no Canvas.\n\nLink: [[Second Brain Atlas]]",
      "outgoing": 1,
      "incoming": 0,
      "degree": 1
    },
    {
      "id": "wiki-notes-action-vs-fyi",
      "title": "Action vs FYI",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Action vs FYI.md",
      "tags": [
        "prometeus/concept",
        "prometeus/email"
      ],
      "aliases": [
        "action-vs-fyi"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Signal vs Noise",
        "Deadline Externo"
      ],
      "pathLinks": [],
      "summary": "`action` e email que pede decisao, resposta, prazo ou mitigacao de risco.",
      "teaser": "`action` e email que pede decisao, resposta, prazo ou mitigacao de risco. `FYI` e email que informa, mas nao quebra nada se ficar sem acao agora.",
      "markdown": "# Action vs FYI\n\n`action` e email que pede decisao, resposta, prazo ou mitigacao de risco.\n\n`FYI` e email que informa, mas nao quebra nada se ficar sem acao agora.\n\nPergunta util:\n\n- se eu nao fizer nada nas proximas 24h, algo piora?\n\nSe sim, tende a ser `action`. Se nao, tende a ser `FYI`.\n\nExemplos do audit de 2026-04-23:\n\n- Quantic deadline = `action`\n- CI quebrado no GitHub = `action`\n- newsletter = `FYI`\n\nLinks:\n\n- [[Email Triage]]\n- [[Signal vs Noise]]\n- [[Deadline Externo]]",
      "outgoing": 3,
      "incoming": 6,
      "degree": 9
    },
    {
      "id": "wiki-notes-agent-module-encapsulation",
      "title": "Agent Module Encapsulation",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Agent Module Encapsulation.md",
      "tags": [
        "prometeus/concept",
        "prometeus/agent",
        "prometeus/sota"
      ],
      "aliases": [
        "agent-module-contract",
        "agent-module-encapsulation",
        "modular-agent-encapsulation"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "SOTA Research Gate",
        "Promotion Gate",
        "Email Digest System",
        "Study Track System",
        "Promotion Gate",
        "Foundation Harness",
        "SOTA Research Gate",
        "Second Brain Atlas",
        "SOTA Dev Solo",
        "Foundation Harness",
        "Promotion Gate",
        "Candidate"
      ],
      "pathLinks": [],
      "summary": "Agente util e modulo encapsulado, nao personagem solto.",
      "teaser": "Agente util e modulo encapsulado, nao personagem solto. No Prometeus, a fronteira correta e:",
      "markdown": "# Agent Module Encapsulation\n\nAgente util e modulo encapsulado, nao personagem solto.\n\nNo Prometeus, a fronteira correta e:\n\n```text\nprocedimento -> modulo documentado -> runner manual -> agente real\n```\n\nIsso preserva contexto, reduz sprawl e impede que o repo volte a ter pastas fantasmas de agents, subagents, skills e hooks.\n\n## Contrato minimo\n\nUm modulo candidato precisa declarar:\n\n- `purpose`: uma responsabilidade;\n- `trigger`: quando entra;\n- `non_trigger`: quando nao entra;\n- `input_contract`: o que recebe;\n- `output_contract`: o que entrega;\n- `state`: onde pode lembrar;\n- `tools`: ferramentas permitidas;\n- `permissions`: caminhos e acoes proibidas;\n- `guardrails`: validacoes antes/depois;\n- `eval`: como saber se funcionou;\n- `cost`: contexto, tempo e manutencao;\n- `rollback`: como desfazer.\n\n## Regra Prometeus\n\nNao criar runtime de agente so porque a ideia parece boa.\n\nCriar primeiro um contrato em [[SOTA Research Gate]], `shadow/AGENT-MODULES.md` ou no procedimento certo. Se houver 3 usos reais, evidencia e rollback, entao avaliar promocao com [[Promotion Gate]].\n\n## Candidatos atuais\n\n- [[Email Digest System]] pode virar `email-digest-4p` se provar uso recorrente.\n- [[Study Track System]] pode virar `study-track-done` se reduzir retrabalho.\n- [[Promotion Gate]] ja funciona como modulo decisorio documentado.\n- [[Foundation Harness]] continua deterministico; nao precisa virar agente.\n- [[SOTA Research Gate]] e gate de arquitetura, nao automacao.\n\n## Links\n\n- [[Second Brain Atlas]]\n- [[SOTA Dev Solo]]\n- [[Foundation Harness]]\n- [[Promotion Gate]]\n- [[Candidate]]",
      "outgoing": 8,
      "incoming": 10,
      "degree": 18
    },
    {
      "id": "wiki-notes-agent-usage-map",
      "title": "Agent Usage Map",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Agent Usage Map.md",
      "tags": [
        "prometeus/system",
        "prometeus/agents"
      ],
      "aliases": [
        "agent-usage-map"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Agent Module Encapsulation",
        "Agent Module Encapsulation",
        "SOTA Research Gate",
        "Evidence Log"
      ],
      "pathLinks": [],
      "summary": "`shadow/AGENT-USAGE.md` mapeia como este projeto usa agents/skills/subagents globais do Claude Code sem criar scaffold local.",
      "teaser": "`shadow/AGENT-USAGE.md` mapeia como este projeto usa agents/skills/subagents globais do Claude Code sem criar scaffold local. Substitui a tentacao de criar `.claude/agents/` local: toda necessidade de agente e coberta por recurso global (`Explore`, `Plan`, `/dream`, `/schedule`, `/code-review`) + procedimento em `shadow/`.",
      "markdown": "# Agent Usage Map\n\n`shadow/AGENT-USAGE.md` mapeia como este projeto usa agents/skills/subagents globais do Claude Code sem criar scaffold local.\n\nSubstitui a tentacao de criar `.claude/agents/` local: toda necessidade de agente e coberta por recurso global (`Explore`, `Plan`, `/dream`, `/schedule`, `/code-review`) + procedimento em `shadow/`.\n\nContem tambem o SOTA agent contract para este projeto: orquestrador-worker, parallelization, evaluator-optimizer, context discipline, memory policy, tool minimalism.\n\nDesde 2026-04-23, o arquivo tambem define o Local skills contract: regras para quando um procedimento `operational` pode virar skill em `.claude/skills/<name>/SKILL.md`.\n\nRelacao com [[Agent Module Encapsulation]]: Agent Module e o eixo tecnico (procedimento -> modulo -> runner -> agente); Agent Usage Map e a operacionalizacao local (como usar recursos globais e como promover skills).\n\nLinks: [[Agent Module Encapsulation]], [[SOTA Research Gate]], [[Evidence Log]]",
      "outgoing": 3,
      "incoming": 2,
      "degree": 5
    },
    {
      "id": "wiki-notes-artifact",
      "title": "Artifact",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Artifact.md",
      "tags": [
        "prometeus/concept"
      ],
      "aliases": [
        "artifact"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Candidate",
        "Done",
        "Study Track System"
      ],
      "pathLinks": [],
      "summary": "Um artefato e uma saida persistente que pode ser revisada depois.",
      "teaser": "Um artefato e uma saida persistente que pode ser revisada depois. Exemplos:",
      "markdown": "# Artifact\n\nUm artefato e uma saida persistente que pode ser revisada depois.\n\nExemplos:\n\n- nota wiki;\n- digest salvo;\n- decisao em `shadow/`;\n- checklist;\n- script pequeno;\n- dashboard atualizado.\n\nSem artefato, nao ha evidencia suficiente para marcar como `done` ou `candidate`.\n\nLinks: [[Candidate]], [[Done]], [[Study Track System]]",
      "outgoing": 3,
      "incoming": 11,
      "degree": 14
    },
    {
      "id": "wiki-notes-candidate",
      "title": "Candidate",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Candidate.md",
      "tags": [
        "prometeus/concept",
        "prometeus/promotion"
      ],
      "aliases": [
        "candidate"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Promotion Gate",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "`candidate` e um padrao local que pode entrar em conversa de migracao.",
      "teaser": "`candidate` e um padrao local que pode entrar em conversa de migracao. Requisitos:",
      "markdown": "# Candidate\n\n`candidate` e um padrao local que pode entrar em conversa de migracao.\n\nRequisitos:\n\n- trigger claro;\n- uso repetido;\n- artefato claro;\n- risco conhecido;\n- rollback simples;\n- harness passando;\n- autorizacao humana antes de tocar OLMO.\n\nLinks: [[Promotion Gate]], [[Artifact]]",
      "outgoing": 2,
      "incoming": 7,
      "degree": 9
    },
    {
      "id": "wiki-notes-deadline-externo",
      "title": "Deadline Externo",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Deadline Externo.md",
      "tags": [
        "prometeus/concept",
        "prometeus/email"
      ],
      "aliases": [
        "deadline-externo"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Action vs FYI",
        "Signal vs Noise"
      ],
      "pathLinks": [],
      "summary": "`deadline externo` e um prazo vindo de fora da sua fila interna.",
      "teaser": "`deadline externo` e um prazo vindo de fora da sua fila interna. Ele merece prioridade quando:",
      "markdown": "# Deadline Externo\n\n`deadline externo` e um prazo vindo de fora da sua fila interna.\n\nEle merece prioridade quando:\n\n- vence logo\n- expira de verdade\n- tem custo claro se ignorado\n\nExemplos do audit de 2026-04-23:\n\n- Quantic MBA deadline `today`\n- codigo temporario com validade curta\n\nO erro e deixar prazo apodrecer no inbox sem decisao explicita.\n\nLinks:\n\n- [[Email Triage]]\n- [[Action vs FYI]]\n- [[Signal vs Noise]]",
      "outgoing": 3,
      "incoming": 4,
      "degree": 7
    },
    {
      "id": "wiki-notes-done",
      "title": "Done",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Done.md",
      "tags": [
        "prometeus/concept",
        "prometeus/study"
      ],
      "aliases": [
        "done"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Study Track System",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "`done` nao e sensacao de progresso. E evidencia.",
      "teaser": "`done` nao e sensacao de progresso. E evidencia. Algo pode ser `done` quando:",
      "markdown": "# Done\n\n`done` nao e sensacao de progresso. E evidencia.\n\nAlgo pode ser `done` quando:\n\n- Lucas consegue explicar claramente;\n- foi aplicado em um artefato concreto;\n- foi repetido o suficiente para deixar de ser fragil.\n\nSe a evidencia for fraca, fica em `em-estudo` ou `aplicando`.\n\nLinks: [[Study Track System]], [[Artifact]]",
      "outgoing": 2,
      "incoming": 5,
      "degree": 7
    },
    {
      "id": "wiki-notes-email-digest-system",
      "title": "Email Digest System",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Email Digest System.md",
      "tags": [
        "prometeus/system",
        "prometeus/email"
      ],
      "aliases": [
        "email-digest-system"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Action vs FYI",
        "Waiting",
        "Deadline Externo",
        "Signal vs Noise",
        "Subscription Drift",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "Gmail e fila de entrada. A taxonomia duravel mora em artefato persistente.",
      "teaser": "Gmail e fila de entrada. A taxonomia duravel mora em artefato persistente. Labels:",
      "markdown": "# Email Digest System\n\nGmail e fila de entrada. A taxonomia duravel mora em artefato persistente.\n\nLabels:\n\n- `Prometeus/Processar`: fila normal.\n- `Prometeus/Alta`: prioridade.\n- `Prometeus/Ruido`: ignorar ou detectar padrao de ruido.\n- `Prometeus/Digerido`: somente depois de nota ou digest salvo.\n\nDigest completo tem quatro paragrafos:\n\n1. O que aconteceu.\n2. Deadlines e cobrancas.\n3. Conceitos para estudar.\n4. Filosofia e tensoes.\n\nConceitos operacionais de triagem:\n\n- [[Email Triage]]\n- [[Action vs FYI]]\n- [[Waiting]]\n- [[Deadline Externo]]\n- [[Signal vs Noise]]\n- [[Subscription Drift]]\n\nLink: [[Artifact]]",
      "outgoing": 7,
      "incoming": 6,
      "degree": 13
    },
    {
      "id": "wiki-notes-email-triage",
      "title": "Email Triage",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Email Triage.md",
      "tags": [
        "prometeus/system",
        "prometeus/email"
      ],
      "aliases": [
        "email-triage"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Action vs FYI",
        "Waiting",
        "Deadline Externo",
        "Signal vs Noise",
        "Subscription Drift",
        "Email Digest System"
      ],
      "pathLinks": [],
      "summary": "Email triage nao e ler tudo. E decidir rapido o destino operacional de cada mensagem.",
      "teaser": "Email triage nao e ler tudo. E decidir rapido o destino operacional de cada mensagem. Conceitos-base:",
      "markdown": "# Email Triage\n\nEmail triage nao e ler tudo. E decidir rapido o destino operacional de cada mensagem.\n\nConceitos-base:\n\n- [[Action vs FYI]]\n- [[Waiting]]\n- [[Deadline Externo]]\n- [[Signal vs Noise]]\n- [[Subscription Drift]]\n\nLeitura do inbox de 2026-04-23:\n\n- `action`: Quantic deadline, CI quebrado, Stripe se billing for prioridade\n- `waiting`: vazio no dia\n- `deadline externo`: Quantic e codigo temporario\n- `signal`: CI, cobranca, renovacao, cancelamento\n- `noise`: promo, onboarding e newsletters duplicadas\n\nPerguntas em ordem:\n\n1. exige acao?\n2. vence de verdade?\n3. muda risco, dinheiro ou estado de sistema?\n4. estou esperando alguem?\n\nSe as quatro respostas forem nao, tende a ser arquivo ou leitura opcional.\n\nLink: [[Email Digest System]]",
      "outgoing": 6,
      "incoming": 9,
      "degree": 15
    },
    {
      "id": "wiki-notes-evidence-log",
      "title": "Evidence Log",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Evidence Log.md",
      "tags": [
        "prometeus/system",
        "prometeus/promotion"
      ],
      "aliases": [
        "evidence-log"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "SOTA Research Gate",
        "Candidate",
        "Promotion Gate",
        "Promotion Gate",
        "Candidate",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "`shadow/EVIDENCE-LOG.md` e o registro auditavel de uso real dos procedimentos deste repo. E o mecanismo que transforma \"3 usos reais\" de intuicao em dado.",
      "teaser": "`shadow/EVIDENCE-LOG.md` e o registro auditavel de uso real dos procedimentos deste repo. E o mecanismo que transforma \"3 usos reais\" de intuicao em dado. Cada vez que um procedimento como `email-digest-4p`, `study-track-done` ou o [[SOTA Research Gate]] roda em uso real, entra uma linha: data, input, output, observacao, proximo.",
      "markdown": "# Evidence Log\n\n`shadow/EVIDENCE-LOG.md` e o registro auditavel de uso real dos procedimentos deste repo. E o mecanismo que transforma \"3 usos reais\" de intuicao em dado.\n\nCada vez que um procedimento como `email-digest-4p`, `study-track-done` ou o [[SOTA Research Gate]] roda em uso real, entra uma linha: data, input, output, observacao, proximo.\n\nE o gate para transitar de [[Candidate]] para `operational` em [[Promotion Gate]]: tres entradas + rubrica passando + estabilidade.\n\nSem ele, o projeto perde a distincao entre procedimento em uso e procedimento aspiracional.\n\nLinks: [[Promotion Gate]], [[Candidate]], [[Artifact]]",
      "outgoing": 4,
      "incoming": 3,
      "degree": 7
    },
    {
      "id": "wiki-notes-foundation-harness",
      "title": "Foundation Harness",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Foundation Harness.md",
      "tags": [
        "prometeus/system"
      ],
      "aliases": [
        "foundation-harness"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Workspace Boundary",
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "O harness e a camada minima de regressao local.",
      "teaser": "O harness e a camada minima de regressao local. Comando:",
      "markdown": "# Foundation Harness\n\nO harness e a camada minima de regressao local.\n\nComando:\n\n```powershell\npowershell -ExecutionPolicy Bypass -File .\\scripts\\check.ps1\n```\n\nEle valida:\n\n- boundary fundamental;\n- arquivos essenciais;\n- Obsidian vault basico nomeado `Prometeus`;\n- adaptadores `CLAUDE.md` e `GEMINI.md`;\n- ausencia de scaffolds fantasmas;\n- contratos de procedimentos e SOTA gate;\n- wikilinks e aliases do Obsidian;\n- referencias de arquivos no Canvas;\n- ausencia de referencias antigas;\n- ausencia de segredos obvios;\n- paridade entre `.gitignore` e `.claudeignore`;\n- ignores privados e gerados;\n- checks textuais pulam arquivos ignorados e redigem linhas de segredo;\n- estado Git.\n\nNao substitui julgamento. Evita regressao boba.\n\nLinks:\n\n- [[Workspace Boundary]]\n- [[SOTA Research Gate]]\n- [[Agent Module Encapsulation]]\n- [[Artifact]]",
      "outgoing": 4,
      "incoming": 10,
      "degree": 14
    },
    {
      "id": "wiki-notes-project-log",
      "title": "Project Log",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Project Log.md",
      "tags": [
        "prometeus/log"
      ],
      "aliases": [
        "project-log"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Foundation Harness"
      ],
      "pathLinks": [],
      "summary": "Registrar aqui apenas fatos que ajudam contexto futuro. Conversa solta nao entra.",
      "teaser": "Registrar aqui apenas fatos que ajudam contexto futuro. Conversa solta nao entra.",
      "markdown": "# Project Log\n\n## 2026-04-23\n\n- Criado repo isolado `OLMO_PROMETEUS`.\n- Consolidado SOTA em decisoes curtas.\n- Adicionado harness local.\n- Boundary fundamental registrada: nunca escrever fora do repo.\n- Criado Obsidian vault do projeto.\n- Renomeado o vault para `Prometeus`, mantendo o repo isolado em `C:\\Dev\\Projetos\\OLMO_PROMETEUS`.\n- Removidos scaffolds fantasmas de agents, subagents, skills, hooks e playground.\n- Criados adaptadores finos `CLAUDE.md` e `GEMINI.md` via arquivos raiz, sem `.claude/` ou `.gemini/` ativos.\n- Registrado [[SOTA Research Gate]] como regra para arquitetura, memoria e orquestracao.\n- Documentada a fronteira [[Agent Module Encapsulation]]: agente como modulo com contrato, tools, memoria, guardrails, eval e rollback.\n- Estabilizado [[Foundation Harness]] para checks textuais sem dependencia fragil de `rg`.\n- Aplicado frame adversarial de seguranca: `.claudeignore` espelha buffers privados do Git e o harness nao imprime conteudo de possiveis segredos.\n\n## Regra\n\nRegistrar aqui apenas fatos que ajudam contexto futuro. Conversa solta nao entra.",
      "outgoing": 3,
      "incoming": 3,
      "degree": 6
    },
    {
      "id": "wiki-notes-promotion-gate",
      "title": "Promotion Gate",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Promotion Gate.md",
      "tags": [
        "prometeus/system",
        "prometeus/promotion"
      ],
      "aliases": [
        "promotion-gate"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Candidate",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "Tudo entra como `private`, `experiment` ou `candidate`.",
      "teaser": "Tudo entra como `private`, `experiment` ou `candidate`. Material pessoal, cockpit, digests e notas dependentes de contexto. Nao migra.",
      "markdown": "# Promotion Gate\n\nTudo entra como `private`, `experiment` ou `candidate`.\n\n## Private\n\nMaterial pessoal, cockpit, digests e notas dependentes de contexto. Nao migra.\n\n## Experiment\n\nFluxo promissor, mas ainda instavel ou pouco repetido.\n\n## Candidate\n\nPadrao reutilizavel com trigger, evidencia e rollback.\n\nAntes de qualquer conversa sobre OLMO:\n\n- objetivo;\n- trigger;\n- artefato;\n- custo;\n- risco;\n- rollback.\n\nLinks: [[Candidate]], [[Artifact]]",
      "outgoing": 2,
      "incoming": 10,
      "degree": 12
    },
    {
      "id": "wiki-notes-sota-dev-solo",
      "title": "SOTA Dev Solo",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/SOTA Dev Solo.md",
      "tags": [
        "prometeus/concept",
        "prometeus/sota"
      ],
      "aliases": [
        "sota-dev-solo"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Foundation Harness",
        "SOTA Research Gate",
        "Agent Module Encapsulation",
        "Promotion Gate",
        "Artifact",
        "Done"
      ],
      "pathLinks": [],
      "summary": "SOTA dev solo e um operador humano com agentes como amplificadores, nao uma pilha grande de automacao.",
      "teaser": "SOTA dev solo e um operador humano com agentes como amplificadores, nao uma pilha grande de automacao. Principios:",
      "markdown": "# SOTA Dev Solo\n\nSOTA dev solo e um operador humano com agentes como amplificadores, nao uma pilha grande de automacao.\n\nPrincipios:\n\n- Um ciclo pequeno por vez.\n- Artefato persistente antes de `done`.\n- Harness antes de commit.\n- Memoria em arquivos certos, nao em conversa solta.\n- Orquestracao conservadora.\n- Pesquisa SOTA antes de mudanca estrutural.\n- Agentes como modulos encapsulados, nao personas soltas.\n\nLinks:\n\n- [[Foundation Harness]]\n- [[SOTA Research Gate]]\n- [[Agent Module Encapsulation]]\n- [[Promotion Gate]]\n- [[Artifact]]\n- [[Done]]",
      "outgoing": 6,
      "incoming": 5,
      "degree": 11
    },
    {
      "id": "wiki-notes-sota-research-gate",
      "title": "SOTA Research Gate",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/SOTA Research Gate.md",
      "tags": [
        "prometeus/system",
        "prometeus/sota"
      ],
      "aliases": [
        "sota-gate",
        "sota-research-gate"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Foundation Harness",
        "Agent Module Encapsulation",
        "SOTA Dev Solo",
        "Promotion Gate",
        "Workspace Boundary",
        "Project Log"
      ],
      "pathLinks": [],
      "summary": "O SOTA Research Gate impede mudanca estrutural por entusiasmo.",
      "teaser": "O SOTA Research Gate impede mudanca estrutural por entusiasmo. Antes de mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao:",
      "markdown": "# SOTA Research Gate\n\nO SOTA Research Gate impede mudanca estrutural por entusiasmo.\n\nAntes de mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao:\n\n1. Auditar o estado local.\n2. Pesquisar fontes primarias atuais.\n3. Registrar decisao curta.\n4. Explicitar trigger, nao-trigger, risco, custo e rollback.\n5. Definir criterio negativo: quando nao aplicar.\n6. Editar apenas se a pesquisa justificar.\n7. Rodar [[Foundation Harness]] antes de commit.\n\n## Criterio negativo\n\nSe a pratica externa exige escala, equipe, CI, produto, permissao ou runtime que o Prometeus nao tem, nao copiar. Reduzir para procedimento pequeno ou rejeitar.\n\n## Onde registrar\n\n- Decisao SOTA: `shadow/SOTA-DECISIONS.md`.\n- Contrato de modulo: `shadow/AGENT-MODULES.md`.\n- Gate de migracao: `shadow/INCORPORATION-LOG.md`.\n- Nota duravel: `Prometeus/wiki/Notes/`.\n\n## Links\n\n- [[Agent Module Encapsulation]]\n- [[SOTA Dev Solo]]\n- [[Promotion Gate]]\n- [[Workspace Boundary]]\n- [[Project Log]]",
      "outgoing": 6,
      "incoming": 13,
      "degree": 19
    },
    {
      "id": "wiki-notes-signal-vs-noise",
      "title": "Signal vs Noise",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Signal vs Noise.md",
      "tags": [
        "prometeus/concept",
        "prometeus/email"
      ],
      "aliases": [
        "signal-vs-noise"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Action vs FYI",
        "Subscription Drift"
      ],
      "pathLinks": [],
      "summary": "`signal` e mensagem que muda risco, dinheiro, prazo ou estado de um sistema relevante.",
      "teaser": "`signal` e mensagem que muda risco, dinheiro, prazo ou estado de um sistema relevante. `noise` e volume que parece importante, mas nao muda decisao agora.",
      "markdown": "# Signal vs Noise\n\n`signal` e mensagem que muda risco, dinheiro, prazo ou estado de um sistema relevante.\n\n`noise` e volume que parece importante, mas nao muda decisao agora.\n\nExemplos do audit de 2026-04-23:\n\n- falhas de CI no GitHub = `signal`\n- Quantic deadline = `signal`\n- newsletters duplicadas = `noise`\n- label `IMPORTANT` mal calibrado = `noise` vestido de `signal`\n\nVolume nao e importancia.\n\nLinks:\n\n- [[Email Triage]]\n- [[Action vs FYI]]\n- [[Subscription Drift]]",
      "outgoing": 3,
      "incoming": 5,
      "degree": 8
    },
    {
      "id": "wiki-notes-study-track-system",
      "title": "Study Track System",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Study Track System.md",
      "tags": [
        "prometeus/system",
        "prometeus/study"
      ],
      "aliases": [
        "study-track-system"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Done",
        "Artifact"
      ],
      "pathLinks": [],
      "summary": "Estados:",
      "teaser": "Estados: Regra: so marcar `done` com evidencia.",
      "markdown": "# Study Track System\n\nEstados:\n\n- `capturado`\n- `em-estudo`\n- `aplicando`\n- `done`\n\nRegra: so marcar `done` com evidencia.\n\nO sistema serve para mostrar progresso real, nao para esconder bordas inacabadas.\n\nLinks:\n\n- [[Done]]\n- [[Artifact]]",
      "outgoing": 2,
      "incoming": 7,
      "degree": 9
    },
    {
      "id": "wiki-notes-subscription-drift",
      "title": "Subscription Drift",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Subscription Drift.md",
      "tags": [
        "prometeus/concept",
        "prometeus/email"
      ],
      "aliases": [
        "subscription-drift"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Signal vs Noise",
        "Action vs FYI"
      ],
      "pathLinks": [],
      "summary": "`subscription drift` e a erosao lenta de dinheiro e atencao por renovacoes, cancelamentos e setups de conta pouco revisitados.",
      "teaser": "`subscription drift` e a erosao lenta de dinheiro e atencao por renovacoes, cancelamentos e setups de conta pouco revisitados. Nao e so sobre preco. E sobre estado do sistema:",
      "markdown": "# Subscription Drift\n\n`subscription drift` e a erosao lenta de dinheiro e atencao por renovacoes, cancelamentos e setups de conta pouco revisitados.\n\nNao e so sobre preco. E sobre estado do sistema:\n\n- o que esta ativo\n- o que foi cancelado\n- o que renova\n- o que esta pela metade\n\nExemplos do audit de 2026-04-23:\n\n- Apple `Trust the Evidence`\n- cancelamento do Perplexity Pro\n- afiliacao ACP\n- setup incompleto de Stripe\n\nLinks:\n\n- [[Email Triage]]\n- [[Signal vs Noise]]\n- [[Action vs FYI]]",
      "outgoing": 3,
      "incoming": 3,
      "degree": 6
    },
    {
      "id": "wiki-notes-waiting",
      "title": "Waiting",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Waiting.md",
      "tags": [
        "prometeus/concept",
        "prometeus/email"
      ],
      "aliases": [
        "waiting"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Email Triage",
        "Action vs FYI",
        "Deadline Externo"
      ],
      "pathLinks": [],
      "summary": "`waiting` e o estado de um assunto ativo cuja proxima acao depende de outra pessoa.",
      "teaser": "`waiting` e o estado de um assunto ativo cuja proxima acao depende de outra pessoa. Nao e backlog nem arquivo morto.",
      "markdown": "# Waiting\n\n`waiting` e o estado de um assunto ativo cuja proxima acao depende de outra pessoa.\n\nNao e backlog nem arquivo morto.\n\nServe para responder:\n\n- de quem estou esperando algo?\n\nNo audit de 2026-04-23, `waiting` estava vazio porque nao houve email enviado no dia. Isso mostrou que o problema principal nao era follow-up perdido, mas ruido e algumas poucas decisoes reais.\n\nLinks:\n\n- [[Email Triage]]\n- [[Action vs FYI]]\n- [[Deadline Externo]]",
      "outgoing": 3,
      "incoming": 2,
      "degree": 5
    },
    {
      "id": "wiki-notes-workspace-boundary",
      "title": "Workspace Boundary",
      "domain": "Notes",
      "kind": "concept",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Notes/Workspace Boundary.md",
      "tags": [
        "prometeus/system",
        "prometeus/boundary"
      ],
      "aliases": [
        "workspace-boundary"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Foundation Harness",
        "SOTA Research Gate"
      ],
      "pathLinks": [],
      "summary": "Regra fundamental: nunca escrever fora de `C:\\Dev\\Projetos\\OLMO_PROMETEUS`.",
      "teaser": "Regra fundamental: nunca escrever fora de `C:\\Dev\\Projetos\\OLMO_PROMETEUS`. Proibido sem autorizacao explicita:",
      "markdown": "# Workspace Boundary\n\nRegra fundamental: nunca escrever fora de `C:\\Dev\\Projetos\\OLMO_PROMETEUS`.\n\nProibido sem autorizacao explicita:\n\n- criar arquivo fora daqui;\n- editar arquivo fora daqui;\n- deletar ou mover arquivo fora daqui;\n- sincronizar com repositorios siblings;\n- automatizar write externo;\n- tocar `C:\\Dev\\Projetos\\OLMO`.\n\nSe uma tarefa exigir write externo, parar e pedir autorizacao citando caminho e acao exata.\n\nLinks: [[Foundation Harness]], [[SOTA Research Gate]]",
      "outgoing": 2,
      "incoming": 5,
      "degree": 7
    },
    {
      "id": "wiki-references-kepano-and-karpathy-principles",
      "title": "Kepano and Karpathy Principles",
      "domain": "References",
      "kind": "reference",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/References/Kepano and Karpathy Principles.md",
      "tags": [
        "prometeus/reference",
        "prometeus/sota"
      ],
      "aliases": [
        "kepano-and-karpathy-principles"
      ],
      "relatedLinks": [],
      "bodyLinks": [
        "Foundation Harness",
        "SOTA Research Gate"
      ],
      "pathLinks": [],
      "summary": "Esta nota resume o que foi incorporado dos repos lidos para ajustar o vault.",
      "teaser": "Esta nota resume o que foi incorporado dos repos lidos para ajustar o vault. Fontes:",
      "markdown": "# Kepano and Karpathy Principles\n\nEsta nota resume o que foi incorporado dos repos lidos para ajustar o vault.\n\n## Kepano / Obsidian\n\nFontes:\n\n- `kepano/kepano-obsidian`: https://github.com/kepano/kepano-obsidian\n- `kepano/obsidian-skills`: https://github.com/kepano/obsidian-skills\n- `kepano/defuddle`: https://github.com/kepano/defuddle\n\nPrincipios aplicados:\n\n- Bottom-up primeiro, taxonomia depois.\n- Vault como arquivos Markdown locais.\n- Pastas simples: `Notes`, `References`, `Daily`, `Templates`, `Attachments`, `Clippings`, `Categories`.\n- Usar Obsidian Markdown: wikilinks, properties e templates.\n- Clippings devem virar Markdown limpo antes de entrar na wiki.\n\n## Karpathy\n\nFontes:\n\n- `karpathy/nanoGPT`: https://github.com/karpathy/nanoGPT\n- `karpathy/build-nanogpt`: https://github.com/karpathy/build-nanogpt\n- `karpathy/nanochat`: https://github.com/karpathy/nanochat\n- `karpathy/micrograd`: https://github.com/karpathy/micrograd\n- `karpathy/llm.c`: https://github.com/karpathy/llm.c\n\nPrincipios aplicados:\n\n- Simples, legivel, hackable.\n- Escopo explicitamente limitado.\n- Evolucao em passos pequenos e commits limpos.\n- Harness cobre o fluxo minimo.\n- Separar referencia educacional de uso operacional.\n\n## Karpathy 2026 LLM Wiki Pattern\n\nEvolucao do pensamento Karpathy para second brain + AI:\n\n- Raw e junk drawer. Clippings, daily, attachments entram sem organizar; a AI/LLM processa depois. O projeto ja implementa via `Prometeus/wiki/Clippings/`, `Prometeus/wiki/Daily/`, `Prometeus/wiki/Attachments/` ignorados.\n- Prose > bullets para LLMs. LLMs preferem frases completas; bullets telegrapicos perdem sinal. Aplicacao local: `Prometeus/wiki/Notes` tende a prose para conceitos duraveis; `shadow/` mantem bullets porque e operacional e scanavel.\n- First version small. Nao sobredesenhar schema; nao importar digital life em um fim de semana; nao overbuild search.\n- Durabilidade. Markdown + folders + schemas explicitos; tool-agnostico; funciona com qualquer LLM hoje ou em dez anos.\n- AI organiza cross-links. Deliberadamente NAO adotado por enquanto (viola anti-sprawl ate haver >=3 dores concretas onde curadoria manual falhou; revisar em `shadow/SOTA-DECISIONS.md > Blocked ate evidencia > C4`).\n\nLinks: [[Foundation Harness]], [[SOTA Research Gate]]\n\n## Decisao local\n\nO vault deve ser pequeno. Se crescer, a primeira acao e consolidar notas duplicadas, nao criar plugins ou pastas.\n\nNotas conceituais em `wiki/Notes` devem ter >=2 wikilinks para outras notas (harness valida); senao viram espelhos de `shadow/` e sao candidatas a delete.",
      "outgoing": 2,
      "incoming": 3,
      "degree": 5
    },
    {
      "id": "wiki-templates-email-digest",
      "title": "Email Digest - {{date}}",
      "domain": "Templates",
      "kind": "note",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Templates/Email Digest.md",
      "tags": [
        "prometeus/template",
        "prometeus/email"
      ],
      "aliases": [
        "email-digest",
        "email-digest-date"
      ],
      "relatedLinks": [],
      "bodyLinks": [],
      "pathLinks": [],
      "summary": "Paragrafo 1.",
      "teaser": "Paragrafo 1. Paragrafo 2.",
      "markdown": "# Email Digest - {{date}}\n\n## Digest\n\nParagrafo 1.\n\nParagrafo 2.\n\nParagrafo 3.\n\nParagrafo 4.\n\n## Fontes\n\n## Conceitos\n\n## Proximas acoes",
      "outgoing": 0,
      "incoming": 1,
      "degree": 1
    },
    {
      "id": "wiki-templates-daily-note",
      "title": "{{date}}",
      "domain": "Templates",
      "kind": "note",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Templates/Daily Note.md",
      "tags": [
        "prometeus/template",
        "prometeus/daily"
      ],
      "aliases": [
        "daily-note",
        "date"
      ],
      "relatedLinks": [],
      "bodyLinks": [],
      "pathLinks": [],
      "summary": "",
      "teaser": "",
      "markdown": "# {{date}}\n\n## Foco\n\n## Capturas\n\n## Artefatos\n\n## Decisoes\n\n## Proximo passo",
      "outgoing": 0,
      "incoming": 1,
      "degree": 1
    },
    {
      "id": "wiki-templates-concept-note",
      "title": "{{title}}",
      "domain": "Templates",
      "kind": "note",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Templates/Concept Note.md",
      "tags": [
        "prometeus/template"
      ],
      "aliases": [
        "concept-note",
        "title"
      ],
      "relatedLinks": [],
      "bodyLinks": [],
      "pathLinks": [],
      "summary": "",
      "teaser": "",
      "markdown": "# {{title}}\n\n## Definicao\n\n## Quando usar\n\n## Evidencia\n\n## Links\n\n- Adicione links quando a nota tiver conexao real com um hub, sistema ou conceito.",
      "outgoing": 0,
      "incoming": 1,
      "degree": 1
    },
    {
      "id": "wiki-templates-decision-note",
      "title": "{{title}}",
      "domain": "Templates",
      "kind": "note",
      "description": "",
      "confidence": "",
      "created": "",
      "path": "wiki/Templates/Decision Note.md",
      "tags": [
        "prometeus/template",
        "prometeus/decision"
      ],
      "aliases": [
        "decision-note",
        "title"
      ],
      "relatedLinks": [],
      "bodyLinks": [],
      "pathLinks": [],
      "summary": "",
      "teaser": "",
      "markdown": "# {{title}}\n\n## Decisao\n\n## Contexto\n\n## Trade-off\n\n## Proxima acao\n\n## Links\n\n- Adicione links quando a decisao tiver conexao real com um hub, sistema ou conceito.",
      "outgoing": 0,
      "incoming": 1,
      "degree": 1
    }
  ],
  "links": [
    {
      "source": "wiki-atlas-graph-operating-system",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-graph-operating-system",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-graph-operating-system",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-graph-operating-system",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-graph-operating-system",
      "target": "wiki-notes-sota-dev-solo",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-categories-prometeus-wiki",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-project-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-evidence-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-knowledge-lifecycle",
      "target": "wiki-notes-agent-usage-map",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-readme",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-categories-prometeus-wiki",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-atlas-graph-operating-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-atlas-knowledge-lifecycle",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-workspace-boundary",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-evidence-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-agent-usage-map",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-sota-dev-solo",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-done",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-references-kepano-and-karpathy-principles",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-clippings-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-daily-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-atlas-second-brain-atlas",
      "target": "wiki-attachments-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-attachments-readme",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-atlas-graph-operating-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-atlas-knowledge-lifecycle",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-workspace-boundary",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-sota-dev-solo",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-done",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-references-kepano-and-karpathy-principles",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-clippings-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-daily-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-attachments-readme",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-notes-project-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-templates-concept-note",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-templates-decision-note",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-templates-daily-note",
      "type": "wikilink"
    },
    {
      "source": "wiki-categories-prometeus-wiki",
      "target": "wiki-templates-email-digest",
      "type": "wikilink"
    },
    {
      "source": "wiki-clippings-readme",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-daily-readme",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-atlas-graph-operating-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-atlas-knowledge-lifecycle",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-categories-prometeus-wiki",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-workspace-boundary",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-home",
      "target": "wiki-references-kepano-and-karpathy-principles",
      "type": "wikilink"
    },
    {
      "source": "wiki-maps-readme",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-action-vs-fyi",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-action-vs-fyi",
      "target": "wiki-notes-signal-vs-noise",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-action-vs-fyi",
      "target": "wiki-notes-deadline-externo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-atlas-second-brain-atlas",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-sota-dev-solo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-module-encapsulation",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-usage-map",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-usage-map",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-agent-usage-map",
      "target": "wiki-notes-evidence-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-artifact",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-artifact",
      "target": "wiki-notes-done",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-artifact",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-candidate",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-candidate",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-deadline-externo",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-deadline-externo",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-deadline-externo",
      "target": "wiki-notes-signal-vs-noise",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-done",
      "target": "wiki-notes-study-track-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-done",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-waiting",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-deadline-externo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-signal-vs-noise",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-subscription-drift",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-digest-system",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-waiting",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-deadline-externo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-signal-vs-noise",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-subscription-drift",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-email-triage",
      "target": "wiki-notes-email-digest-system",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-evidence-log",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-evidence-log",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-evidence-log",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-evidence-log",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-foundation-harness",
      "target": "wiki-notes-workspace-boundary",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-foundation-harness",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-foundation-harness",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-foundation-harness",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-project-log",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-project-log",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-project-log",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-promotion-gate",
      "target": "wiki-notes-candidate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-promotion-gate",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-signal-vs-noise",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-signal-vs-noise",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-signal-vs-noise",
      "target": "wiki-notes-subscription-drift",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-dev-solo",
      "target": "wiki-notes-done",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-agent-module-encapsulation",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-sota-dev-solo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-promotion-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-workspace-boundary",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-sota-research-gate",
      "target": "wiki-notes-project-log",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-study-track-system",
      "target": "wiki-notes-done",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-study-track-system",
      "target": "wiki-notes-artifact",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-subscription-drift",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-subscription-drift",
      "target": "wiki-notes-signal-vs-noise",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-subscription-drift",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-waiting",
      "target": "wiki-notes-email-triage",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-waiting",
      "target": "wiki-notes-action-vs-fyi",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-waiting",
      "target": "wiki-notes-deadline-externo",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-workspace-boundary",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-notes-workspace-boundary",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    },
    {
      "source": "wiki-references-kepano-and-karpathy-principles",
      "target": "wiki-notes-foundation-harness",
      "type": "wikilink"
    },
    {
      "source": "wiki-references-kepano-and-karpathy-principles",
      "target": "wiki-notes-sota-research-gate",
      "type": "wikilink"
    }
  ]
};
