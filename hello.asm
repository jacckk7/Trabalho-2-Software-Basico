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
    push 16
    call ler_nome           ;le nome -> retorna tamanho do nome

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
    call ler_opcoes         ;le oçoes

    push option
    push size_option
    call print_string

    push addition
    push size_addition
    call print_string

    push subtraction
    push size_subtraction
    call print_string

    push multiplication
    push size_multiplication
    call print_string

    push division
    push size_division
    call print_string

    push expo
    push size_expo
    call print_string

    push modul
    push size_modul
    call print_string

    push getout
    push size_getout
    call print_string

    


    ; Encerre o programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

ler_opcoes:
    push ebp
    mov ebp, esp

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp + 8]
    mov edx, 1
    int 80h

    pop ebp
    ret 4

ler_nome:    ;retorna o tamanho da string no eax
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

    mov eax, 4
    mov ebx, 1
    mov ecx, [ebp + 12]
    mov edx, [ebp + 8]
    int 80h

    pop eax
    pop ebp
    ret 8
