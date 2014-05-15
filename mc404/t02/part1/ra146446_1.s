.globl arm_strtou

@.extern printf


@.data
@  print_mask: .asciz "%c\n" @máscara do printf

.text
arm_strtou:
    @movb r1, [r0]
    
    @ldr r0, =print_mask
    @bl printf
    mov r0, #25