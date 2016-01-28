%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define limit 4000000
%define end 100000000 ; run 100,000,000 times

section .text
    global _start

_start:
    mov r14, limit

.again: 
    inc rdx
    cmp rdx, end
    je _end
    xor rax, rax
    mov r12, 1
    mov r13, 2

.loop:
    add rax, r13
    mov r11, r13 ; r11 = 2
    add r13, r12 ; r13 = 3
    mov r12, r13 ; r12 = 3
    add r13, r11 ; r13 = 5
    mov r11, r13 ; r11 = 5
    add r13, r12 ; r13 = 8
    mov r12, r11
    cmp r13, r14
    jb .loop
    jmp .again
 
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
