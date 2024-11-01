section .data
    max_names equ 100
    max_length equ 100
    prompt db "Enter name: ", 0
    names times max_names * max_length db 0

section .bss
    i resq 1

section .text
    global _start

_start:
    ; Initialize loop counter
    mov qword [i], 0

loop_start:
    ; Print prompt
    mov rax, 1          ; sys_write
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, prompt
    mov rdx, 12         ; length of prompt
    syscall

    ; Calculate address for reading name
    mov rsi, [i]
    imul rsi, max_length
    lea rdi, [names + rsi]

    ; Read name
    mov rax, 0          ; sys_read
    mov rsi, 0          ; file descriptor (stdin)
    mov rdx, max_length ; max length to read
    syscall

    ; Increment loop counter
    add qword [i], 1

    ; Check loop condition
    cmp qword [i], max_names
    jl loop_start

    ; Exit program
    xor rax, rax
    xor rdi, rdi
    mov rax, 60
    syscall
