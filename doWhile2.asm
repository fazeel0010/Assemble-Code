section .data
	array times 7 dw 12, 1003, 6543, 24680, 789, 30123, 32766
	even times 7 dw 0
	temp dw 0

section .text
	global _start

_start:
	mov rsi, 0          ; initialize rsi to 0
	mov rdi, 0          ; initialize rdi to 0

loop_start:
	movzx eax, word [array + rsi*2]  ; load array element into eax (16-bit)
	mov temp, eax
	and eax, 1              ; check if eax is even
	jnz next_element      ; if odd, skip to next element

	mov [even + rdi*2], temp ; copy even element to even array
	inc rdi               ; increment rdi

next_element:
	inc rsi               ; increment rsi
	cmp rsi, 7            ; check if rsi < 7
	jl loop_start         ; if yes, loop again

	; Exit program
	mov eax, 60
	xor edi, edi
	syscall
