#!/usr/bin/env bash
# script para inicializar e sincronizar um repositório Git local com GitHub CLI

set -euo pipefail

# Função para exibir mensagem de erro e sair
error() {
  echo "Erro: $1" >&2
  exit "${2:-1}"
}

# Verifica se estamos dentro de um repositório Git
if git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Repositório Git já configurado."
else
  echo "Nenhum repositório Git encontrado nesta pasta."

  # Verifica autenticação no GitHub CLI
  if ! gh auth status &>/dev/null; then
    echo "Você não está autenticado no GitHub CLI."
    echo "Execute: gh auth login"
    error "Autenticação necessária."
  fi

  # Lista repositórios do usuário
  echo "Seus repositórios no GitHub:"
  gh repo list --limit 100  # sem paginar interativamente

  # Pergunta se usa repo existente ou cria novo
  use_existing=""
  while [[ ! "$use_existing" =~ ^[sSnN]$ ]]; do
    read -rp "Usar repositório existente? (s/n): " use_existing
  done

  # Determina login do usuário
  GH_USER=$(gh api user --jq '.login')
  [[ -n "$GH_USER" ]] || error "Não foi possível obter login GitHub."

  if [[ "${use_existing,,}" == "s" ]]; then
    read -rp "Informe o nome do repositório (ex: usuario/repo): " repo_name
    # Verifica existência
    if gh repo view "$repo_name" &>/dev/null; then
      echo "Conectando ao repositório '$repo_name'..."
    else
      error "Repositório '$repo_name' não encontrado." 2
    fi
  else
    read -rp "Nome do novo repositório (ex: repo): " new_repo
    repo_name="$GH_USER/$new_repo"
    echo "Criando repositório '$repo_name'..."
    gh repo create "$new_repo" --public --source=. --remote=origin || \
      error "Falha ao criar repositório." 3
  fi

  # Inicializa localmente
  echo "Inicializando repositório local..."
  git init -b main

  # Configura remote "origin"
  if git remote get-url origin &>/dev/null; then
    git remote set-url origin "https://github.com/$repo_name.git"
    echo "URL do remote 'origin' atualizada."
  else
    git remote add origin "https://github.com/$repo_name.git"
    echo "Remote 'origin' configurado."
  fi

  echo "Repositório local e remoto prontos."
fi

# Exibe último commit (se existir)
echo "Último commit:" 
git log -1 --pretty=%B || echo "Ainda não há commits."

# Verifica existência de alterações
if git diff-index --quiet HEAD --; then
  echo "Não há alterações para commitar."
  exit 0
fi

# Solicita mensagem de commit
while :; do
  read -rp "Mensagem de commit: " commit_message
  [[ -n "$commit_message" ]] && break
  echo "A mensagem de commit não pode ser vazia."
done

# Executa commit e push
git add .
git commit -m "$commit_message"
git push -u origin main

echo "Commit e push realizados com sucesso!"
