# Acerca de

Este es un despliegue de un servidor openvpn, cuyo trafico es encapsulado haciendo uso de TLS, para asi prevenir
que los IDS que usan metodologias como DPI (deep packet inspection), detecten el trafico del Vpn y corten la 
comuniacion. Permitiendonos asi, tener conexiones seguras en entornos restrictivos.


## Motivacion

Hoy en día, se considera una práctica normal, los bloqueos realizados a recursos de internet por parte de
las instituciones, tanto educativas como gubernamentales, con la finalidad de evitar el acceso a sitios no permitidos,
ya sea por piratería, posible malware o contenido de entretenimiento. Estos bloqueos usualmente se realizan
mediante el firewall de la entidad, agregando reglas de dominios y/o inspección profunda de paquetes, para
bloquear paquetes de ciertos protocolos, como es el caso del BitTorrent. Sin embargo, es común que estos bloqueos
consistan en una serie de reglas automatizadas por compañías, que bloquean recursos necesarios tanto para el
aprendizaje, así como la libertad de expresión y acceso a la información, caso que es común en China con su gran
firewall que busca limitar el acceso de información a la población civil.


## ToDo
- bashScript para configuracion automatica.
- DockerCompose para despliegue del proyecto

# --------------------------------------

## Guia configuracion manual

## Configuracion del servidor

### Requerimientos servidor

- Ubuntu 20.x > o cualquier distribucion basada en debian.
- nginx > 1.15
- OpenVpn

### Configuracion de nginx	

Se debe configurar nginx de tal manera que acepte conexiones entrantes al puerto 443
y contenga un certificado valido.

para eso se recomienda seguir la guia "Configuracion Nginx.md".

### Configuracion del OpenVpn

Se debe montar y habilitar el servicio de OpenVpn, de tal manera que escuche peticiones
locales haciendo uso del protocolo TCP.

Se recomienda seguir la guia "Configuracion OpenVpn.md".

## Configuracion del cliente

### Requerimientos para el cliente (Distros basadas en Debian)

- stunnel
- OpenVpn

### Configuracion Stunnel
