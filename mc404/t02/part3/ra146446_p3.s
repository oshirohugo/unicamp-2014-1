.globl execute

.globl read_instruction
.globl take_op_1
.globl take_op_2
.globl take_address_1
.globl take_address_2
.globl read_PC
.globl increment_PC
.globl read_arch_PC

.globl internal_PC

.extern IAS_MEM_MAP
.extern PC
.extern AC
.extern MQ

.align 4

.data
    instruction:        .space 5
    op:                 .space 4
    address:            .space 4
    aux:                .space 4
    internal_PC:        .word 0
    
    mem_content:        .space 5
    
    five_bytes:         .space 5
    aux_five:           .space 5
    
.align 4

.text
@=================================================================================================
execute:
    push {lr}
    
    bl read_instruction
    
    bl PC_is_left               @r0 contains 1 if instruction is left, and 0 otherwise
    cmp r0, #0
    beq treat_right_instruction
    
    treat_left_instruction:
        bl take_op_1                
        bl take_address_1
        b execute_op
    
    treat_right_instruction:
        bl take_op_2                
        bl take_address_2
    
    execute_op:
        mov r1, #0              @return value
    
        ldr r0, =op
        ldr r0, [r0]
        
        cmp r0, #0xA            @1 - LOAD MQ
        bne load_mq_case_end
        load_mq_case:
            bl load_mq
            b execute_op_end
        load_mq_case_end:    
        
        cmp r0, #0x9            @2 - LOAD MQ, M(X)
        bne load_mq_mx_case_end
        load_mq_mx_case:
            bl load_mq_mx
            cmp r0, #1
            beq execute_return
            b execute_op_end
        load_mq_mx_case_end:
        
        cmp r0, #0x21           @3 - STOR M(X)
        bne store_mx_case_end
        store_mx_case:
            bl store_mx
            cmp r0, #1
            beq execute_return
            b execute_op_end
        store_mx_case_end:
        
        cmp r0, #0x1            @4 - LOAD M(X)
        bne load_mx_case_end
        load_mx_case:
            bl load_mx
            cmp r0, #1
            beq execute_return
            b execute_op_end
        load_mx_case_end:
        
        cmp r0, #0x2            @5 - LOAD -M(X)
        bne load_neg_mx_case_end
        load_neg_mx_case:
            bl load_neg_mx
            cmp r0, #1
            beq execute_return
            b execute_op_end
        load_neg_mx_case_end:
        
        cmp r0, #0x3            @6 - LOAD |M(X)|
        bne load_abs_mx_case_end
        load_abs_mx_case:
            bl load_abs_mx
            cmp r0, #1
            beq execute_return
            b execute_op_end
        load_abs_mx_case_end:
        
        cmp r0, #0xD            @7 - JUMP M(X,0:19)
        bne jump_left_case_end
        jump_left_case:
            bl jump_left
            cmp r0, #1
            beq execute_return
            b execute_op_end
        jump_left_case_end:
        
        cmp r0, #0xE            @8 - JUMP M(X,20:39)
        bne jump_right_case_end
        jump_right_case:
            bl jump_right
            cmp r0, #1
            beq execute_return
            b execute_op_end
        jump_right_case_end:
        
        cmp r0, #0xF            @9 - JUMP+M(X,0:19)
        bne jump_left_plus_case_end
        jump_left_plus_case:
            bl jump_left_plus
            cmp r0, #1
            beq execute_return
            b execute_op_end
        jump_left_plus_case_end:
        
        cmp r0, #0x10           @10- JUMP+M(X,20:39)
        bne jump_right_plus_case_end
        jump_right_plus_case:
            bl jump_right_plus
            cmp r0, #1
            beq execute_return
            b execute_op_end
        jump_right_plus_case_end:
        
        cmp r0, #0x5            @11- ADD M(X)
        bne ias_add_case_end
        ias_add_case:
            bl ias_add
            cmp r0, #1
            beq execute_return
            b execute_op_end
        ias_add_case_end:
        
        cmp r0, #0x7            @12- ADD |M(X)|
        bne add_abs_case_end
        add_abs_case:
            bl add_abs
            cmp r0, #1
            beq execute_return
            b execute_op_end
        add_abs_case_end:
        
        cmp r0, #0x6            @13- SUB M(X)
        bne ias_sub_case_end
        ias_sub_case:
            bl ias_sub
            cmp r0, #1
            beq execute_return
            b execute_op_end
        ias_sub_case_end:
        
        cmp r0, #0x8            @14- SUB |M(X)|
        bne sub_abs_case_end
        sub_abs_case:
            bl sub_abs
            cmp r0, #1
            beq execute_return
            b execute_op_end
        sub_abs_case_end:
        
        cmp r0, #0xB            @15- MUL M(X) TODO
        bne ias_mul_case_end
        ias_mul_case:
            bl ias_mul
            b execute_op_end
        ias_mul_case_end:
        
        cmp r0, #0xC            @16- DIV M(X) TODO
        bne ias_div_case_end
        ias_div_case:
            bl ias_div
            b execute_op_end
        ias_div_case_end:
        
        cmp r0, #0x14           @17- LSH
        bne lsh_case_end
        lsh_case:
            bl lsh
            cmp r0, #1
            beq execute_return
            b execute_op_end
        lsh_case_end:
        
        cmp r0, #0x15           @18- RSH
        bne rsh_case_end
        rsh_case:
            bl rsh
            cmp r0, #1
            beq execute_return
            b execute_op_end
        rsh_case_end:
        
        cmp r0, #0x12           @19- STOR M(X,8:19)
        bne store_left_address_case_end
        store_left_address_case:
            bl store_left_address
            cmp r0, #1
            beq execute_return
            b execute_op_end
        store_left_address_case_end:
        
        cmp r0, #0x13           @20- STOR M(X,28:39)
        bne store_right_address_case_end
        store_right_address_case:
            bl store_right_address
            cmp r0, #1
            beq execute_return
            b execute_op_end
        store_right_address_case_end:
        
    execute_op_end:
        
    bl increment_PC
    
    bl read_PC                  @r0 contains PC value
    
    cmp r0, #1024               @verifies out of map
    moveq r0, #2
    movlt r0, #0
    b execute_return
    
    
    execute_return:
    
    
    pop {pc}
