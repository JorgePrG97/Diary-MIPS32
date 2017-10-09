# NOMBRE: JORGE PRIETO GÓMEZ
# ASIGNATURA: ESTRUCTURA DE COMPUTADORES
# TRABAJO: PRACTICA AGENDA
#################################################################
# Gestión de una agenda telefónica en ensambaldor de MIPS	#
# Operaciones:							#
# 	-Insertar entrada					#
#	-Borrar entrada						#
#	-Buscar y mostrar					#
#	-Contar numero de entradas				#
#	-Terminar programa					#
# 								#	
# NUEVA ESTRUCTURA:						#
# 	-NOMBRE --> 16 BYTES					#
#       -APELLIDOS -->32 BYTES					#
#	-CORREO -->32 BYTES					#
#	-CALLE -->32 BYTES					#
#	-TELEFONO 1 -->16 BYTES					#
#	-TELEFONO 2 -->16 BYTES					#
#	-NICK -->8 BYTES					#
#	-CODIGO POSTAL -->4 BYTES				#
#	-IDENTIFICADOR --> 4 BYTES				#
# 164 BYTES EN TOTAL x 50 CONTACTOS MAXIMO= 8200 BYTES		#
#################################################################
.data
comienzo_agenda:	.space 8200
fin_agenda:
################################		TIRAS DE SIN FICHEROS		################################
tiraexplicativa:.asciiz "AGENDA REALIZADA POR JORGE PRIETO GOMEZ (j.prietogo@alumnos.urjc.es) PARA LA ASIGNATURA DE ESTRUCTURA DE COMPUTADORES (2016).\n\n\n\n\t\t\t\tHOLA Y BIENVENIDOS A SU AGENDA PERSONAL.\nESTA AGENDA TIENE UN FUNCIONAMIENTO SENCILLO. DISPONE DE 7 FUNCIONES PRINCIPALES:\n\t\t*INSERTAR ENTRADA\n\t\t*BORRAR ENTRADA\n\t\t*BUSCAR ENTRADA\n\t\t*CONTAR EL NUMERO DE CONTACTOS\n\t\t*LISTAR LAS ENTRADAS DE LA AGENDA\n\t\t*BORRAR LA AGENDA COMPLETAMENTE\n\t\t*MODIFICAR UN CONTACTO\nPARA INTRODUCIR UNA ENTRADA SIMPLEMENTE SERA NECESARIO TECLEAR EL DATO CORRESPONDIENTE Y PULSAL LA TECLA 'ENTER'.\nUNA DE LAS PRINCIPALES CARACTERISTICAS DE ESTA AGENDA ES LA EXISTENCIA DE UN IDENTIFICADOR, QUE SERVIRA PARA PODER BUSCAR (Y EN CASO DE QUE SE DESEE, BORRAR) UN CONTACTO. \nPOR TANTO SERA NECESARIO QUE RECUERDE EL IDENTIFICADOR DE SUS CONTACTOS\n\t\t\t\tGRACIAS Y DISFRUTE DE SU AGENDA PERSONAL.\n\n\n\n"	
tira01:		.asciiz "\nESTA AGENDA TIENE LA POSIBILIDAD DE OBTENER UN FICHERO CON LOS CONTACTOS O SIMPLEMENTE GUARDARLOS EN MEMORIA. ¿QUE DESEA HACER?\n\t(1)SIN FICHERO\n\t(2)CON FICHERO\n"
tira02:		.asciiz "\n\nElija que accion desea realizar(Entre parentesis se encuentra el numero que debe introducir):\n"
tira03:		.asciiz "\t\t(1)Insertar nueva entrada\n"
tira04:		.asciiz "\t\t(2)Borrar entrada ya escrita\n"
tira05:		.asciiz "\t\t(3)Buscar y mostrar entrada\n"
tira06:		.asciiz "\t\t(4)Contador de entradas actuales\n"
tira07a:	.asciiz "\t\t(5)Modificar una entrada\n"
tira08a:	.asciiz "\t\t(6)Listar la agenda\n"
tira09a:	.asciiz "\t\t(7)Borrar agenda\n"
tira07:		.asciiz "\t\t(8)Terminar programa\n"
tira08:		.asciiz "\nNombre (max. 14 caracteres):"
tira09:		.asciiz "\nApellidos (max. 30 caracteres):"
tira10:		.asciiz "\nCorreo (max. 30 caracteres):"
tira11:		.asciiz "\nDireccion (max. 30 caracteres):"
tira12:		.asciiz "\nPrimer telefono(max. 14 caracteres):"
tira13:		.asciiz "\nSegundo telefono(max. 14 caracteres):"
tira14:		.asciiz "\nNick (max 6 caracteres):"
tira15:		.asciiz "\nCodigo postal (max 6 caracteres):"
tira16:		.asciiz	"\nIdentificador(max 3 caracteres):"
tira17:		.asciiz "\nPor favor introduzca el identificador del contacto que desee borrar:"
tira18:		.asciiz "\nPor favor introduzca el identificador del contacto que desee buscar:"
tira19:		.asciiz "\nEN LA AGENDA HAY "
tira20:		.asciiz " CONTACTOS.\n"
tira21:		.asciiz "\nEl numero que has introducido no es valido, por favor introduce un numero comprensido entre 1 y 7"
tira22:		.asciiz "\nIdentificador:"
tira23:		.asciiz "\nPor favor introduzca el identificador del contacto que desee modificar:"
tira24:		.asciiz "\n---------------------------------------------------------------------------------------\n"
################################		TIRAS DE CON FICHEROS		################################
tira000:	.asciiz "\t\t(5)Guardar en fichero\n"
tira001:	.asciiz "\t\t(6)Terminar programa\n"
################################		TIRAS DE FUNCIONES		################################
tiraAA:		.asciiz "¿Que desea hacer?\n\t\t(YES) Cerrar programa.\t\t(NO) Volver al menu sin ficheros.\t\t(CANCELar) Selector con o sin ficheros.\n"
tiraAB:		.asciiz "\nNo hemos podido encontrar el dato solicitado\n"
tiraAC:		.asciiz "¿Esta seguro que deseea cerrar su agenda?"
tiraAD:		.asciiz "¿Que desea hacer?\n\t\t(YES) Cerrar programa.\t\t(NO) Volver al menu con ficheros.\t\t(CANCELar) Selector con o sin ficheros.\n"
################################		NOMBRES AGENDAS			################################
nombre_agenda:		.asciiz "agenda1"
nombre_agenda_nueva:	.asciiz "agenda2"
################################		VARIABLES			################################
.align 2
aux:	.space 4
tam_entrada:	.space 4
max_entrada:	.space 4
num_entradas:	.space 4

