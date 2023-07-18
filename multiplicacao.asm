section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32
    extern overflow
    extern size_overflow
    extern print_string

    global multiplicacao

multiplicacao:
    push ebp
    mov ebp, esp


    cmp [chosenPrecision], byte 31h
    je multiplicacao32

    call ler_int_16
    mov ebx, eax
    push ebx
    call ler_int_16
    pop ebx

    imul bx
    jo overflow_mul

    jmp fim_multiplicacao
multiplicacao32:
    call ler_int_32
    mov ebx, eax
    push ebx
    call ler_int_32
    pop ebx

    imul ebx
    jo overflow_mul

fim_multiplicacao:
    pop ebp
    ret

overflow_mul:
        push overflow
        push size_overflow
        call print_string

        mov eax, 1
        mov ebx, 0
        int 80h