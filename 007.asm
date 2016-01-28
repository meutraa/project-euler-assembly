%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define x 10001

section .text
    global _start

_start:
    mov rdi, 1 ; prime count
    mov rsi, 1 ; index
    mov rbp, x

.loop:
    add rsi, 2 
    mov rax, rsi
    call isprime
    cmp rdx, 1
    jne .loop
    inc rdi
    cmp rdi, rbp
    je _end
    jmp .loop

_end:
    mov rcx, rsi
    call printrax  
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

; preserves rax, if rax is prime, rdx set to 1
isprime:
    push rax
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]

    pop rbx	 ; rbx is sqrt(rcx)
    mov rcx, rax ; rcx is our value to check
    mov r10, 1

.loop:
    inc r10
    mov rax, rcx
    xor rdx, rdx
    div r10
    cmp rdx, 0
    je .end
    cmp r10, rbx
    jne .loop
    mov rdx, 1
.end:
    mov rax, rcx
    ret

printrax:
    mov r9, 10
    mov rbp, rsp
    push 0Ah

.div:
    xor rdx, rdx
    div r9
    add rdx, '0'
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
    cmp rsp, rbp
    jne .print
ret
