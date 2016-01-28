%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define max 100

section .text
    global _start

_start:
    mov rcx, max

.sum:
    add rsi, rcx ; rsi - sum
    mov rax, rcx
    mul rax
    add rdi, rax ; rdi - sum of squares
    dec rcx
    jnz .sum

    mov rax, rsi
    mul rsi
    sub rax, rdi

_end:
    call printrax
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

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
