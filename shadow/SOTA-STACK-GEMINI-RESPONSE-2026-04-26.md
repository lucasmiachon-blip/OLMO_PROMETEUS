Como "perna" do modelo Gemini nesta decisão triádica, assumo meu papel de avaliação técnica. Este não é um ambiente de tutorial; trataremos o laboratório Prometeus como uma infraestrutura de estado da arte. 

Aqui está a avaliação rigorosa do seu stack, considerando o cenário técnico atual (26 de abril de 2026).

---

### 1. Análise de Claims (Relatório Opus vs. Realidade)

Apontei explicitamente o nível de veracidade das premissas subentendidas no seu escopo:

*   **Gemini 3.1 Pro Preview**: **Fato Verificado**. Lançado oficialmente pela Google em fevereiro de 2026. Possui otimizações profundas para ferramentas e engenharia de software, incluindo um endpoint específico: `gemini-3.1-pro-preview-customtools`, altamente otimizado para integração nativa com bash.
*   **Janela de 2M Tokens no Gemini 3.1 Pro**: **Fato Incorreto / Não Verificado em Documentação Oficial**. A documentação técnica oficial da Google para o Gemini 3.1 Pro Preview estabelece o limite de entrada em **1.048.576 tokens (1M)**. A janela de 2M foi um marco da série 1.5 Pro, mas a arquitetura 3.1 focou em densidade de raciocínio, eficiência de tokens e níveis de "Thinking" (ex: parâmetro `thinking_level: MEDIUM`), trocando expansão horizontal extrema por precisão de contexto estruturado.
*   **ChatGPT 5.5**: **Fato Verificado**. Lançado pela OpenAI há apenas dois dias (23/24 de abril de 2026). O diferencial atual do modelo (GPT-5.5 Thinking e GPT-5.5 Pro) é a aderência rígida a instruções, menor desperdício de tokens em raciocínios errados e capacidade SOTA em mapeamento *cross-file* (raciocínio através de múltiplos documentos).
*   **Claude Code vs Codex CLI**: **Fato Verificado**. O cenário SOTA de terminais é hoje um duopólio. O Codex CLI aplica *sandboxing* restrito a nível de kernel do SO (Landlock+Seccomp no Linux), enquanto o Claude Code atua no nível da aplicação, operando com arquitetura de subagentes autônomos e o padrão de extensibilidade "Agent Skills" (SKILL.md).

---

### 2. Estado da Arte Verificável (2026-04-26)

*   **Sistema Operacional**: O **Ubuntu 26.04 LTS (Resolute Raccoon)** foi lançado há 3 dias (23 de abril de 2026). Traz kernel 7.0 e GNOME Wayland-only. No entanto, para ambientes WSL2 corporativos e de pesquisa, este sistema encontra-se no estágio de "risco zero-day".
*   **Orquestração de Agentes no Terminal**: Agentes CLI abandonaram o conceito de "assistentes conversacionais" para se tornarem orquestradores de fluxo. O Claude Code agora suporta "Scheduled Tasks" e "Cloud Auto-fix" pós-PR, enquanto dita o ecossistema com o padrão MCP (Model Context Protocol).
*   **Linguagens e Toolchain**:
    *   **Python**: `uv` (Astral) substituiu virtualmente pip/poetry no alto escalão, acompanhado pelo linter `ruff`.
    *   **TypeScript/JS**: `bun` amadureceu como runtime de baixíssima latência (vital para ferramentas chamadas repetitivamente por agentes de IA), enquanto `biome` substituiu o gargalo do Prettier+ESLint.
*   **Gargalo do `/mnt/c` no WSL2**: *Inscrição de Fato*: O driver 9p protocol do WSL2 e a tradução do NTFS causam degradação de I/O em até 80% em operações massivas (ex: `node_modules` ou leituras/escritas em alta frequência por agentes de IA inspecionando repositórios). 

---

### 3. Arquitetura de Stack Recomendada para o "Prometeus"

