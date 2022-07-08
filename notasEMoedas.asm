.data




entrada: .asciiz "Insira o valor: "

notas: .word 100, 50, 20, 10, 5, 2
moedas: .float 1.0, 0.5, 0.25, 0.1, 0.05, 0.01

.text

main:	
	# Obter o valor
	li $v0, 4
	la $a0, entrada
	syscall
	li $v0, 6 # f0 = valor	
	syscall
	
	# Encerrar o programa
	li $v0, 10
	syscall

calcula_nota:
	# a0 = valor, a1 = x
	addi $v0, $zero, 0
	whileNota:
		blt $a0, $a1, exitNota
		addi $v0, $v0, 1
		sub $a0, $a0, $a1
		j whileNota 	
	exitNota:
	jr $ra

