section .data
    array dw 12, 1003, 6543, 24680, 789, 30123, 32766    ; 16-bit array
    even  dw 7                                         ; Reserve space for 7 16-bit elements
    hex dw 0

section .text
    global _start

_start:
    xor rsi, rsi            ; rsi = 0 (index for array)
    xor rdi, rdi            ; rdi = 0 (index for even)

do_while:
    cmp rsi, 7              ; Check if rsi >= 7 (end of array)
    jge done                ; If yes, exit the loop
    
    lea rdx, [rsi * 2] 
    movzx ax,[array + rdx]  ; Load array[rsi] into ax (16-bit)
    test ax, 1              ; Test if ax is odd (ax % 2 == 1)
    jnz not_even            ; If odd, skip to the next iteration

    lea rdx, [rdi * 2]
    mov [even + rdx], ax  ; Copy the even number to even[rdi]
    inc rdi                 ; Increment rdi (next slot in even array)

not_even:
    inc rsi                 ; Increment rsi (next element in array)
    jmp do_while            ; Repeat the loop

done:
    ; Exit program
    mov rax, 60             ; Syscall number for exit
    xor rdi, rdi            ; Exit code 0
    syscall


