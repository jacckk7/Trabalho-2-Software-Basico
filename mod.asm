section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32

    global op_mod

op_mod:
    push ebp
    mov ebp, esp

    sub esp, 4              ;resevar dword na pilha

    cmp [chosenPrecision], byte 31h
    je op_mod32

    call ler_int_16
    mov [esp], eax

    call ler_int_16
    mov ebx, eax
    mov eax, dword [esp]

    cmp eax, 0
    jl first_neg_mod

    xor edx, edx
    jmp do_mod
first_neg_mod:
    mov edx, dword -1

do_mod:
    idiv ebx

    jmp fim_op_mod

op_mod32:
    call ler_int_32         ;le primeiro numero ->eax
    mov [esp], eax

    call ler_int_32

    mov ebx, eax
    mov eax, dword [esp]

    cmp eax, 0
    jl first_neg_mod_32

    xor edx, edx
    jmp do_mod_32
first_neg_mod_32:
    mov edx, dword -1

do_mod_32:
    idiv ebx

fim_op_mod:
    mov eax, edx
    add esp, 4
    pop ebp
    ret