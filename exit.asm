%define SYS_EXIT 60

section .text
    global _start

_exit:
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
