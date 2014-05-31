.globl get_command
.globl run_command

.globl arm_getline
.globl print_string
.globl arm_strtok
.globl print_command
.globl print_address
.globl arm_utostr_hex
.globl print_MQ
.globl print_AC
.globl print_PC

.globl arm_strtou
.globl arm_utostr
.globl arm_strlen
.globl arm_strcmp
.globl arm_memcpy

.globl run_registers

.extern IAS_MEM_MAP
.extern internal_PC
.extern AC
.extern MQ

.data
.align 4
    read_line:          .space 255
    cmd:                .space 100
    arg1:               .space 100
    arg2:               .space 100
    newline:            .asciz "\n"
    space_char:         .asciz " "
    zero_char:          .asciz "0"
    x_char:             .asciz "x"
    pc_little:          .space 100
    
    ac_string:          .asciz "AC: "
    mq_string:          .asciz "MQ: "
    pc_string:          .asciz "PC: "
    
    right:              .asciz " - D"
    left:               .asciz " - E"
        
    quit:               .asciz "quit"
    step:               .asciz "step"
    continue:           .asciz "continue"
    write:              .asciz "write"
    print:              .asciz "print"
    registers:          .asciz "registers"
    
    big_endian:         .space 5
    litle_endian:       .space 4
    
    number_string:      .space 100
    
.align 4
    
.text
@=================================================================================================
arm_getline:
    push {r7, lr}
    mov r0, #0x0        @reads from stdin
    ldr r1, =read_line  @loads read line address
    mov r2, #255        @reads a maximum of 255 bytes
    mov r7, #0x3        @determines it is a read syscall
    svc 0               @make a syscall with previews parameters
    
    
    @ldr r0, =read_line  @returns the address of line read
    
    pop {r7, pc}
@=================================================================================================    
print_AC:
    push {r4, r5, r7, lr}
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =ac_string                  @address from where to be printed
    mov r2, #4                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    ldr r3, =AC                         @loads AC address in r1
    mov r4, #5                          @counts for 5 bytes
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =zero_char                  @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =x_char                     @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    print_AC_loop:
        cmp r4, #0                      @check if 5 bytes were processed    
        beq print_AC_loop_end           @breaks    
        ldrb r0, [r3]                   @takes content of address
        
        push {r3}
        ldr r1, =number_string          @load address where string representing address content should be stored
        bl arm_utostr_hex               @transform number in string and puts in number_string
        pop {r3}
        
        push {r0-r3}
        ldr r0, =number_string
        bl arm_strlen
        mov r5, r0
        pop {r0-r3}
        
        cmp r5, #2
        beq print_AC_normally
        
        mov r0, #0x1                    @prints in stout
        ldr r1, =zero_char              @address from where to be printed
        mov r2, #1                      @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        print_AC_normally:
        mov r0, #0x1                    @prints in stout
        ldr r1, =number_string          @address from where to be printed
        mov r2, #100                    @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        add r3, r3, #1                  @points to next byte    
        sub r4, r4, #1                  @decrements
        b print_AC_loop            @loops
    print_AC_loop_end:
   
    pop {r4, r5, r7, pc}
     
    
@=================================================================================================    
print_MQ:
    push {r4, r5, r7, lr}
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =mq_string                  @address from where to be printed
    mov r2, #4                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    ldr r3, =MQ                         @loads MQ address in r1
    mov r4, #5                          @counts for 5 bytes
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =zero_char                  @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =x_char                     @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    

    print_MQ_loop:
        cmp r4, #0                      @check if 5 bytes were processed    
        beq print_MQ_loop_end           @breaks    
        ldrb r0, [r3]                   @takes content of address
        

        
        push {r3}
        ldr r1, =number_string          @load address where string representing address content should be stored
        bl arm_utostr_hex               @transform number in string and puts in number_string
        pop {r3}
        
        push {r0-r3}
        ldr r0, =number_string
        bl arm_strlen
        mov r5, r0
        pop {r0-r3}
        
        cmp r5, #2
        beq print_MQ_normally
        
        mov r0, #0x1                    @prints in stout
        ldr r1, =zero_char              @address from where to be printed
        mov r2, #1                      @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        print_MQ_normally:
        mov r0, #0x1                    @prints in stout
        ldr r1, =number_string          @address from where to be printed
        mov r2, #100                    @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        add r3, r3, #1                  @points to next byte    
        sub r4, r4, #1                  @decrements
        b print_MQ_loop            @loops
    print_MQ_loop_end:
          
    pop {r4, r5, r7, pc}
    
