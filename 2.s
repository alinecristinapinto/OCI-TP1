.data
cartao: .word 4 9 1 6 6 4 1 8 5 9 3 6 9 0 8 0 
# vetor de base - 1 p/ indices impares e 2 p/ indices pares
base: .word 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
.text
main:
la a0, cartao
jal ra, verifica
beq zero, zero, FIM
##### START MODIFIQUE AQUI START #####
verifica:
	addi sp, sp, -24
    sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
	sw ra, 20(sp)
    
    addi s3, zero, 10 # const 10
	addi s4, zero, -1 # const -1
    
	lw s0, 60(a0) # cartao[15] -> offset = 60 (15 * 4)
	
    jal ra, multvetores # chama func multvetores
    
	rem s1, a0, s3 # retorno % 10
	mul s2, s1, s4 # -s1
	add s2, s3, s2 # 10 - s1
    
    add a0, zero, zero # set valido como falso
    rem s2, s2, s3 # (10 - s1) % 10 (0 ... 9)
    
	bne s0, s2, SEGUE # s0 != s2  => SEGUE
	VALIDO: addi a0, zero, 1
	SEGUE: 
    lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
	lw ra, 20(sp)
	addi sp sp 24
jalr zero, 0(ra)

multvetores:
	addi sp, sp, -40
    sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw s9, 36(sp)

	addi s4, zero, 14 # const 14
    addi s5, zero, 10 # cont 10
    addi s6, zero, -1 # i = -1, na primeira iteracao em LOOP i = 0

	la s0, base # &base
	add s1, zero, a0 # &cartao
	add a0, zero, zero # soma = 0

LOOP:
	addi s6, s6, 1 # i++
    
	lw s2, 0(s0) # base[i]
	lw s3, 0(s1) # cartao[i]
    
	mul s7, s3, s2 # mult = cartao[i] * base[i]
    
    rem s8, s7, s5 # unidade => numero % 10
    div s9, s7, s5 # dezena => numero / 10
    
    add s7, s8, s9 # unidade + dezena
	add a0, a0, s7 # soma += mult
    
	addi s0, s0, 4 # incrementa posicao do vetor base
	addi s1, s1, 4 # incrementa posicao do vetor cartao
blt s6, s4, LOOP    # i < 14  

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
    lw s3, 12(sp)
	lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    lw s9, 36(sp)
	addi sp sp 40
jalr zero, 0(ra)
##### END MODIFIQUE AQUI END #####
FIM: add zero, zero, zero