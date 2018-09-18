%include "print.asm"
%include "timer.asm"
%include "exit.asm"

%define divisors  500	; plus 1 for the first with over n + 1
%define max ((divisors + 2)>>1)

section .text
    global _start

_start:
    time_start

.next:
    cmp rbp, max
    ja _end

    ; next triangle number
    inc r8
    add rbx, r8
    bt rbx, 0
    jc .next

    xor rbp, rbp
    push rbx
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]
    pop rcx

.loop:
    dec rcx
    jz .next
    xor rdx, rdx
    mov rax, rbx
    div rcx
    cmp rdx, 0
    jne .loop
    inc rbp
    jmp .loop

_end:
    time_save rax
    print rax
    print rbx
    call _exit
