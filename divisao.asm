section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32

    global divisao

divisao:
    push ebp
    mov ebp, esp

    sub esp, 4              ;resevar dword na pilha

    cmp [chosenPrecision], byte 31h
    je divisao32

    call ler_int_16
    mov [esp], eax
    
    call ler_int_16
    mov ebx, eax
    mov eax, dword [esp]

    xor edx, edx

    idiv ebx

    jmp fim_divisao

divisao32:
    call ler_int_32         ;le primeiro numero ->eax
    mov [esp], eax

    call ler_int_32

    mov ebx, eax
    mov eax, dword [esp]

    xor edx, edx

    idiv ebx

fim_divisao:
    add esp, 4
    pop ebp
    ret