# 📌 Configuração do Ambiente de Desenvolvimento

Este guia fornece um passo a passo para configurar ferramentas essenciais para o desenvolvimento em Python, incluindo gerenciamento de versões, pacotes e formatação de código.

---

## 🐍 Pyenv: Gerenciamento de Versões do Python

O `pyenv` permite instalar e alternar entre diferentes versões do Python com facilidade.

### 📥 Instalação

**Windows:**

```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
```

**Linux:**

```bash
curl https://pyenv.run | bash
```

### 🔄 Atualização

- Atualizar o próprio `pyenv`:
  ```bash
  pyenv update
  ```
- Instalar a versão mais recente do Python 3.13:
  ```bash
  pyenv install 3.13:latest
  ```
- Definir uma versão global do Python:
  ```bash
  pyenv global 3.13
  ```
- Definir uma versão local do Python para um projeto:
  ```bash
  pyenv local 3.13
  ```
- Listar versões instaladas:
  ```bash
  pyenv versions
  ```

---

## 📦 Pipx: Gerenciamento de Pacotes Globais

`pipx` permite instalar pacotes Python globalmente sem afetar outras dependências do sistema.

### 📥 Instalação

**Windows:**

```powershell
python -m pip install --user pipx
pipx ensurepath
```

**Linux:**

```bash
python3 -m pip install --user pipx
pipx ensurepath
```

### 📦 Comandos Úteis

- Instalar um pacote isoladamente:
  ```bash
  pipx install nome_do_pacote
  ```
- Atualizar um pacote:
  ```bash
  pipx upgrade nome_do_pacote
  ```
- Desinstalar um pacote:
  ```bash
  pipx uninstall nome_do_pacote
  ```
- Listar pacotes instalados:
  ```bash
  pipx list
  ```

---

## 📜 Poetry: Gerenciador de Pacotes e Ambientes Virtuais

O `Poetry` facilita o gerenciamento de dependências e a criação de ambientes isolados para projetos Python.

### 📥 Instalação

```bash
pipx install poetry
```

### 🚀 Criando e Configurando um Projeto

- Criar um novo projeto:
  ```bash
  poetry new nome_do_projeto
  ```
- Entrar na pasta do projeto e instalar dependências:
  ```bash
  cd nome_do_projeto
  poetry install
  ```
- Adicionar uma nova dependência:
  ```bash
  poetry add nome_da_biblioteca
  ```
- Ativar o ambiente virtual:
  ```bash
  poetry shell
  ```
- Listar as dependências instaladas:
  ```bash
  poetry show
  ```
- Remover uma dependência:
  ```bash
  poetry remove nome_da_biblioteca
  ```

---

## 📑 Ignr: Geração Automática de .gitignore

O `ignr` cria arquivos `.gitignore` automaticamente com base em templates predefinidos.

### 📥 Instalação

```bash
pipx install ignr
```

### ✍️ Uso

- Criar um `.gitignore` para Python:
  ```bash
  ignr python > .gitignore
  ```
- Criar um `.gitignore` para múltiplas tecnologias:
  ```bash
  ignr python,linux,visualstudiocode > .gitignore
  ```
- Ver templates disponíveis:
  ```bash
  ignr --list
  ```

---

## 🛠️ Ruff: Analisador e Formatador de Código

O `Ruff` é uma ferramenta rápida para análise de código e formatação automática.

### 📥 Instalação

```bash
poetry add --group dev ruff
```

### ⚙️ Configuração

No arquivo `pyproject.toml`, adicione:

```toml
[tool.ruff]
line-length = 100
extend-exclude = ['migrations']

[tool.ruff.lint]
preview = true
select = ['I', 'F', 'E', 'W', 'PL', 'PT']

[tool.ruff.format]
preview = true
quote-style = 'single'
```

### 🚀 Uso

- Verificar código:
  ```bash
  ruff check .
  ```
- Aplicar formatação automática:
  ```bash
  ruff format .
  ```
- Corrigir erros automaticamente:
  ```bash
  ruff check . --fix
  ```

---

## 🔄 Taskipy: Automação de Tarefas

O `Taskipy` facilita a criação de atalhos para comandos recorrentes no projeto.

### 📥 Instalação

```bash
poetry add --group dev taskipy
```

### ⚙️ Configuração

No `pyproject.toml`, adicione:

```toml
[tool.taskipy.tasks]
run = 'python nomeProjeto/codigo.py'
lint = 'ruff check . && ruff check . --diff'
format = 'ruff check . --fix && ruff format .'
pre_test = 'task lint'
post_test = 'echo "Testes finalizados!"'
```

### 🚀 Uso

- Executar um atalho:
  ```bash
  task nome_do_comando
  ```
- Listar atalhos disponíveis:
  ```bash
  task --list
  ```

---

## 🔥 Resumo dos Comandos Principais

```plaintext
🔧 Pyenv
  pyenv install 3.13        # Instala o Python 3.13
  pyenv global 3.13         # Define a versão global do Python
  pyenv versions            # Lista versões instaladas

📦 Pipx
  pipx install pacote       # Instala um pacote isoladamente
  pipx list                 # Lista pacotes instalados

📜 Poetry
  poetry new projeto        # Cria um novo projeto
  poetry add biblioteca     # Adiciona uma biblioteca
  poetry shell              # Ativa o ambiente virtual
```

---

Com este guia, você tem uma configuração completa para um ambiente de desenvolvimento Python eficiente! 🚀
