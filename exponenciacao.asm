section .text
    extern chosenPrecision
    extern ler_int_16
    extern ler_int_32
    extern overflow
    extern size_overflow
    extern print_string

    global exponenciacao

exponenciacao:
    push ebp
    mov ebp, esp

    cmp [chosenPrecision], byte 31h
    je esponenciacao32

    call ler_int_16
    mov ebx, eax       ;ebx recebe base
    push ebx
    call ler_int_16
    pop ebx
    mov ecx, eax        ;ecx recebe expoente

    mov eax, 1

loop_exp16:
    cmp ecx, 0
    je fim_exponenciacao
        
    imul bx
    jo overflow_exp

    dec ecx
    jmp loop_exp16

esponenciacao32:
    call ler_int_32
    mov ebx, eax
    push ebx
    call ler_int_32
    pop ebx
    mov ecx, eax

    mov eax, 1

loop_exp32:
    cmp ecx, 0
    je fim_exponenciacao

    imul ebx
    jo overflow_exp

    dec ecx
    jmp loop_exp32

fim_exponenciacao:
    pop ebp
    ret

overflow_exp:
    push overflow
    push size_overflow
    call print_string

    mov eax, 1
    mov ebx, 0
    int 80h