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

loop_principal:    push option
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

    push chosenOption
    push 2
    call ler_string


    cmp [chosenOption], byte 37h
    je sair 
    cmp [chosenOption], byte 36h
    je mod
    cmp [chosenOption], byte 35h
    je exp
    cmp [chosenOption], byte 34h
    je divi
    cmp [chosenOption], byte 33h
    je multi
    cmp [chosenOption], byte 32h
    je subi

    call adicao         ;retorna resultado em eax
    jmp imprime_resultado

subi:
    call subtracao      ;retorna resultado em eax
    jmp imprime_resultado
multi:  
divi:
exp:
mod:   
    mov [chosenOption], eax
    push chosenOption
    push 2
    call print_string

imprime_resultado:

    push eax
    cmp [chosenPrecision], byte 31h
    je imprime_resultado32

    call print_int_16
    jmp loop_principal

imprime_resultado32:
    call print_int
    jmp loop_principal

    ; Encerre o programa
sair:    
    mov eax, 1
    xor ebx, ebx
    int 0x80

ler_int_16:
            push ebp
            mov ebp, esp

            sub esp, 7              ;reserva espaço para numero

            mov eax, 3
            mov ebx, 0
            mov ecx, esp
            mov edx, 7
            int 80h                 ;le numero 16bits e escreve em [esp]

            dec eax
            mov byte[esp + eax], 0  ;tira o \n

            ;verifica se tem -123
            ;esp-- eax--
            mov esi, 0
            mov bl, [esp]
            cmp ebx, 2dh
            jne continue16
            inc esp
            dec eax
            mov esi, 1

continue16: dec eax                 ;expoente de 10
            mov ecx, eax            ;ecx = expoente do 10
            mov eax, 0              ;eax = resp
            mov edx, 0              ;index
            mov ebx, 0              

p_caracter16: 
            mov bl, [esp + edx]    ;le caracter
            sub bl, 30h            ;passa para int
            push ecx                ;salva expoente 10
            push edx                ;salva index
mult10_16:     
            cmp ecx, 0              ;verifica se == 0
            je proximo16
            sal ebx, 1              ;ebx = 2i
            mov edx, ebx            ;edx = 2i
            sal ebx, 2              ;ebx = 8i
            add ebx, edx            ;ebx = 10i
            dec ecx
            jmp mult10_16
proximo16:    
            pop edx                 ;recupera index
            pop ecx                 ;recupera expoente 10
            dec ecx                 ;proximo expoente
            inc edx                 ;proximo caracter
            add eax, ebx            ;adiciona a resposta
            mov ebx, 0
            cmp ecx, 0

            jge p_caracter16

            cmp esi, 1
            jne fim16          
            neg eax
            dec esp

fim16:      add esp, 7
            pop ebp
            ret

ler_int_32:
            push ebp
            mov ebp, esp

            sub esp, 12              ;reserva espaço para numero

            mov eax, 3
            mov ebx, 0
            mov ecx, esp
            mov edx, 12
            int 80h                 ;le numero 32bits e escreve em [esp]

            dec eax
            mov byte[esp + eax], 0  ;tira o \n

            ;verifica se tem -
            ;esp-- eax--
            mov esi, 0
            mov bl, [esp]
            cmp ebx, 2dh
            jne continue32
            inc esp
            dec eax
            mov esi, 1

continue32: dec eax                 ;expoente de 10
            mov ecx, eax            ;ecx = expoente do 10
            mov eax, 0              ;eax = resp
            mov edx, 0              ;index
            mov ebx, 0              

p_caracter32: 
            mov bl, [esp + edx]    ;le caracter
            sub bl, 30h            ;passa para int
            push ecx                ;salva expoente 10
            push edx                ;salva index
mult10_32:     
            cmp ecx, 0              ;verifica se == 0
            je proximo32
            sal ebx, 1              ;ebx = 2i
            mov edx, ebx            ;edx = 2i
            sal ebx, 2              ;ebx = 8i
            add ebx, edx            ;ebx = 10i
            dec ecx
            jmp mult10_32
proximo32:  pop edx                 ;recupera index
            pop ecx                 ;recupera expoente 10
            dec ecx                 ;proximo expoente
            inc edx                 ;proximo caracter
            add eax, ebx            ;adiciona a resposta
            mov ebx, 0
            cmp ecx, 0

            jge p_caracter32

            cmp esi, 1
            jne fim32       
            mov ebx, eax
            mov eax, 0
            sub eax, ebx
            dec esp

fim32:      add esp, 12
            pop ebp
            ret


