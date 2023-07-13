section .data
    hello db 'Hello, world!', 0

section .text
    global _start

_start:
    ; Escreva a mensagem na saída padrão
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, 13
    int 0x80

    ; Encerre o programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
