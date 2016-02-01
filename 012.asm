%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define divisors  500	; plus 1 for the first with over n + 1
%define max ((divisors + 2)>>1)

section .text
    global _start

_start:

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
    mov rax, rbx
    call printrax  
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

printrax:
    mov r9, 10
    mov rbp, rsp
    push 0Ah

.div:
    xor rdx, rdx
    div r9
    add rdx, '0'
    push rdx 
    cmp rax, 0
    jne .div
    
    mov rax, SYS_WRITE
    mov rdi, stdout
    mov rdx, 1 

.print: 
    mov rsi, rsp
    syscall
    add rsp, 8
    cmp rsp, rbp
    jne .print
ret
