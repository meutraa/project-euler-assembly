%include "print.asm"
%include "exit.asm"

%define low 99 ; exclusive
%define high 999

section .text
    global _start

_start:
    mov r10, low
    mov r12, 1	; our record

.incr10:
    mov r9, low
    cmp r10, high
    je _end
    inc r10
.incr9:
    cmp r9, high
    je .incr10
    inc r9
    mov rax, r9
    mul r10

    ; is rax a palidrome?
    mov rcx, rax ; save rax
    mov r11, 10  ; divisor
    xor rbx, rbx ; digit counter
.div:
    xor rdx, rdx
    div r11
    push rdx
    inc rbx
    cmp rax, 0
    jne .div
    ; else we have all stored digits
   
    cmp rbx, 5
    je .odd
.even:	; has six digits
    pop r13
    pop r14
    pop r15
    cmp r13, [rsp + 16]
    jne .faileven
    cmp r14, [rsp + 8]
    jne .faileven
    cmp r15, [rsp]
    jne .faileven
    add rsp, 24
    jmp .palidrome
.faileven:
    add rsp, 24
    jmp .incr9
.odd:	; has five digits
    pop r13
    pop r14
    cmp r13, [rsp + 16]
    jne .failodd
    cmp r14, [rsp + 8]
    jne .failodd
    add rsp, 24 
    jmp .palidrome
.failodd:
    add rsp, 24
    jmp .incr9

.palidrome:
    cmp rcx, r12
    cmova r12, rcx
    jmp .incr9

_end:
    mov rbx, r12
    call _print
    call _exit
