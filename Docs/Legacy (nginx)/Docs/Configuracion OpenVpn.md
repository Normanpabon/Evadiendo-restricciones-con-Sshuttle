# Guia de configuracion OpenVpn

Para llevar acabo la configuracion del OpenVpn, haremos uso del script de configracion
alojado en el repositorio https://git.io/vpn

Obtenemos el archivo de configuracion

- wget https://git.io/vpn -O openvpn-ubuntu-install.sh

Damos permiso de ejecucion al script

- chmod +x openvpn-ubuntu-install.sh

Ejecutamos el script como root

Llenamos los datos que se nos pidan acorde a la configuracion deseada, eso si, el protocolo
debe ser TCP. (por defecto es UDP)

- sudo ./openvpn-ubuntu-install.sh

### Valores de configuracion a revisar

Una vez terminada la configuracion del script, debemos revisar que los siguientes parametros
se encuentren en dicho archivo de configuracion. El archivo se encuentra en "/etc/openvpn/server/server.conf"

local 127.0.0.1
port VPN_PORT_NGINX
tls-server
mode server

Una vez realizados los ajustes necesarios, reiniciamos el servicio de openvpn para habilitar los cambios

- sudo systemctl restart openvpn

