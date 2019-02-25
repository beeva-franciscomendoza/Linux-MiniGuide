
"GUIA LPIC COMMANDS IMPORTANT"

USERS 

	How To View System Users in Linux on Ubuntu

		"/etc/passwd"

			Todos los users se encuentran almacenados en ese fichero.

		root:x:0:0:root:/root:/bin/bash
			
			1. root       -- Username
			2. x          -- Password info que son obtenidas de /etc/shadow
			3. 0 	      -- User ID, el user root siempre se identifica como 0
			4. 0	      -- Group ID, cada user tiene un grupo por default, el group de root es 0
			5. root   	  -- Descripción
			6. /root  	  -- Directorio home, para los demas users será del tipo /home/samuetto
			7. /bin/bash  -- Este campo contiene el shell que se generará o el comando que se ejecutará 
							 cuando el usuario inicie sesión. 

			"Danger" -- NO tocar este fichero a mano.

		"/etc/shadow"

			Archivo para almacenar las contraseñas 

		daemon:*:15455:0:99999:7:::	

			1. deamon	  -- Username
			2. * 		  -- Pass in hash 
			3. 15455 	  -- Último cambio de contraseña
			4. 0
			5. 99999 	  -- Días hasta que un cambio de contraseña es requerido 
			6. 7 		  -- Días para avisar al user que cambie la pass
			7. [blank]	  -- one: Días hasta que la cuenta pasa a inactiva 
							 two: Días desde que expiró la cuenta
							 three: unused

		cut -d : -f 1 /etc/passwd

			Todos los usernames que tenemos almacenados.

	Cambiar Contraseñas

		passwd # Para cambiar la contraseña del usuario actual

		sudo passwd username # Para cambiar la contraseña del user indicado

	Crear Usuarios

		adduser demo # Solo root puede añadir users 

	Visudo -- Sudoers File 

		El comando sudo estaconfigurado a través del archivo que está "/etc/sudoers"
		Para tocar este archivo siempre usar $ visudo --> ya que nunca guardará el archivo si tiene errores de sintaxis.

		User privilegies lines:

			root ALL=(ALL:ALL) ALL

			1. root : username
			2. a - ALL : la regla se aplica a todos los host.
			3. b - ALL : puede ejecutar comandos como todos los users.
			4. c - ALL : puede ejecutar comandos de todos los grupos.
			5. d - ALL : el ultimo comando indica que esas reglas se aplican a todos los comandos.

			Nuestro user root puede ejecutar cualquier comando usando sudo.

		Los nombres que empiezan con % indican un nombre de grupo.

			%admin ALL=(ALL) ALL
			%sudo  ALL=(ALL:ALL) ALL

			Son iguales que com los definidos para los users.

		La útima linea aunque parezca un comentario no lo es, indica que tambien se incluyan todos los archivos almacenados
		en /etc/sudoers.d con el mismo formato.	

			#includedir /etc/sudoers.d

			Lo ideal es tener un archivo en sudoers.d con las reglas y no tocar el sudoers.

			sudo visudo -f /etc/sudoers.d/file_to_edit # para hacer que el comando visudo modifique este archivo en vez
													   # de /etc/sudoers

	Dar a un user privilegios de sudo.

		La manera más facil es añadir al usuario en cuestión al grupo sudo.

			sudo usermod -aG sudo username

			sudo usermod -aG wheel username - Centos 			
 
FIND

	Comando de busqueda para buscar archivos, directorios y demas.

		find / -name foo.txt -type f -print  # En la mayoria de sistemas linux no hace falta el -print

		-type c donde c puede ser:

			  b      block (buffered) special
			  c      character (unbuffered) special
			  d      directory
			  p      named pipe (FIFO)
			  f      regular file
			  l      symbolic link; this is never true if the -L option or the
			         -follow option is in effect, unless the symbolic link  is
			         broken.  If you want to search for symbolic links when -L
			         is in effect, use -xtype.
			  s      socket
			  D      door (Solaris)

		find . -name foo.txt -type f -print

			El punto indica que va a buscar en este directorio y en todos los subdirectorios.

		find . -name "foo.*" -type f -print

			Va a buscar todos las terminaciones a partir del punto.

		find . -name "*.html" -type f -print


	Para buscar archivos que contengan cierto texto vamos a usar: grep. Por lo que se va a explicar antes GREP.

