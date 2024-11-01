section .data
    max_names equ 100
    max_length equ 100
    prompt db "Enter name %d: ", 0
    names times max_names * max_length db 0

section .bss
    i resq 1

section .text
    global main
    extern printf, scanf

main:
    ; Initialize loop counter
    mov qword [i], 0

loop_start:
    ; Print prompt
    mov rdi, prompt
    mov rsi, [i]
    add rsi, 1
    call printf

    ; Read name
    mov rdi, names
    mov rsi, [i]
    mov rsi, rsi
    lea rdi, [names + rsi * max_length]
    ;mov rdi, [names + rsi * max_length]
    mov rsi, rdi
    call scanf

    ; Increment loop counter
    add qword [i], 1

    ; Check loop condition
    cmp qword [i], max_names
    jl loop_start

    ; Exit program
    xor rax, rax
    ret
