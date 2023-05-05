##### Problema 1: Numeros primos #####
# Procedimento que calcula os numeros primos em uma determinada faixa.
# Numero primo: possui apenas dois divisores positivos e distintos (1 e ele mesmo).
# 
.data
vetor: .word 0 0 0 0
##### START MODIFIQUE AQUI START #####
#
# Este espaço eh para você definir as suas constantes e vetores auxiliares.
##### END MODIFIQUE AQUI END #####
.text
main:
add s0, zero, zero
#Teste 1
addi a0, zero, 5
addi a1, zero, 7
la a2, vetor
jal ra, primos
addi t0, zero, 2
beq t0, a0, OK1
beq zero, zero, T2
OK1: addi s0, s0, 1 #Teste ok, passou
#Teste 2
T2: addi a0, zero, 1
addi a1, zero, 6
la a2, vetor
jal ra, primos
addi t0, zero, 3
beq t0, a0, OK2
beq zero,bzero, FIM
OK2: addi s0, s0, 1 #Teste ok, passou
beq zero,bzero, FIM
##### START MODIFIQUE AQUI START #####
primos: jalr zero, 0(ra)
##### END MODIFIQUE AQUI END #####
FIM: add zero, zero, zero
#Final da execucao, s0 deve ter o valor igual a 2.