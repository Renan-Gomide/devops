# 🚀 Guia Tutorial de pytest

> Um guia prático e visual para escrever, organizar e executar testes com **pytest**!  
> De scripts simples a suítes complexas: teste seu código Python com eficiência.

## 📋 Índice

| Seção                 | Descrição Breve                                          | Comando/Arquivo           |
|-----------------------|----------------------------------------------------------|---------------------------|
| **Instalação**        | Instalar pytest                                          | `pip install pytest`      |
| **Estrutura de Testes** | Organização de arquivos e pastas                       | `tests/`                  |
| **Escrevendo Testes** | Sintaxe básica e assertivas                              | `.py`                     |
| **Execução**          | Rodar testes no terminal                                  | `pytest`                  |
| **Marcadores**        | Tags para categorizar testes                              | `@pytest.mark`            |
| **Fixtures**          | Setup e teardown reutilizáveis                            | `@pytest.fixture`         |
| **Parametrização**    | Testar múltiplos cenários com entradas variadas          | `@pytest.mark.parametrize`|
| **Relatórios**        | Plugins para relatórios HTML, JUnit, etc.                 | `--html=report.html`      |
| **Cobertura**         | Medir cobertura de testes com coverage.py                 | `--cov=.`                 |
| **Boas Práticas**     | Dicas para testes claros, rápidos e confiáveis            | —                         |

---

## 🔧 1. Instalação

Instale o pytest via pip no seu ambiente virtual:
```bash
pip install pytest
```
Ou, em projetos com **Poetry**:
```bash
poetry add --dev pytest
```  

---

## 📁 2. Estrutura de Testes

Organize seus testes em uma pasta dedicada:
```bash
meu-projeto/
├── src/
│   └── minha_app/
│       ├── __init__.py
│       └── calc.py
├── tests/
│   ├── __init__.py
│   ├── test_calc.py
│   └── integration/
│       └── test_api.py
└── pytest.ini         # Configurações do pytest
```
- **tests/**: onde ficam todos os testes.  
- **test_*.py** ou ***_test.py**: padrões reconhecidos automaticamente.  
- **pytest.ini**: arquivo de configuração global.

Exemplo mínimo de `pytest.ini`:
```ini
[pytest]
minversion = 6.0
addopts = -ra -q
testpaths = tests
```

---

## ✍️ 3. Escrevendo Testes

Crie funções de teste com `assert`:
```python
# tests/test_calc.py
from minha_app.calc import soma

def test_soma_positivos():
    assert soma(2, 3) == 5

def test_soma_negativos():
    assert soma(-1, -1) == -2
```
- Os nomes devem começar com `test_`.  
- Use asserts simples para verificar comportamento.

---

## ▶️ 4. Executando Testes

Para rodar todos os testes:
```bash
pytest
```
Para mais verbosidade:
```bash
pytest -v
```
Para executar um arquivo específico:
```bash
pytest tests/test_calc.py
```

---

## 🏷️ 5. Marcadores

Agrupe ou sinalize testes:
```python
import pytest

@pytest.mark.lento
def test_operacao_lenta():
    assert True
```
Liste marcadores disponíveis:
```bash
pytest --markers
```
Rode apenas os rápidos:
```bash
pytest -m "not lento"
```

---

## 🔧 6. Fixtures

Defina recursos compartilhados:
```python
import pytest
from minha_app.calc import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

def test_soma(calc):
    assert calc.soma(1, 2) == 3
```
- Fixtures podem ter `scope` (`function`, `module`, `session`).  
- Use `autouse=True` para aplicar sem precisar passar como parâmetro.

---

## 🔄 7. Parametrização

Teste múltiplos cenários:
```python
import pytest
from minha_app.calc import soma

@pytest.mark.parametrize("a,b,resultado", [
    (1, 2, 3),
    (0, 0, 0),
    (-1, 1, 0),
])
def test_soma_param(a, b, resultado):
    assert soma(a, b) == resultado
```
- Evita código repetitivo e facilita cobertura de casos.

---

## 📊 8. Relatórios

Use plugins para relatórios melhores:
```bash
pip install pytest-html pytest-junitxml
pytest --html=report.html --self-contained-html
pytest --junitxml=report.xml
```
- Abra o `report.html` no navegador para visualizar.

---

## 📋 9. Cobertura de Testes

Instale e use coverage:
```bash
pip install pytest-cov
pytest --cov=src --cov-report=term-missing
```
Gera relatório no terminal e mostra linhas não cobertas.

---

## 💡 10. Boas Práticas

- 🧹 Mantenha testes pequenos e independentes.  
- 🔄 Use fixtures para setup/teardown.  
- 🚀 Integre pytest em CI (GitHub Actions, GitLab CI).  
- 📁 Separe testes unitários e de integração.  
- 📝 Documente casos de uso e limites.  

---

# 🏁 Conclusão

Com **pytest**, seus testes ficam:
- **Claros** e **legíveis**.  
- **Flexíveis** com fixtures e parametrização.  
- **Automatizados** em qualquer pipeline CI.  
Bora garantir qualidade de código! 🎉
