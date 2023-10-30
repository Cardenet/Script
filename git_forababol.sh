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
        git clone "$repo_url" "$clone_dir"
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

stage_changes() {
    echo "--------------------------------------------------------------------"
    echo "Esta opción se utiliza en caso de solo modificar algun archivo especifico"
    read -p "Introduzca los nombres de los archivos a escenificar (separados por espacios): " files
    echo "--------------------------------------------------------------------"

    git add ${files}
    echo "--------------------------------------------------------------------"

}

commit_changes() {
    echo "--------------------------------------------------------------------"
    read -p "Escriba el comentario de guardado: " commit_msg

    git commit -m "$commit_msg"
    echo "--------------------------------------------------------------------"
}

push_changes() {
    echo "--------------------------------------------------------------------"
    echo "Esta opción se utiliza en caso de subirlo a una rama diferente"
    read -p "Escribra la branch para subirla: " push_branch

    git push origin "$push_branch"
    echo "--------------------------------------------------------------------"
}

add_commit_push() {
    echo "--------------------------------------------------------------------"
    echo "Esta opción se utiliza en caso de hacer una subida rapida y facil"
    read -p "Escriba el comentario de guardado: " commit_msg
    echo "--------------------------------------------------------------------"

    git add .
    git commit -m "$commit_msg"
    git push origin main
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
    echo "3) Escenificar cambios (add)"
    echo "4) Guardar cambios (commit)"
    echo "5) Subir cambios (push)"
    echo "6) Subida rapida y facil de los cambios (add, commit y push)"
    echo "7) Descargar cambios de la rama especifica (pull)"
    echo "8) Descargar cambios rapido (pull)"
    echo "9) Mezclar ramas (merge)"
    echo "10) Ver el estado del git (status)"
    echo "11) Mirar si hay algun cambio disponible (fetch)"
    echo "12) Salir"

    read -p "Escriba la opcion: " choice

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
        fast_pull_changes
        ;;
    9)
        merge_branch
        ;;
    10)
        git_status
        ;;
    11)
        git_fetch
        ;;
    12)
        echo "Hasta luego..."
        break
        ;;
    *) echo "Opcion invalida" ;;
    esac

done
