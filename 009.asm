%include "print.asm"
%include "timer.asm"
%include "exit.asm"

section .text
    global _start

_start:
    time_start
    mov rbx, 1

.loop:
    inc rbx		; rbx 4
    ; calculate rcx
    mov rcx, 500	; rcx 500
    mov rax, rbx	; rax 4
    mul rax		; rax 16
    sub rcx, rax	; rcx 484
    xor rdx, rdx	; rdx 0
    mov rax, rcx	; rax 484
    div rbx		; rax 121
    cmp rdx, 0
    jne .loop
    cmp rbx, rax
    jle .loop
    mov rbp, rax

    ; rbx = m & rbp = n
    ; a = m2 - n2
    mov rax, rbx
    mul rbx
    mov r8, rax ; r8 m2

    mov rax, rbp
    mul rbp
    mov r9, rbp ; r9 n2

    mov rax, rbx
    mul rbp
    shl rax, 1	; rax = b

    mov rdi, r8
    sub rdi, r9	; rdi = a

    add r8, r9	; r8 = c
    mul rdi
    mul r8

_end:
    time_save rbx
    print rbx
    print rax
    call _exit
