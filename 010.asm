%include "print.asm"
%include "prime.asm"
%include "exit.asm"

%define max 2000000

section .text
    global _start

_start:
    mov rsi, max ; index

.loop:
    dec rsi
    jz _end
    mov rax, rsi
    call _isprime
    cmp rdx, 1
    jne .loop
    add rdi, rax
    jmp .loop

_end:
    mov rbx, rdi
    call _print  
    call _exit
