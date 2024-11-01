section .data
    main_menu db "Main Menu:", 0
    prompt_title db "1. Enter title", 0
    prompt_author db "2. Enter author", 0
    prompt_exit db "3. Exit", 0
    enter_title db "Enter title: ", 0
    enter_author db "Enter author: ", 0
    display_title db "Title: ", 0
    display_author db "Author: ", 0

section .bss
    title resb 100
    author resb 100
    choice resb 2

section .text
    global _start

_start:
    ; Main loop
main_loop:
    ; Print main menu
    mov rax, 1
    mov rdi, 1
    mov rsi, main_menu
    mov rdx, 11
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_title
    mov rdx, 15
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_author
    mov rdx, 16
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_exit
    mov rdx, 11
    syscall

    ; Read choice
    mov rax, 0
    mov rdi, 0
    mov rsi, choice
    mov rdx, 2
    syscall

    ; Handle choice
    mov rsi, choice
    movsil
    cmp rsi, '1'
    je enter_title

    cmp rsi, '2'
    je enter_author

    cmp rsi, '3'
    je exit_program

    jmp main_loop

enter_title:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, enter_title
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

    ; Display title
    mov rax, 1
    mov rdi, 1
    mov rsi, display_title
    mov rdx, 8
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, title
    mov rdx, 100
    syscall

    jmp main_loop

enter_author:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, enter_author
    mov rdx, 14
    syscall

    ; Read author
    mov rax, 0
    mov rdi, 0
    mov rsi, author
    mov rdx, 100
    syscall

    ; Null-terminate author
    mov byte [author + rax], 0

    ; Display author
    mov rax, 1
    mov rdi, 1
    mov rsi, display_author
    mov rdx, 9
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, author
    mov rdx, 100
    syscall

    jmp main_loop

exit_program:
    ; Exit program
    xor rax, rax
    xor rdi, rdi
    mov rax, 60
    syscall
