.data
mensagem1: .asciiz "Digite o primeiro ano: "
mensagem2: .asciiz "Digite o segundo ano: "
nova_linha: .asciiz "\n"
mensagem_erro: .asciiz "A diferenca nao pode ser maior que 1000. Digite novamente.\n"

.text
.globl main

main:
ler_anos:
    # Mostrar mensagem do primeiro ano
    li $v0, 4
    la $a0, mensagem1
    syscall

    # Receber o primeiro ano
    li $v0, 5
    syscall
    move $t0, $v0

    # Mostrar mensagem do segundo ano
    li $v0, 4
    la $a0, mensagem2
    syscall

    # Receber o segundo ano
    li $v0, 5
    syscall
    move $t1, $v0

    # Organizar os anos
    bgt $t0, $t1, primeiro_maior

    move $t2, $t0
    move $t3, $t1
    j anos_organizados

primeiro_maior:
    move $t2, $t1
    move $t3, $t0

anos_organizados:
    # Calcular a diferenca
    sub $t7, $t3, $t2

    # Verificar o limite
    li $t8, 1000
    bgt $t7, $t8, intervalo_invalido
    
    #Comrçar a verificar os anos
    addi $t4, $t2, 1
repetir_anos:
    # Verificar se chegou ao limite
    bge $t4, $t3, fim_repeticao

    # Verificar se é divisivel por 4
    li $t5, 4
    rem $t6, $t4, $t5
    bne $t6, $zero, nao_bissexto

    # Verificar se é divisivel por 100
    li $t5, 100
    rem $t6, $t4, $t5
    bne $t6, $zero, proximo_ano

    # Verificar se é divisivel por 400
    li $t5, 400
    rem $t6, $t4, $t5
    beq $t6, $zero, proximo_ano

nao_bissexto:
    # Apresentar ano nao bissexto
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, nova_linha
    syscall

proximo_ano:
    # Avancar para o proximo ano
    addi $t4, $t4, 1
    j repetir_anos

fim_repeticao:
    li $v0, 10
    syscall

intervalo_invalido:
    #Mensagem de erro
    li $v0, 4
    la $a0, mensagem_erro
    syscall
    j ler_anos