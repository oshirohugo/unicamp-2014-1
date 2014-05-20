.globl main

.data
        msg1:           .asciz          "Digite uma mensagem: "
        msg2:           .asciz          "\nA mensagem digitada eh: "
        mensagem:       .space          100

.text
main:
        push {r7, lr}

        @ $> Digite uma mensagem: 
        mov r0, #0x1
        ldr r1, =msg1
        mov r2, #0x15
        mov r7, #0x4
        svc 0   

        @ Le a mensagem do usuário
        mov r0, #0x0
        ldr r1, =mensagem
        mov r2, #0x64
        mov r7, #0x3
        svc 0 

        @ $> A mensagem digitada eh:
        mov r0, #0x1
        ldr r1, =msg2
        mov r2, #0x19
        mov r7, #0x4
        svc 0

        @ Escreve a mensagem de volta na tela
        mov r0, #0x1
        ldr r1, =mensagem
        mov r2, #0x64   
        mov r7, #0x4
        svc 0

        mov r0, #0x0 @retorno da main
        pop {r7,pc}