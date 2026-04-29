# PHI Checklist

Status: operational guard

Use antes de qualquer digest, estudo, wiki, prompt, automacao ou agente que possa tocar saude, pessoa fisica, atendimento, exame ou documento importado.

## Stop checklist

Responder `nao` para todos antes de versionar ou enviar a LLM externa:

- Contem nome, iniciais, apelido, foto, voz, assinatura ou identificador direto?
- Contem data de nascimento, idade especifica incomum, data de atendimento, data de exame ou data de internacao?
- Contem telefone, email, endereco, cidade pequena, local de trabalho ou plano de saude?
- Contem numero de documento, prontuario, pedido, exame, guia, transacao, dispositivo ou login?
- Contem relato clinico real, imagem, audio, PDF, receita, laudo, evolucao, mensagem de paciente ou print?
- Contem combinacao que permita reidentificar uma pessoa mesmo sem nome?
- Veio de sistema clinico, email, WhatsApp, prontuario, laboratorio, seguradora ou agenda?

Se qualquer resposta for `sim`, classificar como `phi` ou `sensitive` e parar.

## Detector regex e suplemento, nao substituto

Desde 2026-04-28, `scripts/guard-secrets.sh` inclui regex para CPF formatado (`\b[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}\b`) alem dos 15 patterns de secret. Validado em `scripts/test-guard-secrets.sh` com fixtures positivos (CPF sintetico) + falsos positivos comuns (`Silva`, `Santos`, datas isoladas).

**Regra:** detector regex bloqueia commit/add quando padrao formal aparece em staged blob. Mas regex NAO substitui esta checklist humana — falsos negativos sao garantidos:

- CPF nao formatado (11 digitos cru) NAO e bloqueado: muitos CPFs aparecem sem pontos/traco em sistemas internos.
- CNS, RG, idade especifica, prontuario, datas de atendimento nao sao detectados.
- Combinacoes reidentificantes (nome + cidade pequena) nao sao detectadas.
- Conteudo clinico narrativo nao e detectado.

**Como aplicar:** sempre rodar a stop checklist acima ANTES de stage. Detector e ultima linha — pega regressoes obvias, nao garante PHI absence. Cada catch real do detector vira linha em `shadow/EVIDENCE-LOG.md` com metadado nao-sensivel (data, classe, acao tomada).

## Permitido

- Exemplo sintetico criado do zero.
- Dado publico de documentacao oficial.
- Descricao abstrata de fluxo sem caso real.
- Rubrica, checklist ou procedimento sem conteudo de paciente.

## Registro minimo quando bloquear

Registrar em `shadow/INCIDENT-LOG.md` apenas metadado nao sensivel:

- data;
- classe;
- origem geral;
- acao tomada;
- status;
- proximo passo.

Nao registrar o conteudo bloqueado.

## Fontes

- HHS HIPAA Minimum Necessary Requirement: `https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html`
- HHS HIPAA Minimum Necessary FAQ: `https://www.hhs.gov/hipaa/for-professionals/faq/minimum-necessary/index.html`

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
