.globl get_command
.globl run_command

.globl arm_getline
.globl print_string
.globl arm_strtok

.extern arm_strtou
.extern arm_utostr
.extern arm_strlen
.extern arm_strcmp
.extern arm_memcpy

.data
    read_line:  .space 100
    print_line: .space 100
    cmd:        .space 100
    arg1:       .space 100
    arg2:       .space 100
    

.text
arm_getline:
    push {r7, lr}
    mov r0, #0x0        @reads from stdin
    ldr r1, =read_line  @loads read line address
    mov r2, #100        @reads a maximum of 100 bytes
    mov r7, #0x3        @determines it is a read syscall
    svc 0               @make a syscall with previews parameters
    
    ldr r0, =read_line  @returns the address of line read
    
    pop {r7, pc}
    
print_string:
    push {r7, lr}
    mov r1, r0          @moves address from string to r1
    
    
    push {r0, r1}
    bl arm_strlen
    mov r2, r0          @number os bytes to be printed in r2
    pop {r0, r1}
    
    mov r0, #0x1        @prints in stout
    mov r7, #0x4        @determines it is a write syscall
    svc 0               @make a syscall with previews parameters
    
    ldr r0, =read_line  @returns the address of line read
    
    pop {r7, pc}

arm_strtok:
    push {r4, r5, lr}
    
    mov r4, #0                          @initialize r4 that counts words token
    arm_strtok_loop:
        ldrb r1, [r0], #1               @reads char and points to next
        cmp r1, #' '                    @treats space
        beq check_flag
        change_flag:
            mov r3, #0                  @changes flag
            
            cmp r1, #'\n'               @checks if line end
            beq arm_strtok_loop_end     @stop processing
            
            cmp r4, #0                  @if its first word
            beq store_cmd
            cmp r4, #1                  @if its second word
            beq store_arg1
            cmp r4, #2                  @if its third word
            beq store_arg2
            store_cmd:
                ldr r5, =cmd
                str r0, [r5]
                b store_break
            store_arg1:
                ldr r5, =arg1
                str r0, [r5]
                b store_break
            store_arg2:
               ldr r5, =arg2
                str r0, [r5]
            store_break:
                add r4, r4, #1
            b treat_tok_end             @process next
        check_flag:
            cmpeq r3, #1                @only if last wasn't space
            beq treat_tok_end
        
        treat_tok:
            mov r2, #0                  @puts '\0' when token is found
            strb r2, [r1]               @puts '\0' when token is found
            mov r3, #1                  @sets flag to treat spaces
        treat_tok_end:
        
        b arm_strtok_loop
    arm_strtok_loop_end:
    
    mov r0, r4
    
    pop {r4, r5, pc}
    
    