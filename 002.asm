%include "print.asm"
%include "exit.asm"

%define limit 4000000
%define end 2 ; repeat 

section .text
    global _start

_start:
    mov r14, limit

.again: 
    inc rdx
    cmp rdx, end
    je _end
    xor rax, rax
    mov r12, 1
    mov r13, 2

.loop:
    add rax, r13
    mov r11, r13 ; r11 = 2
    add r13, r12 ; r13 = 3
    mov r12, r13 ; r12 = 3
    add r13, r11 ; r13 = 5
    mov r11, r13 ; r11 = 5
    add r13, r12 ; r13 = 8
    mov r12, r11
    cmp r13, r14
    jb .loop
    jmp .again
 
_end:
    mov rbx, rax
    call _print
    call _exit