@=================================================================================================    
print_PC:
    push {r4, r5, r7, lr}
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =pc_string                  @address from where to be printed
    mov r2, #4                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
       
    mov r0, #0x1                        @prints in stout
    ldr r1, =zero_char                  @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =x_char                     @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    
    ldr r0, =internal_PC
    ldr r0, [r0]
    mov r1, #2
    bl remain   
    
    cmp r0, #0
    bne print_right
    
    print_left:
        
        ldr r0, =internal_PC
        ldr r0, [r0]
        mov r1, #2
        bl division
        
        ldr r1, =number_string
        bl arm_utostr_hex
        
        ldr r0, =number_string
        bl arm_strlen
        cmp r0, #3
        beq print_left_normal
        
        mov r1, #3
        sub r3, r1, r0
        
        print_left_zero:
            cmp r3, #0
            beq print_left_normal
            
            mov r0, #0x1                    @prints in stout
            ldr r1, =zero_char              @address from where to be printed
            mov r2, #1                      @number of bytes to be printed
            mov r7, #0x4                    @determines it is a write syscall
            svc 0                           @make a syscall with previews parameters
            
            sub r3, r3, #1
            b print_left_zero
      
        
        print_left_normal:
            mov r0, #0x1                    @prints in stout
            ldr r1, =number_string          @address from where to be printed
            mov r2, #100                    @number of bytes to be printed
            mov r7, #0x4                    @determines it is a write syscall
            svc 0                           @make a syscall with previews parameters
        
            mov r0, #0x1                    @prints in stout
            ldr r1, =left                   @address from where to be printed
            mov r2, #4                      @number of bytes to be printed
            mov r7, #0x4                    @determines it is a write syscall
            svc 0                           @make a syscall with previews parameters
            b print_PC_return
        
    print_right:
    
        ldr r0, =internal_PC
        ldr r0, [r0]
        mov r1, #2
        bl division
        sub r0, r0, #1
      
        ldr r1, =number_string
        bl arm_utostr_hex
        
        mov r0, #0x1                    @prints in stout
        ldr r1, =number_string          @address from where to be printed
        mov r2, #100                    @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
    
        mov r0, #0x1                    @prints in stout
        ldr r1, =right                   @address from where to be printed
        mov r2, #4                      @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters    
        
    print_PC_return:
    
    pop {r4, r5, r7, pc}

@=================================================================================================    
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
   
    pop {r7, pc}
@=================================================================================================
arm_strtok:
    push {r4, r5, r6, lr}
    
    mov r4, #0                          @initialize r4 that counts words token
    mov r3, #0                          @initialize r3 flag
    arm_strtok_loop:
        ldrb r1, [r0]                   @reads char
        cmp r1, #' '                    @treats space
        beq check_flag
        change_flag:
            mov r6, r3                  @set flag
            mov r3, #0                  @changes flag
            
        cmp r1, #'\n'               @checks if line end
        beq arm_strtok_loop_end     @stop processing
        
        cmp r3, r6
        bne treat_words
        cmpeq r4, #0
        bne treat_words_end
        treat_words:
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
            
        treat_words_end:
        b treat_tok_end             @process next
            
        check_flag:
            cmpeq r3, #1                @only if last wasn't space
            beq treat_tok_end
        
        treat_tok:
            mov r2, #0                  @puts '\0' in r2
            strb r2, [r0]               @puts '\0' where a space was found
            mov r6, r3                  @sets flag to treat spaces
            mov r3, #1                  @sets flag to treat spaces
        treat_tok_end:
        add r0, r0, #1                 @goes o next char
        b arm_strtok_loop
    arm_strtok_loop_end:
    
    mov r2, #0                          @puts '\0' in r2
    strb r2, [r0]                       @puts '\0' where a '\n' was found
    
    mov r0, r4
    
    pop {r4, r5, r6, pc}

