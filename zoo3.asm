
section .data
    prompt db "Enter title: ", 0
    display db "You entered: ", 0

section .bss
    title resb 100

section .text
    global _start

_start:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 13
    syscall

    ; Read title
    mov rax, 0
    mov rdi, 0
    mov rsi, title
    mov rdx, 100
    syscall

    ; Null-terminate title
    mov byte [title + rax], 0

    ; Print display message
    mov rax, 1
    mov rdi, 1
    mov rsi, display
    mov rdx, 12
    syscall

    ; Print title
    mov rax, 1
    mov rdi, 1
    mov rsi, title
    mov rdx, 100
    syscall

    ; Exit program
    xor rax, rax
    xor rdi, rdi
    mov rax, 60
    syscall
