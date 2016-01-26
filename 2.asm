%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define limit 4000000

section .text
    global _start

_start:
    mov r11, 1

.inc:
    bt r11, 0
    jc .skip
    add rax, r11

.skip:
    mov r13, r12
    mov r12, r11
    add r11, r13
    cmp r11, limit
    jb .inc
 
    call printrax

_end:
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
