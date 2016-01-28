%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define max 2000000

section .text
    global _start

_start:
    mov rsi, max ; index

.loop:
    dec rsi
    jz _end
    mov rax, rsi
    call isprime
    cmp rdx, 1
    jne .loop
    add rdi, rax
    jmp .loop

_end:
    mov rax, rdi
    call printrax  
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

; preserves rax, if rax is prime, rdx set to 1
isprime:
    cmp rax, 1
    jle .fail
    bt rax, 0
    jc .odd
.fail:
    xor rdx, rdx
    jmp .end

.odd: 
    cmp rax, 50
    jae .large
    mov rbx, rax
    mov rcx, rax
    jmp .loop

.large:
    push rax
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]

    pop rbx	 ; rbx is sqrt(rcx)
    mov rcx, rax ; rcx is our value to check
    mov r10, 1

.loop:
    add r10, 2
    mov rax, rcx
    xor rdx, rdx
    div r10
    cmp rdx, 0
    je .end
    cmp r10, rbx
    jbe .loop
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
