_coprime:
   bt rax, 0
   jc .loop
   bt rdx, 0
   jc .loop
   xor rdx, rdx
   jmp .end

.loop:
   bt rax, 0
   jc .beven
   tzcnt rcx, rax
   shr rax, cl
.beven:
   bt rdx, 0
   jc .amore
   tzcnt rcx, rdx
   shr rdx, cl
.amore:
   cmp rax, rdx
   je .checkone
   jl .bmore
   sub rax, rdx
   shr rax, 1
   jmp .loop
.bmore:
   sub rdx, rax
   shr rdx, 1
   jmp .loop

.checkone:
   cmp rax, 1
   je .end
   xor rdx, rdx
.end:
ret

