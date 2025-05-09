# Tutorial de Ansible

Ansible é uma ferramenta de automação de TI que permite gerenciar configurações, implantar aplicativos e orquestrar tarefas em múltiplos sistemas. É uma solução poderosa e eficiente, ideal para a automação de ambientes de servidores.

---

## 📋 Índice

1. [Conceitos Básicos](#conceitos-básicos)
2. [Instalação do Ansible](#instalação-do-ansible)
3. [Estrutura do Ansible](#estrutura-do-ansible)
4. [Configuração do Ansible com `ansible-config`](#configuração-do-ansible-com-ansible-config)
5. [Inventário](#inventário)
6. [Playbooks](#playbooks)
7. [Módulos](#módulos)
8. [Exemplo Prático](#exemplo-prático)
9. [Comandos Úteis](#comandos-úteis)
10. [Tabela de Referência](#tabela-de-referência)
11. [Conclusão](#conclusão)
12. [Secrets e Ansible Vault](#secrets-e-ansible-vault)

---

## 📖 Conceitos Básicos

- **Agentes**: O Ansible é uma ferramenta sem agente, ou seja, não requer a instalação de software adicional nos nós gerenciados. Ele utiliza protocolos como SSH (Linux) ou WinRM (Windows) para se conectar aos sistemas.
- **Idempotência**: As operações do Ansible são idempotentes, garantindo que a execução repetida de um playbook sempre leve ao mesmo estado desejado.
- **Arquitetura Simples**: O Ansible utiliza arquivos YAML para descrever tarefas, tornando-o fácil de aprender e usar.

---

## 🛠️ Instalação do Ansible

### No Ubuntu

```bash
sudo apt update
sudo apt install ansible -y
```

### No MacOS

```bash
brew install ansible
```

### No Windows

Utilize o Windows Subsystem for Linux (WSL) ou instale via Cygwin ou Chocolatey.

```bash
choco install ansible
```

---

## 🏗️ Estrutura do Ansible

### Componentes Principais

| Componente     | Descrição                                                                             |
| -------------- | ------------------------------------------------------------------------------------- |
| **Inventário** | Define os nós que o Ansible gerencia. Pode ser estático ou dinâmico.                  |
| **Playbook**   | Arquivos YAML que descrevem as tarefas a serem executadas nos nós.                    |
| **Módulos**    | Unidades de trabalho que o Ansible executa, como instalar pacotes ou copiar arquivos. |
| **Templates**  | Arquivos Jinja2 usados para criar configurações dinâmicas.                            |

---

## ⚙️ Configuração do Ansible com `ansible-config`

O arquivo `ansible.cfg` é usado para configurar o comportamento do Ansible. Ele permite definir opções globais, como o inventário padrão, configurações de SSH, diretórios de logs, entre outros.

O comando `ansible-config` é usado para gerenciar e verificar as configurações do Ansible. Ele permite visualizar, editar e validar o arquivo de configuração (`ansible.cfg`), que controla o comportamento do Ansible.

### Localização do Arquivo de Configuração

O Ansible procura o arquivo `ansible.cfg` em várias localizações, na seguinte ordem de prioridade:

1. Diretório atual do projeto.
2. Variável de ambiente `ANSIBLE_CONFIG`.
3. Diretório do usuário (`~/.ansible.cfg`).
4. Diretório padrão do sistema (`/etc/ansible/ansible.cfg`).

### 🛠️ Criando um Arquivo `ansible.cfg`

1. **Crie o arquivo `ansible.cfg` no diretório do seu projeto**  
   Use o comando abaixo para criar o arquivo:

   ```bash
   touch ansible.cfg
   ```

2. **Adicione o conteúdo básico ao arquivo**  
   Aqui está um exemplo de configuração básica:

   ```ini
   [defaults]
   inventory = ./hosts                # Caminho para o arquivo de inventário
   remote_user = ubuntu               # Usuário padrão para SSH
   private_key_file = ~/.ssh/id_rsa   # Caminho para a chave privada SSH
   host_key_checking = False          # Desabilita a verificação de chave do host
   timeout = 30                       # Tempo limite para conexões SSH
   forks = 10                         # Número de conexões simultâneas
   log_path = ./ansible.log           # Caminho para o arquivo de log

   [privilege_escalation]
   become = True                      # Habilita o uso de sudo
   become_method = sudo               # Método de elevação de privilégio
   become_user = root                 # Usuário para elevação de privilégio
   ```

3. **Salvar e testar a configuração**  
   Após criar o arquivo, você pode verificar se ele está sendo usado corretamente executando o comando:
   ```bash
   ansible-config dump --only-changed
   ```
   Este comando exibe as configurações que foram alteradas em relação aos padrões.

---

### 🧩 Explicação das Configurações

| Seção                      | Opção               | Descrição                                                                     |
| -------------------------- | ------------------- | ----------------------------------------------------------------------------- |
| **[defaults]**             | `inventory`         | Define o caminho para o arquivo de inventário.                                |
|                            | `remote_user`       | Usuário padrão para conexões SSH.                                             |
|                            | `private_key_file`  | Caminho para a chave privada SSH.                                             |
|                            | `host_key_checking` | Desabilita a verificação de chave do host (útil para evitar erros em testes). |
|                            | `timeout`           | Define o tempo limite para conexões SSH.                                      |
|                            | `forks`             | Número de conexões simultâneas que o Ansible pode abrir.                      |
|                            | `log_path`          | Caminho para o arquivo de log das execuções do Ansible.                       |
| **[privilege_escalation]** | `become`            | Habilita o uso de sudo para elevação de privilégios.                          |
|                            | `become_method`     | Método de elevação de privilégio (ex.: sudo, su).                             |
|                            | `become_user`       | Usuário para o qual os privilégios serão elevados (ex.: root).                |

---

### 🎯 Exemplo Completo

Se você estiver configurando um ambiente para gerenciar servidores com o Ansible, o arquivo `ansible.cfg` pode ser algo assim:

```ini
[defaults]
inventory = ./hosts
remote_user = ubuntu
private_key_file = ~/.ssh/id_rsa
host_key_checking = False
timeout = 30
forks = 5
log_path = ./ansible.log

[privilege_escalation]
become = True
become_method = sudo
become_user = root
```

---

### 📋 Testando a Configuração

1. **Verificar conectividade com os nós**  
   Use o comando abaixo para testar a conectividade com os servidores definidos no inventário:

   ```bash
   ansible all -m ping
   ```

2. **Executar um playbook com a configuração**  
   Execute um playbook utilizando as configurações definidas no arquivo `ansible.cfg`:
   ```bash
   ansible-playbook -i hosts seu_playbook.yml
   ```

Se tudo estiver configurado corretamente, o Ansible usará as opções definidas no arquivo `ansible.cfg`.

---

## 📂 Inventário

O inventário é um arquivo que lista os servidores (nós) que serão gerenciados pelo Ansible. Ele pode ser escrito em formato INI ou YAML.

### Exemplo de Inventário em Formato INI

```ini
[servidores]
servidor1 ansible_host=192.168.1.10
servidor2 ansible_host=192.168.1.11
```

### Exemplo de Inventário em Formato YAML

```yaml
all:
  hosts:
    servidor1:
      ansible_host: 192.168.1.10
    servidor2:
      ansible_host: 192.168.1.11
```

---

## 📜 Playbooks

Os playbooks são arquivos YAML que contêm uma série de tarefas a serem executadas. Eles são o coração do Ansible.

### Estrutura de um Playbook

```yaml
---
- name: Nome descritivo do playbook
  hosts: nome_do_grupo_ou_nos
  tasks:
    - name: Descrição da tarefa
      módulo:
        parâmetros:
```

### Exemplo de Playbook

Aqui está um exemplo de um playbook que instala o Apache e garante que ele está em execução:

```yaml
---
- name: Instalar e iniciar Apache
  hosts: servidores
  tasks:
    - name: Instalar o Apache
      apt:
        name: apache2
        state: present

    - name: Iniciar o Apache
      service:
        name: apache2
        state: started
```

---

## 🧩 Módulos

Os módulos são as unidades de trabalho que o Ansible executa. Aqui estão alguns módulos comuns:

| Módulo      | Descrição                              |
| ----------- | -------------------------------------- |
| **apt**     | Gerencia pacotes em sistemas Debian.   |
| **yum**     | Gerencia pacotes em sistemas Red Hat.  |
| **copy**    | Copia arquivos de um local para outro. |
| **service** | Gerencia serviços no sistema.          |
| **command** | Executa comandos no sistema.           |

### Exemplo de Uso de Módulos

```yaml
- name: Copiar arquivo
  copy:
    src: /caminho/origem/arquivo.txt
    dest: /caminho/destino/arquivo.txt
```

---

## 🖥️ Exemplo Prático

### 1. Criar um Playbook

Crie um arquivo chamado `install_apache.yml` com o seguinte conteúdo:

```yaml
---
- name: Instalar e iniciar Apache
  hosts: servidores
  tasks:
    - name: Instalar o Apache
      apt:
        name: apache2
        state: present

    - name: Iniciar o Apache
      service:
        name: apache2
        state: started
```

### 2. Criar um Inventário

Crie um arquivo chamado `hosts` com o seguinte conteúdo:

```ini
[servidores]
192.168.1.10
192.168.1.11
```

### 3. Executar o Playbook

Execute o playbook usando o comando:

```bash
ansible-playbook -i hosts install_apache.yml
```

### 4. Verificar a Instalação

Acesse o endereço IP do servidor no navegador para verificar se o Apache foi instalado e iniciado corretamente.

---

## 🛠️ Comandos Úteis

| Comando                                      | Descrição                                  |
| -------------------------------------------- | ------------------------------------------ |
| `ansible all -m ping`                        | Verifica a conectividade com todos os nós. |
| `ansible-playbook -i hosts seu_playbook.yml` | Executa um playbook específico.            |
| `ansible-inventory -i hosts --list`          | Lista todos os nós no inventário.          |
| `ansible all -i hosts -a "uname -a"`         | Executa um comando em todos os nós.        |
| `ansible-config list`                        | Lista todas as configurações disponíveis.  |
| `ansible-config dump`                        | Mostra as configurações ativas.            |
| `ansible-config init --minimal`              | Gera um arquivo `ansible.cfg` básico.      |

---

## 📚 Tabela de Referência

| Elemento       | Descrição                                                                 |
| -------------- | ------------------------------------------------------------------------- |
| **Inventário** | Define os nós gerenciados pelo Ansible. Pode ser estático ou dinâmico.    |
| **Playbook**   | Arquivo YAML que descreve as tarefas a serem executadas.                  |
| **Módulos**    | Unidades de trabalho, como instalar pacotes ou copiar arquivos.           |
| **Templates**  | Arquivos Jinja2 usados para criar configurações dinâmicas.                |
| **Comandos**   | Ferramentas de linha de comando para executar tarefas e verificar status. |

---

## 🔒 Secrets e Ansible Vault

O Ansible Vault é uma funcionalidade que permite criptografar e proteger informações sensíveis, como senhas, chaves de API e outros dados confidenciais. Ele é especialmente útil para manter a segurança em projetos compartilhados.

### 🛠️ Criando um Arquivo Criptografado

1. **Criar um arquivo criptografado**  
   Use o comando abaixo para criar um arquivo criptografado com o Ansible Vault:

   ```bash
   ansible-vault create secrets.yml
   ```

   Você será solicitado a definir uma senha. Após isso, o editor padrão será aberto para que você insira os dados sensíveis no arquivo.

2. **Exemplo de conteúdo do arquivo `secrets.yml`**
   ```yaml
   api_key: "minha-chave-secreta"
   db_password: "senha-do-banco"
   ```

---

### 🔍 Editando um Arquivo Criptografado

Para editar um arquivo já criptografado, use o comando:

```bash
ansible-vault edit secrets.yml
```

O editor padrão será aberto, e você poderá modificar o conteúdo do arquivo.

---

### 📖 Visualizando um Arquivo Criptografado

Se você precisar apenas visualizar o conteúdo de um arquivo criptografado, use o comando:

```bash
ansible-vault view secrets.yml
```

---

### 🔓 Descriptografando um Arquivo

Caso seja necessário descriptografar um arquivo para que ele fique em texto plano, use o comando:

```bash
ansible-vault decrypt secrets.yml
```

**Atenção:** Isso removerá a criptografia do arquivo, deixando-o exposto.

---

### 🔐 Recriptografando um Arquivo

Se você quiser recriptografar um arquivo que foi descriptografado, use o comando:

```bash
ansible-vault encrypt secrets.yml
```

---

### 🧩 Usando Secrets em Playbooks

Você pode usar variáveis criptografadas diretamente em seus playbooks. Por exemplo:

1. **Arquivo `secrets.yml` criptografado**:

   ```yaml
   db_password: "senha-do-banco"
   ```

2. **Playbook que utiliza o secret**:

   ```yaml
   ---
   - name: Configurar aplicação
     hosts: servidores
     tasks:
       - name: Configurar banco de dados
         command: /configurar-banco --password={{ db_password }}
   ```

3. **Executar o playbook com o arquivo criptografado**:  
   Use a opção `--ask-vault-pass` para fornecer a senha do Vault ao executar o playbook:
   ```bash
   ansible-playbook -i hosts playbook.yml --ask-vault-pass
   ```

---

### 🔑 Alterando a Senha do Vault

Se for necessário alterar a senha usada para criptografar os arquivos, use o comando:

```bash
ansible-vault rekey secrets.yml
```

Você será solicitado a fornecer a senha antiga e a nova senha.

---

### 📋 Comandos Úteis do Ansible Vault

| Comando                           | Descrição                                         |
| --------------------------------- | ------------------------------------------------- |
| `ansible-vault create <arquivo>`  | Cria um novo arquivo criptografado.               |
| `ansible-vault edit <arquivo>`    | Edita um arquivo criptografado.                   |
| `ansible-vault view <arquivo>`    | Visualiza o conteúdo de um arquivo criptografado. |
| `ansible-vault encrypt <arquivo>` | Criptografa um arquivo em texto plano.            |
| `ansible-vault decrypt <arquivo>` | Remove a criptografia de um arquivo.              |
| `ansible-vault rekey <arquivo>`   | Altera a senha usada para criptografar o arquivo. |
| `:wq`                             | Salvar e sair do modo edição da Vault             |

---

### 🎯 Boas Práticas com Ansible Vault

1. **Não compartilhe a senha do Vault em texto plano**: Use ferramentas de gerenciamento de senhas para armazená-la com segurança.
2. **Evite descriptografar arquivos desnecessariamente**: Trabalhe com arquivos criptografados sempre que possível.
3. **Integre o Vault com pipelines CI/CD**: Utilize variáveis de ambiente para fornecer a senha do Vault em ambientes automatizados.
4. **Mantenha o arquivo `secrets.yml` fora do controle de versão**: Use `.gitignore` para evitar que arquivos sensíveis sejam versionados.

---

## 🎯 Conclusão

O Ansible é uma ferramenta poderosa para automação e gerenciamento de configurações. Este tutorial cobriu os conceitos básicos, instalação, estrutura, módulos e exemplos práticos. Explore mais sobre o Ansible para maximizar suas capacidades de automação!
