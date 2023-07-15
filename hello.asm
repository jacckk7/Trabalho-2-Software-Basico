section .data
    ; Ponteiros para os strings de texto das mensagens
    name db 'Bem-vindo. Digite seu nome:', 13, 10, 0
    welcomeone db 'Hola, ', 0
    welcometwo db ', bem-vindo ao programa de CALC IA-32', 13, 10, 0
    precision db 'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):', 13, 10, 0
    option db 'ESCOLHA UMA OPÇÃO:', 13, 10, 0
    addition db '- 1: SOMA', 13, 10, 0
    subtraction db '- 2: SUBTRACAO', 13, 10, 0
    multiplication db '- 3: MULTIPLICACAO', 13, 10, 0
    division db '- 4: DIVISAO', 13, 10, 0
    expo db '- 5: EXPONENCIACAO', 13, 10, 0
    modul db '- 6: MOD', 13, 10, 0
    getout db '- 7: SAIR', 13, 10, 0

section .bss
    personName resb 16
    chosenPrecision resb 1
    chosenOption resb 1

section .text
    global _start

_start:
    ; Chamada da funcao de mensagens de texto
    call mensages

    ; Encerre o programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

mensages:
    push EBP

    ; Escreve a mensagem name
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 29
    int 0x80

    ; Pega o input do nome da pessoa
    mov eax, 3
    mov ebx, 0
    mov ecx, personName
    mov edx, 16
    int 0x80

    ; Escreve a mensagem welcomeone
    mov eax, 4
    mov ebx, 1
    mov ecx, welcomeone
    mov edx, 6
    int 0x80

    ;Escreve o nome da pessoa na tela
    mov eax, 4
    mov ebx, 1
    mov ecx, personName
    mov edx, 16
    int 0x80

    ; Escreve a mensagem welcometwo
    mov eax, 4
    mov ebx, 1
    mov ecx, welcometwo
    mov edx, 39
    int 0x80

    pop EBP
    ret
