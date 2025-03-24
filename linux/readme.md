# 🚀 Guia Completo de Comandos Básicos do Linux

Seja bem-vindo(a) a este guia completo e prático sobre comandos essenciais do Linux! Aqui você encontrará tudo o que precisa para dominar o terminal, desde comandos básicos até técnicas avançadas de automação. Este guia é ideal para iniciantes e usuários intermediários que desejam se aprofundar no uso do Linux, seja em um servidor local, na nuvem (AWS) ou no Windows Subsystem for Linux (WSL).

---

## 📚 Sumário

1. [Introdução ao WSL](#-introdução-ao-wsl)
2. [Acessando o Linux na AWS](#-acessando-o-linux-na-aws)
3. [Entendendo o Terminal](#-entendendo-o-terminal)
4. [Comandos de Navegação](#-comandos-de-navegação)
5. [Manipulação de Arquivos e Diretórios](#-manipulação-de-arquivos-e-diretórios)
6. [Gerenciamento de Usuários](#-gerenciamento-de-usuários)
7. [Permissões e Propriedades](#-permissões-e-propriedades)
8. [Outros Comandos Úteis](#-outros-comandos-úteis)
9. [Automatizando Comandos do Terminal](#-automatizando-comandos-do-terminal)
10. [Comandos de Rede](#-comandos-de-rede)
11. [Tabela Resumida dos Comandos](#-tabela-resumida-dos-comandos)

---

## 🖥️ Introdução ao WSL

O **Windows Subsystem for Linux (WSL)** permite rodar um ambiente Linux dentro do Windows sem a necessidade de uma máquina virtual. É uma ferramenta poderosa para desenvolvedores que precisam de um ambiente Linux no Windows.

### 📌 Instalação do WSL

Para instalar o WSL, abra o PowerShell como administrador e execute:

```powershell
wsl --install
```

Este comando instala automaticamente a versão padrão do Ubuntu. Caso queira instalar uma distribuição específica, use:

```powershell
wsl --install -d <distribuição>
```

Exemplo para instalar o Debian:

```powershell
wsl --install -d Debian
```

### 📌 Gerenciando Distribuições no WSL

- **Listar distribuições disponíveis:**

  ```powershell
  wsl --list --online
  ```

- **Listar distribuições instaladas:**

  ```powershell
  wsl --list --verbose
  ```

- **Definir uma distribuição como padrão:**

  ```powershell
  wsl --set-default <distribuição>
  ```

- **Iniciar o WSL:**

  ```powershell
  wsl
  ```

- **Encerrar o WSL:**

  ```powershell
  wsl --shutdown
  ```

### 📌 Reduzindo o Tamanho da Partição Virtual do WSL

Se o arquivo virtual do WSL estiver ocupando muito espaço, você pode compactá-lo. Primeiro, localize o caminho da partição virtual:

```powershell
wsl --shutdown
(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq '<distribution-name>' }).GetValue("BasePath") + "\ext4.vhdx"
```

Substitua `<distribution-name>` pelo nome da distribuição, por exemplo, `ubuntu`. Em seguida, abra o `diskpart` e compacte o arquivo:

```bash
DISKPART> select vdisk file="local-da-particao"
DISKPART> compact vdisk
```

---

## 🌍 Acessando o Linux na AWS

Para acessar um servidor Linux na AWS, você pode usar o **PuTTY** para conectar via SSH. Se estiver no Windows, converta a chave `.pem` para `.ppk` usando o PuTTYgen.

Exemplo de conexão via SSH:

```bash
ssh -i minha-chave.pem usuario@ip-do-servidor
```

---

## 💻 Entendendo o Terminal

Ao abrir o terminal, você verá algo assim:

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

## 📂 Comandos de Navegação

| Ação                               | Comando | Explicação                                      |
| ---------------------------------- | ------- | ----------------------------------------------- |
| **Mostrar diretório atual**        | `pwd`   | Exibe o caminho completo do diretório atual.    |
| **Ir para a raiz (`/`)**           | `cd /`  | Move para o diretório raiz do sistema.          |
| **Ir para o diretório do usuário** | `cd ~`  | Vai diretamente para a pasta do usuário.        |
| **Voltar um diretório**            | `cd ..` | Sobe um nível na hierarquia de diretórios.      |
| **Listar arquivos**                | `ls`    | Mostra os arquivos e diretórios na pasta atual. |

---

## 👐 Manipulação de Arquivos e Diretórios

| Ação                                    | Comando                      | Explicação                                              |
| --------------------------------------- | ---------------------------- | ------------------------------------------------------- |
| **Criar um arquivo**                    | `touch arquivo.txt`          | Cria um novo arquivo vazio.                             |
| **Criar um diretório**                  | `mkdir nomedodir`            | Cria um novo diretório.                                 |
| **Excluir um diretório vazio**          | `rmdir nomedodir`            | Remove um diretório, desde que esteja vazio.            |
| **Excluir diretório e arquivos dentro** | `rm -rf nomedir`             | Remove um diretório e todo seu conteúdo recursivamente. |
| **Exibir o conteúdo de um arquivo**     | `cat nomearquivo.txt`        | Exibe o conteúdo de um arquivo de texto.                |
| **Buscar arquivos por nome**            | `find -name nomeaserbuscado` | Pesquisa arquivos no diretório atual e subdiretórios.   |
| **Mover ou renomear arquivos**          | `mv file.txt novo_nome.txt`  | Move ou renomeia um arquivo.                            |
| **Mover arquivos para outro diretório** | `mv arquivo.txt /destino/`   | Move um arquivo para outro diretório.                   |

---

## 👤 Gerenciamento de Usuários

| Ação                           | Comando                               | Explicação                                                                |
| ------------------------------ | ------------------------------------- | ------------------------------------------------------------------------- |
| **Criar usuário**              | `useradd nomeusuario -m -s /bin/bash` | Cria um novo usuário com home directory (`-m`) e shell padrão (`-s`).     |
| **Definir senha**              | `passwd nomeusuario`                  | Define ou altera a senha de um usuário.                                   |
| **Excluir usuário**            | `userdel -r -f nomeusuario`           | Remove um usuário e seu diretório home (`-r`), forçando a remoção (`-f`). |
| **Listar usuários do sistema** | `cat /etc/passwd`                     | Exibe todos os usuários cadastrados no sistema.                           |
| **Adicionar usuário a grupos** | `usermod -G adm,sudo nomeusuario`     | Adiciona um usuário a múltiplos grupos.                                   |

---

## 🔒 Permissões e Propriedades

### 🔹 Alterar dono de um arquivo ou diretório:

```bash
chown usuario:grupo arquivo.txt
```

### 🔹 Alterar permissões (r=4, w=2, x=1):

```bash
chmod 755 arquivo.txt
```

| Código | Permissões                                        |
| ------ | ------------------------------------------------- |
| 777    | Todos têm acesso total                            |
| 755    | Dono pode modificar, outros apenas ler e executar |
| 644    | Apenas o dono pode modificar, outros só podem ler |

---

## 🛠️ Outros Comandos Úteis

| Ação                          | Comando                | Explicação                           |
| ----------------------------- | ---------------------- | ------------------------------------ |
| **Limpar a tela**             | `clear`                | Limpa o terminal.                    |
| **Ver histórico de comandos** | `history`              | Exibe os comandos já executados.     |
| **Obter ajuda de um comando** | `comando --help`       | Mostra a documentação de um comando. |
| **Editar arquivos de texto**  | `nano nomearquivo.txt` | Abre o editor de texto `nano`.       |

---

## 🤖 Automatizando Comandos do Terminal

Crie scripts shell para automatizar tarefas repetitivas. Aqui está um exemplo de script para automatizar comandos do Git:

### 📜 Script Shell (`git-automation.sh`)

```bash
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
   ```bash
   chmod +x git-automation.sh
   ```
2. Execute o script:
   ```bash
   ./git-automation.sh
   ```

### 📌 Adicionando o Script ao `PATH`

Para executar o script de qualquer diretório, adicione-o ao `PATH`:

1. Abra o arquivo de configuração do shell (`~/.bashrc`, `~/.bash_profile` ou `~/.zshrc`).
2. Adicione a linha abaixo ao final do arquivo:
   ```bash
   export PATH=$PATH:/caminho/para/o/script
   ```
3. Recarregue a configuração do shell:
   ```bash
   source ~/.bashrc
   ```

Agora você pode executar o script de qualquer lugar digitando:

```bash
git-automation.sh
```

### 📌 Criando um Alias

1. Abra o arquivo de configuração do seu shell.
2. Adicione a linha abaixo ao final do arquivo:
   ```bash
   alias git-automation='/caminho/para/o/script/git-automation.sh'
   ```
3. Recarregue a configuração do shell:
   ```bash
   source ~/.bashrc
   ```

Agora você pode executar o script de qualquer diretório digitando o alias:

```bash
git-automation
```

### 📜 Script Shell para Backup (`backup.sh`)

```bash
#!/bin/bash

# Diretório de origem
origem="/caminho/para/origem"

# Diretório de destino
destino="/caminho/para/destino"

# Nome do arquivo de backup
arquivo_backup="backup_$(date +%Y%m%d%H%M%S).tar.gz"

echo "Criando backup de $origem em $destino/$arquivo_backup"
tar -czvf "$destino/$arquivo_backup" "$origem"

echo "Backup concluído!"
```

### 📌 Executando o Script de Backup

1. Dê permissão de execução ao script:
   ```bash
   chmod +x backup.sh
   ```
2. Execute o script:
   ```bash
   ./backup.sh
   ```

---

## 🌐 Comandos de Rede

| Ação                           | Comando           | Explicação                                         |
| ------------------------------ | ----------------- | -------------------------------------------------- |
| **Verificar conectividade**    | `ping google.com` | Envia pacotes ICMP para verificar a conectividade. |
| **Mostrar interfaces de rede** | `ifconfig`        | Exibe informações sobre as interfaces de rede.     |
| **Mostrar rotas de rede**      | `route -n`        | Exibe a tabela de rotas do kernel.                 |
| **Mostrar conexões ativas**    | `netstat -tuln`   | Exibe todas as conexões de rede ativas.            |
| **Verificar portas abertas**   | `nmap localhost`  | Escaneia as portas abertas no host local.          |

---

## 📋 Tabela Resumida dos Comandos

| Categoria       | Comando                               | Descrição                           |
| --------------- | ------------------------------------- | ----------------------------------- |
| **Navegação**   | `pwd`                                 | Mostra o diretório atual.           |
|                 | `cd /`                                | Vai para a raiz do sistema.         |
|                 | `cd ~`                                | Vai para o diretório do usuário.    |
| **Manipulação** | `touch arquivo.txt`                   | Cria um arquivo vazio.              |
|                 | `mkdir pasta`                         | Cria um diretório.                  |
|                 | `rm -rf pasta`                        | Remove um diretório e seu conteúdo. |
| **Usuários**    | `useradd nomeusuario -m -s /bin/bash` | Cria um novo usuário.               |
|                 | `passwd nomeusuario`                  | Define a senha do usuário.          |
|                 | `userdel -r nomeusuario`              | Remove um usuário.                  |
| **Permissões**  | `chmod 755 arquivo`                   | Modifica permissões de acesso.      |
|                 | `chown usuario:grupo arquivo`         | Modifica o dono do arquivo.         |
| **Outros**      | `clear`                               | Limpa a tela.                       |
|                 | `history`                             | Mostra o histórico de comandos.     |
| **Rede**        | `ping google.com`                     | Verifica a conectividade.           |
|                 | `ifconfig`                            | Mostra interfaces de rede.          |
|                 | `route -n`                            | Mostra rotas de rede.               |
|                 | `netstat -tuln`                       | Mostra conexões de rede ativas.     |
|                 | `nmap localhost`                      | Escaneia portas abertas.            |

---

## 🔥 Conclusão

Com este guia, você já tem o básico para utilizar o Linux de maneira eficiente. Se precisar de mais informações sobre qualquer comando, use:

```bash
man nome-do-comando
```

🚀 **Agora é só praticar e dominar o terminal!**
