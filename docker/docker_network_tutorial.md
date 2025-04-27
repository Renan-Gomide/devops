# 📦 Docker Networking Tutorial

Este tutorial explica como funcionam as **redes no Docker**, como criar e gerenciar redes, e como conectar contêineres entre si. É voltado para iniciantes e intermediários.

---

## 🧠 O que é uma Docker Network?

Docker Networks são **interfaces de rede virtuais** que permitem a comunicação entre contêineres, com o host ou com o mundo externo. Elas oferecem isolamento, segurança e controle sobre como os contêineres se comunicam.

---

## 🧭 Tipos de Redes no Docker

| Tipo       | Descrição                                                                 | Casos de Uso                                   |
|------------|---------------------------------------------------------------------------|------------------------------------------------|
| **bridge** | Rede padrão criada automaticamente para contêineres locais                | Comunicação entre contêineres no mesmo host    |
| **host**   | Contêiner compartilha a rede do host                                      | Alta performance e acesso direto à rede        |
| **none**   | Contêiner sem nenhuma interface de rede                                   | Isolamento total                               |
| **overlay**| Conecta contêineres em hosts diferentes (usada com Swarm)                 | Microsserviços distribuídos em múltiplos hosts |
| **macvlan**| Atribui um MAC/IP diretamente do host (parece outro dispositivo na rede) | Conectividade com redes físicas                |

---

## 🛠️ Comandos Essenciais

### 🔍 Listar redes existentes
```bash
docker network ls
```

### 👀 Inspecionar uma rede
```bash
docker network inspect bridge
```

### ➕ Criar uma nova rede bridge
```bash
docker network create \
  --driver bridge \
  minha_rede
```

### ➖ Remover uma rede
```bash
docker network rm minha_rede
```

---

## 🤝 Comunicação entre contêineres

### Exemplo com rede bridge personalizada:
```bash
# Criar rede personalizada
$ docker network create app_net

# Subir contêineres na mesma rede
$ docker run -dit --name app1 --network app_net alpine
$ docker run -dit --name app2 --network app_net alpine

# Testar comunicação via ping
$ docker exec -it app1 ping app2
```

✔️ **Nota:** Contêineres na mesma rede personalizada se resolvem pelo nome.

---

## 🌐 Exemplo com rede host
```bash
# Subir contêiner usando a rede do host
$ docker run --rm -it --network host alpine
```
✔️ Neste modo, não há isolamento de porta: o contêiner compartilha a rede do host.

---

## 🚫 Exemplo com rede none
```bash
# Subir contêiner sem rede
$ docker run -dit --name isolado --network none alpine

# Tentar pingar algo (vai falhar)
$ docker exec -it isolado ping google.com
```

---

## 🔗 Conectar contêiner a outra rede
```bash
# Conectar app1 a outra rede
$ docker network create net2
$ docker network connect net2 app1

# Agora app1 está em duas redes: app_net e net2
```

---

## 🔄 Desconectar contêiner de uma rede
```bash
$ docker network disconnect net2 app1
```

---

## 🧪 Dica: Simule microserviços com redes
```bash
# Criar rede
$ docker network create micro_net

# Subir "banco de dados"
$ docker run -dit --name db --network micro_net mongo

# Subir "API" que conecta ao banco
$ docker run -dit --name api --network micro_net node-app

# API pode acessar o banco usando: mongodb://db:27017
```

---

## 📘 Conclusão

- Docker Networks são fundamentais para segurança e conectividade.
- Use redes personalizadas para ter DNS interno automático.
- Combine redes com volumes e Compose para criar ambientes complexos.

---

## 📚 Leitura Recomendada

- [Documentação Oficial Docker Networking](https://docs.docker.com/network/)
- [Docker Networking Deep Dive – Bret Fisher](https://www.bretfisher.com/docker-networking/)

---

## 💡 Dica Extra

Se estiver usando Docker Compose:
```yaml
services:
  app:
    image: minha-app
    networks:
      - minha-rede

networks:
  minha-rede:
    driver: bridge
```

---

> ⚓ Este tutorial foi criado para facilitar o aprendizado prático e visual sobre redes no Docker.