Baseado na natureza não-iniciante do laboratório, recomendo a seguinte arquitetura de execução:

*   **Core OS**: **WSL2 com Ubuntu 24.04 LTS**. Bloqueie a migração para 26.04 LTS. *Inscrição de Risco*: Atualizações prematuras do Linux 7.0 no WSL podem quebrar compilações locais sem oferecer ganhos imediatos ao toolchain de IA.
*   **Filesystem / Workspace**: O projeto `OLMO_PROMETEUS` **precisa residir na partição ext4 nativa do Linux** (`~/Dev/Projetos/OLMO_PROMETEUS`). Arquitetos AI e Agentes operando no CLI não toleram a latência do `/mnt/c`. A interoperabilidade com o Windows (para Obsidian, por exemplo) deve ocorrer mapeando o drive de rede do WSL (`\\wsl.localhost\Ubuntu\home\...`) a partir do Windows, e não o inverso.
*   **Agentes de Terminal**:
    *   **Claude Code (Pilar de Arquitetura)**: Usado para "commits" pesados, tarefas que demandam arquitetura de software complexa, *Test-Driven Development* iterativo e uso rigoroso do ecossistema MCP.
    *   **Codex CLI (Operacional / Econômico)**: Usado para "keystrokes". Refatorações rápidas e scripts de manutenção, devido à sua eficiência (até 8x mais barato em tokens e execução veloz com sandbox do kernel).
*   **Chamadas Dinâmicas / API Triádica**: Scripts de orquestração interna rodando via `uv` devem disparar APIs utilizando **ChatGPT 5.5** para roteamento lógico e o endpoint **`gemini-3.1-pro-preview-customtools`** para sub-processos que exigem execução de bash de forma não-supervisionada.
*   **Shell**: `nushell` para operações do desenvolvedor humano lidando com dados tubulares (JSON/CSV parse nativo). Porém, o sub-shell entregue ao modelo (Gemini ou Claude) **deve** ser o `bash` estrito, devido às métricas de aderência a instruções de LLMs.

---

### 4. Decisões: Amanhã vs. Bloqueadas

**Para executar amanhã:**
1.  **Adoção do `uv` + `ruff` + `bun` + `biome`**. Eles eliminam os gargalos de performance que atrasam o *loop* de reflexão dos agentes. Ferramentas lentas induzem a IA a interromper cadeias de pensamento por "timeout" ou a desperdiçar contexto.
2.  **Transplante controlado do rootdir**: Iniciar a migração da `C:\Dev` para `~/Dev` ext4.
3.  **Estabelecer o Padrão SKILL.md**: Criar imediatamente diretórios de Agent Skills locais para definir o contexto de arquitetura para o Claude Code (para evitar que ele quebre o padrão da sua infraestrutura toda vez que abrir a sessão).

**Para ficar bloqueado rigorosamente:**
1.  **Upgrade de SO para Ubuntu 26.04 LTS**. A liberação do `26.04.1` será só em meados de Julho. Evite o sangramento de *day-one bugs*.
2.  **Migrações Automáticas**. *Decisão:* Nenhum script deve mover os arquivos do Obsidian e reescrever *symlinks* sem confirmação. O Prometeus não deve delegar ações destrutivas de FS a agentes antes que a latência no WSL nativo seja validada.
3.  **Deploy em produção do GPT-5.5 para chamadas que requerem Sandboxing no Servidor** (aguardar maturação de segurança do modelo recém-lançado esta semana para vetores de injeção direta).

---

### 5. Riscos, Custo, Rollback e Critério Negativo

