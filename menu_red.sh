#!/bin/bash

# Configuración de IP
#Consideracions;
    #T’has de documentar com realitzar una Funció que retorni un Menú
    #T’has de documentar com realitzar funcions en Bash hola
    #T’has de documentar sobre com configurar una IP estàtica i una IP dinàmica amb l’ordre shell nmcli, con eliminar una connexió de xarxa amb nmcli, etc
    #S’ha d’entregar el fitxer .sh
get_menu() {
  clear
  echo "Configuración IP"
  echo "1.- IP-Fija"
  echo "2.- IP-DHCP"
  echo "3.- Eliminar Red"
  echo "4.- Salir"
}

get_adaptador() {
  echo "Configuración de la IP"
  ip link show
  read -p "Introduzca la interfaz (nombre): " interfaz
}

ip_fija() {
  get_adaptador
  read -p "Introduzca la IP: " ip
  read -p "Introduzca la máscara (n° de unos): " mascara
  read -p "Introduzca el gateway: " gateway
  read -p "Introduzca el primer DNS: " dns1
  read -p "Introduzca el segundo DNS: " dns2
  nmcli con mod "$interfaz" ipv4.method manual ipv4.addresses "$ip/$mascara" ipv4.gateway "$gateway" ipv4.dns "$dns1 $dns2"
  nmcli con up "$interfaz"
  echo "Configuración IP fija aplicada a $interfaz"
}


ip_dhcp() {
  get_adaptador
  nmcli con mod $interfaz ipv4.method auto
  echo "La conexión '$interfaz' ha sido completada."
}

eliminar_red() {
  get_adaptador
  nmcli connection delete "$interfaz"
  echo "La conexión '$interfaz' ha sido eliminada."
}

# Inicio
while true; do
  get_menu
  read -p "Elija una opción: " opcion
  case $opcion in
    1)
      ip_fija
      ;;
    2)
      ip_dhcp
      ;;
    3)
      eliminar_red
      ;;
    4)
      exit
      ;;
    *)
      echo "Opción incorrecta"
      ;;
  esac
  read -p "Pulse intro para continuar: " intro
done