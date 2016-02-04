%include "print.asm"
%include "prime.asm"
%include "exit.asm"

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
    call _isprime
    cmp rdx, 1
    jne .loop
    inc rdi
    cmp rdi, rbp
    je _end
    jmp .loop

_end:
    print rsi
    call _exit
