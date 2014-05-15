.globl troca_endianness_imprime
.extern printf

data:
    print_mask: .asciz "%u\n"                           @máscara do printf
  
troca_endianness_imprime:
    push {r4, r5, r6, r7, lr}
    mov r6, #0                                          @initializes counter

while:
    ldr r1, [r0]                                        @copy r0 to r1
    mov r1, r1, lsl #24                                 @shift r1 left, so 4 turns 1
 
    ldr r2, [r0]                                        @copy r0 to r2
    mov r2, r2, lsl #8                                  @shift r2 left, so 3 turns 2
    and r2, r2, #0b00000000111111110000000000000000     @filter bits with mask
    
    ldr r3, [r0]                                        @copy r0 to r3
    mov r3, r3, lsr #8                                  @shift r1 left, so 2 turns 3
    and r3, r3, #0b00000000000000001111111100000000     @filter bits with mask
    
    ldr r4, [r0]                                        @copy r0 to r4
    mov r4, r4, lsr #24                                 @shift r1 left, so 1 turns 4
    and r4, r4, #0b00000000000000000000000011111111     @filter bits with mask
    
    orr r5, r1, r2                                      @mount number with an logic or and stores in r5
    orr r5, r5, r3
    orr r5, r5, r4
    
    cmp r6, #0
    beq if                                              @if first number is beaing read
    bne end_if                                          @if not do nothing
    if:
        mov r7, r5                                      @sets number of repetions
    end_if:
        
    add r6, r6, #1                                      @increments counter
    add r0, r0, #4                                      @increments memory address to point to next number
    
    push {r0}                                           @stacks r0 to keep its value
    ldr r0, =print_mask                                 @loads mask in ro
    mov r1, r5                                          @loads number transformad to r1
    bl printf                                           @prints to screen
    pop {r0}                                            @pops r0
       
    cmp r6, r7                                          @checks if all numbers where processed
    ble while                                           @repeats process if remains numbers
    
    pop {r4, r5, r6, r7, pc}
    
    