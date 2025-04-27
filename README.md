# 🚀 Projeto DevOps

Bem-vindo ao repositório **DevOps**! Este projeto reúne configurações, comandos e ferramentas essenciais para automação, gerenciamento de infraestrutura e fluxo de trabalho DevOps.

## 📂 Estrutura do Repositório

Este repositório contém documentações e configurações para as seguintes tecnologias:

- **Terraform** 🌍 - Infraestrutura como código.
- **Google SDK** ☁️ - Interação com o Google Cloud Platform.
- **Git** 🔧 - Controle de versão eficiente.
- **GitHub CLI** 🐙 - Gerenciamento do GitHub via terminal.
- **Linux** 🐧 - Comandos e configurações úteis.
- **WSL** 🖥️ - Linux dentro do Windows para desenvolvimento.

## 📖 Como Usar

Cada tecnologia possui uma pasta dedicada com sua respectiva documentação e comandos úteis. Para mais detalhes, navegue até a pasta correspondente.

```bash
cd terraform  # Exemplo: acessar a documentação do Terraform
```

## 🚧 Em Expansão

Este repositório está em constante crescimento! Novas ferramentas e guias serão adicionados regularmente.

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request. 🤝

---

🔗 **Mantenha-se atualizado!**

---

Agora iniciarei um exemplo completo de como configurar um ambiente local, usando várias das ferramentas listadas no tutorial:

1. Intalar o WSL e o Ubuntu:

```powershell
wsl --install
```

Checar a versão do linux instalada:

> wsl -l

Entrar no wsl:

> wsl

fazer update (baixar os últimos pacotes) e upgrade (instalar os ultimos pacotes) do linux:

> sudo apt update
> sudo apt upgrade

Checar se tem o ansible (ferramenta usada para configurar ambientes/máquinas):

> ansible --version

Se não tiver:

> sudo apt install ansible-core

2. Configurar o ansible

Crie na pasta do projeto um arquico chamado _ansible.cfg_, e coloque nesse arquivo a configuração do local do arquivo de inventário (descrição das máquinas a serem afetadas - neste caso, apenas a máquina local).

ansible.cfg :

[defaults]
inventory = ./hosts/hosts.yaml

Crie agora um arquivo de inventário (ex.: ./hosts/hosts.yaml).

hosts.yaml :
all:
hosts:
localhost:
ansible_connection: local

´´´
Explicação:
all:

Define o grupo principal chamado all, que é um grupo padrão no Ansible.
Todos os hosts listados no inventário pertencem automaticamente ao grupo all, a menos que sejam explicitamente atribuídos a outros grupos.
hosts:

Indica que os itens listados abaixo são os hosts (máquinas) que pertencem ao grupo all.
Aqui, estamos definindo os hosts que o Ansible gerenciará.
localhost:

Define um host chamado localhost, que representa a máquina local (o sistema onde o Ansible está sendo executado).
Este é o nome padrão usado para se referir à máquina local.
ansible_connection: local

Especifica o tipo de conexão que o Ansible deve usar para se comunicar com o host localhost.
O valor local indica que o Ansible executará os comandos diretamente na máquina local, sem usar SSH ou outros métodos de conexão remota.
Resumo:
Este inventário define apenas a máquina local (localhost) como o único host gerenciado pelo Ansible. A configuração ansible_connection: local informa ao Ansible que ele deve executar os comandos localmente, sem tentar se conectar via SSH. Isso é útil para testar playbooks ou executar tarefas diretamente na máquina onde o Ansible está instalado.
´´´

3. Vamos agora criar o _playbook_, que nada mais é que o manual com as tarefas que o ansible irá realizar.

- Instalar o Github CLI
