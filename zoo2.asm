section .data
    max_names equ 100
    max_length equ 100
    prompt db "Enter name: ", 0
    names times max_names * max_length db 0

section .bss
    i resq 1
    buf resb max_length

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

    ; Read name
    mov rax, 0          ; sys_read
    mov rdi, 0          ; file descriptor (stdin)
    mov rsi, buf        ; buffer to store input
    mov rdx, max_length ; max length to read
    syscall

    ; Check if read operation was successful
    cmp rax, 0
    jl error

    ; Null-terminate the input string
    mov byte [buf + rax], 0

    ; Store input in names array
    mov rsi, [i]
    imul rsi, max_length
    lea rdi, [names + rsi]
    mov rsi, buf
    mov rdx, max_length
    call strcpy

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

error:
    ; Handle error
    mov rax, 60
    mov rdi, 1
    syscall

; Simple strcpy function
strcpy:
    mov rsi, [rsi]
    mov [rdi], rsi
    add rdi, 1
    add rsi, 1
    dec rdx
    cmp rdx, 0
    jg strcpy
    ret
