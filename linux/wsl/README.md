# Tutorial sobre WSL (Windows Subsystem for Linux)

## Comandos Básicos do WSL

| Comando                                 | Descrição                                           |
| --------------------------------------- | --------------------------------------------------- |
| `wsl --install`                         | Instala o WSL e a distribuição padrão.              |
| `wsl --list --online`                   | Lista as distribuições disponíveis para instalação. |
| `wsl --install -d <NomeDaDistribuicao>` | Instala uma distribuição específica.                |
| `wsl`                                   | Inicia a distribuição padrão do WSL.                |
| `wsl --list --verbose`                  | Lista as distribuições instaladas com detalhes.     |
| `wsl --unregister <NomeDaDistribuicao>` | Desinstala uma distribuição específica.             |
| `sudo apt update`                       | Atualiza a lista de pacotes disponíveis.            |
| `sudo apt upgrade`                      | Atualiza os pacotes instalados.                     |
| `code .`                                | Abre o Visual Studio Code no diretório atual.       |
| `sudo apt install ansible`              | Instala o Ansible na distribuição Linux.            |

## Índice

1. [O que é o WSL?](#o-que-é-o-wsl)
2. [Requisitos](#requisitos)
3. [Habilitando o WSL](#habilitando-o-wsl)
   - [Passo 1: Habilitar o WSL](#passo-1-habilitar-o-wsl)
   - [Passo 2: Reiniciar o Computador](#passo-2-reiniciar-o-computador)
4. [Instalando uma Distribuição Linux](#instalando-uma-distribuição-linux)
   - [Passo 1: Listar Distribuições Disponíveis](#passo-1-listar-distribuições-disponíveis)
   - [Passo 2: Instalar uma Distribuição](#passo-2-instalar-uma-distribuição)
5. [Iniciando o WSL](#iniciando-o-wsl)
6. [Usando o WSL](#usando-o-wsl)
   - [Acessando o Sistema de Arquivos do Windows](#acessando-o-sistema-de-arquivos-do-windows)
   - [Atualizando Pacotes](#atualizando-pacotes)
7. [Instalando o Visual Studio Code (VSCode) no WSL](#instalando-o-visual-studio-code-vscode-no-wsl)
8. [Instalando o Ansible](#instalando-o-ansible)
9. [Listando Distribuições Instaladas](#listando-distribuições-instaladas)
10. [Desinstalando uma Distribuição](#desinstalando-uma-distribuição)
11. [Conclusão](#conclusão)
12. [Recursos Adicionais](#recursos-adicionais)

## O que é o WSL?

O Windows Subsystem for Linux (WSL) permite que você execute um ambiente Linux diretamente no Windows, sem a necessidade de uma máquina virtual ou dual boot. É útil para desenvolvedores que desejam usar ferramentas e aplicativos Linux no Windows.

## Requisitos

- Windows 10 (versão 1903 ou posterior) ou Windows 11.
- Habilitar o recurso "Subsistema do Windows para Linux".

## Habilitando o WSL

### Passo 1: Habilitar o WSL

1. Abra o **PowerShell** como administrador.
2. Execute o seguinte comando:
   ```bash
   wsl --install
   ```

### Passo 2: Reiniciar o Computador

- Após a instalação, você será solicitado a reiniciar o computador.

## Instalando uma Distribuição Linux

### Passo 1: Listar Distribuições Disponíveis

- Após reiniciar, abra o PowerShell e execute:
  ```bash
  wsl --list --online
  ```
- Isso mostrará uma lista de distribuições disponíveis.

### Passo 2: Instalar uma Distribuição

- Para instalar uma distribuição, execute:
  ```bash
  wsl --install -d <NomeDaDistribuicao>
  ```
- Exemplo para instalar o Ubuntu:
  ```bash
  wsl --install -d Ubuntu
  ```

## Iniciando o WSL

- Após a instalação, você pode iniciar o WSL digitando `wsl` no PowerShell ou abrindo a distribuição diretamente pelo menu Iniciar.

## Usando o WSL

### Acessando o Sistema de Arquivos do Windows

- O sistema de arquivos do Windows pode ser acessado a partir do WSL no diretório `/mnt/c/`, onde `c` representa a unidade C.

### Atualizando Pacotes

- Para atualizar os pacotes da sua distribuição, use:
  ```bash
  sudo apt update && sudo apt upgrade
  ```

## Instalando o Visual Studio Code (VSCode) no WSL

### Passo 1: Instalar o VSCode no Windows

1. **Baixar o VSCode**:

   - Acesse o [site oficial do Visual Studio Code](https://code.visualstudio.com/) e baixe o instalador para Windows.

2. **Instalar o VSCode**:
   - Execute o instalador e siga as instruções na tela para completar a instalação.

### Passo 2: Instalar a Extensão WSL para o VSCode

1. **Abrir o VSCode**.
2. **Instalar a Extensão**:
   - Vá até a aba de extensões (ou pressione `Ctrl + Shift + X`).
   - Pesquise por "Remote - WSL" e instale a extensão.

### Passo 3: Abrir um Diretório WSL no VSCode

1. **Abrir o Terminal do WSL**:

   - Você pode abrir o WSL pelo PowerShell ou diretamente no terminal do Windows.

2. **Navegar até o Diretório do Projeto**:

   - Use o comando `cd` para navegar até o diretório do projeto que você deseja abrir no VSCode.

3. **Abrir o VSCode**:
   - Execute o seguinte comando no terminal do WSL:
   ```bash
   code .
   ```
   - Isso abrirá o VSCode no diretório atual do WSL.

## Instalando o Ansible

- Para instalar o Ansible na sua distribuição Linux, execute o seguinte comando:
  ```bash
  sudo apt install ansible
  ```

## Listando Distribuições Instaladas

- Para listar as distribuições instaladas, execute:
  ```bash
  wsl --list --verbose
  ```

## Desinstalando uma Distribuição

- Para desinstalar uma distribuição, use:
  ```bash
  wsl --unregister <NomeDaDistribuicao>
  ```

## Conclusão

O WSL é uma ferramenta poderosa para desenvolvedores que desejam utilizar as ferramentas e ambientes do Linux diretamente no Windows. Com a instalação e configuração simples, você pode começar a desenvolver aplicativos de forma eficiente.

## Recursos Adicionais

- [Documentação Oficial do WSL](https://docs.microsoft.com/pt-br/windows/wsl/)