@=================================================================================================
@Reads instruction from IAS_MEM_MAP and stores in label 'instruction'
read_instruction:
    push {r4, lr}
    bl read_PC                          @r0 now contains PC
    ldr r1, =IAS_MEM_MAP
    add r1, r1, r0                      @displace IAS_MEM_MAP to point to right place
    ldr r2, =instruction                @r2 points to label where instruction will be placed
    mov r3, #5
    read_instruction_loop:
        cmp r3, #0
        beq read_instruction_loop_end
        ldrb r4, [r1], #1               @reads a byte from IAS_MEM_MAP
        strb r4, [r2], #1               @stores one byte in instruction: r2 = r4
        sub r3, r3, #1
        b read_instruction_loop
    read_instruction_loop_end:
    ldr r0, =instruction                @to debug
    ldr r0, [r0]
    rev r0, r0
    
    pop {r4, pc}
@=================================================================================================    
@Takes OP value from 'instruction' label and stores in label 'op_1' also return op in r0
take_op_1:
    push {lr}
    ldr r0, =instruction
    ldrb r0, [r0]
    ldr r1, =op
    strb r0, [r1]
    pop {pc}
@=================================================================================================    
take_op_2:
    push {lr}
    ldr r0, =instruction
    add r0, r0, #1
    ldr r0, [r0]    
    rev r0, r0
    
    mov r0, r0, lsr #12
    ldr r1, =0xff
    and r0, r0, r1

    ldr r1, =op
    strb r0, [r1]
    pop {pc}
@=================================================================================================    
take_address_1:
    push {lr}
    ldr r0, =instruction
    ldr r0, [r0]
    rev r0, r0

    mov r0, r0, lsr #12
    ldr r1, =0xfff
    and r0, r0, r1
    ldr r1, =address
    strb r0, [r1]
    pop {pc}
@=================================================================================================
take_address_2:
    push {lr}
    ldr r0, =instruction
    add r0, r0, #1
    ldr r0, [r0]
    rev r0, r0
    ldr r1, =0xfff
    and r0, r0, r1
    ldr r1, =address
    strb r0, [r1]
    pop {pc}