*   **Riscos e Segurança**: Agentes com acesso nativo (Claude Code) podem acidentalmente corromper configurações de rede e limpar *states* do diretório. A segurança baseada em permissão do Claude não é estanque no nível do kernel como o Codex CLI.
*   **Custo**: Claude Code usando a família Opus / 4.6 queima limites financeiros em horas se deixado em *auto-mode* em projetos de alta superfície.
*   **Estratégia de Rollback**: A migração de `/mnt/c` para `ext4` deve ser feita espelhando os arquivos. A pasta `C:\Dev\Projetos\OLMO_PROMETEUS` continuará existindo, configurada como *Read-Only* pelo Windows temporariamente. Se o Obsidian falhar ou a performance for inesperada, o rollback é instantâneo apenas desfazendo o Read-Only e abandonando o diretório Linux.
*   **Critério Negativo (Condição de Abortar)**: Se o Vault do Obsidian mapeado via `\\wsl.localhost\` para o Windows 11 sofrer com travamentos de indexação (file watching/inotify limits), ou se os plugins do Obsidian falharem em escrever metadados, *aborte* a migração do FS e retorne para `/mnt/c`, transferindo o custo de I/O de volta ao Agente em vez de sacrificar a base de conhecimento humano.

---

### 6. Experimento Mínimo de 7 Dias (Baseado em Evidências)

*   **Dias 1 e 2 (Isolamento de Variáveis)**:
    *   Sincronize com `rsync` seu projeto principal do `/mnt/c` para o filesystem nativo do Ubuntu (`~/Dev/`).
    *   Aponte seu Obsidian local e o VS Code (via WSL-Remote) para este novo caminho. Verifique a telemetria do *inotify* nas primeiras 48h.
*   **Dia 3 e 4 (Estresse da Toolchain)**:
    *   Substitua o *requirements* atual por um fluxo com `uv` e `ruff` num branch apartado.
    *   Execute o Codex CLI para varrer e refatorar 100 arquivos com `uv`. Meça o tempo e os logs de erro comparados com a operação anterior no disco `C:\`.
*   **Dia 5 e 6 (Operação Agentic SOTA)**:
    *   Inicie o Claude Code em uma sessão complexa focada em arquitetura. Forneça o contexto triádico usando um script de ponte entre o modelo e a API Gemini (`gemini-3.1-pro-preview-customtools`) ou ChatGPT 5.5 Pro. Avalie se o agente mantém coesão nas instruções do projeto sem derivar (*context drift*) após 1 hora de trabalho autônomo.
*   **Dia 7 (Fronteira de Decisão)**:
    *   Revisão quantitativa: Agregação de custos no *billing* do Anthropic/OpenAI e métricas de velocidade de compilação.
    *   *Decisão Executiva*: Se não houve corrupção no Obsidian e o ganho em *build time* for de fato expressivo (esperado > 40%), remova definitivamente o repositório de trabalho da partição Windows NTFS.

--- SOURCES ---
1. google.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQG4n5wyPXNo4PP6H7bYXxniiHE7xZRaddaLQ-ZpljcbQ8o4jUseBVoLXZyatdth427WZ7WTvq9pvPL9H_thXB6BYd6CAy1i3VkGaxqGqsmx6Zn7Bm6R-LQFzKBcRI_ERw7YtxH0gGoWFcnMn_iRkIAlnL6I3biZMOQ9xBb-Jpj60Pa5yrtkxc3UnaYC
2. google.dev https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFu5W6_utET8MD17ordTZJ6f7IRrP2-YwrQ-Qr2dAi_C-Ig03Zn2Wp4QiDu-FJwMXdZ90cWPFAYIGbSnRLreWS0CB_AwZj4KOSgeMO0Yy0FeG6NkLMzBXBl9quKYv5NRiDF4-89f3-IAEEz26GcyJyqWx4SBBy7Euj1IOLEILM=
3. webiano.digital https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQE9woOOwi0eRrlMjyQW7k15y2kgHpl0piiNUJA2ZX9VEfBMRNO2yS0GTS-P2m-j1Y1v0PM8a57wSprZdjkWsxiztWAE8gEm8qUhH1rFOYUtDYroIk8DQbz6Z8bdT53KpAjLuVfusJj4I0AqrHwZrLLTW_Wm2Rp0CeGZj1_Ci41hWU8=
4. cnet.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFP4C7EfG9MlAQwiqOuU5_pq8ddksNPi2XkJRklYtu9rhkDfU5afefnDpuLfZwurQISiftVpVZ9DPeeuPoYkLhNT_9Rc_dcsZjSkkTA_fPeunAnMFhK0KWXcoXbc0bApCMp6ze7l54hAC9UZ5nzZZT3-en8T4S6jsLJEtvdFHeR2fLaM6LxQ9tws_SxsZwTaaRF7mHjXCsRMEghcsBFWSidAw==
5. substack.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHRbCmLzNT7tlj9asKSqLSx3qHFchm5lY-dvL5nvlQEwjY8v-opIqQjYvv0u5fv_spKRunYPiIk1a7EAr-XU6_UPELs6_PC_UFfnG65XQeQvP8vlp-hAZ64UPX-xrT9g2mn1omkGee4rO3pJmsde1dpSBZKGKlQ0fe-ARvTkQ==
6. nxcode.io https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHOmv9nvx4uUKUbSjw8S2qnDO_GePavOpEHD0uzM2hZakvQO7OW5Iz5HmwqpTLpwCEJJ1ziaQWPXohsRdEayBgx918vq37bgI66IgPCfiUm8aptfraBDjjEiaPGQRZBrxmOrqBgO7equ7G09UKKwfL-sPmZZ3w6zF8M54z9dNp4-yshGGX6xRJ7KhqdWyDEsyBLaXwcK5SbxQ==
7. firecrawl.dev https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQG8X2GPGAN4M90ROD_qkhfr7g5VFhmgeERs5P_1n6ob-PAHcQX-rh3VdFhoVAxSM2-pdXbgKZbO8W53RghhXln-UKBTcgU3DY_rsIjmBf1n_SSmJ8HxHS_WxMMmBCzVDql298pU-Wo1TmzaUa7Nl_Fo7w==
8. youtube.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH_wbgYIQ8YKc94Ej12Odw1o73ow8KXX20yNcJa_SRlDGBdsQqmWIMA7ttQPJEofZn7Wa_OE3WRuC5lK2oj--pVjFwpDIxvlJeZ0Hnvr3H8zvdvnBleUs0pAzgs-RS92T94rtWRq18=
9. omgubuntu.co.uk https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHzhIHBKkfjoPurjvbl93S_mJIHyJWeV6N8T9w-0HXiBtExxnuvhoA8bOV7ou8-fyNUiKFoG28U1UyuECZO7-aiQ--3rC4AqjqzEPsc-5ZJUzyFMEApXvU8Kc7tXDECOmoQnVpCQ8sYFlvvtKt3SvW724KsYsX_E0A=
10. linuxize.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQE0Bg7lEHvBWPaRphlwI0p8-dflQ2U5BdzXLUu21o3zhhrnExA6fm1t1mnlt1WcPRSlXd3QL3Hi6unc1CDVRMNevk249Mu4FQHamGikP-5NwdI1MRUO3eKvUYtwA7hYVWpm_HsV-k-z55w0w-niIcoECGq4Ng==
11. blakecrosley.com https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHpUTP7r_Ky1uA9O-nuyAV74m6pA2CBWPhqiRsAZQvlHd-Yu4Fo4S3FcXYfTjSBTnbL9my1VFlbQmuBk2Qi-rmDaTo_U3Xzcyv_SqrwEpwgNAQ69ZIz6gDkJs5MonbIXgT3XYYiqu0=
12. builder.io https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFIoXof0j7QlEAFr4jTRkgi9gVj9yGoJ3iRwVlqMeUz8VER51XIZDG0cpqFFxo2DjUPDyXP8J8U4ZzstI5nCNWFMuZN_EOYE87Zp8L7uJxjLuI4Ad7NIpD8LTZ1j-8kymU1lAwR4qQjPzkL