.text
	la 	$s0, comienzo_agenda
	la	$s3, fin_agenda
	li 	$v0, 4
	la	$a0, tiraexplicativa
	syscall
	primera_eleccion:
		la 	$a0, tira01
		syscall
		li 	$v0, 5
		syscall #ahora tengo en $v0 el dato introducido
#########################################################################################################################################
#							AQUI COMIENZA SIN FICHEROS							#	
#########################################################################################################################################			
if_selector1:
	li 	$t0, 1
	bne 	$t0, $v0, if_selector2
	move	$k0, $v0
comienzo_sin_ficheros:	#seleccion de la funcion
	li 	$v0, 4
	la 	$a0, tira02
	syscall	
	la 	$a0, tira03
	syscall
	la 	$a0, tira04
	syscall
	la 	$a0, tira05
	syscall	
	la 	$a0, tira06
	syscall	
	la 	$a0, tira07a
	syscall
	la 	$a0, tira08a
	syscall
	la 	$a0, tira09a
	syscall
	la 	$a0, tira07
	syscall
	li 	$v0, 5
	syscall
	
	if_insertar_sin:	
		li 	$t0, 1
		bne 	$t0, $v0, if_borrar_sin
	then_insertar_sin:
		move 	$s1, $s0
		bnez 	$s2, siguiente_contacto #si no es el primero contacto que añadimos, nos vamos hasta la primera posicion libre
		volver_insertar_sin:
			addi 	$s2, $s2, 1
			#Introducimos el nombre
			li 	$v0, 4
			la 	$a0, tira08
			syscall
			la 	$a0, 0($s1)
			li 	$a1, 16
			li 	$v0, 8
			syscall
			#Introducimos los apellidos
			li	$v0, 4
			la	$a0, tira09
			syscall
			la	$a0, 16($s1)
			li	$a1, 32
			li	$v0, 8
			syscall
			#Introducimos el correo
			li 	$v0, 4
			la 	$a0, tira10
			syscall
			la 	$a0, 48($s1)
			li 	$a1, 32
			li 	$v0, 8
			syscall
			#Introducimos la direccion
			li 	$v0, 4
			la 	$a0, tira11
			syscall
			la 	$a0, 80($s1)
			li 	$a1, 32
			li 	$v0, 8
			syscall
			#Introducimos el tlf1
			li 	$v0, 4
			la 	$a0, tira12
			syscall
			la 	$a0, 112($s1)
			li 	$a1, 16
			li 	$v0, 8
			syscall
			#Introducimos el tlf2
			li 	$v0, 4
			la 	$a0, tira13
			syscall
			la 	$a0, 128($s1)
			li 	$a1, 16
			li 	$v0, 8
			syscall
			#Introducimos el nick
			li 	$v0, 4
			la 	$a0, tira14
			syscall
			la 	$a0, 144($s1)
			li 	$a1, 8
			li 	$v0, 8
			syscall
			#Introducimos el codigo postal
			li 	$v0, 4
			la 	$a0, tira15
			syscall
			la 	$a0, 152($s1)
			li 	$a1, 8
			li 	$v0, 8
			syscall
			#Ponemos EL IDENTIFICADOR
			li 	$v0, 4
			la 	$a0, tira16
			syscall
			la 	$a0, 160($s1)
			li 	$a1, 4
			li 	$v0, 8
			syscall
			li	$t9, 2
			beq	$k0, $t9, que_hacer_con
			j	que_hacer
						
	if_borrar_sin:	
		li 	$t0, 2
		bne 	$t0, $v0, if_buscar_sin
	then_borrar_sin:
		li	$v0, 4
		la	$a0, tira17
		syscall
		la	$a0, aux
		li	$a1, 4
		li	$v0, 8
		syscall
		lw	$a0, aux
		jal	buscador
		sw	$zero, 0($s1)
		li	$t9, 2
		beq	$k0, $t9, que_hacer_con 
		j	que_hacer
		
	if_buscar_sin:	
		li 	$t0, 3
		bne 	$t0, $v0, if_contador_sin
	then_buscar_sin:
		li	$v0, 4
		la	$a0, tira18
		syscall
		la	$a0, aux
		li	$a1, 4
		li	$v0, 8
		syscall
		lw	$a0, aux
		jal	buscador
		sub	$s1, $s1, 160
		jal	imprimir
