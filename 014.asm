%include "print.asm"
%include "timer.asm"
%include "exit.asm"

%define max 1000000

section .text
    global _start

_start:
    time_start

.begin:
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
    jbe .begin 
    mov rbp, rbx
    inc rbp
    shr rbp, 1
    add rbx, rbp
    add rdi, 2
    jmp .test

_end:
    time_save rax
    print rax
    print r9
    call _exit
