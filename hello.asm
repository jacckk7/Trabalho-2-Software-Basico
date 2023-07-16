section .data
    ; Ponteiros para os strings de texto das mensagens
    name db 'Bem-vindo. Digite seu nome:', 13, 10, 0
    size_name EQU $-name 

    welcomeone db 'Hola, ', 0
    size_welcomeone EQU $-welcomeone

    welcometwo db ', bem-vindo ao programa de CALC IA-32', 13, 10, 0
    size_welcometwo EQU $-welcometwo

    precision db 'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):', 13, 10, 0
    size_precision EQU $-precision

    option db 'ESCOLHA UMA OPÇÃO:', 13, 10, 0
    size_option EQU $-option

    addition db '- 1: SOMA', 13, 10, 0
    size_addition EQU $-addition

    subtraction db '- 2: SUBTRACAO', 13, 10, 0
    size_subtraction EQU $-subtraction

    multiplication db '- 3: MULTIPLICACAO', 13, 10, 0
    size_multiplication EQU $-multiplication

    division db '- 4: DIVISAO', 13, 10, 0
    size_division EQU $-division

    expo db '- 5: EXPONENCIACAO', 13, 10, 0
    size_expo EQU $-expo

    modul db '- 6: MOD', 13, 10, 0
    size_modul EQU $-modul

    getout db '- 7: SAIR', 13, 10, 0
    size_getout EQU $-getout

section .bss
    personName resb 16
    chosenPrecision resb 1
    chosenOption resb 1

section .text
    global _start

_start:
    ; Chamadas da funcao de mensagens de texto
    push name
    push size_name
    call print_string       ;escreve name
    
    push personName
    push 16                 ;le apenas 15 caracteres
    call ler_string         ;le nome -> retorna tamanho do nome

    push welcomeone
    push size_welcomeone
    call print_string       ;escreve welcome1

    push personName
    push eax                ;tamanho da string nome
    call print_string       ;escreve person_name

    push welcometwo
    push size_welcometwo
    call print_string       ;escreve welcome1

    push precision
    push size_precision
    call print_string       ;escreve precision

    push chosenPrecision
    push 2
    call ler_string         ;le precisao -> retorna o tamanho da opção

    push option
    push size_option
    call print_string       ;escreve opcoes

    push addition
    push size_addition
    call print_string       ;escreve adicao

    push subtraction
    push size_subtraction
    call print_string       ;escreve subtracao

    push multiplication
    push size_multiplication
    call print_string       ;escreve multiplicacao

    push division
    push size_division
    call print_string       ;escreve divisao

    push expo
    push size_expo
    call print_string       ;escreve exponenciacao

    push modul
    push size_modul
    call print_string       ;escreve modulo

    push getout
    push size_getout
    call print_string       ;escreve sair

    call ler_int_16

    mov [chosenOption], eax
    push chosenOption
    push 2
    call print_string
    

    ; Encerre o programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

ler_int_16:
            push ebp
            mov ebp, esp

            sub esp, 6              ;reserva espaço para numero

            mov eax, 3
            mov ebx, 0
            mov ecx, esp
            mov edx, 6
            int 80h                 ;le numero 16bits e escreve em [esp]

            dec eax
            mov byte[esp + eax], 0  ;tira o \n

            ;verifica se tem -
            ;esp-- eax--
            mov bl, [esp]
            cmp ebx, 2dh
            jne continue
            push byte 1
            dec esp
            dec eax

continue:   dec eax                 ;expoente de 10
            mov ecx, eax            ;ecx = expoente do 10
            mov eax, 0              ;eax = resp
            mov edx, 0              ;index
            mov ebx, 0              

p_caracter: 
            mov bl, [esp + edx + 1]    ;le caracter
            sub bl, 30h            ;passa para int
            push ecx                ;salva expoente 10
            push edx                ;salva index
mult10:     
            cmp ecx, 0              ;verifica se == 0
            je proximo
            sal ebx, 1              ;ebx = 2i
            mov edx, ebx            ;edx = 2i
            sal ebx, 2              ;ebx = 8i
            add ebx, edx            ;ebx = 10i
            dec ecx
            jmp mult10
proximo:    pop edx                 ;recupera index
            pop ecx                 ;recupera expoente 10
            dec ecx                 ;proximo expoente
            inc edx                 ;proximo caracter
            add eax, ebx            ;adiciona a resposta
            cmp ecx, 0

            jge p_caracter

            cmp [esp], byte 1
            jne fim          
            mov ebx, eax
            mov eax, 0
            sub eax, ebx
            add esp, 1

fim:        add esp, 6
            pop ebp
            ret

ler_string:    ;retorna o tamanho da string no eax
    push ebp
    mov ebp, esp

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp + 12]
    mov edx, [ebp + 8]
    int 80h

    dec eax
    mov byte [ecx + eax], 0

    pop ebp
    ret 8


print_string:
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    push edx

    mov eax, 4
    mov ebx, 1
    mov ecx, [ebp + 12]
    mov edx, [ebp + 8]
    int 80h
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop ebp
    ret 8
