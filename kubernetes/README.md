# Introdução a Kubernetes

Kubernetes é uma plataforma open-source para gerenciar aplicações containerizadas em múltiplos hosts, fornecendo mecanismos básicos para a implantação, manutenção e escalonamento de aplicações.

## Kubectl

`kubectl` é a ferramenta de linha de comando para interagir com o Kubernetes. Com ele, você pode executar comandos no seu cluster Kubernetes, como criar, atualizar, excluir e visualizar recursos.

### Comandos básicos do kubectl

| Comando                     | Descrição                                 |
| --------------------------- | ----------------------------------------- |
| `kubectl get svc`           | Lista todos os serviços no cluster.       |
| `kubectl get nodes --watch` | Monitora os nós do cluster em tempo real. |

## AWS CLI para criar e acessar um Kubernetes (EKS)

O Amazon Elastic Kubernetes Service (EKS) é um serviço gerenciado que facilita a execução do Kubernetes na AWS sem precisar instalar e operar seu próprio plano de controle Kubernetes.

### Instalando a AWS CLI

Para instalar a AWS CLI, siga as instruções oficiais da [documentação da AWS](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

### Comandos para EKS

| Comando                                                                        | Descrição                                         |
| ------------------------------------------------------------------------------ | ------------------------------------------------- |
| `aws eks --region sa-east1 describe_cluster --name aaa --query cluster.status` | Descreve o status do cluster EKS.                 |
| `aws eks --region sa-east1 update-kubeconfig --name aaa`                       | Atualiza o kubeconfig para acessar o cluster EKS. |

## Config do kubectl para acessar a AWS

Após configurar a AWS CLI, você precisa configurar o `kubectl` para acessar seu cluster EKS. Use o comando `aws eks update-kubeconfig` para atualizar seu arquivo kubeconfig com as credenciais do cluster.

## Criando nós na AWS

Os nós são as máquinas (físicas ou virtuais) que executam as aplicações containerizadas e outros componentes do Kubernetes. No EKS, você pode criar nós usando grupos de nós gerenciados ou autoescaladores.

### Criando um grupo de nós gerenciados

1. Acesse o console do EKS.
2. Selecione seu cluster.
3. Vá para a seção "Compute" e clique em "Add Node Group".
4. Siga as instruções para configurar e criar o grupo de nós.

## Criando Kubernetes no GCP (GKE)

O Google Kubernetes Engine (GKE) é um serviço gerenciado que facilita a execução do Kubernetes no Google Cloud Platform (GCP).

### Criando um cluster GKE

1. Acesse o console do GCP.
2. Vá para a seção "Kubernetes Engine".
3. Clique em "Create Cluster".
4. Siga as instruções para configurar e criar o cluster.

## Instalar CLI gcloud no Linux e acessar pelo terminal

A CLI gcloud é a ferramenta de linha de comando para interagir com o Google Cloud Platform.

### Instalando a CLI gcloud

1. Baixe e instale a CLI gcloud seguindo as instruções da [documentação oficial](https://cloud.google.com/sdk/docs/install).

### Autenticando e configurando

1. Execute `gcloud init` para inicializar a CLI e configurar seu projeto.
2. Use `gcloud container clusters get-credentials [CLUSTER_NAME]` para configurar o `kubectl` para acessar seu cluster GKE.

### Resumo dos Comandos

| Comando                                                                        | Descrição                                         |
| ------------------------------------------------------------------------------ | ------------------------------------------------- |
| `aws eks --region sa-east1 describe_cluster --name aaa --query cluster.status` | Descreve o status do cluster EKS.                 |
| `aws eks --region sa-east1 update-kubeconfig --name aaa`                       | Atualiza o kubeconfig para acessar o cluster EKS. |
| `kubectl get svc`                                                              | Lista todos os serviços no cluster.               |
| `kubectl get nodes --watch`                                                    | Monitora os nós do cluster em tempo real.         |

## Criando YAML do Kubernetes

Para criar recursos no Kubernetes, você pode usar arquivos YAML. Aqui estão alguns exemplos de tipos de recursos que você pode definir:

- `kind: Pod`
- `kind: Deployment`

### Estrutura de um arquivo YAML

Um arquivo YAML para Kubernetes geralmente contém as seguintes seções:

- `apiVersion`: A versão da API do Kubernetes que você está usando.
- `kind`: O tipo de recurso que você está criando (por exemplo, Pod, Deployment).
- `metadata`: Metadados sobre o recurso, como nome e rótulos.
- `spec`: A especificação do recurso, que varia dependendo do tipo de recurso.

### Exemplo de YAML para um Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
    - name: meu-container
      image: nginx
```

### Exemplo de YAML para um Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meu-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: meu-app
  template:
    metadata:
      labels:
        app: meu-app
    spec:
      containers:
        - name: meu-container
          image: nginx
```

### Exemplo de YAML para um LoadBalancer

```yaml
apiVersion: v1
kind: Service
metadata:
  name: meu-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: meu-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

### Criando um NodePort

Um NodePort é um tipo de serviço que expõe uma aplicação em um número de porta estático em cada nó do cluster. Aqui está um exemplo de YAML para criar um NodePort:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: meu-nodeport
spec:
  type: NodePort
  selector:
    app: meu-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30007
```

### Usando kubectl exec --stdin --tty

O comando `kubectl exec` permite que você execute comandos em um contêiner em execução. A opção `--stdin` permite que você envie entrada para o comando, e `--tty` aloca um terminal TTY. Exemplo:

```sh
kubectl exec --stdin --tty <nome-do-pod> -- /bin/bash
```

### Usando kubectl port-forward

O comando `kubectl port-forward` permite que você encaminhe uma porta local para uma porta em um pod no cluster. Exemplo:

```sh
kubectl port-forward <nome-do-pod> 8080:80
```

### Deploy e Service em um único arquivo YAML

Você pode definir múltiplos recursos em um único arquivo YAML separando-os com `---`. Exemplo:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meu-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: meu-app
  template:
    metadata:
      labels:
        app: meu-app
    spec:
      containers:
        - name: meu-container
          image: nginx
---
apiVersion: v1
kind: Service
metadata:
  name: meu-service
spec:
  type: LoadBalancer
  selector:
    app: meu-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

### Diferenças entre Service e Pods

| Característica | Service                                | Pod                     |
| -------------- | -------------------------------------- | ----------------------- |
| `kind`         | Service                                | Pod                     |
| Função         | Expor aplicações como serviços de rede | Executar contêineres    |
| Persistência   | Persistente                            | Efêmero                 |
| Escalabilidade | N/A                                    | Não escalável por si só |

### Diferença entre Pod e Container

| Característica | Pod                            | Container                                            |
| -------------- | ------------------------------ | ---------------------------------------------------- |
| `kind`         | Pod                            | N/A                                                  |
| Função         | Agrupar um ou mais contêineres | Executar uma aplicação isolada                       |
| Escalabilidade | Não escalável por si só        | N/A                                                  |
| Gerenciamento  | Gerenciado pelo Kubernetes     | Gerenciado pelo Docker ou outro runtime de contêiner |

### Criando e usando Persistent Volume (PV)

Um Persistent Volume (PV) é um recurso de armazenamento no Kubernetes que existe independentemente dos pods. Aqui está um exemplo de YAML para criar um PV:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: meu-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

### Criando e usando Persistent Volume Claim (PVC)

Um Persistent Volume Claim (PVC) é uma solicitação de armazenamento por um usuário. Aqui está um exemplo de YAML para criar um PVC:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: meu-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

### Criando e usando PV e PVC dentro do GCP

No GCP, você pode criar um PV e PVC usando o Google Cloud Persistent Disk. Aqui está um exemplo de YAML para criar um PV e PVC no GCP:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: gcp-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  gcePersistentDisk:
    pdName: my-gce-disk
    fsType: ext4
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: gcp-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

### Criando um NFS (Filestore) no GCP para usar com PV

O Google Cloud Filestore é um serviço de armazenamento de arquivos NFS. Aqui está um exemplo de YAML para criar um PV usando um Filestore NFS:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 1Ti
  accessModes:
    - ReadWriteMany
  nfs:
    path: /path/to/share
    server: nfs-server.example.com
```

### Criando recursos com YAML

Para criar recursos definidos em um arquivo YAML, use o comando:

```sh
kubectl apply -f <arquivo.yaml>
```

### Escalando e expondo recursos

- `kubectl scale`: Escala o número de réplicas de um recurso.
- `kubectl expose`: Expõe um recurso como um serviço.

Exemplo de uso:

```sh
kubectl scale deployment <nome-do-deployment> --replicas=<número-de-réplicas>
kubectl expose deployment <nome-do-deployment> --type=LoadBalancer --name=<nome-do-serviço>
```

## Kind: Kubernetes IN Docker

O **Kind (Kubernetes IN Docker)** é uma ferramenta para executar clusters Kubernetes localmente usando contêineres Docker como nós do cluster. Ele é ideal para testes, desenvolvimento e aprendizado.

### 🔧 Como funciona?

O Kind cria clusters Kubernetes dentro de contêineres Docker. Cada nó do cluster é um contêiner, o que torna o processo leve e fácil de configurar. Ele é amplamente utilizado para:

- Testar configurações de Kubernetes localmente.
- Executar clusters temporários para desenvolvimento.
- Automatizar testes de integração.

### 🛠️ Instalando o Kind

1. Certifique-se de que o Docker está instalado e em execução no seu sistema.
2. Instale o Kind usando o comando abaixo:

   ```sh
   curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
   chmod +x ./kind
   sudo mv ./kind /usr/local/bin/kind
   ```

   > Para outros sistemas operacionais, consulte a [documentação oficial do Kind](https://kind.sigs.k8s.io/).

3. Verifique se o Kind foi instalado corretamente:
   ```sh
   kind version
   ```

### 🚀 Criando um Cluster com Kind

1. Crie um cluster Kubernetes com o comando:

   ```sh
   kind create cluster
   ```

   Isso criará um cluster padrão com um único nó.

2. Para criar um cluster com uma configuração personalizada, use um arquivo de configuração YAML. Exemplo:

   ```yaml
   kind: Cluster
   apiVersion: kind.x-k8s.io/v1alpha4
   nodes:
     - role: control-plane
     - role: worker
     - role: worker
   ```

   Execute o comando:

   ```sh
   kind create cluster --config kind-config.yaml
   ```

3. Liste os clusters criados:

   ```sh
   kind get clusters
   ```

4. Para deletar um cluster:
   ```sh
   kind delete cluster
   ```

### 🧪 Usando o Kind com `kubectl`

Após criar um cluster com o Kind, ele configura automaticamente o `kubectl` para se conectar ao cluster. Você pode usar comandos como:

- Listar os nós do cluster:

  ```sh
  kubectl get nodes
  ```

- Aplicar um arquivo YAML:
  ```sh
  kubectl apply -f <arquivo.yaml>
  ```

### 🌟 Vantagens do Kind

- **Leve e rápido**: Ideal para testes locais.
- **Sem necessidade de VMs**: Usa contêineres Docker como nós.
- **Configuração simples**: Fácil de instalar e usar.

---

## Resumo dos Comandos do Kind

| Comando                              | Descrição                                       |
| ------------------------------------ | ----------------------------------------------- |
| `kind create cluster`                | Cria um cluster Kubernetes padrão.              |
| `kind create cluster --config <arq>` | Cria um cluster com configuração personalizada. |
| `kind get clusters`                  | Lista os clusters criados.                      |
| `kind delete cluster`                | Remove o cluster criado.                        |