@=================================================================================================
read_PC:
    push {lr}
    ldr r0, =internal_PC
    ldr r0, [r0]
    mov r1, #2
    bl remain
    mov r1, r0
    ldr r0, =internal_PC
    ldr r0, [r0]
    cmp r1, #0
    beq treat_even_PC
    
    treat_odd_PC:
        sub r0, r0, #1
    treat_even_PC:
        mov r1, #2
        bl division                     @r0 will have PC value
        
    
    pop {pc}
@=================================================================================================
read_arch_PC:
    push {lr}
    ldr r0, =PC
    add r0, r0, #3
    
    push {r0}
    bl clean_aux
    pop {r0}
    
    ldr r1, =aux
    add r1, r1, #1                      @points to address end
    
    
    mov r2, #2
    read_arch_PC_loop:
        cmp r2, #0
        beq read_arch_PC_loop_end
        
        ldrb r3, [r0], #1
        strb r3, [r1], #-1
        
        sub r2, r2, #1
        b read_arch_PC_loop
    read_arch_PC_loop_end:
    
    ldr r0, =aux
    ldr r0, [r0]                        @return aux value
    
        
    pop {pc}
    
@=================================================================================================
increment_PC:
    push {r4, lr}
    ldr r0, =internal_PC
    ldr r0, [r0]
    
    add r0, r0, #1
    
    push {r0}
    
    ldr r1, =internal_PC
    str r0, [r1]               @stores new value of PC back to internal_PC
    
    bl sync_arch_PC
    
    pop {r4, pc}
    
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
clean_aux:
    push {lr}
    ldr r0, =aux
    mov r1, #0                  @put 0 in aux
    str r1, [r0]
    pop {pc}
@=================================================================================================
PC_is_left:
    push {lr}
    ldr r0, =internal_PC
    ldr r0, [r0]
    mov r1, #2
    bl remain
    mov r1, r0
    ldr r0, =internal_PC
    ldr r0, [r0]
    cmp r1, #0
    beq is_left
    
    is_right:
        mov r0, #0
        beq PC_is_left_return
    is_left:
        mov r0, #1
    
    PC_is_left_return:
        
    pop {pc}
@=================================================================================================
load_mem_content:
    push {r4, lr}
    
    ldr r0, =address
    ldr r0, [r0]
    
    ldr r1, =1023
    cmp r0, r1
    bgt out_of_memory_error
    
    ldr r1, =IAS_MEM_MAP
    add r1, r1, r0                      @displace IAS_MEM_MAP to point to right place
    ldr r2, =mem_content                @r2 points to label where mem_content will be placed
    mov r3, #5
    load_mem_content_loop:
        cmp r3, #0
        beq load_mem_content_loop_end
        ldrb r4, [r1], #1               @reads a byte from IAS_MEM_MAP
        strb r4, [r2], #1               @stores one byte in instruction: r2 = r4
        sub r3, r3, #1
        b load_mem_content_loop
    load_mem_content_loop_end:
    b load_mem_content_return
    
    out_of_memory_error:
        mov r0, #1                      @invalid address
        
    load_mem_content_return:
    
    pop {r4, pc}
    
@=================================================================================================
@ 1 - Transfer MQ cotent to AC register
load_mq:
    push {lr}
    ldr r0, =MQ
    ldr r1, =AC
    
    bl copy_5bytes
    
    mov r0, #0                  @always return OK!
    
    pop {pc}
@=================================================================================================
@ 2 - Transfer content of memory address X to MQ register
load_mq_mx:
    push {lr}
        
    mov r0, #0
    
    bl load_mem_content         @M(x) content now in mem_content label
    
    ldr r0, =mem_content
    ldr r1, =MQ
    
    bl copy_5bytes              @ [MQ] = [mem_content]
    mov r0, #0
    b load_mq_mx_return
    
    load_mq_mx_error:
        mov r0, #1
    
    load_mq_mx_return:
    
    pop {pc}
