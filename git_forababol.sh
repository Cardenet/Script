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
fast_pull_changes() {
    git pull origin main
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
    echo "12) Resetear a un guardado (muy peligroso!!!!, reset)"
    echo "13) Salir"

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
        git_reset
        ;;
    13)
        echo "Hasta luego..."
        break
        ;;
    *) echo "Opcion invalida" ;;
    esac

done