@=================================================================================================    
print_command: @TO DEBUG
    push {lr}
    
    ldr r0, =newline
    bl print_string
    
    ldr r0, =cmd
    ldr r0, [r0]
    bl print_string
    
    ldr r0, =newline
    bl print_string
    
    ldr r0, =arg1
    ldr r0, [r0]
    bl print_string
    
    ldr r0, =newline
    bl print_string
    
    ldr r0, =arg2
    ldr r0, [r0]
    bl print_string
    
    ldr r0, =newline
    bl print_string
    
    pop {pc}
    
@=================================================================================================    
print_address:
    push {r4, r5, r7, lr}
                                        @r0 contains address number
    mov r2, #5
    mul r1, r0, r2                      @calculates displacement over address map
    ldr r0, =IAS_MEM_MAP                @loads IAS_MEM_MAP address in r1
    add r3, r0, r1                      @points do desired address
    mov r4, #5                          @counts for 5 bytes
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =zero_char                  @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    mov r0, #0x1                        @prints in stout
    ldr r1, =x_char                     @address from where to be printed
    mov r2, #1                          @number of bytes to be printed
    mov r7, #0x4                        @determines it is a write syscall
    svc 0                               @make a syscall with previews parameters
    
    print_address_loop:
        cmp r4, #0                      @check if 5 bytes were processed    
        beq print_address_loop_end      @breaks    
        ldrb r0, [r3]                   @takes content of address
        
        push {r3}
        ldr r1, =number_string          @load address where string representing address content should be stored
        bl arm_utostr_hex               @transform number in string and puts in number_string
        pop {r3}
        
        push {r0-r3}
        ldr r0, =number_string
        bl arm_strlen
        mov r5, r0
        pop {r0-r3}
        
        cmp r5, #2
        beq print_normally
        
        mov r0, #0x1                    @prints in stout
        ldr r1, =zero_char              @address from where to be printed
        mov r2, #1                      @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        print_normally:
        mov r0, #0x1                    @prints in stout
        ldr r1, =number_string          @address from where to be printed
        mov r2, #100                    @number of bytes to be printed
        mov r7, #0x4                    @determines it is a write syscall
        svc 0                           @make a syscall with previews parameters
        
        
        add r3, r3, #1                  @points to next byte    
        sub r4, r4, #1                  @decrements
        b print_address_loop            @loops
    print_address_loop_end:
    pop {r4, r5, r7, pc}
    
@=================================================================================================    
get_command:
    push {r4, r5, r6, r7, lr}
    
    push {r0, r1}
    bl arm_getline              @line in r0
    pop {r0, r1}
    
    push {r0, r1, r2}
    ldr r0 , =read_line
    bl arm_strtok               @strings in 'cmd' 'arg1' 'arg2'
    mov r7, r0                  @r7 contains number of words read
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
            beq treat_quit
        cmp r3, #'s'
            beq treat_step
        cmp r3, #'c'
            beq treat_continue
        cmp r3, #'w'
            beq treat_write
        cmp r3, #'p'
            beq treat_print
        cmp r3, #'r'
            beq treat_registers
        b default
        
        treat_quit:
            mov r3, #0
            b store_args
        treat_quit_end:
        
        treat_step:
            cmp r7, #1
            beq no_step_arg
            ldr r3, =arg1
            ldr r3, [r3]
            push {r0-r2}
            mov r0, r3
            bl arm_strtou
            mov r3, r0
            pop {r0-r2}
            b store_args
            
            no_step_arg:
                mov r3, #1      @defaul return for step with no args
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
        cmp r7, #2
        blt store_args_end

        @copy arg1 to r0 address
        ldr r4, =arg1
        ldr r4, [r4]
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @arg1 len in r5
        pop {r0-r3}
                
        push {r0-r3}
        @mov r0, r0             @r0 already contains dest
        mov r1, r4              @puts src in r1
        mov r2, r5              @puts len to be copy in r2        
        bl arm_memcpy
        pop {r0-r3}
        
        cmp r7, #3
        blt store_args_end
        
        @copy arg2 to r0 address
        ldr r4, =arg2
        ldr r4, [r4]
        
        push {r0-r3}
        mov r0, r4              @puts arg1 in r0 to call strlen
        bl arm_strlen
        mov r5, r0              @arg1 len in r5
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
    
