# Referencia Docker

La interfaz de línea de comandos de docker se compone de múltiples [comandos](https://docs.docker.com/engine/reference/commandline/docker/) de los cuales los más necesarios para iniciar a prácticar con docker con los sigueintes:

* docker load. Sirve para cargar una imagen, previamente exportada con el comando docker save. Sintaxis:

```shell
docker load --input Nombre_del_archivo.tar
```

* docker save. Sirve para exportar una imagen en su estado actual. Sintaxis:

```shell
docker save --output Nombre_del_archivo_salida.tar
```

* docker image. Tiene un set bastante amplio de [subcomandos](https://docs.docker.com/engine/reference/commandline/image/), ya que el comando sirve para administrar las imágenes, pero el más util sería desplegar el listado de imágenes que tenemos actualmente cargadas. Sintaxis:

```shell
docker image list
```

* docker ps. Listado de procesos o container creados. Sintaxis:

```shell
docker ps -a
```

Salida de ejemplo:

|CONTAINER ID|IMAGE|COMMAND|CREATED|STATUS|PORTS|NAMES|
|------------|-----|-------|-------|------|-----|-----|
|b038aa585a36|oracle/database:12.2.0.1-ee|"/bin/sh -c 'exec $O…"|7 days ago|Up 7 days (healthy)|   0.0.0.0:1521->1521/tcp, 0.0.0.0:5500->5500/tcp|ora_12_1|
|37f6d6c5cc79|helloworld|"/scripts/start.sh"|5 weeks ago|Exited (143) 5 weeks ago||helloWorldInstance|
|673af6953884|prom/prometheus|"/bin/prometheus --c…"|3 months ago|Exited (0) 3 months ago||    promy|

Interpretación de cada columna:

1. **ContainerID**. Identificador (base 64) del contenedor. Es una cadena única que distingue a cada instancia.
2. **Image**. Nombre de la imagen (contenedor) que fue instanciado. PUede haber múltiples instancias de una misma imagen.
3. **Command**. Comando con el que se ejecutó el container. Cada contenedor, tiene un "entrypoint" o comando con el cual se inicializa, o que dispara el proceso o servicio que va a estar atendiendo el contenedor. En este caso sería un shell que inicia una BD de Oracle.
4. **Created**. Fecha en que fue creado el contenedor
5. **Status**. Estado actual del contenedor. Detenido, Iniciado, En mal estado (con errores)...etc.
6. **Ports**. Indica los puertos del contenedor mapeados al host. 0.0.0.0:1521->1521/tcp significaría que está abierto en todas las interfaces de Red del servidor/pc (0.0.0.0) en el puerto 1521 correlacionado al puerto 1521 del container. El puerto que expone un contenedor, es comúnmente fijo, si se requirieran múltiples instancias, se debe cambiar el puerto del host, no del container, algo como 1522->1521, 1523->1521...etc.
7. **Names**. Nombre del contenedor. Para facilitar la administración de los contenedores, se puede asignar un nombre personalizado, a parte de tener un id. Los comandos para administración de contenedores toman indistantamente el ID del contenedor o su nombre, ya que ambos son únicos.

* docker logs. Comando para ver el log del salida del contenedor. Imprime último segmento de log por default, similar al comando "*tail*" y similarmente ofrece una bandera "-f" para ir sigiuendo el log. Sintaxis: 

```shell
docker logs CONTAINER_ID_OR_NAME # Sólo imprime las últimas línea del log
docker logs -f CONTAINER_ID_OR_NAME # Seguir el log en línea, se sale con Ctrl + C
```

* docker stop. Como su nombre lo indica, permite detener un contenedor por su nombre o id. Tiene la bandera "-f" para el detenido forzado. Sintaxis:

```shell
docker stop CONTAINER_ID_OR_NAME
docker stop -f CONTAINER_ID_OR_NAME # Detenido forzado
```

* docker start. Igualmente como su nombre indica, sirve para iniciar un contenedor por su nombre o Id.

```shell
docker start CONTAINER_ID_OR_NAME
```

* docker exec. Permite ejecutar un comando dentro del container. Debido a la similitud de un container con una máquina virtual también podemos ejecutar comandos dentro del contenedor, e inclusive una sesión interactiva similar a una sesión SSH. Sintaxis:

```shell
docker exec -it CONTAINER_ID_OR_NAME /bin/bash #Iniciará una consola dentro del container.
```

Al momento de conectarse a un contenedor, tener en cuenta que las imágenes tienen lo mínimo necesario para funcionar, tanto a nivel aplicativo como a nivel "Sistema", es decir, es posible que se desee editar un archivo con el comando "**vi**" y al tratar de usarlo no se encuentre instalado. Sólo debería ser instalado para fines de prueba, pero no quedar grabado dentro de la imagen, ya que no es necesario para que la aplicación se ejecute de forma adecuada.