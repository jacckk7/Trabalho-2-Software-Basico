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

    xor edx, edx

    idiv ebx

    mov eax, edx

    jmp fim_op_mod

op_mod32:
    call ler_int_32         ;le primeiro numero ->eax
    mov [esp], eax

    call ler_int_32

    mov ebx, eax
    mov eax, dword [esp]

    xor edx, edx

    idiv ebx

    mov eax, edx

fim_op_mod:
    add esp, 4
    pop ebp
    ret