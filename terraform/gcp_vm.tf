provider "google" {
  project     = "nome-projeto-service-account"  # Nome do projeto no GCP
  region      = "us-central1"                   # Região onde os recursos serão criados
  zone        = "us-central1-c"                 # Zona específica dentro da região
  credentials = file("serviceaccount.json")     # Arquivo de credenciais da service account
}

# Para criar um projeto preciso ter uma organização
/*resource "google_project" "devops" {
  name                = "DevOps"               # Nome do projeto que será exibido no console do Google Cloud
  project_id          = "devops-2025-br"       # ID do projeto, deve ser único globalmente no Google Cloud
  auto_create_network = false                  # Não cria uma rede padrão automaticamente
  billing_account     = "xxxxxx-xxxxxx-xxxxxx" # ID da conta de faturamento associada ao projeto
}*/

resource "google_compute_instance" "primeira-vm" {
  boot_disk {
    auto_delete = true                      # Disco será deletado quando a VM for deletada
    device_name = "primeira-vm"             # Nome do dispositivo do disco

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250213" # Imagem do SO
      size  = 10                            # Tamanho do disco em GB
      type  = "pd-standard"                 # Tipo do disco (padrão)
    }

    mode = "READ_WRITE"                     # Modo de acesso ao disco (leitura e escrita)
  }

  can_ip_forward      = false               # Não permite encaminhamento de IP
  deletion_protection = false               # Proteção contra exclusão desativada
  enable_display      = false               # Display desativado

  labels = {
    goog-ec-src = "vm_add-tf"               # Rótulo para a VM
  }

  machine_type = "e2-micro"                 # Tipo de máquina (pequena)
  name         = "primeira-vm"              # Nome da VM

  network_interface {
    access_config {
      network_tier = "STANDARD"              # Nível de rede (STANDARD)
    }
    
    subnetwork  = "projects/gomide-advocacia/regions/us-central1/subnetworks/default" # Sub-rede
  }

  scheduling {
    automatic_restart   = false             # Reinício automático desativado
    on_host_maintenance = "MIGRATE"         # Migração em manutenção do host
    preemptible         = false             # Não é preemptível
    provisioning_model  = "STANDARD"        # Modelo de provisionamento padrão
  }

  service_account {
    email  = "xxxx-compute@developer.gserviceaccount.com"         # Email da service account
    scopes = [                                                    # Escopos de acesso
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true      # Monitoramento de integridade ativado
    enable_secure_boot          = false     # Boot seguro desativado
    enable_vtpm                 = true      # vTPM ativado
  }

  tags = ["http-server", "https-server"]    # Tags para a VM
  zone = "us-central1-c"                    # Zona onde a VM será criada
}

