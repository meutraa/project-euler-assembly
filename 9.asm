%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define loop 1000000

section .text
    global _start

_start:
    mov rsi, loop

.again:
    dec rsi
    jz _end
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
    jmp .again

_end:
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
