#!/bin/bash
echo "Bienvenido al asistente de configuración para sshuttle." 
echo -e

# Verificar si se está ejecutando como sudo
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ser ejecutado con privilegios de superusuario (sudo)."
    exit 1
fi

while true; do
    echo "Por favor, elija una opción:"
    echo "1. Instalar sshuttle (Servidor)"
    echo "2. Agregar un usuario"
    echo "3. Ver usuarios creados"
    echo "4. Eliminar un usuario"
    echo "5. Salir"
    echo -e
    read -p "Opción: " option

    case $option in
        1)
            echo -e "---------------------------------"
            echo "Realizando apt update..."
            sudo apt update -y 
            sudo apt install sshuttle -y
            
            # Crear grupo de usuarios sshuttle
            sudo groupadd sshuttle

            echo "sshuttle instalado correctamente."
            ;;
        2)
            echo -e "---------------------------------"
            read -p "Ingrese el nombre de usuario: " username

            #Crear usuario
            sudo useradd -m -d /home/$username -s /bin/bash $username

            #Pedir contraseña al usuario
            echo "Digite la contraseña para el usuario $username:"
            
            sudo passwd $username
            
            #Crear directorio .ssh
            sudo mkdir /home/$username/.ssh

            #Cambiar propietario del directorio .ssh
            sudo chown $username:$username /home/$username/.ssh

            #Agregar usuario a grupo sshuttle
            sudo usermod -aG sshuttle $username


            # Generar la llave RSA para acceder por SSH
            ssh-keygen -t rsa -b 4096 -C "$username" -f "/home/$username/.ssh/id_rsa" -N ""

            # Copiar la llave RSA generada al directorio actual con el nombre "Rsa$username.pem"
            sudo cp /home/$username/.ssh/id_rsa "$PWD/Rsa$username.pem"

            chmod 700 /home/$username/.ssh
            chmod 600 /home/$username/.ssh/authorized_keys

            echo "Usuario $username agregado correctamente."
            ;;
        
        3)
            echo -e "---------------------------------"
            echo "Usuarios creados sshuttle:"
            echo -e "---------------------------------"
            sudo getent group sshuttle | cut -d: -f4 | tr ',' '\n'
            
            ;;
        
        4)
            echo -e "---------------------------------"
            read -p "Digite el nombre de usuario a eliminar: " username
            sudo userdel -r $username
            echo "Usuario $username eliminado correctamente."
            ;;

        5)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción inválida. Por favor, seleccione una opción válida."
            ;;
    esac

    echo -e "---------------------------------"
    echo -e -e

done