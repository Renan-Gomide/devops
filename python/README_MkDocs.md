# 🚀 Guia Tutorial de MkDocs

> Um guia prático e visual para criar, configurar e publicar documentação de projetos com **MkDocs**!  

## 📋 Índice

| Tópico                   | Descrição Breve                                | Comando/Arquivo          |
|--------------------------|------------------------------------------------|--------------------------|
| **Instalação**           | Instalar o MkDocs via pip                      | `pip install mkdocs`     |
| **Novo Projeto**         | Criar uma estrutura inicial de docs            | `mkdocs new meu-projeto` |
| **Servir Localmente**    | Visualizar em um servidor de desenvolvimento   | `mkdocs serve`           |
| **Build do Site**        | Gerar a versão estática da documentação        | `mkdocs build`           |
| **Configuração**         | Arquivo `mkdocs.yml` com nav, tema e plugins   | `mkdocs.yml`             |
| **Estrutura de Pastas**  | Onde ficam os arquivos Markdown                | `docs/`                  |
| **Temas**                | Default, Read the Docs, Material, etc.         | `theme:` no `mkdocs.yml` |
| **Deploy**               | Publicar no GitHub Pages                       | `mkdocs gh-deploy`       |
| **Plugins & Extras**     | Extensões e comandos avançados                  | `mkdocs <comando>`       |
| **GitHub Actions**       | CI/CD para atualizar seu site automaticamente  | Ação `.github/workflows` |

---

## 🔧 1. Instalação

Para instalar o MkDocs via pip, execute:  
```bash
pip install mkdocs
```  
Este comando instala o pacote principal do MkDocs e suas dependências em seu ambiente Python citeturn0search0.

---

## 🆕 2. Criando um Novo Projeto

Crie uma nova base de documentação com o comando:  
```bash
mkdocs new meu-projeto
```  
Isso gera `mkdocs.yml` e a pasta `docs/` com `index.md` de exemplo citeturn0search0.

---

## 📡 3. Servir Localmente

Para rodar o servidor de desenvolvimento e ver as alterações em tempo real:  
```bash
mkdocs serve
```  
Acesse `http://127.0.0.1:8000/` no navegador e edite seu Markdown para ver reload automático citeturn0search0.

---

## 📦 4. Build do Site

Para gerar os arquivos estáticos da sua documentação:  
```bash
mkdocs build
```  
Os resultados ficam na pasta `site/` pronta para deploy citeturn1search5.

---

## ⚙️ 5. Configuração (`mkdocs.yml`)

Exemplo mínimo de `mkdocs.yml`:
```yaml
site_name: Meu Projeto
nav:
  - Home: index.md
  - Sobre: about.md
theme:
  name: readthedocs
plugins:
  - search
```
- **site_name**: título da sua documentação.  
- **nav**: definição de menus e mapeamento de arquivos.  
- **theme.name**: tema padrão ou `readthedocs`, `material`, etc. citeturn1search5.  
- **plugins**: extensões como busca, redirects, diagramas, etc. citeturn1search5.

---

## 📁 6. Estrutura de Pastas

```bash
meu-projeto/
├── mkdocs.yml          # Configuração principal
├── docs/               # Fonte dos arquivos Markdown
│   ├── index.md
│   ├── about.md
│   └── guia/
│       └── setup.md
└── site/               # Gerado pelo `build` (não versionar)
```  
Qualquer arquivo Markdown em `docs/` é convertido em página estática citeturn0search8.

---

## 🎨 7. Temas

MkDocs inclui temas como:
- **mkdocs** (padrão)
- **readthedocs** (semelhante a RTD)  
Você pode instalar e usar **Material for MkDocs** para design moderno e plugins extras citeturn0search9.

---

## 🚀 8. Deploy com GitHub Pages

Para publicar automaticamente na branch `gh-pages`, use:  
```bash
mkdocs gh-deploy
```  
Isso constrói o site, comita na `gh-pages` e publica no GitHub Pages citeturn1search0.

---

## 🔌 9. Plugins & Comandos Avançados

O CLI MkDocs oferece comandos como:
- `mkdocs get-deps` – lista dependências de plugins citeturn1search5  
- `mkdocs build --clean` – limpa antes de gerar  
- `mkdocs gh-deploy --force` – força o deploy citeturn1search1

---

## 🤖 10. Integração com GitHub Actions

Exemplo de workflow `.github/workflows/ci.yml`:
```yaml
name: Deploy MkDocs
on:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.x'
      - run: pip install mkdocs-material
      - run: mkdocs gh-deploy --force
```
Automatize a atualização do seu site sempre que você der push na branch principal citeturn1search4.

---

# 🏁 Conclusão

Com este setup de **MkDocs**, você terá uma documentação:
- **Rápida** e **simples** de manter.  
- **Visualmente atrativa** com temas modernos.  
- **Automatizada** com deploy contínuo.  
Bora documentar! 🎉
