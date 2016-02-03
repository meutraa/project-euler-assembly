; destroys rcx, rdx, r10
; if rax is prime, rdx set to 1
_isprime:
    cmp rax, 1
    jle .fail
    bt rax, 0
    jc .odd

.fail:
    xor rdx, rdx
    jmp .end

.odd:
    mov rcx, rax
    mov r10, 1
    push rbx
    
    cmp rax, 50
    ja .large
    mov rbx, rax
    jmp .loop

.large:
    push rax
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]
    pop rbx      ; rbx is sqrt(rcx)

.loop:
    add r10, 2
    mov rax, rcx
    xor rdx, rdx
    div r10
    cmp rdx, 0
    je .end
    cmp r10, rbx
    jbe .loop
    mov rdx, 1
.end:
    pop rbx
    ret
