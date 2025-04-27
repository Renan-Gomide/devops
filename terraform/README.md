# 📌 Guia Rápido: Terraform & Google SDK (gcloud) no Windows e Linux (Ubuntu)

Este guia apresenta a instalação e comandos essenciais do **Terraform** e do **Google Cloud SDK (gcloud)** no Windows e Linux (Ubuntu).

---

## 🏰 1. Instalação do Terraform

### 📀 Windows

1. Acesse o site oficial do Terraform:  
   🔗 [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads)
2. Baixe e extraia o arquivo `.exe` em uma pasta de sua escolha.
3. Adicione o local do arquivo à variável de ambiente `PATH`:
   - No Windows, pesquise por **Variáveis de Ambiente** e edite a variável `PATH`.
   - Adicione o caminho onde o `.exe` foi salvo.
4. Teste a instalação rodando o comando:
   ```bash
   terraform version
   ```

### 🌐 Linux (Ubuntu)

1. Atualize os pacotes:
   ```bash
   sudo apt update && sudo apt install -y software-properties-common gnupg
   ```
2. Adicione o repositório oficial do HashiCorp:
   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   ```
3. Instale o Terraform:
   ```bash
   sudo apt update && sudo apt install -y terraform
   ```
4. Teste a instalação:
   ```bash
   terraform version
   ```

---

## ☁️ 2. Instalação do Google Cloud SDK (CLI)

### 📀 Windows

1. Abra o **PowerShell** como administrador e execute:
   ```powershell
   (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")
   & $env:Temp\GoogleCloudSDKInstaller.exe
   ```
2. No **PowerShell (como administrador)**, defina permissões de execução e escolha **A** quando solicitado:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope CurrentUser
   ```
3. Verifique se o Google SDK foi instalado corretamente:
   ```powershell
   gcloud --version
   ```
4. Faça login na sua conta do **Google Cloud Platform (GCP)**:
   ```powershell
   gcloud auth application-default login
   ```
5. Liste os projetos disponíveis na conta logada:
   ```powershell
   gcloud projects list
   ```

### 🌐 Linux (Ubuntu)

1. Baixe e instale o Google Cloud SDK:
   ```bash
   sudo apt update && sudo apt install -y curl apt-transport-https ca-certificates gnupg
   curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
   sudo apt update && sudo apt install -y google-cloud-sdk
   ```
2. Verifique se a instalação foi bem-sucedida:
   ```bash
   gcloud --version
   ```
3. Faça login no Google Cloud:
   ```bash
   gcloud auth application-default login
   ```
4. Liste os projetos disponíveis:
   ```bash
   gcloud projects list
   ```

---

## 🚀 3. Comandos Básicos do Terraform

| Ação                           | Comando             | Explicação                                                             |
| ------------------------------ | ------------------- | ---------------------------------------------------------------------- |
| **Inicializar o Terraform**    | `terraform init`    | Prepara o diretório de trabalho com os arquivos de configuração.       |
| **Criar um plano de execução** | `terraform plan`    | Mostra quais mudanças serão aplicadas.                                 |
| **Aplicar mudanças**           | `terraform apply`   | Aplica as mudanças necessárias para atingir o estado desejado.         |
| **Mostrar o estado atual**     | `terraform show`    | Exibe o estado atual dos recursos gerenciados.                         |
| **Atualizar o estado**         | `terraform refresh` | Sincroniza o estado do Terraform com os recursos reais.                |
| **Destruir os recursos**       | `terraform destroy` | Remove todos os recursos gerenciados pelo Terraform. **IRREVERSÍVEL!** |

---

## 🎮 4. Comandos Básicos do Google SDK (gcloud)

| Ação                                      | Comando                                             | Explicação                                        |
| ----------------------------------------- | --------------------------------------------------- | ------------------------------------------------- |
| **Listar instâncias de VM**               | `gcloud compute instances list`                     | Lista todas as instâncias de VM do projeto atual. |
| **Iniciar uma instância de VM**           | `gcloud compute instances start [INSTANCE_NAME]`    | Inicia uma instância de VM específica.            |
| **Parar uma instância de VM**             | `gcloud compute instances stop [INSTANCE_NAME]`     | Para uma instância de VM específica.              |
| **Obter informações sobre uma instância** | `gcloud compute instances describe [INSTANCE_NAME]` | Exibe detalhes sobre uma instância de VM.         |
| **Conectar-se a uma VM via SSH**          | `gcloud compute ssh [INSTANCE_NAME] --zone=[ZONE]`  | Conecta via SSH a uma instância de VM.            |

> 💡 **Observação:** Certifique-se de ter o arquivo da service account do projeto para ter as permissões IAM necessárias.

---

Este tutorial fornece os comandos essenciais para você trabalhar com **Terraform** e **gcloud** no Windows e Linux.
Agora é só colocar a mão na massa! 💪🚀
