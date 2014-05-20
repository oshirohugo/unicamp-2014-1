.globl get_command
.globl run_command

.globl arm_getline
.globl print_string

.extern arm_strtou
.extern arm_utostr
.extern arm_strlen
.extern arm_strcmp
.extern arm_memcpy

.data
    read_line:  .space 100
    print_line: .space 100
    

.text
arm_getline:
    push {r7, lr}
    mov r0, #0x0        @reads from stdin
    ldr r1, =read_line  @loads read line address
    mov r2, #30        @reads a maximum of 100 bytes
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