@=================================================================================================
@ 3 - Transfer content from register AC to address X
store_mx:
    push {lr}
    ldr r0, =address
    ldr r0, [r0]                @r0 contains address
    
    ldr r1, =1023
    cmp r0, r1
    bgt store_mx_error
    
    ldr r1, =IAS_MEM_MAP
    add r1, r1, r0
    
    ldr r0, =AC
    
    bl copy_5bytes              @[IAS_MEM_MAP(X)] = [AC]
    mov r0, #0
    b store_mx_return
    
    store_mx_error:
        mov r0, #1
    store_mx_return:
    
    pop {pc}
@=================================================================================================
@ 4 - Transfer content from memory address X to AC register
load_mx:
    push {lr}
    
    bl load_mem_content         @M(x) content now in mem_content label
    cmp r0, #1
    beq load_mx_error
    
    ldr r0, =mem_content
    ldr r1, =AC
    
    bl copy_5bytes              @[AC] = [M(X)]
    
    mov r0, #0
    b load_mx_return
    
    load_mx_error:
        mov r0, #1
    load_mx_return:
    
    pop {pc}
@=================================================================================================
@ 5 - Transfer negative of content from memory address X to AC register
load_neg_mx:
    push {lr}
    
    bl load_mem_content         @mem_content now contains address content
    cmp r0, #1
    beq load_neg_mx_error
    
    ldr r0, =mem_content
    bl negative_number          @five_bytes contains negative number of mem_content
    
    ldr r1, =AC                 @load adress to call bl copy_5bytes
    ldr r0, =five_bytes
    
    bl copy_5bytes              @copies r0 in r1, [r1] = [r0]
    
    mov r0, #0
    b load_neg_mx_return
    
    load_neg_mx_error:
        mov r0, #1
    load_neg_mx_return:
    
    pop {pc}
@=================================================================================================
@ 6 Transfer absolute value of content from memory address X to AC register
load_abs_mx:
    push {lr}
    
    bl load_mem_content         @mem_content now contains address content
    cmp r0, #1
    beq load_abs_mx_error
    
    ldr r0, =mem_content
    bl abs_5bytes               @five_bytes contains negative number of mem_content
    
    ldr r1, =AC                 @load adress to call bl copy_5bytes
    ldr r0, =five_bytes
    
    bl copy_5bytes              @copies r0 in r1, [r1] = [r0]
    
    mov r0, #0
    b load_abs_mx_return
    
    load_abs_mx_error:
        mov r0, #1
    load_abs_mx_return:
    
    pop {pc}
@=================================================================================================
@ 7 
jump_left:
    push {lr}
    ldr r0, =address
    ldr r0, [r0]
    
    ldr r1, =1023
    cmp r0, r1
    bgt jump_left_error
    
    mov r1, #2
    mul r0, r1                  @r0 = r0 x r1
    
    ldr r1, =internal_PC
    str r0, [r1]
    
    bl sync_arch_PC
    mov r0, #0
    b jump_left_return
    
    jump_left_error:
        mov r0, #1
        
    jump_left_return:
  
    pop {pc}
@=================================================================================================
@ 8
jump_right:
    push {lr}
    
    ldr r0, =address
    ldr r0, [r0]
    
    ldr r1, =1023
    cmp r0, r1
    bgt jump_right_error
    
    mov r1, #2
    mul r0, r1                  @r0 = r0 x r1
    add r0, r0, #1
    
    ldr r1, =internal_PC
    str r0, [r1]
    
    bl sync_arch_PC
     mov r0, #0
    b jump_right_return
    
    jump_right_error:
        mov r0, #1
        
    jump_right_return:
    
    pop {pc}
@=================================================================================================
@ 9 If number in AC register is non negative, jump to instruction in left side of word restrained
@ in X memory address
jump_left_plus:
    push {lr}
    ldr r0, =AC
    bl is_negative
    cmp r0, #1
    beq jump_left_plus_return
    
    bl jump_left
    
    jump_left_plus_return:
    
    pop {pc}
@=================================================================================================
@ 10 If number in AC register is non negative, jump to instruction in right side of word restrained
@ in X memory address
jump_right_plus:
    push {lr}
    
    push {lr}
    ldr r0, =AC
    bl is_negative
    cmp r0, #1
    beq jump_right_plus_return
    
    bl jump_right
    
    jump_right_plus_return:
    
    pop {pc}
