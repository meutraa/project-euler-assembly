%include "print.asm"
%include "timer.asm"
%include "prime.asm"
%include "exit.asm"

%define x 600851475143

section .text
    global _start

_start:
    time_start
    mov rdi, x
    mov rbp, 1 

    push rdi
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]
    pop rsi

.next:
    cmp rbp, rsi
    jae _end
    add rbp, 2	; since our x is not divisable by evens
    mov rax, rdi
    xor rdx, rdx
    div rbp
    cmp rdx, 0
    jne .next

    ; rbp & rax are divisors of rdi
    mov rax, rbp
    call _isprime
    cmp rdx, 1
    jne .next
    mov rbx, rbp
    jmp .next

_end:
    time_save rax
    print rax
    print rbx
    call _exit
