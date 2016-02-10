%include "print.asm"
%include "timer.asm"
%include "prime.asm"
%include "exit.asm"

%define max 2000000

section .text
    global _start

_start:
    time_start
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
    time_save rax
    print rax
    print rdi
    call _exit
