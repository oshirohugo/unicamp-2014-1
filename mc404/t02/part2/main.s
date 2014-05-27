.globl main

.data
    msg0:        .asciz  "\nEnter command: "
    msg:           .asciz          "\nA mensagem digitada eh: "
    newLine:    .asciz  "\n"
    endMessage:    .asciz  "\nProgram End\n"

.text
main:
    push {r0}
    ldr r0, =msg0
    bl print_string
    pop {r0}

    push {lr}
    bl arm_getline
    
    push {r0}
    ldr r0, =msg
    bl print_string
    pop {r0}

    push {r0}
    bl print_string
    pop {r0}
    
    push {r0}
    ldr r0, =newLine
    bl print_string
    pop {r0}

    
    push {r0}
    bl arm_strtok
    pop {r0}
    
    push {r0}
    ldr r0, =endMessage
    bl print_string
    pop {r0}
    
    pop {pc}
    
    
get_command:
    push {r4, r5, r6, lr}
    
    push {r0, r1}
    bl arm_getline              @line in r0
    mov r2, r0                  @line in r2
    pop {r0, r1}
    
    push {r0, r1, r2}
    mov r0, r2                  @puts line in r0 to call arm_strtok 
    bl arm_strtok               @strings in 'cmd' 'arg1' 'arg2' 
    pop {r0, r1, r2}
    
    push {r0-r3}
    bl print_command
    pop {r0-r3}
    
    ldr r3, =cmd
    ldr r3, [r3]                @r3 points to cmd string
    
    push {r0, r1, r2, r3}
    mov r0, r3                  @put r3 in r0 to call arm_strlen
    bl arm_strlen
    mov r4, r0                  @puts len in r4
    pop {r0, r1, r2, r3}
    
    cmp r4, #1
    beq match_first_char
    
    mov r6, #1                  @counter
    match_command:
        ldr r4, =quit
        loop_command:
        
        cmp r6, #7
        beq loop_command_end
        
        push {r0-r3}
        mov r0, r3
        mov r1, r4
        bl arm_strcmp
        mov r5, r0
        pop {r0-r3}
        
        cmp r5, #0
        beq match_first_char
        
        push {r0-r3}
        mov r0, r4
        bl arm_strlen
        mov r5, r0
        add r5, r5, #1
        push {r0-r3}
        
        add r4, r4, r5
        
        add r6, r6, #1
        
        b loop_command
        
        loop_command_end:
        mov r3, #-5
        b get_command_return
    match_command_end:
    
    match_first_char:
        ldrb r3, [r3]
        cmp r3, #'q'
            b treat_quit
        cmp r3, #'s'
            b treat_step
        cmp r3, #'c'
            b treat_continue
        cmp r3, #'w'
            b treat_write
        cmp r3, #'p'
            b treat_print
        cmp r3, #'r'
            b treat_registers
        b default
        
        treat_quit:
            mov r3, #0
            b store_args
        treat_quit_end:
        
        treat_step:
            ldr r3, =arg1
            ldr r3, [r3]
            push {r0-r2}
            mov r0, r3
            bl arm_strtou
            mov r3, r0
            pop {r0-r2}
            b store_args
        treat_step_end:
        
        treat_continue:
            mov r3, #-1
            b store_args
        treat_continue_end:
        
        treat_write:
            mov r3, #-2
            b store_args
        treat_write_end:

        treat_print:
            mov r3, #-3
            b store_args
        treat_print_end:
        
        treat_registers:
            mov r3, #-4
            b store_args
        treat_registers_end:

        default:
            mov r3, #-5
            b store_args
        default_end:
        
    match_first_char_end:
    
    store_args:
        @copy arg1 to r0 address
        ldr r4, =arg1
        ldr r4, [r4]
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @agr1 len in r5
        pop {r0-r3}
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @agr1 len in r5
        pop {r0-r3}
        
        
        push {r0-r3}
        @mov r0, r0             @r0 already contains dest
        mov r1, r4              @puts src in r1
        mov r2, r5              @puts len to be copy in r2        
        bl arm_memcpy
        pop {r0-r3}
        
        @copy arg2 to r0 address
        ldr r4, =arg2
        ldr r4, [r4]
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @agr1 len in r5
        pop {r0-r3}
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @agr1 len in r5
        pop {r0-r3}
        
        push {r0-r3}
        mov r0, r1              @r0 now contains dest
        mov r1, r4              @puts src in r1
        mov r2, r5              @puts len to be copy in r2        
        bl arm_memcpy
        pop {r0-r3}
        
    store_args_end:
    
    get_command_return:
        mov r0, r3              @return command code
    
    
    pop {r4, r5, r6, pc}