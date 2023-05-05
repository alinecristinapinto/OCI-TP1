.data
cartao: .word 4 9 1 6 6 4 1 8 5 9 3 6 9 0 8 0
##### START MODIFIQUE AQUI START #####
#
# Este espaço eh para você definir as suas constantes e vetores auxiliares.
##### END MODIFIQUE AQUI END #####
.text
main:
la a0, cartao
jal ra, verifica
beq zero,zero,FIM
##### START MODIFIQUE AQUI START #####
verifica:
jalr zero, 0(ra)
multvetores:
jalr zero, 0(ra)
##### END MODIFIQUE AQUI END #####
FIM: add zero, zero, zero