@=================================================================================================
@ 11 - Sums value restrained in memory address X a puts value in AC 
ias_add:
    push {lr}
    bl load_mem_content         @number id in 'mem_content'
    cmp r0, #1
    beq ias_add_error
    
    ldr r0, =AC
    ldr r2, =mem_content
    
    bl add_5bytes               @result five_bytes
    
    @copies r0 to r1
    ldr r0, =five_bytes
    ldr r1, =AC
    bl copy_5bytes
    @AC now contains the result of adition! (or it should have)
    
    mov r0, #0
    b ias_add_return
    
    ias_add_error:
        mov r0, #1
    ias_add_return:
    
    pop {pc}
@=================================================================================================
@ 12 - Sums absolute of value restrained in memory address X a puts value in AC 
add_abs:
    push {lr}
    
    bl load_mem_content         @number id in 'mem_content'
    cmp r0, #1
    beq add_abs_error
    
    ldr r0, =mem_content
    bl abs_5bytes               @five_bytes now contains abs value of mem_content
    
    ldr r0, =five_bytes
    ldr r1, =mem_content
    bl copy_5bytes              @mem_content now have five_bytes
    
    ldr r0, =AC
    ldr r2, =mem_content
    bl add_5bytes               @result five_bytes
    
    @copies r0 to r1
    ldr r0, =five_bytes
    ldr r1, =AC
    bl copy_5bytes
    @AC now contains the result of adition! (or it should have)
    
    mov r0, #0
    b add_abs_return
    
    add_abs_error:
        mov r0, #1
    add_abs_return:
    
    
    pop {pc}
@=================================================================================================
@ 13 - Subtract value restrained in memory address X a puts value in AC 
ias_sub:
    push {lr}
    
    bl load_mem_content         @number id in 'mem_content'
    cmp r0, #1
    beq ias_sub_error
    
    ldr r0, =mem_content
    bl negative_number          @five_bytes contains result
    
    ldr r0, =five_bytes
    ldr r1, =mem_content
    bl copy_5bytes
    
    
    ldr r0, =AC
    ldr r1, =mem_content    
    bl add_5bytes               @result five_bytes
    
    @copies r0 to r1
    ldr r0, =five_bytes
    ldr r1, =AC
    bl copy_5bytes
    @AC now contains the result of adition! (or it should have)
    mov r0, #0
    b ias_sub_return
    
    ias_sub_error:
        mov r0, #1
    ias_sub_return:
    
    pop {pc}
@=================================================================================================
@ 14 - Subtract absolute of value restrained in memory address X a puts value in AC 
sub_abs:
    push {lr}
    
    bl load_mem_content         @number id in 'mem_content'
    cmp r0, #1
    beq sub_abs_error           @treats memory error
    
    ldr r0, =mem_content
    bl abs_5bytes               @five_bytes contains result
    
    ldr r0, =five_bytes
    ldr r1, =mem_content
    bl copy_5bytes
    
    ldr r0, =mem_content
    bl negative_number          @five_bytes contains result
    
    ldr r0, =five_bytes
    ldr r1, =mem_content
    bl copy_5bytes
    
    
    ldr r0, =AC
    ldr r1, =mem_content    
    bl add_5bytes               @result five_bytes
    
    @copies r0 to r1
    ldr r0, =five_bytes
    ldr r1, =AC
    bl copy_5bytes
    @AC now contains the result of adition! (or it should have)
    mov r0, #0
    b sub_abs_return 
    
    
    sub_abs_error:
        mov r0, #1
    sub_abs_return:
    
    pop {pc}
@=================================================================================================
@ 15
ias_mul:
    push {lr}
    pop {pc}
@=================================================================================================
@ 16
ias_div:
    push {lr}
    pop {pc}
@=================================================================================================
@ 17 - Displace bits from AC register to left
lsh:
    push {lr}
    
    ldr r0, =AC
    
    ldrb r1, [r0], #1
    mov r1, r1, lsl #1          @r1 contains the highest part
    
    ldrb r2, [r0]
    mov r2, r2, lsr #7          @r2 contains the highest bit prom 2nd bytes
    
    ldr r3, [r0]
    rev r3, r3
    mov r3, r3, lsl #1          @r3 contains the lowest bytes
    
    cmp r2, #1
    bne one_to_right_end
    
    one_to_right:
        ldr r0, =0x80
        and r1, r1, r0
    one_to_right_end:
    
    
    ldr r0, =AC
    ldrb r1, [r0], #1           @store first byte
    
    rev r3, r3
    ldr r3, [r0]                @stores rest
    
    mov r0, #0                  @always return OK
    
    pop {pc}
