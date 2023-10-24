#!/bin/bash


read -p "Redacte el nombre del usuario: " nom_usuario


if getent passwd "$nom_usuario" >/dev/null 2>&1; then
  
  uid=$(getent passwd "$nom_usuario" | awk -F ':' '{print $3}')
  gid=$(getent passwd "$nom_usuario" | awk -F ':' '{print $4}')
  gecos=$(getent passwd "$nom_usuario" | awk -F ':' '{print $5}')
  home=$(getent passwd "$nom_usuario" | awk -F ':' '{print $6}')
  shell=$(getent passwd "$nom_usuario" | awk -F ':' '{print $7}')

  echo "El usuario $nom_usuari existe."
  echo "UID: $uid"
  echo "GID: $gid"
  echo "GECOS: $gecos"
  echo "Carpeta personal: $home"
  echo "Shell por defecto: $shell"
else
  echo "El usuario $nom_usuario no existe despierta todo esto en sueño."
  exit 1
fi
