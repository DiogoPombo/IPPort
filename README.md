# IPPort

![Autor](https://img.shields.io/badge/Autor-POMBO-blue)
![Ano](https://img.shields.io/badge/Ano-2025-green)
![Versão](https://img.shields.io/badge/Vers%C3%A3o-1.0-orange)

**IPPort** é um script utilitário leve em lote (Batch/CMD) projetado para automatizar testes essenciais de conectividade ponto a ponto entre a máquina local e um host de destino (IP ou URL). Ele combina a leveza do ecossistema Batch com interfaces visuais dinâmicas do PowerShell, tornando a triagem rápida de problemas de rede mais ágil e acessível para técnicos e administradores.

---

## 🚀 Funcionalidades

- **Interface Visual Guiada:** Utiliza caixas de entrada (`InputBox`) e caixas de mensagem (`MessageBox`) gráficas via PowerShell, evitando que o operador precise digitar parâmetros diretamente na linha de comando.
- **Internacionalização Dinâmica (Bilingue):** Detecta automaticamente o idioma padrão do Sistema Operacional (através da consulta da chave `LocaleName` no Registro do Windows) e adapta toda a interface e mensagens dinamicamente para **Português (PT)** ou **Inglês (EN)**.
- **Filtro Preventivo de Hosts:** Possui uma validação de segurança que bloqueia a execução do script caso o operador insira domínios potencialmente maliciosos, de spam ou incompatíveis (como as extensões `.onion` e `.xyz`).
- **User-Agent Dinâmico:** Gera um identificador aleatório exclusivo (`IPPort_XXXX`) a cada execução do script. Essa assinatura é injetada nas requisições HTTP do `curl`, mitigando bloqueios automatizados por WAF (Web Application Firewall) durante a checagem do servidor.
- **Suporte a IPv6:** Estrutura preparada para aceitar barramentos IPv6 (orientando o usuário a utilizá-los entre colchetes, ex: `[XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX]`).

---

## 🔍 Sequência de Testes Executados (Esteira de Diagnóstico)

O script realiza uma varredura sequencial direta para isolar falhas de rede de forma clara:
1. **Validação de Conectividade TCP (`Test-NetConnection`):** Testa a abertura de uma porta específica (se informada) ou executa um diagnóstico de porta padrão, trazendo detalhes técnicos da interface de conexão.
2. **Ping Simples (`ping`):** Valida a resposta básica de eco ICMP e o tempo de latência da rota.
3. **Resolução de DNS (`nslookup`):** Consulta a resolução de nomes padrão para certificar se o domínio aponta corretamente para um IP válido.
4. **Busca por Endereço Canônico (`nslookup -type=CNAME`):** Identifica a existência de pseudônimos (aliases) ou redirecionamentos na infraestrutura de DNS do destino.
5. **Inspeção de Cabeçalho HTTP (`curl`):** Executa uma chamada do tipo `HEAD` (`-I`) com tempo limite máximo de 120 segundos e aplicando o *User-Agent* dinâmico para analisar os códigos de retorno HTTP (como 200 OK, 403 Forbidden, 500 Error).
6. **Rastreamento de Rota (`tracert`):** Lista todos os saltos pelos quais o pacote trafega até atingir o destino, ideal para identificar pontos de estrangulamento ou loops de roteamento.

---

## 📋 Pré-requisitos

- **Sistema Operacional:** Windows 10 ou Windows 11.
- **Dependências Nativas:** O script utiliza componentes nativos do Windows (`powershell.exe`, `curl.exe`, ferramentas padrão de rede). Não requer nenhuma instalação de terceiros.
- **Privilégios:** Pode ser executado em nível de usuário comum.

---

## 🛠️ Como Utilizar

1. Copie o código original do script `IPPort`.
2. Abra o **Bloco de Notas** (Notepad) ou o editor de texto de sua preferência.
3. Cole o código e salve o arquivo obrigatoriamente com a extensão **`.bat`** ou **`.cmd`** (Exemplo: `IPPort.bat`).
4. **Dica de Codificação:** Certifique-se de salvar o arquivo com a codificação `UTF-8` para garantir que os caracteres especiais e acentos sejam renderizados perfeitamente na tabela de páginas do terminal (`chcp 65001`).
5. Dê um duplo clique no arquivo gerado para iniciar os testes.

---

## 👤 Créditos e Assinatura

- **Desenvolvedor:** POMBO `\Õ/`
- **Assinatura / Chave:** `@EWEP - 2025`
- **Propósito:** Diagnóstico ágil, enxuto e direto de redes ponto a ponto.
