.set GRAVITY_CONST 0xA
.set MAX 0x9

.org 0x000
    LOAD MQ,M(var_x)
    MUL M(gravity)        
    LOAD MQ
    STORE M(var_prod)
    
    LOAD M(var_prod)
    RSH
    STORE M(var_k)

laco:    

    LOAD M(var_prod)
    DIV M(var_k)
    LOAD MQ
    ADD M(var_k)
    RSH
    STORE M(var_k)
    
    LOAD M(var_i)
    SUB M(const1)
    STORE M(var_i)
    JUMP+ M(laco)
    
    LOAD M(var_k)
    
    
    
.org 0x14
const1: .word 0x1
gravity: .word GRAVITY_CONST
var_x: .word 0x1
var_k: .word 0x0
var_prod: .word 0x0
var_i: .word MAX
var_max: .word MAX
    
    
