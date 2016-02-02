; destroys rbx, rcx, rdx, r10
; preserves rax, if rax is prime, rdx set to 1
_isprime:
    cmp rax, 1
    jle .fail
    bt rax, 0
    jc .odd
.fail:
    xor rdx, rdx
    jmp .end

.odd:
    cmp rax, 50
    jae .large
    mov rbx, rax
    mov rcx, rax
    jmp .loop

.large:
    push rax
    fild qword [rsp]
    fsqrt
    fistp qword [rsp]

    pop rbx      ; rbx is sqrt(rcx)
    mov rcx, rax ; rcx is our value to check
    mov r10, 1

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
    mov rax, rcx
    ret
