.org 0x0
.section .iv,"a"

_start:         

interrupt_vector:

   b RESET_HANDLER
.org 0x18
   b IRQ_HANDLER
   
.org 0x100
.text

@ Zera o contador
  ldr r2, =CONTADOR  @lembre-se de declarar esse contar numa secao de dados! 
  mov r0,#0
  str r0,[r2]

RESET_HANDLER:
    SET_GPT:
        .set GPT_BASE,                 0x53FA0000
        .set GPT_CR,                   0x0
        .set GPT_PR,                   0x4
        .set GPT_IR,                   0xC
        .set GPT_OCR1,                 0x10
        
        @start setting GPT stuff
        mov r0, #0x00000041
        ldr r1, =GPT_BASE
        str r0, [r1, #GPT_CR]            @enable GTP control register and set clock_src peripheral
        
        mov r0, #0
        ldr r1, =GPT_BASE
        str r0, [r1, #GPT_PR]            @set prescaler to zero
        
        mov r0, #100
        ldr r1, =GPT_BASE
        str r0, [r1, #GPT_OCR1]          @count up to 100
        
        mov r0, #1
        ldr r1, =GPT_BASE
        str r0, [r1, #GPT_IR]            @show interest in Output Compare Channel 1
        
        msr  CPSR_c,  #0x13   @ SUPERVISOR mode, IRQ/FIQ enabled

    SET_TZIC:
        @ Constantes para os enderecos do TZIC
        .set TZIC_BASE,                0x0FFFC000
        .set TZIC_INTCTRL,             0x0
        .set TZIC_INTSEC1,             0x84 
        .set TZIC_ENSET1,              0x104
        .set TZIC_PRIOMASK,            0xC
        .set TZIC_PRIORITY9,           0x424

        @ Liga o controlador de interrupcoes
        @ R1 <= TZIC_BASE

        ldr    r1, =TZIC_BASE

        @ Configura interrupcao 39 do GPT como nao segura
        mov    r0, #(1 << 7)
        str    r0, [r1, #TZIC_INTSEC1]

        @ Habilita interrupcao 39 (GPT)
        @ reg1 bit 7 (gpt)

        mov    r0, #(1 << 7)
        str    r0, [r1, #TZIC_ENSET1]

        @ Configure interrupt39 priority as 1
        @ reg9, byte 3

        ldr r0, [r1, #TZIC_PRIORITY9]
        bic r0, r0, #0xFF000000
        mov r2, #1
        orr r0, r0, r2, lsl #24
        str r0, [r1, #TZIC_PRIORITY9]

        @ Configure PRIOMASK as 0
        eor r0, r0, r0
        str r0, [r1, #TZIC_PRIOMASK]

        @ Habilita o controlador de interrupcoes
        mov    r0, #1
        str    r0, [r1, #TZIC_INTCTRL]

        @instrucao msr - habilita inteerrupcoes
        msr  CPSR_c, #0x13       @ SUPERVISOR mode, IRQ/FIQ enabled


        @Set interrupt table base address on coprocessor 15.
                ldr r0, =interrupt_vector
                mcr p15, 0, r0, c12, c0, 0

        @@@...continua tratando o reset
        
        @ Zera o contador
        ldr r2, =CONTADOR  @lembre-se de declarar esse contar numa secao de dados! 
        mov r0,#0
        str r0,[r2]

laco:
    b laco
    
IRQ_HANDLER:
    @increments counter
    ldr r0, =CONTADOR
    ldr r1, [r0]
    add r1, r1, #1
    str r1, [r0]
    
    sub lr, lr, #4      @correct PC
    movs pc, lr         @back to laco

.org 0xFF
.data
CONTADOR:       .space 4