@=================================================================================================
@ 18 - Displace bits from AC register to right
rsh:
    push {lr}
    
    ldr r0, =AC
    
    ldrb r2, [r0]               @r2 ontains the most significant byte
    and r1, r2, #0b1            @r1 contains the low bit of higher byte
    
    mov r2, r2, lsr #1          @shift r2 to the right
    
    add r0, r0, #1
    ldr r0, [r0]                @loads 4 low bytes
    rev r0, r0                  @puts in big endian
    mov r0, r0, lsr #1
    
    cmp r1, #1
    bne one_to_left_end
    
    one_to_left:
        ldr r1, =0x80000000
        orr r0, r0, r1
    one_to_left_end:
    
    
    ldr r1, =AC                 @stores first part
    strb r2, [r1], #1
    
    rev r0, r0                  @back representation
    str r0, [r1]                @stores rest
    
    mov r0, #0                  @always return OK
    
    pop {pc}
@=================================================================================================
@ 19 - Move 12 bits from AC right to memory field from X word left
store_left_address:
    push {lr}
    mov r0, #0
    bl clean_aux
    
    ldr r0, =AC
    add r0, r0, #1
    ldr r0, [r0]
    rev r0, r0
    ldr r1, =0xfff
    and r0, r0, r1
    ldr r1, =aux                @aux contains 12 bits from AC right 
    strb r0, [r1]
    
    bl load_mem_content
    cmp r0, #1
    beq store_left_address_error
    
    ldr r0, =mem_content        @mem_content contains instruction to be modified
    ldr r0, [r0]
    rev r0, r0
    ldr r1, =0xff000fff         @mask to put address in right place
    and r0, r0, r1
    
    ldr r2, =aux
    ldr r2, [r2]
    mov r2, r2, lsl #20
    orr r0, r0, r2
    
    rev r0, r0
    
    ldr r1, =mem_content
    str r0, [r1]                @mem_content now contains mem altered
    
    ldr r0, =address
    ldr r0, [r0]
    
    ldr r1, =IAS_MEM_MAP
    add r1, r1, r0              @displace IAS_MEM_MAP to point to right place
    
    bl copy_5bytes              @substitute the new mem_content in the IAS_MEM_MAP
    
    mov r0, #0
    b store_left_address_return
    
    store_left_address_error:
        mov r0, #1
    store_left_address_return:
    
    pop {pc}
@=================================================================================================
@ 20 - 19 - Move 12 bits from AC right to memory field from X word right
store_right_address:
    push {lr}
    mov r0, #0
    
    bl clean_aux
    
    ldr r0, =AC
    add r0, r0, #1
    ldr r0, [r0]
    rev r0, r0
    ldr r1, =0xfff
    and r0, r0, r1
    ldr r1, =aux                @aux contains 12 bits from AC right 
    strb r0, [r1]
    
    bl load_mem_content
    cmp r0, #1
    beq store_right_address_error
    
    ldr r0, =mem_content        @mem_content contains instruction to be modified
    add r0, r0, #1
    ldr r0, [r0]
    rev r0, r0
    ldr r1, =0xfffff000         @mask to put address in right place
    and r0, r0, r1
    
    ldr r2, =aux
    ldr r2, [r2]
    orr r0, r0, r2
    
    rev r0, r0
    
    ldr r1, =mem_content
    str r0, [r1]                @mem_content now contains mem altered
    
    ldr r0, =address
    ldr r0, [r0]
    
    ldr r1, =IAS_MEM_MAP
    add r1, r1, r0              @displace IAS_MEM_MAP to point to right place
    
    bl copy_5bytes              @substitute the new mem_content in the IAS_MEM_MAP
    
    mov r0, #0
    b store_right_address_return
    
    store_right_address_error:
        mov r0, #1
    store_right_address_return:
    
    
    pop {pc}
