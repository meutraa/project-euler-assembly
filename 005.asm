%include "print.asm"
%include "exit.asm"

%define x 20

section .text
    global _start

_start:
    mov rcx, 0

.inc:
    mov rbx, x
    add rcx, rbx
.onc:
    xor rdx, rdx
    mov rax, rcx
    div rbx
    cmp rdx, 0
    jne .inc
    dec rbx
    jnz .onc

_end:
    print rcx
    call _exit
