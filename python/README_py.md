# 🐍 Setup Moderno de Python

> Um guia prático e visual para dominar o uso de **pyenv**, **pipx**, **poetry**, **ruff**, **taskpy** e **ignr**!  
> Setup rápido, leve e profissional para seus projetos.

## 📋 Índice

| Ferramenta | O que é? | Principais Comandos | Uso Principal |
|:---|:---|:---|:---|
| **pyenv** | Gerenciador de versões do Python | `pyenv install`, `pyenv global` | Trocar versões do Python facilmente |
| **pipx** | Instala e executa apps Python em ambientes isolados | `pipx install`, `pipx run` | Rodar ferramentas sem poluir seu ambiente |
| **poetry** | Gerenciador de dependências e ambientes virtuais | `poetry init`, `poetry add`, `poetry install` | Criar, gerenciar e versionar projetos Python |
| **ruff** | Linter e formatador ultra rápido | `ruff check`, `ruff format` | Padronizar e corrigir seu código Python |
| **taskpy** | Orquestrador de tarefas simples para projetos | `task -l`, `task <tarefa>` | Automatizar rotinas comuns (ex: testes, build) |
| **ignr** | Gerador de arquivos `.gitignore` para projetos | `ignr python` | Gerar `.gitignore` na hora, sem pesquisar |

## 📁 Estrutura Padrão de Projeto

```bash
meu-projeto/
├── README.md
├── pyproject.toml        # Gerenciado pelo poetry
├── tasks.py              # Tarefas automatizadas com taskpy
├── .gitignore            # Gerado via ignr
├── src/
│   └── meu_modulo/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
└── .venv/                # Ambiente virtual (poetry)
```

---

# 🚀 Instalando e Configurando Tudo

## 1. pyenv - Gerenciador de Versões do Python

**Instalação no Linux/WSL/Ubuntu:**
```bash
curl https://pyenv.run | bash
```

Depois adicione ao seu `.bashrc` ou `.zshrc`:
```bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

**Principais comandos:**
```bash
pyenv install 3.12.2     # Instala uma versão
pyenv global 3.12.2      # Define a versão global
pyenv versions           # Lista versões instaladas
```

**Por que usar?**  
👉 Nunca mais tenha dor de cabeça com "versão incompatível" de Python!

---

## 2. pipx - Instalar Apps Python sem Poluir o Sistema

**Instalação:**
```bash
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

**Usando pipx:**
```bash
pipx install poetry ruff taskpy ignr
```

👉 Cada ferramenta instalada pelo `pipx` roda em ambiente isolado!

**Comandos úteis:**
```bash
pipx list        # Lista apps instalados
pipx upgrade-all # Atualiza todos
pipx uninstall <package> # Remove
```

---

## 3. poetry - Gerenciador de Projetos e Dependências

**Instalação via pipx:**
```bash
pipx install poetry
```

**Iniciar projeto com poetry:**
```bash
poetry init        # Inicia um projeto (faz perguntas)
poetry new meu-projeto # Cria estrutura de projeto direto
```

**Trabalhar com dependências:**
```bash
poetry add requests         # Adiciona pacote
poetry add --dev pytest      # Adiciona pacote de dev
poetry install               # Instala todas as deps
```

**Rodar comandos no ambiente isolado:**
```bash
poetry run python src/main.py
```

---

## 4. ruff - Linter e Formatador Ultra-Rápido

**Instalação via pipx:**
```bash
pipx install ruff
```

**Principais usos:**
```bash
ruff check src/        # Checar problemas
ruff format src/       # Autoformatar o código
ruff check . --fix     # Corrigir automaticamente
```

**Dica:** Configure um arquivo `pyproject.toml` com as regras de lint.

Exemplo de configuração em `pyproject.toml`:
```toml
[tool.ruff]
line-length = 88
target-version = "py312"
```

---

## 5. taskpy - Automatize Rotinas no Projeto

**Instalação via pipx:**
```bash
pipx install taskpy
```

**Crie um `tasks.py` simples:**
```python
from taskpy import task

@task
def test(ctx):
    ctx.run("pytest tests/")

@task
def lint(ctx):
    ctx.run("ruff check src/")
```

**Rodar tarefas:**
```bash
task -l       # Lista as tarefas disponíveis
task test     # Roda os testes
task lint     # Roda o linter
```

---

## 6. ignr - Gerador de .gitignore na hora

**Instalação via pipx:**
```bash
pipx install ignr
```

**Usando:**
```bash
ignr python > .gitignore
```

👉 Sem precisar abrir sites! Gera `.gitignore` atualizado para seu projeto.

---

# 🔥 Dicas Extras para um Ambiente de Trabalho Top

- 🚀 Sempre crie projetos com `poetry` para manter tudo organizado.
- 🧹 Rode `ruff` antes de cada commit para manter o código limpo.
- 📦 Use `pipx` para instalar suas ferramentas favoritas sem bagunçar seu Python.
- 🔄 Automatize testes, builds e lints com `taskpy` de forma fácil.
- 🧾 Gere `.gitignore` instantâneo com `ignr` e evite problemas de versionamento.

---

# 🏁 Conclusão

> Com esse setup, você vai trabalhar com Python de forma **moderna, rápida, organizada** e ainda com o ambiente 100% limpo e isolado.  
> Bora codar melhor! 🚀
