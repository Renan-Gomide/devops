# 🚀 Guia Completo: Comandos Básicos do GitHub e Git

Seja bem-vindo(a) a este tutorial prático que vai te ajudar a dominar os comandos essenciais para o uso do GitHub e do Git. Aqui você encontrará instruções detalhadas, exemplos práticos e dicas que facilitam o entendimento para que qualquer pessoa, mesmo quem está começando, consiga colocar seu código sob controle de versão e colaborar de forma eficiente.

---

## 📚 Sumário

1. [Introdução ao GitHub CLI](#introdução-ao-github-cli)
2. [Configurando o Git Local](#configurando-o-git-local)
3. [Criando e Gerenciando Repositórios](#criando-e-gerenciando-repositórios)
4. [Trabalhando com Commits e Branches](#trabalhando-com-commits-e-branches)
5. [Gerenciando Tags](#gerenciando-tags)
6. [Sincronizando com o Repositório Remoto](#sincronizando-com-o-repositório-remoto)
7. [Merge, Pull Requests e Revisão de Código](#merge-pull-requests-e-revisão-de-código)
8. [Desfazendo Alterações](#desfazendo-alterações)
9. [Melhores Práticas e Dicas Adicionais](#melhores-práticas-e-dicas-adicionais)
10. [Tabela Resumida dos Comandos](#tabela-resumida-dos-comandos)

---

## Introdução ao GitHub CLI

O **GitHub CLI** é uma ferramenta poderosa que permite interagir com o GitHub diretamente do terminal. Isso significa que você pode criar repositórios, gerenciar pull requests, issues e muito mais sem precisar abrir o navegador.

### Instalação e Verificação

#### No Windows

1. Baixe o instalador [aqui](https://cli.github.com/).
2. Execute o instalador e siga as instruções na tela.

Verifique a instalação abrindo o terminal e executando:

```powershell
gh --version
```

#### No Linux (Ubuntu/Debian)

Abra o terminal e execute:

```bash
sudo apt update && sudo apt install gh -y
```

### Autenticação

Para conectar sua conta GitHub via CLI, basta rodar:

```bash
gh auth login
```

Siga as instruções para autenticar. Essa etapa é essencial para que você possa criar repositórios e interagir com seu perfil.

---

## Configurando o Git Local

Antes de começar a versionar seus projetos, é importante configurar o Git no seu ambiente local.

### Instalação do Git

#### Windows

Baixe o instalador do Git [aqui](https://git-scm.com/downloads) e siga as instruções.

#### Linux (Ubuntu/Debian)

```bash
sudo apt update && sudo apt install git -y
```

### Configurando suas Credenciais

Configure seu nome e email (essas informações ficarão associadas a cada commit):

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seuemail@example.com"
```

Verifique a configuração com:

```bash
git config --list
```

### Integração com o VSCode

Se você usa o VSCode, pode definir o caminho do Git nas configurações. Para isso:

1. Abra as configurações com `Ctrl + ,`.
2. Procure por `git.path` e adicione o caminho do Git no `settings.json`:

   ```json
   "git.path": "E:\\Aplicativos\\Git\\bin\\git.exe"
   ```

---

## Criando e Gerenciando Repositórios

Agora que o Git e o GitHub CLI estão configurados, vamos aprender a criar e gerenciar repositórios.

### Criar um Repositório Local

```bash
mkdir meu-repo && cd meu-repo
git init -b main
```

Este comando cria um novo repositório Git na pasta atual e define a branch principal como `main`.

### Adicionar um Repositório Remoto

Após criar o repositório local, vincule-o ao GitHub:

```bash
git remote add origin https://github.com/seu-usuario/meu-repo.git
```

### Clonar um Repositório Existente

Você pode clonar um repositório já existente de duas maneiras:

- Usando o Git:

  ```bash
  git clone https://github.com/seu-usuario/meu-repo.git
  ```

- Usando o GitHub CLI:

  ```bash
  gh repo clone nomeRepositorio
  ```

### Criar um Repositório Diretamente no GitHub

#### Sem Push Imediato

```bash
gh repo create meu-repo --public --default-branch main
```

#### Com Push Imediato

```bash
gh repo create meu-repo --public --source=. --push
```

Verifique se o repositório remoto foi adicionado corretamente com:

```bash
git remote -v
```

---

## Trabalhando com Commits e Branches

Entenda como registrar alterações e trabalhar com múltiplas linhas de desenvolvimento.

### Adicionando Arquivos e Criando Commits

Para adicionar arquivos ao staging e criar um commit:

```bash
git add nome-do-arquivo
# Ou para adicionar todos os arquivos:
git add .
git commit -m "Mensagem do commit"
```

### Trabalhando com Branches

Crie uma nova branch para novas funcionalidades ou correções:

```bash
git checkout -b minha-nova-branch
```

Para mudar para uma branch já existente:

```bash
git checkout nome-da-branch
```

Liste todas as branches locais com:

```bash
git branch
```

---

## Gerenciando Tags

As tags são úteis para marcar pontos importantes, como lançamentos de versões.

### Criando e Listando Tags

Crie uma nova tag anotada:

```bash
git tag -a v1.0 -m "Versão 1.0"
```

Liste todas as tags:

```bash
git tag
```

### Enviando e Deletando Tags

Envie as tags para o repositório remoto:

```bash
git push origin --tags
```

Para deletar uma tag localmente:

```bash
git tag -d v1.0
```

E para removê-la do repositório remoto:

```bash
git push origin --delete tag v1.0
```

---

## Sincronizando com o Repositório Remoto

Manter seu repositório local sincronizado é fundamental para um fluxo de trabalho colaborativo.

### Enviando Alterações

Após os commits, envie as alterações para o GitHub:

```bash
git push origin nome-da-branch
```

### Atualizando o Repositório Local

Para incorporar as mudanças do repositório remoto:

```bash
git pull origin nome-da-branch
```

---

## Merge, Pull Requests e Revisão de Código

A colaboração é facilitada por merge e pull requests, que permitem integrar e revisar mudanças de forma segura.

### Realizando um Merge

Para mesclar uma branch com a principal:

```bash
git checkout main
git merge minha-nova-branch
```

### Criando um Pull Request via GitHub CLI

Crie um PR para revisar e discutir mudanças:

```bash
gh pr create --base main --head minha-nova-branch --title "Novo recurso" --body "Descrição da feature"
```

_Dica:_ Sempre peça revisão de código por um colega para garantir a qualidade do código antes de integrá-lo.

---

## Desfazendo Alterações

Se algo não sair como esperado, é possível desfazer alterações.

### Antes do Commit

Para desfazer alterações em um arquivo antes de um commit:

```bash
git restore nome-do-arquivo
```

### Resetando Commits

Para remover o último commit mantendo as alterações nos arquivos:

```bash
git reset HEAD~1
```

Para remover o commit e as alterações:

```bash
git reset --hard HEAD~1
```

---

## Melhores Práticas e Dicas Adicionais

### Mensagens de Commit

- **Clareza e objetividade:** Use o modo imperativo ("Adiciona", "Corrige", "Remove").
- **Detalhamento:** Explique brevemente a mudança e o motivo.

### Uso de Branches

- **Branches de feature:** Crie uma branch para cada nova funcionalidade ou correção.
- **Nomenclatura:** Use nomes descritivos, por exemplo, `feature/login-oauth` ou `bugfix/corrigir-css`.

### Versionamento Semântico

- Utilize o padrão **MAJOR.MINOR.PATCH** para identificar versões:
  - **MAJOR:** Alterações incompatíveis.
  - **MINOR:** Novas funcionalidades compatíveis.
  - **PATCH:** Correções de bugs.

### Chaves SSH

Para segurança e praticidade:

- **Verificar chave existente:**

  ```bash
  ls ~/.ssh/id_rsa.pub
  ```

- **Gerar nova chave SSH:**

  ```bash
  ssh-keygen -t rsa -b 4096 -C "seuemail@example.com"
  ```

- **Testar a conexão:**

  ```bash
  ssh -T git@github.com
  ```

---

## Tabela Resumida dos Comandos

| **Tópico**                                      | **Comando**                                                                                              | **Descrição**                                             |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| **Instalar Git (Linux)**                        | `sudo apt update && sudo apt install git -y`                                                             | Instala o Git no Ubuntu/Debian.                           |
| **Configurar Nome e Email**                     | `git config --global user.name "Seu Nome"`<br>`git config --global user.email "seuemail@example.com"`    | Define suas credenciais para os commits.                  |
| **Verificar Configuração do Git**               | `git config --list`                                                                                      | Exibe a configuração atual do Git.                        |
| **Criar Repositório Local**                     | `mkdir meu-repo && cd meu-repo && git init -b main`                                                      | Cria um repositório local com branch principal "main".    |
| **Adicionar Repositório Remoto**                | `git remote add origin https://github.com/seu-usuario/meu-repo.git`                                      | Vincula o repositório local ao repositório remoto.        |
| **Clonar Repositório**                          | `git clone https://github.com/seu-usuario/meu-repo.git`                                                  | Clona um repositório existente do GitHub.                 |
| **Adicionar Arquivos ao Commit**                | `git add nome-do-arquivo`<br>`git add .`                                                                 | Prepara os arquivos para serem commitados.                |
| **Criar um Commit**                             | `git commit -m "Mensagem do commit"`                                                                     | Registra alterações com uma mensagem descritiva.          |
| **Enviar Alterações**                           | `git push origin nome-da-branch`                                                                         | Envia os commits para o repositório remoto.               |
| **Atualizar Repositório Local**                 | `git pull origin nome-da-branch`                                                                         | Sincroniza o repositório local com as mudanças remotas.   |
| **Criar Nova Branch**                           | `git checkout -b minha-nova-branch`                                                                      | Cria e alterna para uma nova branch.                      |
| **Fazer Merge de Branches**                     | `git checkout main && git merge minha-nova-branch`                                                       | Mescla as alterações da branch na branch principal.       |
| **Criar Tag**                                   | `git tag -a v1.0 -m "Versão 1.0"`                                                                        | Cria uma tag anotada para marcar uma versão.              |
| **Enviar Tags**                                 | `git push origin --tags`                                                                                 | Envia todas as tags para o repositório remoto.            |
| **Desfazer Alterações (antes do commit)**       | `git restore nome-do-arquivo`                                                                            | Restaura o arquivo para o último commit.                  |
| **Resetar Último Commit (mantendo alterações)** | `git reset HEAD~1`                                                                                       | Remove o último commit, mantendo os arquivos modificados. |
| **Resetar Último Commit (exclusivo)**           | `git reset --hard HEAD~1`                                                                                | Remove completamente o último commit e suas alterações.   |
| **Criar Pull Request**                          | `gh pr create --base main --head minha-nova-branch --title "Novo recurso" --body "Descrição da feature"` | Abre um pull request via GitHub CLI.                      |
| **Testar Conexão SSH**                          | `ssh -T git@github.com`                                                                                  | Testa a conexão SSH com o GitHub.                         |

---

## Conclusão

Com este guia, você tem em mãos os comandos e práticas essenciais para trabalhar com Git e GitHub de forma eficiente. A partir deste tutorial, você pode:

- Configurar seu ambiente de desenvolvimento.
- Gerenciar repositórios e controlar versões do seu código.
- Colaborar com outros desenvolvedores através de branches e pull requests.
- Aplicar melhores práticas para manter um histórico de commits claro e organizado.

Agora é só praticar e transformar seu fluxo de trabalho em algo ainda mais profissional e ágil!

---

> **Dica Extra:** Explore a documentação oficial do [Git](https://git-scm.com/doc) e do [GitHub CLI](https://cli.github.com/manual/) para descobrir recursos avançados que podem facilitar ainda mais o seu dia a dia no desenvolvimento.
