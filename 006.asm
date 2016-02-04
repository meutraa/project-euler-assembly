%include "print.asm"
%include "exit.asm"

%define max 100

section .text
    global _start

_start:
    mov rcx, max

.sum:
    add rsi, rcx ; rsi - sum
    mov rax, rcx
    mul rax
    add rdi, rax ; rdi - sum of squares
    dec rcx
    jnz .sum

    mov rax, rsi
    mul rsi
    sub rax, rdi

_end:
    print rax
    call _exit
