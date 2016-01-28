%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define limit 1000

section .text
    global _start

_start:
    mov rcx, 5

.three:
    add rax, rbx
    add rbx, 3
    cmp rbx, limit
    jb .three

.five: 
    add rax, rcx
    add rcx, 5
    cmp rcx, limit
    jae _end
    add rax, rcx
    add rcx, 10
    cmp rcx, limit
    jb .five

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

