# WSL2 Ansible Setup

Este projeto utiliza **Ansible** para configurar automaticamente um ambiente de desenvolvimento completo no **WSL2**. Ele inclui a instalação de ferramentas essenciais, configuração de shells, linguagens de programação, gerenciadores de pacotes e integração com o GitHub.

---

## 📂 Estrutura do Projeto

A estrutura do projeto segue as boas práticas do Ansible:

```
\wsl-ansible-setup\
├── ansible.cfg          # Configurações globais do Ansible
├── playbook.yml         # Playbook principal
├── hosts\
│   └── hosts.yaml       # Inventário de hosts
├── group_vars\
│   └── all.yml          # Variáveis globais
├── roles\
│   ├── base\            # Instala pacotes essenciais
│   ├── zsh\             # Configura o shell Zsh
│   ├── docker\          # Instala e configura o Docker
│   ├── nodejs\          # Instala Node.js e gerenciadores de pacotes
│   ├── python\          # Configura o ambiente Python
│   ├── git\             # Configura o Git e chaves SSH
│   └── github-cli\      # Instala e configura o GitHub CLI
```

---

## 🚀 Como Usar


### 1. **Pré-requisitos**

⚠️ Execute os comandos abaixo sempre dentro do terminal WSL, não no PowerShell ou CMD.

⚠️ Essa etapa é feita manualmente no Windows (não pode ser automatizada via Ansible)

- **WSL2** configurado no Windows.
  ```bash
  wsl --list --online
  wsl --install -d <NomeDaDistribuicao>
  sudo apt update && sudo apt upgrade
  ```
- **Python 3** instalado no WSL2. Pode ser checado com:
  ```bash
  python3 --version
  ```
- **Ansible** instalado:
  ```bash
  sudo apt install ansible -y
  ```

### 1.1. Instalar fonte Nerd Font (MesloLGS NF)

- Acesse: https://github.com/romkatv/powerlevel10k#manual-font-installation
- Baixe e instale as 4 variantes:
  - MesloLGS NF Regular
  - MesloLGS NF Bold
  - MesloLGS NF Italic
  - MesloLGS NF Bold Italic

### 1.2. Configurar VS Code

- Digite no terminal `wsl` para iniciar o linux
- Abra o VS Code com `code .`
- Pressione `Ctrl + Shift + P`
- Digite: `Preferences: Open Settings (JSON)` e selecione
- Adicione (ou edite) as seguintes linhas:

```json
"terminal.integrated.fontFamily": "MesloLGS NF",
"terminal.integrated.defaultProfile.linux": "zsh",
"terminal.integrated.fontSize": 13
```

> Essas configurações garantem que o terminal integrado do VS Code use Zsh como padrão e renderize corretamente os ícones e estilo do Powerlevel10k


### 2. **Configurar o Inventário**

Certifique-se de que o arquivo `hosts/hosts.yaml` está configurado corretamente. Exemplo:

```yaml
all:
  hosts:
    localhost:
      ansible_connection: local
```

### 3. **Configurar Variáveis Globais**

Edite o arquivo `group_vars/all.yml` para ajustar as variáveis globais, como o token do GitHub CLI e o timezone:

```yaml
# group_vars/all.yml
ansible_user: seu-nome
ansible_python_interpreter: /usr/bin/python3
timezone: "America/Sao_Paulo"
locale: "pt_BR.UTF-8"
github_token: "seu_token_aqui"
```

> **Nota**: Use o [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) para proteger informações sensíveis, como o `github_token`.

### 4. **Executar o Playbook**

Execute o playbook principal para configurar o ambiente:

```bash
ansible-playbook playbook.yml --ask-become-pass --ask-vault-pass
```

---

## 📜 O que o Playbook Faz?

O `playbook.yml` executa as seguintes roles na ordem especificada:

1. **`base`**:

   - Instala pacotes essenciais como `curl`, `wget`, `htop`, etc.

2. **`zsh`**:

   - Configura o shell Zsh e instala o Oh My Zsh.

3. **`docker`**:

   - Instala o Docker e o Docker Compose.
   - Adiciona o usuário ao grupo `docker`.

4. **`nodejs`**:

   - Instala o Node.js e gerenciadores de pacotes como `npm` e `yarn`.

5. **`python`**:

   - Configura o ambiente Python com `pyenv`, `pipx` e `poetry`.

6. **`git`**:

   - Configura o Git com nome, e-mail e branch padrão.
   - Gera e adiciona uma chave SSH ao `ssh-agent`.

7. **`github-cli`**:
   - Instala o GitHub CLI (`gh`) e autentica com o token fornecido.

---

## ⚙️ Configuração do `ansible.cfg`

O arquivo `ansible.cfg` define configurações globais para o Ansible:

```properties
[defaults]
inventory = ./hosts/hosts.yaml
```

- **`inventory`**: Aponta para o inventário de hosts (`hosts/hosts.yaml`).

---

## 🛠️ Personalização

### Adicionar Novas Roles

1. Crie uma nova pasta dentro de `roles/` com a estrutura padrão:
   ```
   roles/
   └── nova-role/
       ├── tasks/
       │   └── main.yml
       ├── handlers/
       ├── templates/
       ├── files/
       ├── vars/
       ├── defaults/
       └── meta/
   ```
2. Adicione a nova role ao `playbook.yml`:
   ```yaml
   roles:
     - role: nova-role
   ```

---

## 🛡️ Segurança

- **Proteja informações sensíveis**:
  - Use o Ansible Vault para criptografar o arquivo `group_vars/all.yml`:
    ```bash
    ansible-vault encrypt group_vars/all.yml
    ```
  - Para executar o playbook com o Vault:
    ```bash
    ansible-playbook playbook.yml --ask-vault-pass
    ```

---

## 📖 Referências

- [Documentação do Ansible](https://docs.ansible.com/)
- [WSL2 no Windows](https://learn.microsoft.com/pt-br/windows/wsl/)
- [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

---

## 🧑‍💻 Autor

**Renan Gomide**  
Projeto criado para automatizar a configuração do ambiente de desenvolvimento no WSL2.
