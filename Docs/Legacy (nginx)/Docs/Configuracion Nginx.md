# Guia de configuracion NGINX

Para poder llevar a cabo el encapsulamiento del trafico, debemos configurar el servicio de nginx para
recibir peticiones SSL por el puerto 443, asi mismo, debemos contar con un certificado valido y un
dominio y otro subdominio.

### Prerequisitos

- Un servidor con Ubuntu 20.x o superior.
- Un nombre de dominio registrado, este puede arquirirse a bajo precio en NameCheap.
- El dominio configurado para que apunte al servidor, tal que:
-- Record A con ejemplo.com apuntando a IP publica de server
-- Record A con www.ejemplo.com apuntando a IP publica de server

### Configuracion de NGINX

Instalamos Nginx haciendo uso del gestor de paquetes, con el comando:

- sudo apt install nginx

Podemos validar que el servicio este funcionando, con systemctl

- sudo systemctl status nginx

Tambien, podemos verificar dirigiendonos a la direccion IP de nuestro servidor, colocandola en nuestro navegador, el
cual nos mostrara la ladingPage de nginx.

#### Configuracion Server Blocks

En Nginx los server blocks son el equivalente a los virtual hosts de Apache, nos permiten encapsular detalles de 
configuracion y hosts de mas de un dominio en un mismo servidor. 

Previendo el hosting de multiples sitios, vamos a crear la estructura de dominios en /var/www/, tal que, en caso de 
contar con varios dominios, se crean las subcarpetas correspondientes (ej : /var/www/dominio_1/).

Creamos el directorio para el dominio, cambiese "dominio_ejemplo" por el nombre del dominio a usar.

- sudo mkdir -p /var/www/dominio_ejemplo/html

Asignamos la propiedad del directorio con la variable de ambiente $USER

- sudo chown -R $USER:$USER /var/www/dominio_ejemplo/html

Para asegurarnos de tener los permisos correctos, que permitan al usuario propietario leer, escribir y ejecutar,
ingresamos el siguiente comando

- sudo chmod -R 755 /var/www/dominio_ejemplo

Por ultimo, creamos un html por defecto para el dominio haciendo uso de nuestro editor favorito. Una vez editado,
guardamos el archivo con "ctrl + x" en caso de estar usando nano. En el repo se encuentra el archivo "index.html",
el cual puede utilizarse de ejemplo.

- nano /var/www/dominio_ejemplo/html/index.html

##### Habilitar Server 

Para que Nginx nos muestre este contenido, debemos crear la directiva correspondiente al ServerBlock creado.

Creamos un nuevo archivo de configuracion, en el repo ubica el archivo "/Config/dominio_ejemplo", alli se 
encuentra una configuracion de ejemplo para usar aca, solo debe cambiarse el "dominio_ejemplo" por el nombre
de tu dominio a usar.

- sudo nano /etc/nginx/sites-available/dominio_ejemplo

Ahora habilitamos la configuracion creada, creando un link de la configuracion al directorio "sites-enabled",
del cual nginx carga la configuracion:

- sudo ln -s /etc/nginx/sites-available/dominio_ejemplo /etc/nginx/sites-enabled/

Si no requerimos el sitio por default de nginx, podemos borrarlo con el comando 

- sudo rm /etc/nginx/sites-enabled/default

Verificamos que no hayan errores de sintaxis en los archivos de configuracion

- sudo nginx -t

si no hay problemas, reiniciamos el servicio de Nginx para aplicar cambios

- sudo systemctl restart nginx

Una vez reiniciado el servicio, podremos acceder al Server Block creado, navegando a http://dominio_ejemplo

### Asegurando Nginx con Let's encrypt

Let's Encrypt es una autoridad de certificacion (CA), el cual nos permite generar de manera facil y gratuita,
certificados TLS/SSL para nuestros dominios. Parte del proceso lo automatiza con el cliente, Certbot.

Primero, instalamos el paquete de Certbot haciendo uso de apt o snap, la documentacion de certbot recomienda 
hacer uso de snap. Primero actualizamos los paquetes de snap con el comando

- sudo snap install core; sudo snap refresh core

Luego de esto, instalamos el paquete de certbot

- sudo snap install --classic certbot 

Creamos el syslink, para agregar el comando de certbot del directiorio de instalacion de snap a nuestro path de variables.

- sudo ln -s /snap/bin/certbot /usr/bin/certbot

Ahora, podemos verificar la configuracion del server block del paso anterior, pues necesitamos el nombre del dominio
que configuramos en el, para habilitar el ssl para dicho dominio. Una vez verificado el nombre, obtenemos el certificado
usando el siguiente comando, cambiando el "dominio_ejemplo" por el nombre de nuestro dominio:

- sudo certbot --nginx -d dominio_ejemplo.com -d www.dominio_ejemplo.com 

Si todo sale bien, nos saldra un mensaje en la consola diciendo que se ha desplegado correctamente el certificado, ya contamos
con el SSL habilitado para nuestro servidor de Nginx.

### Configuracion subdominio para enrutar trafico de stunnel

Ahora, vamos a configurar un subdominio tls.dominio_ejemplo.com, por el cual nos conectaremos haciendo uso del puerto 443.





