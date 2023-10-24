import os, time

def mostrar_discos_y_particiones():
    os.system("""lsblk | awk 'NR==1 || /(^sd.*|├─|└─)/{print $1"\t" $4}'""")

def mostrar_uso_espacio_disco():
    os.system("df -h | awk '$1 ~ /\/dev\/sd/ || $1 ~ /\/dev\/hd/'")

def crear_particion_estandar():
    if os.geteuid() != 0:
        print("Tienes que tener privilegios para poder ejecutar este archivo.\nIntentalo con 'sudo'.")
    else:
        dispositivo = input("Introduce el nombre del dispositivo (por ejemplo, sdX): ")
        if not os.path.exists(f"/dev/{dispositivo}"):
            print("Bloque invalido")
        else:
            os.system(f"fdisk /dev/{dispositivo}")

while True:
    print("Menú:")
    print("1-Muestra los discos y las particiones del sistema")
    print("2-Muestra el uso de espacio en disco")
    print("3-Crear una partición estándar")
    print("4-Salir del Programa")

    opcion = input("Selecciona una opción: ")

    if opcion == "1":
        mostrar_discos_y_particiones()
    elif opcion == "2":
        mostrar_uso_espacio_disco()
    elif opcion == "3":
        crear_particion_estandar()
    elif opcion == "4":
        print("Saliendo del programa.")
        time.sleep(2)
        print("Hasta el infinito y el mas alla")
        break
    else:
        print("Opción no válida. Por favor, elige una opción válida (1-4).")