.data

entrada: .asciiz "Insira o valor: "

cabecalhoNotas: .asciiz "NOTAS:\n"
cabecalhoMoedas: .asciiz "MOEDAS:\n"

saidaNota: .asciiz " notas(s) de R$ "
saidaMoeda: .asciiz " moeda(s) de R$ "

notas: .word 100, 50, 20, 10, 5, 2
moedas: .float 1.0, 0.5, 0.25, 0.1, 0.05, 0.01
qtd: .word 6

.text

main:	
	# Obter o valor
	li $v0, 4
	la $a0, entrada
	syscall
	li $v0, 6 # f0 = valor	
	syscall
	
	# Imprimir notas
	li $v0, 4
	la $a0, cabecalhoNotas
	syscall

	la $s0, notas
	lw $s1, qtd
	addi $t0, $zero, 0
	forNotas:
		beq $t0, $s1, exitForNotas
		# Saber qual valor estamos
		sll $t1, $t0, 2 # t1 = t0 * 4
		add $s0, $s0, $t1

		move $t2, 0($s0)
		# Imprimir a nota
		li $v0, 1
		move $a0, $t2
		syscall
		
		# Somar o i
		addi $t0, $t0, 1
		
	exitForNotas:
	
	# Imprimir moedas
	
	# Encerrar o programa
	li $v0, 10
	syscall

calcula_nota:
	# a0 = valor, a1 = x
	addi $v0, $zero, 0
	whileNota:
		blt $a0, $a1, exitNota
		sub $a0, $a0, $a1
		addi $v0, $v0, 1
		j whileNota
	exitNota:
	jr $ra

calcula_moeda:
	# a0 = valor, a1 = x
	addi $v0, $zero, 0
	whileMoeda:
		blt $a0, $a1, exitMoeda
		sub $a0, $a0, $a1
		addi $v0, $v0, 1
		j whileMoeda
	exitMoeda:
	jr $ra
	
print_nota:
	# a0 = quantidade, a1 = nota
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, saidaNota
	syscall
	li $v0, 2
	mfc1.d $a0, $f12
	syscall

print_moeda:
	# a0 = quantidade, a1 = moeda
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, saidaMoeda
	syscall
	li $v0, 2
	mfc1.d $a1, $f12
	syscall
