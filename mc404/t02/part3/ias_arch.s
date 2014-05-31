@A macro abaixo eh usada para que possamos declarar um mapa de memoria
@de modo simplificado, sem ter que colocar a diretiva .byte manualmente
@a cada byte.

.macro	dec_bytes	byte1 byte2 byte3 byte4 byte5
	.byte 0x\byte1
	.byte 0x\byte2
	.byte 0x\byte3
	.byte 0x\byte4
	.byte 0x\byte5
.endm


.data
	.align 4
	.globl IAS_MEM_MAP
	.globl PC
	.globl AC
	.globl MQ

PC:
	.space 5

AC:
	.space 5

MQ:
	.space 5

IAS_MEM_MAP:
	dec_bytes 09 00 E0 00 00
	dec_bytes 21 3F F0 13 FD
	dec_bytes 13 00 30 13 FE
	dec_bytes 12 00 40 90 00
	dec_bytes 0B 00 00 A0 00
	dec_bytes 21 00 F0 10 0E
	dec_bytes 05 00 F2 10 0E
	dec_bytes 01 3F D0 50 0D
	dec_bytes 21 3F D0 13 FE
	dec_bytes 05 00 D2 13 FE
	dec_bytes 01 3F F0 60 0D
	dec_bytes 21 3F F1 00 01
	dec_bytes 01 00 E0 D4 00 @12

	dec_bytes 00 00 00 00 01 @const 1
	dec_bytes 00 00 00 00 AB
	dec_bytes 00 00 00 00 0C

	dec_bytes 00 00 00 00 01 @inicio do vetor 1
	dec_bytes 00 00 00 00 01
	dec_bytes 00 00 00 00 01

	dec_bytes 00 00 00 00 02 @inicio do vetor 2
	dec_bytes 00 00 00 00 02
	dec_bytes 00 00 00 00 02
	
	.fill	999, 5, 0		 @preenche 999 linhas com 5 bytes nulos cada
	
	dec_bytes 00 00 00 00 10 @pos do vetor 1
	dec_bytes 00 00 00 00 13 @pos do vetor 2
	dec_bytes 00 00 00 00 03 @tamanho dos vetores

@note que o total de linhas eh 1024
