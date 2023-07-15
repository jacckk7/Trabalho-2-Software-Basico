MAX EQU 100

section .text
    global _start
_start:
    mov eax, MAX
    sal eax, 2
    sub esp, MAX

    mov ecx, MAX
    mov ebx, 0

l:  mov eax, ebx
    sar eax, 1
    mov [esp + ebx*4], eax
    inc ebx
    loop l

fim:mov eax, 1
    mov ebx, 0
    int 80h

