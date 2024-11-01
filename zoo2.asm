section .data
    prompt db "Enter title (or type 'end' to stop): ", 0
    display db "You entered: ", 0
    newline db 10, 0  ; Newline character

section .bss
    title resb 100          ; Space for one title (max 100 bytes)
    titles resb 1000        ; Array for storing multiple titles (up to 10 titles of 100 bytes each)
    count resb 1            ; To store the count of titles entered

section .text
    global _start

_start:
    ; Initialize title count to zero
    mov byte [count], 0

input_loop:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 33
    syscall

    ; Read title
    mov rax, 0
    mov rdi, 0
    mov rsi, title
    mov rdx, 100
    syscall

    ; Null-terminate title
    mov byte [title + rax - 1], 0  ; Remove newline and null-terminate

    ; Check if user typed 'end' to stop input
    mov rsi, title
    mov rdi, end_check
    call str_cmp
    cmp rax, 0
    je display_titles  ; If 'end' was entered, go to display

    ; Copy title to titles array
    mov rsi, title
    mov rdi, titles
    movzx rbx, byte [count]
    imul rbx, rbx, 100   ; Offset for the next title
    add rdi, rbx
    call str_copy

    ; Increment title count
    inc byte [count]

    ; Loop to input next title
    jmp input_loop

display_titles:
    ; Print each title entered
    movzx rbx, byte [count]
    xor rcx, rcx  ; Clear counter

print_loop:
    cmp rcx, rbx
    je exit_program  ; If all titles are printed, exit

    ; Print display message
    mov rax, 1
    mov rdi, 1
    mov rsi, display
    mov rdx, 12
    syscall

    ; Print title
    mov rsi, titles
    imul rdx, rcx, 100  ; Offset for each title in array
    add rsi, rdx
    mov rax, 1
    mov rdi, 1
    mov rdx, 100
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Increment counter and loop
    inc rcx
    jmp print_loop

exit_program:
    ; Exit program
    xor rax, rax
    xor rdi, rdi
    mov rax, 60
    syscall

; String compare function (strcmp)
; Inputs: rsi = first string, rdi = second string
; Output: rax = 0 if equal, non-zero if not
str_cmp:
    xor rax, rax
.str_cmp_loop:
    mov al, [rsi]
    cmp al, [rdi]
    jne .str_cmp_done
    test al, al
    je .str_cmp_done
    inc rsi
    inc rdi
    jmp .str_cmp_loop
.str_cmp_done:
    ret

; String copy function (strcpy)
; Inputs: rsi = source, rdi = destination
str_copy:
    .str_copy_loop:
        mov al, [rsi]
        mov [rdi], al
        test al, al
        je .str_copy_done
        inc rsi
        inc rdi
        jmp .str_copy_loop
    .str_copy_done:
        ret

section .data
end_check db "end", 0
