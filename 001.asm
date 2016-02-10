%include "print.asm"
%include "timer.asm"
%include "exit.asm"

%define limit 1000

section .text
    global _start

_start:
    time_start
    mov rcx, 5

.three:
    add rax, rbx
    add rbx, 3
    cmp rbx, limit
    jb .three

.five: 
    add rax, rcx
    add rcx, 5
    cmp rcx, limit
    jae _end
    add rax, rcx
    add rcx, 10
    cmp rcx, limit
    jb .five

_end:
    time_save rbx
    print rbx
    print rax
    call _exit
