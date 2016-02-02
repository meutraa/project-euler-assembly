%define SYS_WRITE 1
%define stdout 1

_print:
    push rbp
    push rax
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12

    mov rax, rbx
    mov r9, 10
    mov r12, 1
    push 0Ah

.div:
    xor rdx, rdx
    div r9
    add rdx, '0'
    inc r12
    push rdx 
    cmp rax, 0
    jne .div
    
    mov rax, SYS_WRITE
    mov rdi, stdout
    mov rdx, 1 

.print: 
    mov rsi, rsp
    syscall
    add rsp, 8
    dec r12
    jnz .print

    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rax
    pop rbp
ret
