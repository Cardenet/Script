#!/bin/bash

# Functions

clone_repo() {
    echo "--------------------------------------------------------------------"
    read -p "Escribe el URL del repositorio: " repo_url
    read -p "Escribe la ruta de la carpeta de destino: " clone_dir
    echo "--------------------------------------------------------------------"
    # Expresión regular para validar URLs de GitHub
    github_url_regex='^(https?|git)://(www\.)?github\.com/[a-zA-Z0-9-]+/[a-zA-Z0-9_.-]+$'

    if [[ $repo_url =~ $github_url_regex ]]; then
        if [ ! -d "$clone_dir" ]; then
            sudo mkdir -p "$clone_dir"  # Crear la ruta si no existe
            echo "La ruta $clone_dir ha sido creada."
            sudo chmod uo+rwx $clone_dir
            git config --global --add safe.directory $clone_dir
            git clone "$repo_url" "$clone_dir"
        else
            sudo chmod uo+rwx $clone_dir
            git clone "$repo_url" "$clone_dir"
        fi
    else
        echo "URL de GitHub no válido. Por favor, proporciona un enlace válido de GitHub."
    fi
    echo "--------------------------------------------------------------------"
}

create_branch() {
    echo "--------------------------------------------------------------------"
    read -p "Pon el nombre de la rama: " branch_name
    echo "--------------------------------------------------------------------"

    git checkout -b "$branch_name"
    echo "--------------------------------------------------------------------"
}
add_commit_push() {
    echo "--------------------------------------------------------------------"
    echo "Esta opción se utiliza para subir archivos"
    
    
    read -p "Introduzca los nombres de los archivos a escenificar (separados por espacios): " files
    read -p "Escriba el comentario de guardado: " commit_msg
    read -p "Escribra la branch para subirla: " push_branch
    echo "--------------------------------------------------------------------"
    git add ${files}
    git commit -m "$commit_msg"
    git push origin "$push_branch"
    echo "--------------------------------------------------------------------"
}

add_commit_push_ez() {
    echo "--------------------------------------------------------------------"
    echo "Esta opción se utiliza en caso de hacer una subida rapida y facil"
    read -p "Escriba el comentario de guardado: " commit_msg
    echo "--------------------------------------------------------------------"

    git add .
    git commit -m "$commit_msg"
    git push origin main
    echo "--------------------------------------------------------------------"
}

pull_changes() {
    echo "--------------------------------------------------------------------"
    read -p "Pon el nombre de la rama: " pull_branch

    git pull origin "$pull_branch"
    echo "--------------------------------------------------------------------"
}
fast_pull_changes() {
    echo "--------------------------------------------------------------------"
    git pull origin main
    echo "--------------------------------------------------------------------"
}

merge_branch() {
    echo "--------------------------------------------------------------------"
    read -p "Escriba la rama a fusionar en la rama actual: " merge_branch

    git merge "$merge_branch"
    echo "--------------------------------------------------------------------"
}

git_status() {
    echo "--------------------------------------------------------------------"
    echo "Para mirar que archivos has modificado"
    echo "--------------------------------------------------------------------"
    git status --porcelain | awk '{$1 = ""; print substr($0, 2)}'
    echo "--------------------------------------------------------------------"
}

git_fetch() {
    echo "--------------------------------------------------------------------"
    git fetch
    echo "--------------------------------------------------------------------"
}


# Main logic

while true; do

    echo "Selecciona una opción:"
    echo "1) Descargar un repositorio (clone)"
    echo "2) Crear una nueva rama (checkout)"
    echo "3) Subida de los cambios (add, commit y push)"
    echo "4) Subida rapida y facil de los cambios (add, commit y push)"
    echo "5) Descargar cambios de la rama especifica (pull)"
    echo "6) Descargar cambios rapido (pull)"
    echo "7) Mezclar ramas (merge)"
    echo "8) Ver el estado del git (status)"
    echo "9) Mirar si hay algun cambio disponible (fetch)"
    echo "10) Salir"

    read -p "Escriba la opcion: " choice

    case $choice in
    1)
        clone_repo
        ;;
    2)
        create_branch
        ;;
    3)
        add_commit_push
        ;;
    4)
        add_commit_push_ez
        ;;
    5)
        pull_changes
        ;;
    6)
        fast_pull_changes
        ;;
    7)
        merge_branch
        ;;
    8)
        git_status
        ;;
    9)
        git_fetch
        ;;
    10)
        echo "Hasta luego..."
        exit 0
        ;;
    *) echo "Opcion invalida" ;;
    esac

done