@=================================================================================================
run_command:
    push {lr}
    
    cmp r0, #0
    ble case_step_end
    case_step:
        bl run_step
        b run_command_return
    case_step_end:
    
    cmp r0, #0
    bne case_quit_end
    case_quit:
        bl run_quit
        b run_command_success
    case_quit_end:
    
    cmp r0, #-1
    bne case_continue_end
    case_continue:
        bl run_continue
        b run_command_return
    case_continue_end:
    
    cmp r0, #-2
    bne case_write_end
    case_write:
        bl run_write
        b run_command_return
    case_write_end:
    
    cmp r0, #-3
    bne case_print_end
    case_print:
        bl run_print
        b run_command_return
    case_print_end:
    
    cmp r0, #-4
    bne case_registers_end
    case_registers:
        bl run_registers
        b run_command_success
    case_registers_end:
    
    cmp r0, #-5
    beq run_command_fail
    
    run_command_success:
        mov r0, #0
        b run_command_return
    
    run_command_fail:
        mov r0, #-1
        b run_command_return
    
    run_command_return:
    
    pop {pc}
    
@=================================================================================================
run_step:
    push {lr}
    
    mov r0, r1                          @r0 now contains arg1
    bl arm_strtou
    mov r1, r0                          @r1 contains repeat number from arg1
    
    mov r3, #0                          @successful execution counter
    run_step_loop:
        cmp r1, #0                      @if repeat number equals to 0
        beq run_step_loop_end           @stop execute
        bl execute                      @execute
        cmp r0, #0                      @if execute was successful
        addeq r3, r3, #1                @increment successful execution counter
        bne treat_execute_call_error    @treats error
        sub r1, r1, #1                  @decrements repetion number
        b run_step_loop                 @loops!
    run_step_loop_end:
    
    cmp r3, #0                          @if number of successful execution equals to 0
    moveq r0, #-3                       @return fail
    beq run_step_return                 @return fail
    movgt r0, #0                        @else
    bgt run_step_return                 @return success
    
    treat_execute_call_error:
        cmp r0, #2                      @if execute returns status 2
        moveq r0, #-2                   @return fail status -2
        beq run_step_return
        cmp r0, #3                      @if execute returns status 3
        moveq r0, #-3                   @returns fail status -3
        beq run_step_return
    
    run_step_return:
    
    pop {pc}
    
@=================================================================================================
run_quit:
    push {lr}
    pop {pc}
@=================================================================================================
run_continue:
    push {lr}
    run_continue_loop:
        bl execute
        cmp r0, #0
        bne run_continue_loop_end
    run_continue_loop_end:
    
    treat_execute_call_error_2:
        cmp r0, #2                      @if execute returns status 2
        moveq r0, #-2                   @return status -2
        beq run_continue_return
        cmp r0, #3                      @if execute returns status 3
        moveq r0, #-3                   @returns fail status -3
        beq run_continue_return
    
    run_continue_return:
    
    pop {pc}
