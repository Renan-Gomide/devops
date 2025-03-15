# 📌 Coleção de Scripts de Shell

Esta pasta contém uma coleção de scripts de shell úteis para automação de tarefas no Linux. Cada script é projetado para facilitar e agilizar tarefas comuns.

---

## 🌍 Tornando Scripts Globais no Linux

Para que um script de shell possa ser executado de qualquer diretório, você pode colocá-lo em um diretório que esteja no seu `PATH`, como `/usr/local/bin`.

### Passos para Tornar um Script Global

1. **Mover o script para `/usr/local/bin`:**

   Suponha que você tenha um script chamado `script-git.sh`. Para movê-lo para `/usr/local/bin`, use o comando:

   ```bash
   sudo mv script-git.sh /usr/local/bin/
   ```

2. **Certificar-se de que o script é executável:**

   Depois de mover o script, torne-o executável com o comando:

   ```bash
   sudo chmod +x /usr/local/bin/script-git.sh
   ```

3. **Executar o script de qualquer lugar:**

   Agora você pode executar o script de qualquer diretório simplesmente digitando:

   ```bash
   script-git.sh
   ```

---

## 📜 Scripts Disponíveis

### `script-git.sh`

Este script automatiza uma sequência de comandos do Git para verificar o status, adicionar mudanças, criar um commit e enviar as mudanças para o repositório remoto. Se o repositório Git não estiver configurado, ele inicializa um novo repositório e cria um repositório remoto no GitHub.

#### Conteúdo do `script-git.sh`:

```bash
#!/bin/bash

# Solicitar mensagem de commit
read -p "Digite a mensagem de commit: " commit_message

# Verificar se o repositório git está configurado
git status &> /dev/null

if [ $? -ne 0 ]; then
    # Repositório Git não configurado, solicitar nome do repositório
    echo "Não há repositório Git configurado."
    read -p "Digite o nome do repositório remoto: " repo_name

    # Inicializar repositório git local com a branch "main"
    git init -b main

    # Criar repositório remoto no GitHub via API (assumindo que o usuário tenha configurado o GitHub CLI ou tokens)
    gh repo create $repo_name --public --source=. --remote=origin

    # Adicionar o repositório remoto e fazer o primeiro commit
    git add .
    git commit -m "$commit_message"
    git push -u origin main

    echo "Repositório local e remoto configurados com sucesso!"
else
    # O repositório Git já existe, apenas proceder com o commit e push
    echo "Repositório Git já configurado."
    git add .
    git commit -m "$commit_message"
    git push origin main
fi
```

#### Como Usar

1. **Tornar o script executável:**

   ```bash
   chmod +x script-git.sh
   ```

2. **Executar o script:**

   ```bash
   ./script-git.sh
   ```

3. **Seguir as instruções interativas:**

   O script solicitará que você digite uma mensagem de commit. Se o repositório Git não estiver configurado, ele solicitará o nome do repositório remoto, inicializará um novo repositório Git local, criará um repositório remoto no GitHub, e fará o primeiro commit e push. Se o repositório Git já estiver configurado, ele apenas procederá com o commit e push.

---

## 📋 Tabela Resumida dos Scripts

| Script          | Descrição                                                                                |
| --------------- | ---------------------------------------------------------------------------------------- |
| `script-git.sh` | Automatiza comandos do Git para verificar status, adicionar, commitar e enviar mudanças. |

---

## 🌟 Conclusão

Esta coleção de scripts de shell é projetada para facilitar a automação de tarefas comuns no Linux. Sinta-se à vontade para explorar, modificar e adicionar novos scripts conforme necessário. Para tornar qualquer script globalmente acessível, siga os passos descritos acima.

🚀 **Aproveite a automação e aumente sua produtividade!** 🚀
