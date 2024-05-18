# Evadiendo restricciones con Sshuttle
 
## Motivacion

Hoy en día, se considera una práctica normal, los bloqueos realizados a recursos de internet por parte de
las instituciones, tanto educativas como gubernamentales, con la finalidad de evitar el acceso a sitios no permitidos,
ya sea por piratería, posible malware o contenido de entretenimiento. Estos bloqueos usualmente se realizan
mediante el firewall de la entidad, agregando reglas de dominios y/o inspección profunda de paquetes, para
bloquear paquetes de ciertos protocolos, como es el caso del BitTorrent. Sin embargo, es común que estos bloqueos
consistan en una serie de reglas automatizadas por compañías, que bloquean recursos necesarios tanto para el
aprendizaje, así como la libertad de expresión y acceso a la información, caso que es común en China con su gran
firewall que busca limitar el acceso de información a la población civil.

## Limitaciones

Si en el entorno que nos encontramos, se encuentran politicas de red, que bloqueen el uso del
protocolo ssh o rangos de direcciones ip entre los que se encuentre nuestro servidor, esta
tecnica no nos servira.

Tambien es importante aclarar que Sshuttle solo nos ayuda a enrutar el trafico que use el protocolo
TCP, el protoclo UDP hacia dominios con restricciones, seguiria siendo bloqueado por el firewall.

### Requerimientos servidor

- Ubuntu 20.x > o cualquier distribucion basada en debian.
- sshuttle

### Instalacion de Shuttle

Instalamos el shuttle con el gestor de paquetes de linux, la configuracion de este
es nula, pues mediante ssh establecemos la conexion inicial.

- sudo apt install sshuttle

### Requerimientos del cliente

- Python3.6+
- pip
- OS: preferiblemente una distro basada en Debian

### Instalacion en el cliente

Una vez tengamos instalado Python3 con el gestor de paquetes PIP, corremos el siguiente comando:

- python3 -m pip install sshuttle

## Uso

La instruccion para habilitar el uso del proxy con sshuttle seria el siguiente comando:

- sshuttle --dns -vr user@vpsServer.com 0/0 --ssh-cmd -X ipVps/subnet 'ssh -i /path/to/key/key.pem'

### Explicacion de banderas

- 0/0 : Con esto, especificamos que redirija todas las peticiones ipv4 con sus respectivas subnets,
dicho comando tambien podria escribirse como 0.0.0.0/0, si deseamos enrutar tambien conexiones ipv6, usamos la flag ::/0.

- dns : Redirecciona el trafico local de peticiones de DNS al servidor vps, para que este resuelva
dichas peticiones.

- vr : 'v' habilita el modo verbose y 'r' recibe el usuario y servidor a conectarse.

- X : excluye la subnet especificada, aca se suele poner la del servidor remoto para evitar bucles de retransmision.

- ssh-cmd : Nos permite pasarle parametros adicionales a la conexion SSH, en este caso, la llave privada para conectarnos al servidor remoto.









