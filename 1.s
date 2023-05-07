##### Problema 1: Numeros primos #####
#
# Procedimento que calcula os numeros primos em uma determinada faixa.
# Numero primo: numero natural n, n > 1, que possui apenas dois divisores distintos (1 e ele mesmo). 
# Para identificar, podemos verificar o resto da divisao (mod - %) do numero por seus predecessores. 
# Como todo numero eh divisivel por 1, nao precisamos verificar o seu resto. Ainda, nenhum numero  
# natural sera divisivel por outro que seja maior que sua metade. Sendo assim, podemos contabilizar 
# o numero de divisores a partir de 2 ate a metade do numero em questao: se for 0, o numero eh primo.
# A seguir eh apresentado o codigo em alto nivel (c++) implementando essa logica, e que sera
# traduzido para risc-v:
## int a0, a1, countPrimos=0, divisores=0;
## for(int i=a0; i<=a1; i++){
##   divisores = 0;
##   if (i <= 1) divisores = -1;
##   for(int j=2; j<=i/2 ; j++) if(i%j == 0) divisores++;
##   if (divisores == 0) countPrimos++;
## }
# Como queremos aquantidade de primos de um intervalo, ha um for que percorre o intervalo e 
# verifica para cada numero do intervalo se o mesmo eh primo contabilizando na variavel countPrimos.
# Alem disso, como a0 e a1 pode ser qualquer inteiro e nao existem numeros primos menores ou iguais 
# a 1, foi adicionado uma validacao para isso.
#
##### Solucao RISC-V #####
.data
vetor: .word 0 0 0 0
.text
main:
add s0, zero, zero
# Teste 1
addi a0, zero, 5
addi a1, zero, 7
la a2, vetor
jal ra, primos
addi t0, zero, 2
beq t0, a0, OK1
beq zero, zero, T2
OK1: addi s0, s0, 1 # Teste ok, passou
# Teste 2
T2: addi a0, zero, 1
addi a1, zero, 6
la a2, vetor
jal ra, primos
addi t0, zero, 3
beq t0, a0, OK2
beq zero, zero, FIM
OK2: addi s0, s0, 1 # Teste ok, passou
beq zero, zero, FIM
##### START PROCEDIMENTO PRIMO #####
primos:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw ra, 16(sp)
    
	addi t2, zero, 2 # const 2
	addi s0, a0, -1 # i = (a0 - 1) -> LOOP1 sempre faz i++ no inicio, entao na primeira rodada i = a0
	add a0, zero, zero # numPrimos - numero de primos do intervalo, inicialmente 0
    
	LOOP1:
		addi s0, s0, 1 # i++
		add s1, zero, zero # divisores = 0 - armazena numero de divisores de i (s0)
        
		blt s0, t2, LOOP1  # i < 2? se sim: segue para proximo numero  

		addi s2, zero, 1 # j=1 -> LOOP2 sempre faz j++ no inicio, entao na primeira execucao j = 2
		LOOP2: 
			addi s2, s2, 1 # j++
            
			beq s0, t2, COUNT_PRIMOS # i == 2? segue para incrementar numPrimos (a0)
            
			rem s3, s0, s2 # s3 = i % j
            
			bne s3, zero, SEGUE_L2 # mod (s3) != 0? entao j nao eh divisor de i
			COUNT_DIVISORES: addi s1, s1, 1
			SEGUE_L2: div t5, s0, t2 # t5 = i / 2
		bge t5, s2, LOOP2  # j <= i / 2
        
		bne s1, zero, SEGUE_L1 # divisores (s1) != 0? entao nao eh primo
		COUNT_PRIMOS: 
			addi a0, a0, 1
			sb s0, 0(a2) # adiciona numero primo (i) ao vetor
			addi a2, a2, 4 # incrementa posicao do vetor
		SEGUE_L1:
	blt s0, a1, LOOP1  # i < a1 - roda o for para proximo numero do intervalo  

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw ra, 16(sp)
	addi sp, sp, 20
jalr zero, 0(ra)
##### END PROCEDIMENTO PRIMO #####
FIM: add zero, zero, zero
# Final da execucao, s0 deve ter o valor igual a 2.