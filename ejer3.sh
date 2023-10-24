#!/bin/bash


directorio_origen="/home/"


directorio_destinacion="/backup"


fecha_creacion=$(date "+%Y-%m-%d")


if [ ! -d "$directorio_destinacion" ]; then
  sudo mkdir -p "$directorio_destinacion"
fi

fichero_backup="$directorio_destinacion/backup_$fecha_creacion.tar.gz"


tar -czf "$fichero_backup" "$directorio_origen"


if [ $? -eq 0 ]; then
  echo "Backup creado con exito: $fichero_backup"
else
  echo "Error en la creacion del backup, esborrando system32 en 3.. 2.. 1..."
fi
