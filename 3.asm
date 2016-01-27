%define SYS_EXIT 60
%define SYS_WRITE 1
%define stdout 1
%define x 600851475143

section .text
    global _start

_start:
    mov rbp, 1  ; index
    
.next:
    ;cmp rbp, qword x
    ;je _end
    add rbp, 2	; since our x is not divisable by evens
    mov rax, x
    xor rdx, rdx
    div rbp
    cmp rdx, 0
    jnz .next

    ; here if x divides by rbp without remainder
    ; is rax a prime?
    push rax
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]

    ; TODO could check both factors found here for primality.
    pop rbx	 ; rbx is sqrt(rcx)
    mov rcx, rax ; rcx is our value to check
    mov r10, 1

.loop:
    inc r10
    mov rax, rcx
    xor rdx, rdx
    div r10
    cmp rdx, 0
    je .next
    cmp r10, rbx
    jne .loop
    
    mov rax, rcx
    call printrax  
_end:
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
