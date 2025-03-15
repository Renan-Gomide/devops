#!/bin/bash

# Solicitar mensagem de commit
read -p "Digite a mensagem de commit: " commit_message

# Verificar se o repositório git está configurado
git status &> /dev/null

if [ $? -ne 0 ]; then
    # Repositório Git não configurado, solicitar nome do repositório
    echo "Não há repositório Git configurado."
    read -p "Digite o nome do repositório remoto: " repo_name

    # Inicializar repositório git local com a branch "main"
    git init -b main

    # Criar repositório remoto no GitHub via API (assumindo que o usuário tenha configurado o GitHub CLI ou tokens)
    gh repo create $repo_name --public --source=. --remote=origin

    # Adicionar o repositório remoto e fazer o primeiro commit
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