etiq_aux_2:	li	$t9, 2
		beq	$k0, $t9, que_hacer_con
		j	que_hacer
	
	if_contador_sin:	
		li 	$t0, 4
		bne 	$t0, $v0, if_modificar_sin
	then_contador_sin:
		jal	contador
etiq_aux:	li	$v0, 4
		la	$a0, tira19
		syscall
		li	$v0, 1
		subi	$t2, $t2, 1
		move	$a0, $t2
		syscall
		li	$v0, 4
		la	$a0, tira20
		syscall
		li	$t9, 2
		beq	$k0, $t9, que_hacer_con
		j	que_hacer	
		
	if_modificar_sin:	
		li 	$t0, 5
		bne 	$t0, $v0, if_listar_sin
	then_modificar_sin:
		li	$v0, 4
		la	$a0, tira23
		syscall
		la	$a0, aux
		li	$a1, 4
		li	$v0, 8
		syscall
		lw	$a0, aux
		jal	buscador
		subi	$s1, $s1, 160
		jal	destruir_contacto
		subi	$s1, $s1, 164
		j 	volver_insertar_sin
final_modificar:
		li	$t9, 2
		beq	$k0, $t9, que_hacer_con
		j	que_hacer
		
	if_listar_sin:				
		li 	$t0, 6
		bne 	$t0, $v0, if_borrarcompleto_sin
	then_listar_sin:
		move	$s1, $s0		
		bucle_listar:
			addi 	$s1, $s1, 160
			lw	$t0, 0($s1)
			addi	$s1, $s1, 4
			beq	$s1, $s3, que_hacer
			beqz	$t0, bucle_listar
			subi	$s1, $s1, 164
			jal	imprimir
			addi	$s1, $s1, 4
			li 	$v0, 4
			la 	$a0, tira24
			syscall	
			beq	$s1, $s3, que_hacer
			j	bucle_listar
	
	if_borrarcompleto_sin:
		li	$t0, 7
		bne	$t0, $v0, if_terminar_sin
	then_borrarcompleto_sin:
		move	$s1, $s0
		bucle_borrarcompleto:
			jal	destruir_contacto
			beq	$s1, $s3, que_hacer
			j	bucle_borrarcompleto			
		
	if_terminar_sin:		
		li 	$t0, 8
		bne 	$t0, $v0, fallo_entrada_sin 
	then_terminar_sin:
		j	seguro_cerrar
		
