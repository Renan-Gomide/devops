# Tutorial: Usando Taskfile para Automação de Tarefas

Este tutorial descreve como configurar e usar o **Taskfile** com a ferramenta **Task** para automatizar tarefas de desenvolvimento e operações. O **Task** é uma ferramenta de automação de tarefas que permite definir e executar comandos de forma simples e eficiente.

## Pré-requisitos

- Ubuntu 20.04 ou superior (também pode ser usado em outras distribuições, com as adaptações necessárias)
- Acesso à linha de comando (Terminal)
- O pacote **Task** deve estar instalado no seu sistema

## Passo 1: Instalar o Task

### 1.1 Adicionar o repositório do Task

Primeiro, adicione o repositório do **Task** (taskfile) para instalar a versão mais recente:

```bash
sudo add-apt-repository ppa:go-task/ppa
```

### 1.2 Atualizar pacotes e instalar o Task

Agora, atualize os pacotes do sistema e instale o **task**:

```bash
sudo apt update
sudo apt install task
```

Isso irá instalar o **Task** em seu sistema, permitindo o uso de **Taskfile** para automação de tarefas.

## Passo 2: Criando um Taskfile

### 2.1 Estrutura Básica de um Taskfile

Um **Taskfile** é um arquivo YAML onde você pode definir várias tarefas a serem executadas. Aqui está um exemplo simples de um `Taskfile.yml`:

```yaml
version: '3'

tasks:
  # Tarefa de instalação
  install:
    cmds:
      - sudo apt update
      - sudo apt install -y build-essential curl git

  # Tarefa de limpeza
  clean:
    cmds:
      - sudo apt autoremove -y
      - sudo apt clean

  # Tarefa de desenvolvimento
  dev:
    cmds:
      - echo "Iniciando o ambiente de desenvolvimento..."
      - python3 -m venv venv
      - source venv/bin/activate
      - pip install -r requirements.txt
```

### 2.2 Explicação do Taskfile

- **version**: Define a versão do Taskfile. A versão `'3'` é a mais recente.
- **tasks**: A lista de tarefas que serão executadas.
  - Cada tarefa tem um nome (como `install`, `clean`, `dev`).
  - **cmds**: São os comandos que serão executados quando a tarefa for chamada.

## Passo 3: Executando Tarefas

### 3.1 Executando uma Tarefa

Depois de criar o seu `Taskfile.yml`, você pode executar qualquer tarefa definida no arquivo usando o seguinte comando:

```bash
task <nome-da-tarefa>
```

Por exemplo, para executar a tarefa de instalação:

```bash
task install
```

### 3.2 Executando Múltiplas Tarefas

Você pode executar várias tarefas de uma vez utilizando o comando:

```bash
task install clean
```

Isso executará as tarefas `install` e `clean` em sequência.

### 3.3 Verificando o Status de uma Tarefa

Para verificar o status de uma tarefa e ver o que ela está fazendo, você pode usar o comando:

```bash
task <nome-da-tarefa> --verbose
```

## Passo 4: Usando Variáveis

Você pode usar variáveis dentro do `Taskfile.yml` para tornar suas tarefas mais flexíveis. Veja um exemplo:

```yaml
version: '3'

vars:
  project_dir: "/home/user/myproject"

tasks:
  install:
    cmds:
      - cd {{.project_dir}}
      - sudo apt update
      - sudo apt install -y build-essential
```

## Passo 5: Integrando com Ansible

Se você estiver utilizando o **Ansible** para configurar o ambiente, pode invocar as tarefas do **Taskfile** diretamente de um playbook Ansible:

```yaml
- name: Executar tarefas do Taskfile
  command: task install
```

## Passo 6: Criando e Usando um Taskfile Global


Para criar um Taskfile global, siga os passos abaixo:

Crie um arquivo Taskfile.yml no diretório raiz do seu usuário (exemplo: `/.taskfile/Taskfile.yml`).

Defina suas tarefas no arquivo conforme necessário.

Ao executar, use o comando com a flag -g:
```bash
task -g <nome_da_tarefa>
```

## Conclusão

O **Taskfile** é uma ferramenta poderosa para automatizar tarefas e operações de forma simples e eficiente. Usando o **Taskfile**, você pode reduzir a quantidade de trabalho manual e garantir que seus ambientes de desenvolvimento e produção sejam configurados de forma consistente.

### Links úteis

- [Taskfile Official Documentation](https://taskfile.dev/)
