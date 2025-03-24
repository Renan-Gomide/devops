#!/bin/bash

# Checa o último commit, se houver
echo "Último commit:"
git log -1 --pretty=%B || echo "Ainda não há commits."

# Solicitar mensagem de commit
read -p "Digite a mensagem de commit: " commit_message

# Verificar se a mensagem de commit não está vazia
if [ -z "$commit_message" ]; then
    echo "Erro: a mensagem de commit não pode ser vazia."
    exit 1
fi

# Verificar se o repositório git está configurado
git rev-parse --is-inside-work-tree &> /dev/null

if [ $? -ne 0 ]; then
    # Repositório Git não configurado, solicitar nome do repositório
    echo "Não há repositório Git configurado."
    read -p "Digite o nome do repositório remoto: " repo_name

    # Verificar se o GitHub CLI está autenticado
    gh auth status &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Você não está autenticado no GitHub CLI."
        echo "Por favor, faça login utilizando o comando: gh auth login"
        exit 1
    fi

    # Verificar se o repositório já existe no GitHub
    gh repo view "$repo_name" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "O repositório '$repo_name' já existe no GitHub."
        echo "Usando repositório existente e configurando o remoto."
    else
        # Criar repositório remoto no GitHub via API
        gh repo create "$repo_name" --public --source=. --remote=origin
        echo "Repositório '$repo_name' criado com sucesso no GitHub!"
    fi

    # Inicializar repositório git local com a branch "main"
    git init -b main

    # Adicionar o repositório remoto
    git remote add origin "https://github.com/$(git config --get user.name)/$repo_name.git"

    # Adicionar todos os arquivos, fazer o commit e o push
    git add .
    git commit -m "$commit_message"
    git push -u origin main

    echo "Repositório local e remoto configurados com sucesso!"
else
    # O repositório Git já existe, apenas proceder com o commit e push
    echo "Repositório Git já configurado."
    
    git add .
    git commit -m "$commit_message"
    git push origin main
fi
