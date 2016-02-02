%include "print.asm"
%include "exit.asm"

%define loop 2

%macro product 1
    call getdec
    mov rax, rbx
    add rsi, %1
    call getdec
    mul rbx
    add rsi, %1 
    call getdec
    mul rbx
    add rsi, %1
    call getdec
    mul rbx
    sub rsi, (%1*3 + 8)
    cmp rax, r13
    cmova r13, rax
%endmacro

%macro lastrows 0
    mov rax, rsi
    sub rax, rbp
    cmp rax, 680
%endmacro

section .data
    grid: db  "08022297381500400075040507785212507791084949994017811857608717409843694804566200814931735579142993714067538830034913366552709523046011426924685601325671370236912231167151676389419236542240402866331380244732609903450244753353783684203517125032988128642367102638406759547066183864706726206802621220956394396308409166499421245558056673992697177878968314883489637221362309750076442045351400613397343133957817532822753167159403800462161409535692163905429635314755588824001754243629855786560048357189070544443744602158515417581980816805944769287392138652177704895540045208839735991607975732162626793327986688366887576220720346336746551232639353690442167338253911249472180846293240627636206936417230238834629969826759857404361620733529783190017431497148868116235705540170547183515469169233486143520189196748"

section .text
    global _start

_start:
    mov r8, 40
    mov r9, 10
    mov rcx, loop
    mov rbp, grid	; base
    mov rdi, rbp	; max
    add rdi, 792

.again:
    dec rcx
    jz _end
    mov rsi, grid	; index
    jmp .horizontal

.next:
    add rsi, 1
    cmp rsi, rdi
    ja .again

.horizontal:
    ; get remainder mod 40
    mov rax, rsi
    sub rax, rbp
    div r8
    mov r15, rdx	; save remainder for later
    
    ; check if rsi%40 <= 32
    cmp r15, 32
    ja .diagonal_left

    product 0

.diagonal_right:
    lastrows 
    jae .next

    product 40

.diagonal_left:
    lastrows
    jae .next
    cmp r15, 6
    jb .down

    product 36

.down:
    ; already checked for >= 340
    product 38
    jmp .next
   
_end:
    mov rbx, r13
    call _print  
    call _exit

; put in rbx, value at rsi
getdec:
    push rax
    xor rax, rax
    lodsb
    sub rax, 48 
    mul r9
    mov rbx, rax
    lodsb
    add rbx, rax
    sub rbx, 48
    pop rax
    ret
