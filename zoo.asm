section .data
    max_badgers equ 100
    max_staff equ 50
    badger_size equ 44
    staff_size equ 56

    ; Badger structure
    struct_badger:
        id resd 1	
        name resb 50
        home resb 20
        mass resd 1
        stripes resd 1
        sex resb 1
        birth_month resd 1
        birth_year resd 1
        keeper_id resd 1

    ; Staff structure
    struct_staff:
        id resd 1
        surname resb 50
        first_name resb 50
        department resb 20
        salary resd 1
        joining_year resd 1
        email resb 100

    ; Arrays to store badgers and staff
    badgers times max_badgers struct_badger
    staff times max_staff struct_staff

    ; Current indices
    badger_count resd 0
    staff_count resd 0

    ; Messages
    menu_msg db "--- Wildlife Park Management ---", 13, 10, "1. Add Staff", 13, 10, "2. Add Badger", 13, 10, "3. Display Staff", 13, 10, "4. Display Badgers", 13, 10, "5. Search Badger", 13, 10, "6. Search Staff", 13, 10, "0. Exit", 13, 10, 0

    add_staff_msg db "Enter Staff ID: ", 0
    add_badger_msg db "Enter Badger ID: ", 0
    invalid_choice db "Invalid choice.", 13, 10, 0
    max_staff_reached db "Maximum staff reached.", 13, 10, 0
    max_badgers_reached db "Maximum badgers reached.", 13, 10, 0
    staff_added db "Staff member added.", 13, 10, 0
    badger_added db "Badger added.", 13, 10, 0
    staff_not_found db "Staff member not found.", 13, 10, 0
    badger_not_found db "Badger not found.", 13, 10, 0


section .text
    global main
    extern printf, scanf

main:
    ; Initialize data
    mov rdi, badgers
    mov rsi, max_badgers
    call init_badgers

    mov rdi, staff
    mov rsi, max_staff
    call init_staff

menu:
    ; Display menu
    mov rdi, menu_msg
    call printf

    ; Read user input
    mov rdi, choice_msg
    mov rsi, choice
    call scanf

    ; Handle user input
    mov rax, [choice]
    cmp rax, 1
    je add_staff
    cmp rax, 2
    je add_badger
    cmp rax, 3
    je display_staff
    cmp rax, 4
    je display_badgers
    cmp rax, 5
    je search_badger
    cmp rax, 6
    je search_staff
    cmp rax, 0
    je exit
    mov rdi, invalid_choice
    call printf
    jmp menu

add_staff:
    ; Add staff
    mov rdi, staff
    mov rsi, [staff_count]
    call add_staff_func
    inc [staff_count]
    mov rdi, staff_added
    call printf
    jmp menu

add_badger:
    ; Add badger
    mov rdi, badgers
    mov rsi, [badger_count]
    call add_badger_func
    inc [badger_count]
    mov rdi, badger_added
    call printf
    jmp menu

display_staff:
    ; Display staff
    mov rdi, staff
    mov rsi, [staff_count]
    call display_staff_func
    jmp menu

display_badgers:
    ; Display badgers
    mov rdi, badgers
    mov rsi, [badger_count]
    call display_badgers_func
    jmp menu

search_badger:
    ; Search badger
    mov rdi, badgers
    mov rsi, [badger_count]
    call search_badger_func
    jmp menu

search_staff:
    ; Search staff
    mov rdi, staff
    mov rsi, [staff_count]
    call search_staff_func
    jmp menu

exit:
    ret
