#!/bin/bash

# Functions

clone_repo() {
    read -p "Escribe el URL del repositorio: " repo_url
    read -p "Escribe la ruta de la carpeta de destino: " clone_dir

    git clone "$repo_url" "$clone_dir"
}

create_branch() {
    read -p "Pon el nombre de la rama: " branch_name

    git checkout -b "$branch_name"
}

stage_changes() {
    echo "Esta opción se utiliza en caso de solo modificar algun archivo especifico"
    read -p "Introduzca los nombres de los archivos a escenificar (separados por espacios) el add: " files

    git add ${files}
}

commit_changes() {
    read -p "Escriba el comentario de guardado (commit): " commit_msg

    git commit -m "$commit_msg"
}

push_changes() {
    echo "Esta opción se utiliza en caso de subirlo a una rama diferente"
    read -p "Escribra la branch para subirla (push): " push_branch

    git push origin "$push_branch"
}

add_commit_push() {
    echo "Esta opción se utiliza en caso de hacer una subida rapida y facil"
    read -p "Escriba el comentario de guardado (commit): " commit_msg

    git add .
    git commit -m "$commit_msg"
    git push origin main
}

pull_changes() {
    read -p "Pon el nombre de la rama(branch): " pull_branch

    git pull origin "$pull_branch"
}

merge_branch() {
    read -p "Escriba la rama a fusionar en la rama actual (merge): " merge_branch

    git merge "$merge_branch"
}

git_status() {
    git status
}

git_fetch() {
    git fetch
}

git_reset() {
    read -p "Introduzca commit para restablecer: " reset_commit

    git reset --hard "$reset_commit"
}

# Main logic

while true; do

    echo "Select an option:"
    echo "1) Clone a repo"
    echo "2) Create new branch"
    echo "3) Stage changes"
    echo "4) Commit changes"
    echo "5) Push changes"
    echo "6) Add, commit and push changes"
    echo "7) Pull changes"
    echo "8) Merge branch"
    echo "9) Git status"
    echo "10) Git fetch"
    echo "11) Git reset"
    echo "12) Exit"

    read -p "Enter choice: " choice

    case $choice in
    1)
        clone_repo
        ;;
    2)
        create_branch
        ;;
    3)
        stage_changes
        ;;
    4)
        commit_changes
        ;;
    5)
        push_changes
        ;;
    6)
        add_commit_push
        ;;
    7)
        pull_changes
        ;;
    8)
        merge_branch
        ;;
    9)
        git_status
        ;;
    10)
        git_fetch
        ;;
    11)
        git_reset
        ;;
    12)
        echo "Exiting..."
        break
        ;;
    *) echo "Invalid choice" ;;
    esac

done