@=================================================================================================
add_5bytes: @[five_bytes] = [r0] + [r1]
    push {r4, r5, lr}
    
    push {r0, r1}
    bl clean_five_byte
    pop {r0, r1}
    
    ldrb r2, [r0]               @take the most significant byte
    add r0, r0, #1              @take four less significant bytes
    ldr r0, [r0]
    rev r0, r0
    
    ldrb r3, [r1]               @take the most significant byte
    add r1, r1, #1              @take four less significant bytes
    ldr r1, [r1]
    rev r1, r1
    
    adds r4, r0, r1
    adc r5, r2, r3              @r5r4 now contains the number summed
    
    ldr r0, =five_bytes
    strb r5, [r0], #1           @stores most significant byte in 'five_bytes'
    
    rev r4, r4                  @put in big endian again
    str r4, [r0]                @stores in the last 4 bytes of five_bytes
    
    pop {r4, r5, pc}
@=================================================================================================
clean_five_byte:
    push {lr}
    ldr r0, =five_bytes
    mov r1, #0
    
    mov r2, #5
    clean_five_byte_loop:
        cmp r2, #0
        beq clean_five_byte_loop_end
        
        strb r1, [r0], #1    
        
        sub r2, r2, #1
    clean_five_byte_loop_end:
    
    pop {pc}

@=================================================================================================
negative_number: @put in five_bytes the negative representation of number address in r0
    push {r4, r5, pc}
    
    push {r0}
    bl clean_five_byte
    pop {r0}
    
    ldr r3, =five_bytes
    
    mov r1, #5
    negative_number_loop:
        cmp r1, #0
        beq negative_number_loop_end
        
        ldrb r2, [r0], #1
        eor r2, r2, #0xff
        strb r2, [r3], #1
        
        sub r1, r1, #1
        b negative_number_loop
    negative_number_loop_end:
    
    ldr r0, =five_bytes
    ldrb r1, [r0]       @load high part of the number 
    
    add r0, r0, #1      @load the low part 4 bytes
    ldr r2, [r0]
    rev r2, r2
    
    adds r4, r2, #1     @r4 contains low part
    adc r5, r1, #0      @r5 contains greater part
    
    
    ldr r0, =five_bytes
    strb r5, [r0], #1
    
    rev r4, r4
    str r4, [r0]
    
    
    pop {r4, r5, pc}
    
@=================================================================================================
copy_5bytes: @[r1] = [r0]
    push {lr}
    
    mov r2, #5
    
    copy_5bytes_loop:
        cmp r2, #0
        beq copy_5bytes_loop_end
        
        ldrb r3, [r0], #1
        strb r3, [r1], #1
        
        sub r2, r2, #1
        b copy_5bytes_loop
    copy_5bytes_loop_end:
    
    pop {pc}
    
@=================================================================================================
is_negative: @see if number with address in r0 is negative
    push {lr}
    
    ldrb r0, [r0]
    mov r0, r0, lsr #7
    
    pop {pc}    
@=================================================================================================
abs_5bytes: @put abs of number whose adress in r0 in five_bytes
    push {lr}
    
    push {r0}
    bl is_negative
    mov r1, r0
    pop {r0}
    
    cmp r1, #1
    bne treat_positive_abs
    
    treat_negative_abs:
        bl negative_number      @five_bytes contains negative representation of [r0]
        b return_abs_5bytes
    treat_positive_abs:
        ldr r1, =five_bytes
        bl copy_5bytes
        
    return_abs_5bytes:
    
    push {pc}    

@=================================================================================================
sync_arch_PC:
    push {r4, lr}
    
    mov r0, #0
    
    bl read_PC                  @r0 contains correct PC value
    
    push {r0-r1}
    bl clean_aux
    pop {r0-r1}
    
    ldr r1, =aux
    str r0, [r1]                @stores PC actual value in aux

    ldr r2, =PC
    add r2, r2, #4              @points to address end to store PC bytes
    
    mov r3, #2                  @initialize counter    
    increment_PC_loop:
        cmp r3, #0
        beq increment_PC_loop_end
        
        ldrb r4, [r1], #1
        strb r4, [r2], #-1
        
        sub r3, r3, #1
        b increment_PC_loop
    increment_PC_loop_end:
    
    pop {r4, pc}

