.data

entrada: .asciiz "Insira o valor: "

cabecalhoNotas: .asciiz "NOTAS:\n"
cabecalhoMoedas: .asciiz "MOEDAS:\n"

saidaNota: .asciiz " notas(s) de R$ "
saidaMoeda: .asciiz " moeda(s) de R$ "

printTeste: .asciiz "TESTE"

linhaEmBranco: .asciiz "\n"

notas: .float 100, 50, 20, 10, 5, 2
moedas: .float 1.0, 0.5, 0.25, 0.1, 0.05, 0.01
qtd: .word 6

.text

main:	
	# Vetores
	l.s $f0, notas
	lw $s1, qtd
	l.s $f1, moedas
	
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

	addi $t0, $zero, 0 # i
	la $t1, 0($f0) # vetor
	forNotas:
		beq $t0, $s1, exitForNotas
		# Imprimir a nota		
		li $v0, 1
		lw $a0, 0($t1)
		syscall
		li $v0, 4
		la $a0, linhaEmBranco
		syscall
		
		# Passar o valor para a funcao e imprimir a quantidade
		mfc1 $a0, $f0
		mfc1 $a1, $t1
		jal calcula_nota
		
		li $v0, 4
		la $a0, printTeste
		syscall
		
		move $a0, $v0
		lw $a1, 0($t1)
		jal print_nota

		# Somar o i
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		j forNotas
		
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
				
		sub.s $a0, $a0, $a1
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
