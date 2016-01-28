%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define low 99 ; exclusive
%define high 999

section .text
    global _start

_start:
    mov r10, low
    mov r12, 1	; our record

.incr10:
    mov r9, low
    cmp r10, high
    je _end
    inc r10
.incr9:
    cmp r9, high
    je .incr10
    inc r9
    mov rax, r9
    mul r10

    ; is rax a palidrome?
    mov rcx, rax ; save rax
    mov r11, 10  ; divisor
    xor rbx, rbx ; digit counter
.div:
    xor rdx, rdx
    div r11
    push rdx
    inc rbx
    cmp rax, 0
    jne .div
    ; else we have all stored digits
   
    cmp rbx, 5
    je .odd
.even:	; has six digits
    pop r13
    pop r14
    pop r15
    cmp r13, [rsp + 16]
    jne .faileven
    cmp r14, [rsp + 8]
    jne .faileven
    cmp r15, [rsp]
    jne .faileven
    add rsp, 24
    jmp .palidrome
.faileven:
    add rsp, 24
    jmp .incr9
.odd:	; has five digits
    pop r13
    pop r14
    cmp r13, [rsp + 16]
    jne .failodd
    cmp r14, [rsp + 8]
    jne .failodd
    add rsp, 24 
    jmp .palidrome
.failodd:
    add rsp, 24
    jmp .incr9

.palidrome:
    cmp rcx, r12
    cmova r12, rcx
    jmp .incr9

_end:
    mov rax, r12
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