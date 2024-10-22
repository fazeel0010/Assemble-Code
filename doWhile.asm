section .data
	array times 7 dw 12, 1003, 6543, 24680, 789, 30123, 32766 	; declare static array
	even_array times 7 dw 0 						; declare empty array for even

section .text
	global _start

_start:
	mov rsi, 0          ; initialize rsi to 0
	mov rdi, 0          ; initialize rdi to 0

loop_start:
	movzx eax, word [array + rsi*2]  ; load array element into eax (16-bit)
	mov ebx, eax			 ; mov eax value to bax
	and eax, 1              	 ; check if eax value is even
	jnz next_array_element  	 ; if odd, skip to next element

	; only comes here if element is even
	mov [even_array + rdi*2], ebx 	; copy even element to even array
	inc rdi               		; increment rdi

next_array_element:
	inc rsi               ; increment rsi
	cmp rsi, 7            ; check if rsi < 7
	jl loop_start         ; if yes, loop again

	; Exit program
	mov eax, 60
	xor edi, edi
	syscallls
