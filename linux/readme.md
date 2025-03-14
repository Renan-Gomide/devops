# 📌 Guia Rápido de Comandos Básicos do Linux

Este guia apresenta comandos essenciais para quem usa **Ubuntu Server**. Inclui navegação, manipulação de arquivos, gerenciamento de usuários e permissões.

---

## 🖥️ 1. Introdução ao WSL (Windows Subsystem for Linux)

O **WSL** permite rodar um ambiente Linux dentro do Windows sem a necessidade de uma máquina virtual. Para instalar e usar, siga os passos abaixo:

### 📌 Instalar o WSL no Windows

```powershell
wsl --install
```

Este comando instala automaticamente a versão padrão do Ubuntu. Caso queira uma distribuição específica, use:

```powershell
wsl --install -d <distribuição>
```

Por exemplo, para instalar o Debian:

```powershell
wsl --install -d Debian
```

### 📌 Verificar distribuições disponíveis

```powershell
wsl --list --online
```

Exibe uma lista de distribuições Linux que podem ser instaladas no WSL.

### 📌 Listar distribuições instaladas

```powershell
wsl --list --verbose
```

Mostra as distribuições já instaladas e seu status.

### 📌 Definir uma distribuição como padrão

```powershell
wsl --set-default <distribuição>
```

Define qual distribuição será usada ao rodar `wsl` sem especificar uma distribuição.

### 📌 Iniciar e acessar o WSL

```powershell
wsl
```

Abre o terminal da distribuição Linux padrão.

### 📌 Encerrar o WSL

```powershell
wsl --shutdown
```

Encerra todas as instâncias do WSL em execução.

### 📌 Localizar o caminho da partição virtual do WSL e reduzi-la

```powershell
wsl --shutdown(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq '<distribution-name>' }).GetValue("BasePath") + "\ext4.vhdx"
```

Substitua `<distribution-name>` pelo nome da distribuição. Ex. (ubuntu):

```powershell
wsl --shutdown(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq 'ubuntu' }).GetValue("BasePath") + "\ext4.vhdx"
```

Agora no _Powershell_ digite `diskpart`. Abrirá uma nova aba. Selecione a partição virtual.

```bash
DISKPART> select vdisk file="local-da-particao"

DiskPart successfully selected the virtual disk file.
```

Por último, compacte ela:

```bash
DISKPART> compact vdisk
```

---

## 🚀 2. Acessando o Linux na AWS

Para acessar um servidor Linux na AWS, baixe e utilize o **Putty** para conectar via SSH.

---

## 💻 3. Entendendo o Terminal

Quando você abre o terminal, pode ver algo assim:

```bash
renan@servidor:~$
```

| Elemento     | Significado                                |
| ------------ | ------------------------------------------ |
| **renan**    | Nome do usuário                            |
| **servidor** | Nome da máquina                            |
| **~**        | Diretório do usuário                       |
| **$**        | Usuário comum (se for `#`, é superusuário) |

---

## 📂 4. Comandos de Navegação

| Ação                                                   | Comando            | Explicação                                                      |
| ------------------------------------------------------ | ------------------ | --------------------------------------------------------------- |
| **Mostrar diretório atual**                            | `pwd`              | Exibe o caminho completo do diretório atual.                    |
| **Ir para a raiz (`/`)**                               | `cd /`             | Move para o diretório raiz do sistema.                          |
| **Ir para o diretório do usuário**                     | `cd ~`             | Vai diretamente para a pasta do usuário.                        |
| **Voltar um diretório**                                | `cd ..`            | Sobe um nível na hierarquia de diretórios.                      |
| **Listar arquivos**                                    | `ls`               | Mostra os arquivos e diretórios na pasta atual.                 |
| **Listar arquivos com paginação**                      | `ls \| more`       | Exibe a lista de arquivos uma tela por vez.                     |
| **Listar arquivos que começam com um nome específico** | `ls iniciodonome*` | Filtra a listagem para arquivos que começam com `iniciodonome`. |

---

## 👐 5. Manipulação de Arquivos e Diretórios

| Ação                                    | Comando                      | Explicação                                                                      |
| --------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------- |
| **Criar um arquivo**                    | `touch arquivo.txt`          | Cria um novo arquivo vazio.                                                     |
| **Criar um diretório**                  | `mkdir nomedodir`            | Cria um novo diretório.                                                         |
| **Excluir um diretório vazio**          | `rmdir nomedodir`            | Remove um diretório, desde que esteja vazio.                                    |
| **Excluir diretório e arquivos dentro** | `rm -rf nomedir`             | Remove um diretório e todo seu conteúdo recursivamente e sem pedir confirmação. |
| **Exibir o conteúdo de um arquivo**     | `cat nomearquivo.txt`        | Exibe o conteúdo de um arquivo de texto.                                        |
| **Buscar arquivos por nome**            | `find -name nomeaserbuscado` | Pesquisa arquivos no diretório atual e subdiretórios.                           |

---

## 👤 6. Gerenciamento de Usuários