#########################################################################################################################################
#							AQUI COMIENZA CON FICHEROS							#	
#########################################################################################################################################
if_selector2:
	li 	$t0, 2
	bne 	$t0, $v0, que_hacer
	move	$k0, $v0
	
comienzo_con_ficheros:	#seleccion de la funcion
	li 	$v0, 4
	la 	$a0, tira02
	syscall	
	la 	$a0, tira03
	syscall
	la 	$a0, tira04
	syscall
	la 	$a0, tira05
	syscall
	la	$a0, tira06
	syscall	
	la 	$a0, tira000
	syscall	
	la 	$a0, tira001
	syscall
	li 	$v0, 5
	syscall
	move	$s7, $v0
		la	$a0, comienzo_agenda
		la	$a1, tam_entrada
		la	$a2, num_entradas
		la	$a3, nombre_agenda
		jal	leer_agenda
	if_insertar_con:	
		li 	$t0, 1
		bne 	$t0, $s7, if_borrar_con
	then_insertar_con:
		j	then_insertar_sin
		
	if_borrar_con:	
		li 	$t0, 2
		bne 	$t0, $s7, if_buscar_con
	then_borrar_con:
		j	then_borrar_sin
	
	if_buscar_con:	
		li 	$t0, 3
		bne 	$t0, $s7, if_contador_con
	then_buscar_con:
		j	then_buscar_sin
		
	if_contador_con:	
		li 	$t0, 4
		bne 	$t0, $s7, if_guardar_con
	then_contador_con:
		j	then_contador_sin
	
	if_guardar_con:	
		li 	$t0, 5
		bne 	$t0, $s7, if_terminar_con
	then_guardar_con:
		la	$a0, comienzo_agenda
		li	$a1, 164		#lw	$a1, tam_entrada
		li	$a2, 50			#lw	$a2, num_entradas
		la	$a3, nombre_agenda_nueva		
		jal	grabar_agenda
	if_terminar_con:	
		li 	$t0, 6
		bne 	$t0, $s7, fallo_entrada_con
	then_terminar_con:
		j	seguro_cerrar_con
	
#########################################		FINALES			#########################################		
fallo_entrada_sin:
	li	$v0, 4
	la 	$a0, tira21
	syscall
	j 	comienzo_sin_ficheros
fallo_entrada_con:
	li	$v0, 4
	la	$a0, tira21
	syscall
	j	comienzo_con_ficheros
final: # Terminar
	li	$v0,10
	syscall
	
