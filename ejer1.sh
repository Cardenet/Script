#!/bin/bash


if [ $# -ne 1 ]; then
  echo "Uso: $0 /Ruta_Al_Fichero/nombre_fichero"
  exit 1
fi


ruta_fichero="$1"


if [ -e "$ruta_fichero" ]; then

  if [ -f "$ruta_fichero" ]; then

    permisos_octal=$(stat -c "%a" "$ruta_fichero")


    permisos_simbolico=$(stat -c "%A" "$ruta_fichero")

    echo "El archivo existe i es un archivo regular."
    echo "Permisos en formato octal: $permisos_octal"
    echo "Permisos en formato simbolico: $permisos_simbolico"
  else
    echo "El archivo existe, pero no és un archivo regular."
  fi
else
  echo "El archivo no existe."
fi