| Ação                                 | Comando                                                     | Explicação                                                                               |
| ------------------------------------ | ----------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Criar usuário**                    | `useradd nomeusuario -m -c "Usuário de teste" -s /bin/bash` | Cria um novo usuário com home directory (`-m`), comentário (`-c`) e shell padrão (`-s`). |
| **Criar senha para um usuário**      | `passwd nomeusuario`                                        | Define ou altera a senha de um usuário.                                                  |
| **Excluir usuário**                  | `userdel -r -f nomeusuario`                                 | Remove um usuário e seu diretório home (`-r`), forçando a remoção (`-f`).                |
| **Alterar configurações do usuário** | `usermod nomeusuario -s /bin/bash`                          | Modifica um usuário, nesse caso, alterando seu shell padrão.                             |
| **Listar usuários do sistema**       | `cat /etc/passwd`                                           | Exibe todos os usuários cadastrados no sistema.                                          |
| **Adicionar usuário a grupos**       | `usermod -G adm,sudo nomeusuario`                           | Adiciona um usuário a múltiplos grupos.                                                  |
| **Criar um grupo**                   | `groupadd nomedogrupo`                                      | Cria um novo grupo de usuários.                                                          |
| **Excluir um grupo**                 | `groupdel nomedogrupo`                                      | Remove um grupo do sistema.                                                              |

---

## 🔒 7. Permissões e Propriedades

### 🔹 **Alterar dono de um arquivo ou diretório**

```bash
chown nomeusuario:nomegrupo /nomedir
```

Muda o dono (`nomeusuario`) e o grupo (`nomegrupo`) de um diretório ou arquivo.

### 🔹 **Alterar permissões (r=4, w=2, x=1, nenhuma=0)**

Os três números representam permissões para:
1️⃣ Dono  
2️⃣ Grupo  
3️⃣ Outros

| Ação                                            | Comando              | Explicação                                                   |
| ----------------------------------------------- | -------------------- | ------------------------------------------------------------ |
| **Permissão total para todos**                  | `chmod 777 /nomedir` | Dá leitura (`4`), escrita (`2`) e execução (`1`) para todos. |
| **Adicionar permissão de execução para o dono** | `chmod +x nomedir`   | Concede permissão de execução apenas para o dono.            |
| **Remover permissão de execução**               | `chmod -x nomedir`   | Remove permissão de execução.                                |

---

## 🛠️ 8. Outros Comandos Úteis

| Ação                          | Comando                | Explicação                           |
| ----------------------------- | ---------------------- | ------------------------------------ |
| **Limpar a tela**             | `clear`                | Limpa o terminal.                    |
| **Ver histórico de comandos** | `history`              | Exibe os comandos já executados.     |
| **Obter ajuda de um comando** | `ls --help`            | Mostra a documentação de um comando. |
| **Editar arquivos de texto**  | `nano nomearquivo.txt` | Abre o editor de texto `nano`.       |

---

## 🤖 9. Automatizando Comandos do Terminal no Linux

Você pode criar um script shell (`.sh`) para automatizar os comandos do Git. Aqui está um exemplo de como fazer isso:

### 📜 Script Shell (`git-automation.sh`)

```sh
#!/bin/bash

echo "Adicionando arquivos ao commit..."
git add .

echo "Commitando mudanças..."
read -p "Digite a mensagem do commit: " commitMessage
git commit -m "$commitMessage"

echo "Enviando para o repositório remoto..."
git push

echo "Processo concluído!"
```

### 📌 Executando o Script

1. Dê permissão de execução ao script:

   ```sh
   chmod +x git-automation.sh
   ```

2. Execute o script:
   ```sh
   ./git-automation.sh
   ```

Durante a execução do script, você será solicitado a digitar a mensagem do commit. A mensagem que você digitar será usada no comando `git commit -m "$commitMessage"`.

### 📌 Executando o Script de Qualquer Diretório

#### Adicionando o Diretório ao `PATH`

1. Abra o arquivo de configuração do seu shell. Para `bash`, geralmente é `~/.bashrc` ou `~/.bash_profile`. Para `zsh`, é `~/.zshrc`.

2. Adicione a linha abaixo ao final do arquivo, substituindo `/caminho/para/o/script` pelo caminho real onde o script está localizado:

   ```sh
   export PATH=$PATH:/caminho/para/o/script
   ```

3. Salve o arquivo e recarregue a configuração do shell:
   ```sh
   source ~/.bashrc  # ou ~/.bash_profile ou ~/.zshrc, dependendo do seu shell
   ```

Agora você pode executar o script de qualquer diretório digitando o nome do script:

```sh
git-automation.sh
```

### 📌 Criando um Alias

1. Abra o arquivo de configuração do seu shell. Para `bash`, geralmente é `~/.bashrc` ou `~/.bash_profile`. Para `zsh`, é `~/.zshrc`.

2. Adicione a linha abaixo ao final do arquivo, substituindo `/caminho/para/o/script/git-automation.sh` pelo caminho real onde o script está localizado:

   ```sh
   alias git-automation='/caminho/para/o/script/git-automation.sh'
   ```

3. Salve o arquivo e recarregue a configuração do shell:
   ```sh
   source ~/.bashrc  # ou ~/.bash_profile ou ~/.zshrc, dependendo do seu shell
   ```

Agora você pode executar o script de qualquer diretório digitando o alias:

```sh
git-automation
```

Ambas as abordagens permitem que você execute o script de qualquer diretório no seu sistema.

---

### 🔥 **Conclusão**

Este guia resume os comandos mais importantes para começar no Linux. Caso precise de mais informações sobre um comando, use `man nomedocomando` ou `comando --help`.

🚀 **Bons estudos e boa prática no terminal!**
