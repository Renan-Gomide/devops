# 🐳 Guia Completo do Docker

Este tutorial é um guia completo e prático sobre Docker. Aqui você vai aprender desde os conceitos básicos até operações mais avançadas. O material foi pensado para ser claro, visualmente atrativo e de fácil entendimento, mesmo para quem está começando. Vamos nessa?

---

## 📚 Índice

1. [Introdução ao Docker](#-introdução-ao-docker)
2. [Instalação no Linux](#-instalação-no-linux)
3. [Trabalhando com Imagens](#-trabalhando-com-imagens)
4. [Executando Containers](#-executando-containers)
5. [Manipulação de Arquivos](#-manipulação-de-arquivos)
6. [Exemplo Prático: MySQL](#-exemplo-rodando-um-banco-de-dados-mysql)
7. [Volumes e Montagem de Diretórios](#-volumes-e-montagem-de-diretórios)
8. [Criação de Imagens com Dockerfile](#-criação-de-imagens-com-dockerfile)
9. [Imagens Multistage com Dockerfile](#-criação-de-imagens-multistage-com-dockerfile)
10. [Docker Compose](#-como-instalar-o-docker-compose)
11. [Criando um Arquivo YAML para Docker Compose](#-como-criar-um-arquivo-yaml-para-docker-compose)
12. [Docker Swarm](#-o-que-é-docker-swarm)
13. [Configuração e Monitoramento](#-configuração-e-monitoramento)
14. [Gerenciamento de Redes](#-gerenciamento-de-redes)
15. [Resumo dos Comandos](#-resumo-dos-comandos)

---

## 🐳 Introdução ao Docker

Docker é uma plataforma poderosa que permite **criar, implantar e executar aplicativos em contêineres**. Cada contêiner é um ambiente isolado que contém tudo o que o aplicativo precisa para rodar, garantindo portabilidade e consistência entre ambientes.

---

## 📥 Instalação no Linux

Para instalar o Docker em sistemas baseados em Debian/Ubuntu, siga estes passos:

1. **Atualize o sistema:**

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instale o Docker:**

   ```bash
   sudo apt install docker.io -y
   ```

3. **Verifique a instalação:**

   ```bash
   docker --version
   ```

4. **Inicie o serviço e configure o boot:**

   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

5. **(Opcional) Rode sem `sudo`:**  
   Adicione seu usuário ao grupo `docker` e reinicie a sessão:

   ```bash
   sudo usermod -aG docker $USER
   ```

---

## 📦 Trabalhando com Imagens

### 🔍 Procurando Imagens

O [Docker Hub](https://hub.docker.com/) é o repositório oficial para encontrar imagens de contêineres.  
Para buscar uma imagem diretamente pelo terminal, use:

```bash
docker search nome-da-imagem
```

_Exemplo:_

```bash
docker search ubuntu
```

### 📥 Baixando e Listando Imagens

- **Baixar uma imagem:**

  ```bash
  docker pull hello-world
  ```

- **Listar imagens disponíveis:**

  ```bash
  docker images
  ```

---

## 🚀 Executando Containers

### Rodando Containers Básicos

- **Executar um container de teste:**

  ```bash
  docker run hello-world
  ```

- **Executar um container interativo (modo detached + terminal):**

  ```bash
  docker run -dit ubuntu
  ```

- **Executar e nomear um container:**

  ```bash
  docker run -dit --name meu-container ubuntu
  ```

### Gerenciando Containers

- **Listar containers em execução:**

  ```bash
  docker ps
  ```

- **Listar todos os containers (inclusive parados):**

  ```bash
  docker ps -a
  ```

- **Parar um container:**

  ```bash
  docker stop ID_CONTAINER
  ```

- **Iniciar um container parado:**

  ```bash
  docker start ID_CONTAINER
  ```

- **Remover um container:**

  ```bash
  docker rm ID_CONTAINER
  ```

- **Remover uma imagem:**

  ```bash
  docker rmi nome-imagem
  ```

- **Parar e remover todos os containers:**

  ```bash
  docker stop $(docker ps -q)
  docker rm $(docker ps -a -q)
  ```

- **Remover todos os volumes não utilizados:**

  ```bash
  docker volume prune
  ```

### Comandos Adicionais

- **Inspecionar um container:**

  ```bash
  docker inspect nome-container
  ```

- **Ver logs do container:**

  ```bash
  docker logs nome-container
  ```

- **Acessar o terminal de um container:**

  ```bash
  docker exec -it nome-container /bin/bash
  ```

---

## 📂 Manipulação de Arquivos

- **Copiar um arquivo do host para dentro de um container:**

  ```bash
  docker cp arquivo.txt nome-container:/destino
  ```

- **Executar comandos dentro de um container (ex.: listar diretórios):**

  ```bash
  docker exec nome-container ls
  ```

---

## 🗄️ Exemplo: Rodando um Banco de Dados MySQL

1. **Baixar a imagem do MySQL:**

   ```bash
   docker pull mysql
   ```

2. **Rodar um container com MySQL:**

   ```bash
   docker run -e MYSQL_ROOT_PASSWORD=senha123 --name container-mysql -d -p 3306:3306 mysql
   ```

3. **Acessar o terminal do container:**

   ```bash
   docker exec -it container-mysql bash
   ```

4. **Dentro do container, acessar o MySQL:**

   ```bash
   mysql -u root -p --protocol=tcp
   ```

5. **Criar um banco de dados:**

   ```sql
   CREATE DATABASE meu_banco;
   ```

6. **Conectar ao MySQL de fora do container:**  
   Obtenha o IP do container:

   ```bash
   docker inspect container-mysql | grep "IPAddress"
   ```

7. **Instalar um cliente MySQL no host (se necessário):**

   ```bash
   sudo apt -y install mysql-client
   ```

---

## 📁 Volumes e Montagem de Diretórios

Volumes permitem a persistência dos dados, mesmo que o container seja removido.

- **Criar um volume nomeado:**

  ```bash
  docker volume create meu-volume
  ```

- **Usar o volume em um container:**

  ```bash
  docker run -dti --mount source=meu-volume,target=/dados ubuntu
  ```

- **Bind Mount:**  
  Mapeia uma pasta do host para o container:

  ```bash
  docker run -dti --mount type=bind,src=/caminho/host,dst=/caminho/container ubuntu
  ```

- **Tornando a montagem somente leitura:**

  ```bash
  docker run -dti --mount type=bind,src=/caminho/host,dst=/caminho/container,readonly ubuntu
  ```

---

## 🛠️ Criação de Imagens com Dockerfile

O **Dockerfile** é um script que contém instruções para construir uma imagem Docker.  
Exemplo básico:

1. Crie um arquivo chamado `Dockerfile` com o seguinte conteúdo:

   ```dockerfile
   FROM ubuntu
   RUN apt update && apt install -y python3 nano && apt clean
   COPY arquivo-teste.py /pasta/destino/container/arquivo-teste.py
   CMD python3 /pasta/destino/container/arquivo-teste.py
   ```

   - **FROM:** Define a imagem base (ex.: Ubuntu).
   - **RUN:** Executa comandos, como atualização e instalação de pacotes.
   - **COPY:** Copia arquivos do host para o container.
   - **CMD:** Define o comando padrão para execução.

2. **Construa a imagem:**

   ```bash
   docker build . -t imagem-container
   ```

---

## 🏗️ Criação de Imagens Multistage com Dockerfile

Imagens multistage ajudam a reduzir o tamanho final da imagem, copiando apenas os artefatos necessários da fase de build.

Exemplo:

1. Crie um arquivo `Dockerfile` com o conteúdo:

   ```dockerfile
   # Fase de construção
   FROM golang:1.16 AS builder
   WORKDIR /app
   COPY . .
   RUN go build -o meu-app

   # Fase final
   FROM alpine:latest
   WORKDIR /root/
   COPY --from=builder /app/meu-app .
   CMD ["./meu-app"]
   ```

2. **Construa a imagem:**

   ```bash
   docker build . -t meu-app
   ```

---

## 🛠️ Como Instalar o Docker Compose

O Docker Compose permite gerenciar aplicações com múltiplos containers de forma simples.

1. **Baixe a versão mais recente:**

   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. **Torne o binário executável:**

   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Verifique a instalação:**

   ```bash
   docker-compose --version
   ```

---

## 📝 Como Criar um Arquivo YAML para Docker Compose

Um arquivo YAML organiza os serviços, redes e volumes para um projeto com Docker Compose.

Exemplo básico:

1. Crie um arquivo chamado `docker-compose.yml` com o conteúdo:

   ```yaml
   version: "3"
   services:
     web:
       image: nginx
       ports:
         - "80:80"
     db:
       image: mysql
       environment:
         MYSQL_ROOT_PASSWORD: exemplo
   ```

2. **Inicie os serviços:**

   ```bash
   docker-compose up
   ```

---

## 🌐 O que é Docker Swarm

Docker Swarm é a ferramenta de orquestração de containers do Docker. Ele permite gerenciar um cluster de nós Docker como um único sistema.

### Comandos Básicos do Docker Swarm

- **Inicializar um Swarm:**

  ```bash
  docker swarm init
  ```

- **Adicionar um node ao Swarm:**

  ```bash
  docker swarm join --token <token> <manager-ip>:<manager-port>
  ```

- **Listar nodes:**

  ```bash
  docker node ls
  ```

- **Criar um serviço:**

  ```bash
  docker service create --name meu-servico -p 80:80 nginx
  ```

- **Listar serviços:**

  ```bash
  docker service ls
  ```

- **Escalar um serviço:**

  ```bash
  docker service scale meu-servico=3
  ```

- **Remover um serviço:**

  ```bash
  docker service rm meu-servico
  ```

---

## 🛠️ Configuração e Monitoramento

Manter o controle sobre os recursos e o desempenho dos containers é essencial:

- **Informações gerais:**

  ```bash
  docker info
  ```

- **Estatísticas de uso (CPU, memória):**

  ```bash
  docker stats
  ```

- **Inspecionar um container:**

  ```bash
  docker inspect nome-container
  ```

- **Atualizar limites de recursos:**

  ```bash
  docker update nome-container -m 128m --cpus 0.3
  ```

---

## 🌐 Gerenciamento de Redes

Gerenciar redes é fundamental para a comunicação entre containers.

- **Listar redes:**

  ```bash
  docker network ls
  ```

- **Criar uma nova rede:**

  ```bash
  docker network create minha-rede
  ```

- **Conectar um container a uma rede:**

  ```bash
  docker network connect minha-rede nome-container
  ```

- **Desconectar um container de uma rede:**

  ```bash
  docker network disconnect minha-rede nome-container
  ```

---

## 📌 Resumo dos Comandos e Tópicos

| **Tópico/Comando**                             | **Descrição**                                                           |
| ---------------------------------------------- | ----------------------------------------------------------------------- |
| `docker search nome-imagem`                    | Busca por imagens no Docker Hub                                         |
| `docker pull nome-imagem`                      | Baixa uma imagem do repositório                                         |
| `docker images`                                | Lista todas as imagens disponíveis                                      |
| `docker run [opções] nome-imagem`              | Cria e executa um container a partir de uma imagem                      |
| `docker ps` / `docker ps -a`                   | Lista containers ativos ou todos (inclusive os parados)                 |
| `docker stop/start/rm`                         | Para, inicia ou remove containers                                       |
| `docker rmi nome-imagem`                       | Remove uma imagem Docker                                                |
| `docker container prune`                       | Remove todos os containers parados                                      |
| `docker cp`                                    | Copia arquivos entre host e container                                   |
| `docker exec`                                  | Executa comandos dentro de um container                                 |
| `docker volume create` / `docker volume prune` | Cria e gerencia volumes para persistência de dados                      |
| `docker build -t imagem-container .`           | Constrói uma imagem a partir de um Dockerfile                           |
| `docker-compose up`                            | Inicia serviços definidos em um arquivo docker-compose.yml              |
| `docker swarm init` / `docker service create`  | Inicia um cluster Swarm e cria serviços para orquestração de containers |
| `docker network ls/create/connect/disconnect`  | Gerencia redes e a conectividade entre containers                       |
| `docker stats` / `docker info`                 | Monitora recursos e informações gerais do Docker                        |

---

## Considerações Finais

Este tutorial foi preparado para ser seu ponto de partida para dominar o Docker. Experimente os comandos, modifique os exemplos e explore as diversas funcionalidades dessa ferramenta incrível. Se você tiver dúvidas ou quiser aprofundar algum tópico, a documentação oficial do Docker é uma ótima referência.

Bora colocar a mão na massa e explorar o mundo dos containers? 🚀