GREP

	Comando para buscar patrones de texto.

		grep 'GREP' /home/javimendo/Escritorio/Guia\ L1.rb 

		grep 'GREP' /home/javimendo/Escritorio/*
		grep 'GREP' /home/javimendo/Escritorio/*.txt # Todos los archivos que terminen en .txt

			En todos los archivos que estan en el Escritorio

		grep -i 'grep' /home/javimendo/Escritorio/*.txt # case-insensitive para que busque solo en minúsculas

		grep -v grep /home/javimendo/Escritorio/*.txt # todas las lineas que no contengan el grep

	Uso con el pipeline	


GREP + FIND

	Para buscar combinando con el grep

		find . -type f -name "*.rb" -exec grep -l FIFO {} \; 

			Con -l en vez del contenido nos da el nombre del archivo.

		find . -type f -name "*.rb" -exec grep -il FIFO {} \;

			El -i nos daria los archivos que continen Fifo, FIFO, fifo

		find /usr/local -name "*.html" -type f -exec chmod 644 {} \;

			Cuando encuentra los archivos los cambia los permisos.

		find htdocs cgi-bin -name "*.cgi" -type f -exec chmod 755 {} \;

			Para que busque en subdirectorios htdocs y cgi-bin.

		find . -name "*.pl" -exec ls -ld {} \;

			Buscar los archivos que acaben en .pl y se vea la ultima modificación

		find . -type f -name "come.*" -exec rm -r {} \;

			Para borrar el archivo en el directorio actual que empieza por come

JAR 

	jar xfv plugin.jar

		Descomprimir un archivo jar para realizar modificaciones.

	jar cfv pluginMOD.jar *

	jar cfv pluginMOD.jar pliginModBuild/*

		Se realizarian las modificaciones y para volver a crear el jar:

TAR

	tar -zcvf new-tar.backup Prueba/

		Crear un archivo comprimido (z) del directorio prueba.

	tar --exclude='./folder' --exclude='./upload/folder2' -zcvf /backup/filename.tgz .

		Crear un archivo comprimido del directorio actual quitando ciertas carpetas.

	tar -xvf server.backup20170410

		Extraer elementos

	mkdir pretty_name && tar xf MYtar.backup -C pretty_name --strip-components 1

		Cambiar el nombre de la carpeta donde se "untarring" los archivos

		--strip-components 1 : Cuando la carpeta interna del tar tiene una carpeta padre que contiene a las demas

		sources/
			├── sources (copia).list
			└── sources.list

	mkdir pretty_name && tar xf MYtar.backup -C pretty_name 

		Cuando no hay una carpeta padre que contiene al resto dentro del tar.

			├── sources (copia).list
			└── sources.list

SYSTEMCTL 

	Para usar systemctl necesitamos ser user root o tener privilegios de root o lanzar los comandos con sudo.	

		sudo systemctl start application.service  #Systemd sabe que archivos son .service no hace falta indicarlo.
		sudo systemctl start application # No hace falta el .service

		systemctl stop service
			
			Arrancar y parar servicios.

		systemctl restart service # Una aplicación que está en curso.

		systemctl reload service # Si la aplicación es capaz de cargar los archivos de config sin necesidad de hacer un 
								 # un restart.

			Restart	y Reload services.
			
		systemctl enable service

			Para indicar a systemd que arranque los servicios nada mas iniciar el ordenador.

			Lo que va a hacer este paso es crear un link simbólico de la copia del sistema del servicio (usually 
				in /lib/systemd/system or /etc/systemd/system)	donde system.d mira donde lanzar los servicios es en
				(usually /etc/systemd/system/some_target.target.wants.)	

		sudo systemctl disable application.service	

			Para eliminar el link simbólico que indica que el servicio se va a lanzar automaticamente.

		systemctl status service # Tambien nos proporciona notificaciones de los fallos.

			Para ver el estado de un servicio.

		systemctl is-active service
		
			Para comprobar si un servicio está activo.

		systemctl is-system-running	

			Nos indica si un sistema esta corriendo.

		systemctl | grep running 

			Para comprobar todos los servicios que están corriendo.

		systemctl | grep running | grep nginx.service

			Para comprobar un servicio en concreto.


SYSTEMCTL for System State Overview

	Comandos para proporcionar información sobre el sistema:

		systemctl list-units # Lo mismo que poner systemctl sin argumentos

			Una lista de todas las unidades que systemd tiene activas en el sistma.

		systemctl list-units --all --state=inactive
		
			Para mostrar todas las unidades que estan en inactive.

		systemctl list-units --type=service
			
			Otro de los filtros es el flag type.

		systemctl cat service # La salida es el archivo de unidad como se conoce al proceso en ejecución.
		
			Para ver info especifica de un servicio. 	

		systemctl list-dependencies docker

			Para listar las dependencias que tiene un servicio.

		systemctl show docker

			Para ver las propiedades de bajo nivel de un servicio.

		systemctl show docker -p Nice

			Para ver una sola propiedad.

	Masking and Unmasking units

		systemctl mask docker # sudo systemctl start docker  -- meterá un failed 	 

			Marcar un servicio como completamente inestable.

		sudo systemctl unmask nginx.service 
		
			El servicio recuperará su estado previo.

	Editing Unit Files
	
		sudo systemctl edit nginx.service

			Que da un archivo en blanco para sobreescribir o añadir nuevas directivas al servicio. Se creará un override.conf
			en el directorio adecuado (un nginx.service.d en systemd) y en el arranque el sistema mergerá los dos archivos el 
			principal y el override.

		sudo systemctl edit --full nginx.service

			Para editar el archivo "madre" del nginx en vez de crear un snippet.

		Delete snippet

			sudo rm -r /etc/systemd/system/nginx.service.d

		Delete full file

			sudo rm /etc/systemd/system/nginx.service

				Cuando se borra un archivo de configuración o un snippet se debe recargar el systemd 
				(sudo systemctl daemon-reload).

SSH

	Ofrece un método el cual encripta lasesión para conectarse a una máquina remota.

		ssh fmm.lab@54.179.100.255

		ssh -i Jav.pem centos@56.34.23.255

	Generar claves

		ssh-keygen -t dsa 

			-t sirve para definir el tipo de clave a crear los cuales son dsa, ecdsa, ed25519, rsa, rsa1

	Copiar nuestras claves en máquinas remotas	

		ssh-copy-id ansible@888.888.888.888

			Nuestra clave se le va a copiar al user asible a la máquina definida por la IP.

		ssh-add

			Añade nuestras claves al ssh-agent para que no se tenga que estar dando contraseñas por la linea de comandos

	Lanzar comandos sobre shh
	
		ssh ubuntu@10.10.10.10 ls -l /

	Añadir una phasefrase a la clave privada 

		ssh-keygen -p -f keyfile

SCP 

	Es un programa que usa ssh para enviar archivos a máquinas remotas.

		scp report.doc username@remote.host.net: 

		scp username@remote.host.net:report.doc report.doc

			Para copiar el archivo de vuelta del servidor	

		scp report.doc username@remote.host.net:reports/monday.doc

			Para copiarlo en un directorio relativo al home

		scp -r mail username@remote.host.net:

			Para copiar un directorio recursivamente

		scp -r mail username@remote.host.net:

			Para conservar los timestamp de los archivos

		scp -i key.pem -r ec2-user@ec2-888-888-888-888.eu-west-1.compute.amazonaws.com:/opt/service-MYS.tar.gz /home/anaconda/Escritorio/

			Para copiar un archivo de la máquina remota al ordenador local. En este caso de AWS.

CRONTAB

	Puedes ejecutar crontab si tu nombre aparece en /usr/lib/cron/cron.allow , si el fichero no existe puedes ejecutar crontab si tu nombre no aparece
	en /usr/lib/cron/cron.deny.

	Si ninguno de los ficheros existe solo el user root puede ejecutar crontab.

		crontab -l 

			Muestra el fichero crontab.

		crontab -e 

			Edita el fichero del cron si este existe o crea uno nuevo si no.

		crontab -r 

			Elimina el fichero crontab.

	Ficheros Cron

		*     *     *   *    *        command to be executed
		-     -     -   -    -
		|     |     |   |    |
		|     |     |   |    +----- day of week (0 - 6) (Sunday=0)
		|     |     |   +------- month (1 - 12)
		|     |     +--------- day of month (1 - 31)
		|     +----------- hour (0 - 23)
		+------------- min (0 - 59)

		Examples:

			30     18     *     *     *     rm /home/someuser/tmp/*    Borra el tmp cada día a las 18:30

			30 	   0 	  1   1,6,12  * 	ls /					   00:30 Hrs  on 1st of Jan, June & Dec	

			5,10   0 	 10 	* 	  1 	ls / 					   At 12.05,12.10 every Monday & on 10th of every month


APT

	apt list --installed

		Lista de todos los paquetes instalados en la máquina.

AWK 

	Para procesar textos. 

	apt list --installed | grep jenkins | awk '{print $2}'

		Que imprimiría la segunda columna. Y luego si queremos partir lo que se ha obtenido
		se utilizaría cut.

DISCOS

	df -ah 

		Todos los sistemas de ficheros que tenemos montados en el sistema.
		- a -- Para incluir pseudo, duplicados e inaccesibles.
		- h -- Para que nos lo de en potencia de 1000 (1.1 G)
	
-- FDISK 

	fdisk -l 

		Para mostrar todas las particiones que se tienen en el sistema

	fdisk /dev/sda 

		Para entrar en las opciones de fdisk dentro de la partición indicada.

	sudo fdisk -s /dev/sda

		Para ver el tamaño de la partición indicada.

	

FICHEROS Y DIRECTORIOS IMPORTANTES 

	/bin/ 
	    Los comandos para el correcto funcionamiento del sistema.
	/boot/
		Los archivos para el arranque el sistema, esta el grub entre otros elementos.
	/dev/
		Los dispositivos del sistema.
	/etc/
		Los archivos de configuración del sistema.
	
	/etc/apt/sources.list/
		Las fuentes apt del sistema.

		Ejemplo: 
			deb http://archive.ubuntu.com/ubuntu/ intrepid main restricted 

			- La clase de fuente. (paquete binario deb, o código fuente deb-src).
			- Url de la fuente.
			- Distribución.
			- Los campos restantes dicen que repo usar de la fuente.

				main: se instalan por defecto y tienen soporte oficial (realiza actualizaciones de seguridad).
				restricted: paquetes que tiene limitaciones de copyright, por ej. drivers
				backports: si se quiere que después de instalar una determinada versión, se pueda actualizar a nuevas versiones de software.
				universe: paquetes mantenidos por la comunidad Ubuntu
				multiverse: paquetes que no son libres

	/etc/bashrc
		La configuración main del sistema, la del user se encuentra en  ~/.bashrc/ y se ejecutará despues de la global.
	/etc/crontab
		Estan contenidos los trabajos que va a ejecutar el demonio crontab.
	/etc/fstab
		Contiene las particiomes que se cargan al iniciar el sistema, si se modifica cargar con mount -a.
	/etc/group
		La lista de los grupos del sistema y los usuarios que pertenecen a cada grupo.
	/etc/hosts
		Contiene los nombres de los nodos.
	/etc/init.d 
		Para cada servicio gestionado hay un único archivo de inicialización que se encuentra aquí.
	/etc/network/interfaces
		La configuración de las interfaces de red.
	/etc/network
		Información con los nombres de las redes.
	/etc/profile
		Las variables globales de configuración de tipo terminal.
	/etc/services
		Correspondencia entre nombres cortos y nombres de servicios.
	/etc/sudoers
		Base de datos de sudoers, "warning" solo tocar con visudo.


	/lib/
		Bibliotecas de SW mas importantes del sistema.
	/media/
		Punto de montaje de diferentes dispositivos.		
	/opt/
		SW opcinal
	/sbin/
		Comandos para inicializar, reparar y recuperar el sistema.
	/usr/bin
		Mayoria de comandos y ejecutables locales
	/usr/local/bin
		Ejecutables locales
	~/.bashrc/
		Se ejecuta cada vez que se lanza una nueva shell

PUERTOS A DESTACAR

	7  -  echo    -  Servicio echo
   13  -  daytime -  Envia fecha y hora al puerto solicitante
   21  -  ftp     -  Puerto del protocolo de transferencia de archivos
   22  -  ssh 	  -  Servicio de shell seguro
   23  -  telnet  -  Servicio de telnet
   80  -  http    -  Protocolo de transferencia de hipertexto
  443  -  https   -  Protocolo de transferencia de hipertexto seguro
  	

"TOP COMMANDS"

	cd - # Para volver al directorio anterior que has estado.

	!! 	 # Repetir el último comando que has utilizado.

	$ mkdir /tmp/new
	$ cd !!:*

	Ejecutar el segundo comando con los argumentos del previo.

	ls -d */  -- /# Solo mostrar los subdirectorios en el directorio actual.

	# Al pulsar ESC . ponemos los argumentos del último comando 

	ls -thor # Power of gods of ls

	whereis nano  # nano: /bin/nano /usr/bin/nano /usr/bin/X11/nano /usr/share/nano /usr/share/man/man1/nano.1.gz

	which python # /usr/bin/python

		Devuelve  los  nombres  de  ruta  de ficheros (o enlaces) que se ejecutarían en el entorno actual.

	apt-get install --only-upgrade <packagename>
	
	# Solo hace un upgrade del paquete si está instalado.	

COMBINACIÓN DE TECLAS on "TERMINAL"

    Ctrl + a => Return to the start of the command you’re typing
    Ctrl + e => Go to the end of the command you’re typing
    Ctrl + u => Cut everything before the cursor to a special clipboard
    Ctrl + k => Cut everything after the cursor to a special clipboard
    Ctrl + y => Paste from the special clipboard that Ctrl + u and Ctrl + k save their data to
    Ctrl + t => Swap the two characters before the cursor (you can actually use this to transport 
    			a character from the left to the right, try it!)
    Ctrl + w => Delete the word / argument left of the cursor
    Ctrl + l => Clear the screen