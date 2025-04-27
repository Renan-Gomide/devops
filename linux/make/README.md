# 📌 Tutorial de Automação com Make e Scripts de Shell no Linux

Este tutorial fornece um guia passo a passo para configurar e usar `Make` e scripts de shell para automatizar tarefas no Linux. Inclui exemplos práticos e uma tabela resumida para referência rápida.

---

## 🛠️ Usando Make para Automação

`Make` é uma ferramenta poderosa para definir e executar tarefas automatizadas. Ele usa um arquivo chamado `Makefile` para definir as tarefas e suas dependências.

### 📥 Instalação do Make

A maioria das distribuições Linux já vem com `Make` instalado. Para verificar, execute:

```bash
make --version
```

Se não estiver instalado, você pode instalá-lo usando:

```bash
sudo apt-get install make
```

Checar os diretórios incluídos no `PATH`:

```bash
echo $PATH
```

verificar se o Make está no `PATH` e disponível globalmente:

```bash
which make
```

### 📄 Criando um Makefile

Um `Makefile` define as tarefas e suas dependências. Aqui estão os principais componentes de um `Makefile`:

- **Alvos (Targets):** São os nomes das tarefas que você deseja executar.
- **Dependências:** São os arquivos ou tarefas que precisam ser concluídos antes do alvo.
- **Receitas (Recipes):** São os comandos que serão executados para completar o alvo.

**Exemplo de Makefile para automatizar comandos do Git:**

**Makefile:**

```makefile
# Makefile

.PHONY: status commit push

# Alvo 'status' que não tem dependências
status:
	git status

# Alvo 'commit' que não tem dependências
commit:
	git add .
	git commit -m "Atualização automática"

# Alvo 'push' que não tem dependências
push:
	git push origin main

# Alvo 'all' que depende dos alvos 'status', 'commit' e 'push'
all: status commit push
```

### 🚀 Usando Make

- **Verificar o status do Git:**

  ```bash
  make status
  ```

- **Adicionar e confirmar mudanças:**

  ```bash
  make commit
  ```

- **Enviar mudanças para o repositório remoto:**

  ```bash
  make push
  ```

- **Executar todas as tarefas em sequência:**
  ```bash
  make all
  ```

---

## 📝 Usando Scripts de Shell para Automação

Scripts de shell são arquivos de texto que contêm comandos do shell. Eles são extremamente flexíveis e podem ser usados para qualquer tipo de automação.

### 📄 Criando um Script de Shell

Aqui está um exemplo de script de shell para automatizar comandos do Git:

**script.sh:**

```bash
#!/bin/bash

# Verificar status do Git
git status

# Adicionar e confirmar mudanças
git add .
git commit -m "Atualização automática"

# Enviar mudanças para o repositório remoto
git push origin main
```

### 🚀 Usando Scripts de Shell

1. **Tornar o script executável:**

```bash
chmod +x script.sh
```

2. **Executar o script:**

```bash
./script.sh
```

### 🔧 Adicionando Interatividade

Você pode tornar seus scripts de shell interativos solicitando entrada do usuário:

**interactive_script.sh:**

```bash
#!/bin/bash

# Solicitar mensagem de commit
read -p "Digite a mensagem de commit: " commit_message

# Verificar status do Git
git status

# Adicionar e confirmar mudanças
git add .
git commit -m "$commit_message"

# Enviar mudanças para o repositório remoto
git push origin main
```

### 🌍 Tornando Scripts Globais

Para que um script de shell possa ser executado de qualquer diretório, você pode colocá-lo em um diretório que esteja no seu `PATH`, como `/usr/local/bin`.

1. **Mover o script para `/usr/local/bin`:**

```bash
sudo mv script.sh /usr/local/bin/
```

2. **Certificar-se de que o script é executável:**

```bash
sudo chmod +x /usr/local/bin/script.sh
```

Agora você pode executar o script de qualquer lugar usando:

```bash
script.sh
```

---

## 📋 Tabela Resumida

| Ferramenta | Comando/Arquivo                                          | Descrição                                |
| ---------- | -------------------------------------------------------- | ---------------------------------------- |
| **Make**   | `make status`                                            | Verifica o status do Git                 |
| **Make**   | `make commit`                                            | Adiciona e confirma mudanças             |
| **Make**   | `make push`                                              | Envia mudanças para o repositório remoto |
| **Make**   | `make all`                                               | Executa todas as tarefas em sequência    |
| **Shell**  | `chmod +x script.sh`                                     | Torna o script executável                |
| **Shell**  | `./script.sh`                                            | Executa o script de shell                |
| **Shell**  | `read -p "Digite a mensagem de commit: " commit_message` | Solicita entrada do usuário              |
| **Shell**  | `sudo mv script.sh /usr/local/bin/`                      | Move o script para um diretório global   |
| **Shell**  | `sudo chmod +x /usr/local/bin/script.sh`                 | Torna o script global executável         |

---

## 🌟 Conclusão

Tanto `Make` quanto scripts de shell são ferramentas poderosas para automação de tarefas no Linux. `Make` é ideal para organizar tarefas complexas com dependências, enquanto scripts de shell oferecem flexibilidade máxima para qualquer tipo de automação. Escolha a ferramenta que melhor se adapta às suas necessidades e comece a automatizar suas tarefas hoje mesmo! 🚀
