# Guia Rápido de Poetry para Projetos Python com Foco em CI/CD

Comece a gerenciar dependências, ambientes virtuais e publicação de pacotes com **Poetry** de forma simples e profissional.

---

## Tabela de Comandos Essenciais

| Comando                         | Descrição                                                |
|---------------------------------|----------------------------------------------------------|
| `poetry new <nome>`             | Cria novo projeto com layout padrão (src layout)         |
| `poetry init`                   | Cria `pyproject.toml` interativamente                   |
| `poetry install`                | Instala dependências listadas em `pyproject.toml`        |
| `poetry add <pacote>`           | Adiciona dependência ao projeto                          |
| `poetry add --dev <pacote>`     | Adiciona dependência de desenvolvimento                  |
| `poetry update`                 | Atualiza dependências para versões mais recentes         |
| `poetry lock`                   | Gera/atualiza o `poetry.lock`                            |
| `poetry run <comando>`          | Executa comando dentro do ambiente virtual do Poetry     |
| `poetry shell`                  | Abre um shell no ambiente virtual                        |
| `poetry publish --build`        | Empacota e publica no PyPI                               |

---

## Estrutura de Diretórios Recomendada

Um layout profissional que facilita CI/CD e colaboração:

```
my_project/
├─ src/
│  └─ my_project/
│     └─ __init__.py
├─ tests/
│  └─ test_main.py
├─ .github/
│  └─ workflows/
│     └─ ci.yml
├─ pyproject.toml
├─ poetry.lock
├─ README.md
├─ LICENSE
└─ .gitignore
```

- **src/**: Código-fonte do pacote  
- **tests/**: Testes unitários e de integração  
- **.github/workflows/**: Pipelines de CI/CD (GitHub Actions)  
- **pyproject.toml / poetry.lock**: Metadados e lockfile do Poetry  
- **README.md, LICENSE, .gitignore**: Documentação e configurações gerais  

---

## 1. Iniciando um Projeto

Crie um novo projeto com layout `src`:

```bash
poetry new my_project --src
cd my_project
```

Isso gera:

- `src/my_project/` com `__init__.py`  
- `pyproject.toml` configurado  
- `README.md` e `tests/`  

---

## 2. Instalando Dependências

Adicione dependências de runtime e desenvolvimento:

```bash
poetry add requests
poetry add --dev pytest flake8 isort
```

- Dependências normais vão em `[tool.poetry.dependencies]`  
- Dev-dependencies em `[tool.poetry.dev-dependencies]`  

---

## 3. Ambiente Virtual e Execução

- Abra um shell isolado:
  ```bash
  poetry shell
  ```
- Instale todas as dependências:
  ```bash
  poetry install
  ```
- Execute seu script:
  ```bash
  poetry run python src/my_project/main.py
  ```

---

## 4. Testes e Lint (CI/CD)

Exemplo de etapas em GitHub Actions (`.github/workflows/ci.yml`):

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.10
      - name: Install Poetry
        run: |
          pip install poetry
      - name: Install dependências
        run: poetry install
      - name: Lint
        run: poetry run flake8 src tests
      - name: Test
        run: poetry run pytest
```

---

## 5. Publicação no PyPI

Empacote e publique seu projeto:

```bash
poetry build
poetry publish --build
```

Configure seu token PyPI em `~/.pypirc` ou use `poetry config pypi-token.pypi <TOKEN>`.

---

## Conclusão

Este guia mostra como **Poetry** unifica gerenciamento de dependências, ambientes e publicação. Use-o em conjunto com pipelines de CI/CD para garantir consistência e automação em seus projetos Python.