print_int:
    push ebp
    mov ebp, esp

    sub esp, 14

    mov eax, [ebp + 8]  ; argumento da função (número inteiro a ser convertido)
    mov ebx, 10          ; divisor (usado para obter os dígitos individuais)
    mov ecx, 14

    cmp eax, 0          ; verifique se o número é negativo
    jge enter_number    ; se for maior ou igual a zero, vá para a parte de número positivo

    neg eax             ; inverte o sinal do número para torná-lo positivo

enter_number:
    dec ecx
    mov byte [esp + ecx], 0
    dec ecx
    mov byte [esp + ecx], 10
    dec ecx
    mov byte [esp + ecx], 13

    xor edx, edx
    jmp get_next_digit

positive_number:

    xor edx, edx       ; limpe o registrador edx (usado para armazenar o resto da divisão)
    cmp eax, 0         ; verifique se chegamos ao final dos dígitos
    jnz get_next_digit ; se ainda houver dígitos a serem processados, vá para a próxima iteração

    mov eax, [ebp + 8]
    cmp eax, 0          ; verifique se o número é negativo
    jge not_signal ; se for maior ou igual a zero, vá para a parte de número positivo

    ; Caso o número seja negativo, coloque o sinal de menos no início da string
    dec ecx
    mov byte [esp + ecx], '-'
not_signal:
    mov edi, esp
    add edi, ecx
    sub ecx, 14
    neg ecx
    mov eax, edi       ; mova o ponteiro da string para eax (para retorno)

    push eax
    push ecx
    call print_string

    add esp, 14

    pop ebp            ; restaura o valor original do ebp
    ret 4              ; retorna para o chamador

get_next_digit:
    ; Divisão sucessiva para obter os dígitos individuais do número
    div ebx            ; eax = eax / ebx (resultado em eax, resto em edx)
    add dl, '0'        ; converte o resto em seu equivalente em caractere
    dec ecx            ; avance o ponteiro da string para a esquerda
    mov [esp + ecx], dl      ; armazene o dígito no buffer da string
    jmp positive_number  ; vá para a próxima iteração

print_int_16:
    push ebp
    mov ebp, esp

    sub esp, 9

    mov ax, [ebp + 8]  ; argumento da função (número inteiro a ser convertido)
    mov bx, 10          ; divisor (usado para obter os dígitos individuais)
    mov ecx, 9

    cmp ax, 0          ; verifique se o número é negativo
    jge enter_number_16    ; se for maior ou igual a zero, vá para a parte de número positivo

    neg ax             ; inverte o sinal do número para torná-lo positivo

enter_number_16:
    dec ecx
    mov byte [esp + ecx], 0
    dec ecx
    mov byte [esp + ecx], 10
    dec ecx
    mov byte [esp + ecx], 13

    xor edx, edx
    jmp get_next_digit_16

positive_number_16:

    xor edx, edx       ; limpe o registrador edx (usado para armazenar o resto da divisão)
    cmp ax, 0         ; verifique se chegamos ao final dos dígitos
    jnz get_next_digit_16 ; se ainda houver dígitos a serem processados, vá para a próxima iteração

    mov ax, [ebp + 8]
    cmp ax, 0          ; verifique se o número é negativo
    jge not_signal_16 ; se for maior ou igual a zero, vá para a parte de número positivo

    ; Caso o número seja negativo, coloque o sinal de menos no início da string
    dec ecx
    mov byte [esp + ecx], '-'
not_signal_16:
    mov edi, esp
    add edi, ecx
    sub ecx, 14
    neg ecx
    mov eax, edi       ; mova o ponteiro da string para eax (para retorno)

    push eax
    push ecx
    call print_string

    add esp, 9

    pop ebp            ; restaura o valor original do ebp
    ret 4              ; retorna para o chamador

get_next_digit_16:
    ; Divisão sucessiva para obter os dígitos individuais do número
    div bx            ; eax = eax / ebx (resultado em eax, resto em edx)
    add dl, '0'        ; converte o resto em seu equivalente em caractere
    dec ecx            ; avance o ponteiro da string para a esquerda
    mov [esp + ecx], dl      ; armazene o dígito no buffer da string
    jmp positive_number_16  ; vá para a próxima iteração


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

subtracao:
        push ebp
        mov ebp, esp

        sub esp, 8
        call ler_int_32
        mov [esp], eax
        call ler_int_32
        mov [esp + 4], eax

        mov eax, [esp]
        sub eax, [esp + 4]

        add esp, 8
fim_sub:pop ebp
        ret