@=================================================================================================
run_write:
    push {lr}
    @r1 r2

    push {r1}
    mov r0, r2
    bl arm_strtou               @r0 contains number to be stored in 4bytes representation
    pop {r1}
    
    rev r0, r0                  @transform in big endian
    ldr r2, =big_endian         @loads big_endian address in r2
    str r0, [r2]                @copies number to big_endian
    

    
    mov r0, r1
    bl arm_strtou               @r0 contains address of store location
    
    cmp r0, #1024
    movge r0, #-1
    bge run_write_return
    
    mov r2, #5
    mul r1, r0, r2              @calculates displacementin mem_map
    ldr r2, =IAS_MEM_MAP        @load memap in r2
    add r2, r2, r1              @repoints to address to be modified
    
    ldr r0, =big_endian         @loads big_endian address in r0
    mov r3, #5
    run_write_loop:
        cmp r3, #0
        beq run_write_loop_end
        
        ldrb r1, [r0], #1
        strb r1, [r2], #1
        
        sub r3, r3, #1
    run_write_loop_end:
    
    mov r0, #0
    
    run_write_return:
    
    
    pop {pc}
@=================================================================================================
run_print:
    push {lr}
    mov r0, r1          @transform arg1 in in unsigned int
    bl arm_strtou       @r0 contains unsigned int arg1
    
    cmp r0, #1024       @check if map limit was exceeded
    bgt run_print_error
    
    bl print_address
    
    ldr r0, =newline
    bl print_string
    
    mov r0, #0
    b run_print_return
    
    run_print_error:
        mov r0, #-1
        b run_print_return
        
    run_print_return:
    
    pop {pc}
@=================================================================================================
run_registers:
    push {lr}
    bl print_AC
    
    ldr r0, =newline
    bl print_string
    
    bl print_MQ
    
    ldr r0, =newline
    bl print_string
    
    bl print_PC
    
    ldr r0, =newline
    bl print_string
     
    pop {pc}   
@=================================================================================================
execute:
    push {lr}
    @TODO part 3
    mov r0, #0
    pop {pc}   
