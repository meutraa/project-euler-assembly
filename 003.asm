%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define x 600851475143
%define end 2

section .text
    global _start

_start:
    mov rdi, x
    mov r12, end

    push rdi
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]
    pop rsi
.loop:
    dec r12
    jz _end
    mov rbp, 1 
.next:
    cmp rbp, rsi
    jae .loop
    add rbp, 2	; since our x is not divisable by evens
    mov rax, rdi
    xor rdx, rdx
    div rbp
    cmp rdx, 0
    jne .next

    ; here if x divides by rbp without remainder
    call isprime
    cmp rdx, 1
    cmove r11, rax
    je .loop
    mov rax, rbp ; check other divisor
    call isprime
    cmp rdx, 1
    cmove r11, rax
    jmp .next

_end:
    mov rax, r11
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
