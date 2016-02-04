%include "print.asm"
%include "exit.asm"

%define max 1000000

section .text
    global _start

_start:
    cmp rdi, r8
    cmova r8, rdi
    cmova r9, rsi

    inc rsi
    cmp rsi, max
    je _end
    mov rbx, rsi
    xor rdi, rdi	; path length

.test:
    tzcnt rcx, rbx
    shr rbx, cl
    add rdi, rcx
    cmp rbx, 1
    jbe _start
    mov rbp, rbx
    inc rbp
    shr rbp, 1
    add rbx, rbp
    add rdi, 2
    jmp .test

_end:
    print r9
    call _exit
