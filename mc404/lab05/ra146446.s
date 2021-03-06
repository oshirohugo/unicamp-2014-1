.globl main
.extern scanf
.extern printf

.data
	printf_char:	        .asciz "%c:"
	
	printf_vol:		.asciz "volume:%d\n"
	printf_area:            .asciz "area:%d\n"
	scanf_str:		.asciz "%d"

        a:			.word 0
        b:                      .word 0
        c:                      .word 0

.text
	.align 4

main:
	push {ip,lr}			@Armazena valores na pilha, para futuro retorno do procedimento. ip == r12, lr == r14 => mais info. em http://stackoverflow.com/q/16120123

    @Lê valores================================================
	ldr r0, =printf_char	        @carrega o endereco da mensagem printf_char em r0
	ldr r1, ='a'                    @carrega o caractere 'a' em r1, como segundo parametro de printf, do tipo byte
	bl printf						@chama a funcao printf

	ldr r0, =scanf_str				@carrega o endereco da string de scanf em r0
	ldr r1, =a						@carrega o endereco de a em r1 - scanf vai alterar a com o valor lido!
	bl scanf						@chama scanf

	ldr r0, =printf_char            @carrega o endereco da mensagem printf_char em r0
    ldr r1, ='b'                    @carrega o caractere 'b' em r1, como segundo parametro de printf, do tipo byte
    bl printf                       @chama a funcao printf

    ldr r0, =scanf_str              @carrega o endereco da string de scanf em r0
    ldr r1, =b                      @carrega o endereco de b em r1 - scanf vai alterar b com o valor lido!
    bl scanf                        @chama scanf

    ldr r0, =printf_char            @carrega o endereco da mensagem printf_char em r0
    ldr r1, ='c'                    @carrega o caractere 'c' em r1, como segundo parametro de printf, do tipo byte
    bl printf                       @chama a funcao printf

    ldr r0, =scanf_str              @carrega o endereco da string de scanf em r0
    ldr r1, =c                      @carrega o endereco de c em r1 - scanf vai alterar c com o valor lido!
    bl scanf                        @chama scanf
	
	ldr r0, =a						@carrega o endereco de a em r0
	ldr r0, [r0]					@carrega o valor de a em r0
	
    ldr r1, =b                      @carrega o endereco de b em r1
    ldr r1, [r1]                    @carrega o valor de b em r1
    
    ldr r2, =c                      @carrega o endereco de c em r2
    ldr r2, [r2]                    @carrega o valor de c em r2
    
    @Calcula area================================================
	mul r3, r0, r1					@em seguida, faz r3 = r0 * r1
	
	mul r4, r0, r2                  @em seguida, faz r4 = r0 * r2
	
	mul r5, r1, r2                  @em seguida, faz r5 = r1 * r2
	
	add r3, r3, r4                  @em seguida, faz r3 = r3 + r4
	
	add r3, r3, r5                  @em seguida, faz r3 = r3 + r5
	
	mov r4, #2                      @copia numero 2 em r4
	mul r3, r3, r4                  @em seguida, faz r3 = r3 * 2
	
	@Calcula Volume==============================================
	mul r4, r0, r1                  @em seguida, faz r4 = r0 * r1
	mul r4, r4, r2                  @em seguida, faz r4 = r4 * r2
	
	@Printa Resultados===========================================
	ldr r0, =printf_area            @carrega o endereco da mensagem printf_area em r0
    mov r1, r3                      @copia r3 em r1, que eh o segundo parametro de printf
    bl printf                       @chama printf
	
	ldr r0, =printf_vol				@carrega o endereco da mensagem printf_vol em r0
	mov r1, r4		        		@copia r4 em r1, que eh o segundo parametro de printf
	bl printf						@chama printf

	pop {ip,pc} 					@libera o link register no pc, para retornar onde estava antes de chamar main