########################################		FUNCIONES		########################################	
siguiente_contacto:
	mul  	$t1, $s2, 164
	add	$s1, $t1, $s1		
	beq	$s1, $s3, entradas_completas
	j	volver_insertar_sin
	entradas_completas:
		move 	$s1, $s0	
		bucle_f_siguiente_contacto:   #me he colocado delante del primer campo de validez
			addi	$s1, $s1, 160
			lw	$t0, 0($s1)
			bnez	$t0, bucle_f_siguiente_contacto
			subi	$s1, $s1, 160	#con esta linea me coloco al comienzo de la estructura vacia
			j	volver_insertar_sin	
buscador:	#en $a0 esta el identificador
	move	$s1, $s0
	li	$t0, 1
	addi	$s1, $s1, 160 #me coloco en el primer identificador
	lw 	$t2, 0($s1)
	bne	$a0, $t2, bucle_f_buscador
	jr	$ra
	bucle_f_buscador:
		bge	$s1, $s3, no_encontrado
		addi	$s1, $s1, 164
		lw 	$t2, 0($s1)
		bne	$a0, $t2, bucle_f_buscador
		jr	$ra
imprimir:	#$s1 puntero al comienzo de la agenda
	li	$v0, 4
	la	$a0, tira08
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 16
	la	$a0, tira09
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 32
	la	$a0, tira10
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 32
	la	$a0, tira11
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 32
	la	$a0, tira12
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 16
	la	$a0, tira13
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 16
	la	$a0, tira14
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 8
	la	$a0, tira15
	syscall
	la	$a0, 0($s1)
	syscall
	addi	$s1, $s1, 8
	la	$a0, tira22
	syscall
	la	$a0, 0($s1)
	syscall	
	jr 	$ra
contador:
	move	$s1, $s0
	li	$t0, 1
	li	$t2, 0
	li	$t4, 20
	bucle_f_contador:
		bgt	$s1, $s3, etiq_aux
		beq	$t2, $t4, fuera_bucle_f_contador
		addi	$s1, $s1, 160
		lw 	$t3, 0($s1)
		addi	$s1, $s1, 4
		bnez	$t3, suma_f_contador
		j bucle_f_contador
		suma_f_contador:
			addi	$t2, $t2, 1
			j	bucle_f_contador
	fuera_bucle_f_contador:
		jr	$ra
que_hacer:
	la	$a0, tiraAA
	li	$v0, 50
	syscall
	beqz	$a0, final
	li	$t0, 1
	beq	$a0, $t0, comienzo_sin_ficheros
	li	$t0, 2
	beq	$a0, $t0, primera_eleccion
	li	$t0, 3
	bge	$a0, $t0, fallo_entrada_sin	
no_encontrado:
	li	$v0, 4
	la	$a0, tiraAB 
	syscall
	j	etiq_aux_2
que_hacer_con:
	la	$a0, tiraAD
	li	$v0, 50
	syscall
	beqz	$a0, final
	li	$t0, 1
	beq	$a0, $t0, comienzo_con_ficheros
	li	$t0, 2
	beq	$a0, $t0, primera_eleccion
	li	$t0, 3
	bge	$a0, $t0, fallo_entrada_sin	
destruir_contacto:
	addi	$t0, $s1, 164
	bucle_destructor:
		sw 	$zero, 0($s1)
		addi	$s1, $s1, 4
		bne	$s1, $t0, bucle_destructor
		jr	$ra
seguro_cerrar:
	la	$a0, tiraAC
	li	$v0, 50
	syscall
	beqz	$a0, final
	li	$t0, 1
	beq	$a0, $t0, comienzo_sin_ficheros
	li	$t0, 2
	beq	$a0, $t0, comienzo_sin_ficheros
	li	$t0, 3
	bge	$a0, $t0, comienzo_sin_ficheros
seguro_cerrar_con:
	la	$a0, tiraAC
	li	$v0, 50
	syscall
	beqz	$a0, final
	li	$t0, 1
	beq	$a0, $t0, comienzo_con_ficheros
	li	$t0, 2
	beq	$a0, $t0, comienzo_con_ficheros
	li	$t0, 3
	bge	$a0, $t0, comienzo_con_ficheros
