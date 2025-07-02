# Monitoramento de Validade da Licença cPanel via Zabbix

Este projeto permite monitorar a validade da licença do cPanel/WHM através do Zabbix, alertando automaticamente quando a licença não é reativada após um período pré-definido (por padrão, 32 dias).

## 📌 Requisitos

- Servidor Zabbix (testado na versão 7.0.16)
- Acesso root ao WHM (para verificação pública via IP)
- Sistema com `curl`, `date`, e bash

## 📁 Estrutura

```
scripts/
└── licenca_cpanel_monitor.sh  # Script de monitoramento
zabbix/
└── trigger_expression.txt     # Expressão da trigger no Zabbix
```

## ⚙️ Instalação

1. Copie o script para o diretório de scripts externos do Zabbix:

```bash
sudo cp scripts/licenca_cpanel_monitor.sh /usr/lib/zabbix/externalscripts/
sudo chmod +x /usr/lib/zabbix/externalscripts/licenca_cpanel_monitor.sh
```

2. Crie um novo item no Zabbix:
   - Tipo: **Monitoramento externo**
   - Chave: `licenca_cpanel_monitor.sh`
   - Tipo de informação: **Numérico (inteiro sem sinal)**
   - Interface do host: **-Nenhum-**
   - Intervalo de atualização: `1d` ou `86400s`

3. Crie uma trigger com a seguinte expressão:

```
last(/<nome-do-host>/licenca_cpanel_monitor.sh)>32
```

*Substitua `<nome-do-host>` pelo nome real do host no Zabbix.*

4. A trigger disparará quando a última reativação da licença for superior a 32 dias.

## 🧪 Teste manual

```bash
bash /usr/lib/zabbix/externalscripts/licenca_cpanel_monitor.sh
```

## 📋 Exemplo de retorno

```bash
12
```

Indica que a licença foi reativada há 12 dias.

## 🛡️ Segurança

- Este método **não requer autenticação no WHM**.
- A verificação é feita via **https://verify.cpanel.net** (consulta pública de IP).

## 🧾 Licença

[MIT](LICENSE)