@=================================================================================================
arm_strtou:
    push {lr}
    
    push {r0}
    bl arm_strlen                       @calculates string len
    mov r1, r0
    pop {r0}
    
    cmp r1, #2                          @string_len == 2 ?
    push {r1}
    bllt arm_strtou_dec                 @if less use decimal approach (can't be haxadecimal)
    pop {r1}
    cmp r1, #2                          @string_len == 2 ?
    blt arm_strtou_return              
    
    test_second_digit:
        mov r1, r0                      @copies string address to r1
        add r1, r1, #1                  @points to second_letter
        ldrb r1, [r1]                   @loads second_letter
        cmp r1, #120                    @second_letter == 'x' ?
        bleq arm_strtou_hex             @use hexadecimal treatment
        blne arm_strtou_dec             @use decimal treatment
    
    arm_strtou_return:
      
    pop {pc}

@=================================================================================================
    
arm_strtou_dec:
    push {r4, r5, r6, lr}

    mov r1, r0                          @put r0 address in r1
    
    push {r1}
    bl arm_strlen                       @take string len
    pop {r1}
    
    mov r2, r0                          @put string len in r2
    mov r6, r1                          @makes r6 point to string beggining
    sub r6, r6, #1                      @makes r6 point to beggining -1
    add r1, r1, r2                      @makes r1 point to string end
    sub r1, r1, #1                      @corrects pointer
    
    mov r3, #0                          @r3 has digit order
    mov r0, #0                          @r0 will have the number presented by string
    dec_det_number_loop:
        cmp r1, r6
        bleq dec_det_number_loop_end
        
        ldrb r2, [r1], #-1
        
        sub r2, r2, #48                 @48 represents '0' in ASCII 
        
        push {r0, r1, r2, r3}           @push r0 and r1 to call pow
        mov r0, #10
        mov r1, r3
        bl pow
        mov r4, r0                      @r4 has pow(16,r3) result
        pop {r0, r1, r2, r3}                    @pops r0 and r1 after call pow
        
        mul r5, r2, r4                  @calculates decimal representation of that digit
        
        add r0, r0, r5                  @acumulates to make number
        add r3, r3, #1
        bl dec_det_number_loop
    dec_det_number_loop_end:    
      
    pop {r4, r5, r6, pc}

@=================================================================================================    
    
arm_strtou_hex:
    push {r4, r5, lr}

    mov r1, r0                          @put r0 address in r1
    
    push {r1}
    bl arm_strlen                       @take string len
    pop {r1}
    
    mov r2, r0                          @put string len in r2
    add r1, r1, r2                      @makes r1 point to string end
    sub r1, r1, #1                      @corrects pointer
    
    mov r3, #0                          @r3 has digit order
    mov r0, #0                          @r0 will have the number presented by string
    det_number_loop:
        ldrb r2, [r1], #-1
        
        cmp r2, #120
        beq det_number_loop_end
        
        
        cmp r2, #57
        ble is_number
        
        is_letter:
            sub r2, r2, #97             @97 presents 'a' in ASCII
            add r2, r2, #10
            bl is_number_end
        is_letter_end:
        
        is_number:
            sub r2, r2, #48             @48 represents '0' in ASCII 
        is_number_end:
        
        push {r0, r1, r2, r3}           @push r0 and r1 to call pow
        mov r0, #16
        mov r1, r3
        bl pow
        mov r4, r0                      @r4 has pow(16,r3) result
        pop {r0, r1, r2, r3}            @pops r0 and r1 after call pow
        
        mul r5, r2, r4                  @calculates decimal representation of that digit
        
        add r0, r0, r5                  @acumulates to make number
        add r3, r3, #1
        bl det_number_loop
    det_number_loop_end:    
      
    pop {r4, r5, pc}
    
@=================================================================================================
    
arm_strlen:
    push {lr}
    
    mov r2, #0                          @initialize counter as 0
    arm_strlen_loop:    
        ldrb r1, [r0], #1               @reads caracters for r1 (1 byte)
        add r2, r2, #1                  @adds one to counter
        cmp r1, #0                      @if caracter is '\0' goes out
        bne arm_strlen_loop
    arm_strlen_loop_end:
    sub r2, r2, #1                      @adjusts r2 that is the size
    mov r0, r2                          @puts in return value

    pop {pc}

@=================================================================================================

arm_strcmp:
    push {lr}

    arm_strcmp_loop:
        ldrb r2, [r0], #1               @reads caracters for r2 (1 byte) from r0 pointed string
        ldrb r3, [r1], #1               @reads caracters for r3 (1 byte) from r1 pointed string
        cmp r2, #0                      @check if not end of word
        cmpne r3, #0                    @check if the other is not word end
        beq arm_strcmp_loop_end         @finish if end
        cmp r2, r3                      @compare two letters        
        beq arm_strcmp_loop             @if they are equal goes to next
    arm_strcmp_loop_end:
    
    sub r0, r2, r3                      @r2 - r3 and puts in r0 to return
    cmp r0, #0
    movlt r0, #-1                       @returns -1 if difference is negative
    movgt r0, #1                        @returns 1 if differences is positive
    pop {pc}

@=================================================================================================

arm_memcpy:
    push {lr}
    
    
    add r3, r1, r2                      @verifies overlap
    cmp r3, r0                  
    bge arm_memcpy_error                @if overlap occurs, do nothing
    
    arm_memcpy_loop:
        cmp r2, #0                      @used to check if r2 chars were copied
        beq arm_memcpy_loop_end
        ldrb r3, [r1], #1               @reads first char from r1 and increments 1 to take next char
        strb r3, [r0], #1               @copy char readen to r0 and increments 1 to take next address
        sub r2, r2, #1                  @count how many chars were copied
        b arm_memcpy_loop               @loops!
    arm_memcpy_loop_end:
   
        
    arm_memcpy_error:
    
    pop {pc}
    
@=================================================================================================

pow:
    push {lr}
    
    cmp r1, #0
    moveq r0, #1
    bleq pow_return
    
    mov r3, #1
    pow_loop:
        mul r2, r3, r0
        mov r3, r2
        sub r1, #1
        cmp r1, #0
        bne pow_loop
    pow_loop_end:
        mov r0, r3
    pow_return:
        
    pop {pc}
    
@=================================================================================================
arm_utostr:
    push {lr}
    
    push {r0, r1}
    bl number_of_digities               @calculates number_of_digities
    mov r2, r0                          @store number_of_digities in r2
    pop {r0, r1}
    
    add r1, r1, r2                      @goes to string end
    mov r3, #0                          @puts '/0' in r3
    strb r3, [r1], #-1                  @stores '/0' to string end
    
    arm_utostr_loop:
        push {r0, r1, r2}
        mov r1, #10
        bl remain
        mov r3, r0                      @stores remain in r3
        pop {r0, r1, r2}
        
        add r3, r3, #48                 @48 represents '0' in ASCII
        strb r3, [r1], #-1              @stores r3 to string
        
        push {r1, r2, r3}
        mov r1, #10
        bl division                     @r0 = r0 / 10
        pop {r1, r2, r3}
        
        cmp r0, #0                      @determines if no more digities left
        bne arm_utostr_loop
    arm_utostr_loop_end:
    
    pop {pc}
    
@=================================================================================================
arm_utostr_hex:
    push {lr}
    
    push {r0, r1}
    bl number_of_digities_hex           @calculates number_of_digities
    mov r2, r0                          @store number_of_digities in r2
    pop {r0, r1}
    
    add r1, r1, r2                      @goes to string end
    mov r3, #0                          @puts '/0' in r3
    strb r3, [r1], #-1                  @stores '/0' to string end
    
    arm_utostr_hex_loop:
        push {r0, r1, r2}
        mov r1, #16
        bl remain
        mov r3, r0                      @stores remain in r3
        pop {r0, r1, r2}
        
        cmp r3, #9
        bgt treat_hex
        
        add r3, r3, #48                 @48 represents '0' in ASCII
        strb r3, [r1], #-1              @stores r3 to string
        b treat_hex_end
        
        treat_hex:
            sub r3, r3, #10             @treats abcdef
            add r3, #97
            strb r3, [r1], #-1          @stores r3 to string
        treat_hex_end:
        
        push {r1, r2, r3}
        mov r1, #16
        bl division                     @r0 = r0 / 10
        pop {r1, r2, r3}
        
        cmp r0, #0                      @determines if no more digities left
        bne arm_utostr_hex_loop
    arm_utostr_hex_end:
    
    pop {pc}    

@=================================================================================================
division:                               @ r0 = r0 / r1 (integer division)
    push {lr}
    cmp r0, r1
    movlt r2, #0
    blt division_loop_end       
    
    mov r2, #0
    division_loop:
        sub r0, r0, r1
        add r2, r2, #1
        cmp r0, r1
        bge division_loop
    division_loop_end:
    mov r0, r2
    pop {pc}

@=================================================================================================
remain:                                 @r0 =  r0 % r1
    push {lr}
    
    push {r0, r1}
    bl division
    mov r2, r0
    pop {r0, r1}
    
    mul r3, r1, r2
    
    sub r0, r0, r3
    
    pop {pc}
    
@=================================================================================================
number_of_digities:
    push {lr}
    
    mov r1, #10
    mov r2, #0
    number_of_digities_loop:
        push {r1, r2, r3}
        bl division
        pop {r1, r2, r3}
        cmp r0, #0
        addgt r2, r2, #1
        blgt number_of_digities_loop
    number_of_digities_loop_end:
    add r2, r2, #1
    mov r0, r2 
    pop {pc}
    
@=================================================================================================
number_of_digities_hex:
    push {lr}
    
    mov r1, #16
    mov r2, #0
    number_of_digities_hex_loop:
        push {r1, r2, r3}
        bl division
        pop {r1, r2, r3}
        cmp r0, #0
        addgt r2, r2, #1
        blgt number_of_digities_loop
    number_of_digities_hex_loop_end:
    add r2, r2, #1
    mov r0, r2 
    pop {pc}
        
    
    