########################################		PROFE			########################################	
##############################################################################
#                                                                            #
# LECTURA DE LA AGENDA EN DISCO                                              #
#                                                                            #
# Argumentos:                                                                #
#    $a0: puntero a los datos de la agenda                                   #
#    $a1: tamaño de cada una de las entradas de la agenda (por referencia)   #
#    $a2: número de entradas totales de la agenda (por referencia)           #
#    $a3: puntero al nombre del fichero                                      #
#                                                                            #
##############################################################################

leer_agenda:
# Copiar parámetros en registros temporales
		move	$t0,$a0
		move	$t1,$a1
		move	$t2,$a2
		move	$t3,$a3
# Abrir el fichero
		li	$v0,13		# Abrir fichero
		move	$a0,$a3		# Nombre
		li	$a1,0		# Acceso: lectura
		li	$a2,0		# Modo: se ignora
		syscall
		move	$t4,$v0		# Salvar el descriptor
# Leer el tamaño de una entrada
		li	$v0,14		# Leer en fichero
		move	$a0,$t4		# Descriptor
		move	$a1,$t1		# Puntero al tamaño de una entrada
		li	$a2,4		# Tamaño en bytes del dato leído
		syscall
		lw	$t5,0($t1)	# Copiar tamaño de una entrada en registro temporal
# Leer el número de entradas
		li	$v0,14		# Leer en fichero
		move	$a0,$t4		# Descriptor
		move	$a1,$t2		# Puntero al número de entradas almacenadas
		li	$a2,4
		syscall
		lw	$t6,0($t2)	# Copiar número de entradas en registro temporal
# Leer los datos de la agenda
		li	$v0,14		# Leer en fichero
		move	$a0,$t4		# Descriptor
		move	$a1,$t0		# Puntero a la agenda
		mul	$a2,$t5,$t6	# Tamaño en bytes de la agenda
		syscall
# Cerrar el fichero
		li	$v0,16
		move	$a0,$t4		# Descriptor
		syscall
# Retornar
		jr	$ra


##############################################################################
#                                                                            #
# GRABACIÓN DE LA AGENDA EN DISCO                                            #
#                                                                            #
# Argumentos:                                                                #
#    $a0: puntero a los datos de la agenda                                   #
#    $a1: tamaño de cada una de las entradas de la agenda (por copia)        #
#    $a2: número de entradas totales de la agenda (por copia)                #
#    $a3: puntero al nombre del fichero                                      #
#                                                                            #
##############################################################################

grabar_agenda:
# Crear un marco de pila para una variable local
		addi	$sp,$sp,-8
# Copiar parámetros en registros temporales
		move	$t0,$a0
		move	$t1,$a1
		move	$t2,$a2
		move	$t3,$a3
# Abrir el fichero
		li	$v0,13		# Abrir fichero
		move	$a0,$a3		# Nombre
		li	$a1,1		# Acceso: escritura
		li	$a2,0		# Modo: se ignora
		syscall
		move	$t4,$v0		# Salvar el descriptor
# Escribir el tamaño de una entrada
		li	$v0,15		# Escribir en fichero
		move	$a0,$t4		# Descriptor
		sw	$t1,0($sp)	# Tamaño de una entrada
		la	$a1,0($sp)
		li	$a2,4		# Tamaño en bytes del dato escrito
		syscall
# Escribir el número de entradas
		li	$v0,15		# Escribir en fichero
		move	$a0,$t4		# Descriptor
		sw	$t2,4($sp)	# Número de entradas
		la	$a1,4($sp)
		li	$a2,4		# Tamaño en bytes del dato escrito
		syscall
# Escribir los datos de la agenda
		li	$v0,15		# Escribir en fichero
		move	$a0,$t4		# Descriptor
		move	$a1,$t0		# Puntero a la agenda
		mul	$a2,$t1,$t2	# Tamaño en bytes de la agenda
		syscall
# Cerrar el fichero
		li	$v0,16
		move	$a0,$t4		# Descriptor
		syscall
# Destruir marco de pila
		addi	$sp,$sp,8
# Retornar
		jr	$ra
