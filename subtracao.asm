section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32

    global subtracao

subtracao:
    push ebp
    mov ebp, esp

    sub esp, 8

    cmp [chosenPrecision], byte 31h
    je subtracao32

    call ler_int_16
    mov [esp], eax
    call ler_int_16
    mov [esp + 4], eax

    mov eax, [esp]
    sub eax, [esp + 4]

    jmp fim_sub

subtracao32:
    call ler_int_32
    mov [esp], eax
    call ler_int_32
    mov [esp + 4], eax

    mov eax, [esp]
    sub eax, [esp + 4]

fim_sub:
    add esp, 8
    pop ebp
    ret