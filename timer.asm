%macro time_save 0
    mov [time_res + 0], rax
    mov [time_res + 8], rcx
    mov [time_res + 16], rdx
%endmacro

%macro time_load 0
    mov rax, [time_res + 0]
    mov rcx, [time_res + 8]
    mov rdx, [time_res + 16]
%endmacro

%macro time_start 0
    call time_init
%endmacro

%macro time_save 1
    call ret_time
    mov %1, qword [time_val + 0]
%endmacro

section .bss
    time_begin resq 1
    time_val resq 1
    time_res resq 3

section .text

time_init:
    time_save
    rdtscp
    ; high bits are zeroed in 64bit mode
    ; high order bits in edx, low bits in eax
    shl rdx, 32
    add rdx, rax
    mov [time_begin + 0], rdx
    time_load
    ret

ret_time:
    time_save
    rdtscp
    shl rdx, 32
    add rdx, rax
    sub rdx, qword [time_begin + 0]
    mov [time_val + 0], rdx
    time_load
    ret
