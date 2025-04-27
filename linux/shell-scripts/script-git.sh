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
    # Repositório Git não configurado
    echo "Não há repositório Git configurado nesta pasta."

    # Verificar se o GitHub CLI está autenticado
    gh auth status &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Você não está autenticado no GitHub CLI."
        echo "Por favor, faça login utilizando o comando: gh auth login"
        exit 1
    fi

    # Listar repositórios existentes no GitHub
    echo "Listando seus repositórios no GitHub..."
    gh repo list | less # Exibe todos os nomes dos repositórios

    # Perguntar se deseja usar um repositório existente ou criar um novo
    read -p "Deseja usar um repositório existente? (s/n): " use_existing

    if [ "$use_existing" == "s" ]; then
        read -p "Digite o nome do repositório que deseja usar: " repo_name

        # Verificar se o repositório existe no GitHub
        gh repo view "$repo_name" &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Conectando ao repositório '$repo_name'..."
            git init -b main
            git remote add origin "https://github.com/$(gh api user --jq '.login')/$repo_name.git"
        else
            echo "Erro: o repositório '$repo_name' não foi encontrado no GitHub."
            exit 1
        fi
    else
        # Criar um novo repositório
        read -p "Digite o nome do novo repositório remoto: " repo_name
        gh repo create "$repo_name" --public --source=. --remote=origin
        echo "Repositório '$repo_name' criado com sucesso no GitHub!"
        git init -b main
        git remote add origin "https://github.com/$(gh api user --jq '.login')/$repo_name.git"
    fi

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