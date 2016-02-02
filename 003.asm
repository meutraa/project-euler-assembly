%include "print.asm"
%include "prime.asm"
%include "exit.asm"

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
    call _isprime
    cmp rdx, 1
    cmove r11, rax
    je .loop
    mov rax, rbp ; check other divisor
    call _isprime
    cmp rdx, 1
    cmove r11, rax
    jmp .next

_end:
    mov rbx, r11
    call _print
    call _exit
