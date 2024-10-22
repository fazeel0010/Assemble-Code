section .data
    num dw 65535          ; use dw to declare 16-bit variable
    mul_3 dw 0            ; use dw to declare 16-bit variable
    other dw 0            ; use dw to declare 16-bit variable

section .text
    global _start

_start:
    ; Check if num % 3 == 0
    mov eax, [num]
    mov ebx, 3
    xor edx, edx
    div ebx
    cmp edx, 0
    jne mul_3_inc         ; if remainder is not 0, jump to not_mul_3

    ; Check if num % 5 != 0
    mov eax, [num]
    mov ebx, 5
    xor edx, edx
    div ebx
    cmp edx, 0
    je other_inc          ; if remainder is 0, jump to other
    jmp mul_3_inc

other_inc:
    ; Increment other
    inc word [other]
    jmp end_program

mul_3_inc:
    ; Increment mul_3
    inc word [mul_3]
    jmp end_program


end_program:
    ; Exit program
    mov eax, 1            ; syscall: exit
    xor ebx, ebx          ; status: 0
    int 0x80

