section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32

    global adicao

adicao:
    push ebp
    mov ebp, esp

    sub esp, 4              ;resevar dword na pilha

    cmp [chosenPrecision], byte 31h
    je adicao32

    call ler_int_16

    mov [esp], eax
    call ler_int_16

    add eax, [esp]

    jmp fim_adicao

adicao32:
    call ler_int_32         ;le primeiro numero ->eax

    mov [esp], eax          ;salva prieiro numero na pilha
    call ler_int_32         ;le segundo numero -> eax

    add eax, [esp]     ;soma segundo com o primeiro

fim_adicao:
    add esp, 4
    pop ebp
    ret