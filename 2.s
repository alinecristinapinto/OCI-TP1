.data
cartao: .word 4 9 1 6 6 4 1 8 5 9 3 6 9 0 8 0
# vetor de base - 1 p/ indices impares e 2 p/ indices pares
base: .word 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
.text
main:
la a0, cartao
jal ra, verifica
beq zero, zero, FIM
##### START MODIFIQUE AQUI START #####
verifica:
	addi sp, sp, -16
    sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
    
    addi t0, zero, 10 # const 10
	addi t1, zero, -1 # const -1
    
	lw s0, 60(a0) # cartao[15] -> offset = 60 (15 * 4)
	
    jal ra, multvetores # chama func multvetores
    
	rem s1, a0, t0 # retorno % 10
	mul s2, s1, t1 # -s1
	add s2, t0, s2 # 10 - s1
    
    add a0, zero, zero # set valido como falso
    rem s2, s2, t0 # (10 - s1) % 10 (0 ... 9)
    
	bne s0, s2, SEGUE # s0 != s2  => SEGUE
	VALIDO: addi a0, zero, 1
	SEGUE: 
    lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	addi sp sp 16
jalr zero, 0(ra)

multvetores:
	addi sp, sp, -20
    sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
    sw s3, 12(sp)
	sw ra, 16(sp)

	addi t6, zero, 16 # const 16
    addi t5, zero, 10 # cont 10
    addi t1, zero, -1 # i = -1, na primeira iteracao em LOOP i = 0

	la s0, base # &base
	add s1, zero, a0 # &cartao
	add a0, zero, zero # soma = 0

LOOP:
	addi t1, t1, 1 # i++
    
	lw s2, 0(s0) # base[i]
	lw s3, 0(s1) # cartao[i]
    
	mul t2, s3, s2 # mult = cartao[i] * base[i]
    
    rem t3, t2, t5 # unidade => numero % 10
    div t4, t2, t5 # dezena => numero / 10
    
    add t2, t3, t4 # unidade + dezena
	add a0, a0, t2 # soma += mult
    
	addi s0, s0, 4 # incrementa posicao do vetor base
	addi s1, s1, 4 # incrementa posicao do vetor cartao
blt t1, t6, LOOP    # i < 16 

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
    lw s3, 12(sp)
	lw ra, 16(sp)
	addi sp sp 20
jalr zero, 0(ra)
##### END MODIFIQUE AQUI END #####
FIM: add zero, zero, zero