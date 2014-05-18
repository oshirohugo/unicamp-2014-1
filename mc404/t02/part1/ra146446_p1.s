.globl arm_strtou
.globl arm_utostr
.globl arm_strlen
.globl arm_strcmp
.globl arm_memcpy
    
.text

@=================================================================================================
arm_strtou:
    push {lr}
    
    push {r0}
    bl arm_strlen                       @calculates string len
    mov r1, r0
    pop {r0}
    
    cmp r1, #2                          @string_len == 2 ?
    bllt arm_strtou_dec                 @if less use decimal approach (can't be haxadecimal)
    bllt arm_strtou_return              
    
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
    