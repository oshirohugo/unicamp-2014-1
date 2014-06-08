.extern execute
.extern run_registers

main:
push {lr}
bl execute
bl run_registers

mov r0, #0
pop {pc}
