subl # Comment

"Guide to bash programming"

Chapter 1. BASICS


Chapter 1.2 VARS
	
		Hay una gran diferencia entre el nombre de la variable y su valor. Si variable1 es el nombre de una variable 
	con $variable1 nos referimos a su valor.	

		Para definir variables 

			echo $variable1
			echo ${variable1}	

			# Si es null

			unset variable1
			# -z "$var" para comprobar si una variable es null
			if [ -z "$variable1" ]; then
				echo "Var is null"
			fi

		Imprimir dentro de comentarios
			
			a=879
			echo "The value of \"a\" is $a."

		Asignar a una variable la salida de un comando

		a=`ls -l`      # a es igual a la salida del comando ls -l
		echo $a        # Quita tabs y saltos de linea

		echo "$a" 	   # Tal cual es la salida del comando con saltos de linea y tabuladores		

	
Chapter 1.3 Exit and Exit Status	

	# Will exit with status of last command.

	exit  ~  exit $?

	echo hello
	echo $?    # Exit status 0 returned because command executed successfully.


	lskdf      # Unrecognized command. 
	echo $?    # Non-zero exit status returned -- command failed to execute.	

		La salida será de 1, ya que algo malo ha pasado, por convención un exit 0 --> success

	echo
	exit 113    # Will return 113 to shell.
           		# To verify this, type "echo $?" after script terminates.

    convenciones:       		
    
    	1  -  Catchall for general errors
    	2  -  Misuse of shell builtins (according to Bash documentation)
      126  -  Command invoked cannot execute   		
      127  -  Command not found
      128  -  Invalid argument to exit
      128  -  n	Fatal error signal "n"
      130  -  Script terminated by Control-C
      255  -  *	Exit status out of range

