#!/bin/bash
while :; do
    echo "Menú"
    echo "1 - Muestra los discos y las particiones del sistema"
    echo "2 - Muestra el uso de espacio en disco"
    echo "3 - Crear una partición estándar"
    echo "4 - Salir del Programa"
    read respuesta
    case "$respuesta" in
    1)
        lsblk | awk 'NR==1 || /(^sd.*|├─|└─)/{print $1"\t"$4}'
        echo "*****************************************************"
        ;;
    2)
        df -h | awk  '$1 ~ /\/dev\/sd/ || $1 ~ /\/dev\/hd/'
        echo "*****************************************************"
        ;;
    3)
        if [ "$EUID" -ne 0 ]; then
            echo "Tienes que tener privilegios para poder ejecutar este archivo. Intentalo con 'sudo'."
        else
            read -p "Introduce el nombre del dispositivo (por ejemplo, sdX): " disco 
            if [ ! -e /dev/$disco ]; then
                echo "Bloque incorrecto"
            else
                echo "Abriendo el $disco con parted"
                sudo fdisk /dev/"$disco"
                echo "*****************************************************"
            fi
        fi
        ;;
    4)
        echo "Saliendo del programa..."
        sleep 2
        echo "Hasta el infinito y el mas alla"
        exit
        ;;
    esac
done
