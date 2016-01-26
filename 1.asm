%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define limit 1000

section .bss
    store: resb limit

section .text
    global _start

_start:
    
.three:
    add rbx, 3
    cmp rbx, limit
    jae .next
    mov byte [store + rbx], 1 
    jmp .three 

.next:
    xor rbx, rbx

.five: 
    add rbx, 5
    cmp rbx, limit
    jae .sum
    mov byte [store + rbx], 1
    jmp .five


.sum:
    inc r12
    cmp r12, limit
    je _end
    cmp byte [store + r12], 0
    je .sum
    add rax, r12
    jmp .sum
 
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

