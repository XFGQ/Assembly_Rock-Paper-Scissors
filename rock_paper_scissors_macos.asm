section .data
    prompt db "Enter your choice (0: Rock, 1: Paper, 2: Scissors): ", 0
    len_prompt equ $ - prompt

    your_choice db "Your choice is: ", 0
    len_your_choice equ $ - your_choice

    comp_choice db "Computer's choice is: ", 0
    len_comp_choice equ $ - comp_choice

    rock db "Rock", 10, 0
    len_rock equ $ - rock

    paper db "Paper", 10, 0
    len_paper equ $ - paper

    scissors db "Scissors", 10, 0
    len_scissors equ $ - scissors

    msg_win db "YOU WON!", 10, 0
    len_win equ $ - msg_win

    msg_lose db "YOU LOST!", 10, 0
    len_lose equ $ - msg_lose

    msg_draw db "It's a DRAW!", 10, 0
    len_draw equ $ - msg_draw

    invalid db "Invalid input!", 10, 0
    len_invalid equ $ - invalid

section .bss
    user_input resb 1
    user_val resb 1
    comp_val resb 1

section .text
    global _start

_start:
    ; write prompt
    mov rax, 0x2000004      ; syscall write
    mov rdi, 1              ; stdout
    mov rsi, prompt
    mov rdx, len_prompt
    syscall

    ; read input
    mov rax, 0x2000003      ; syscall read
    mov rdi, 0              ; stdin
    mov rsi, user_input
    mov rdx, 1
    syscall

    ; convert char to int
    movzx rax, byte [user_input]
    sub rax, '0'
    cmp rax, 2
    ja invalid_input
    mov [user_val], al

    ; random comp_val (using rdtsc)
    rdtsc
    xor rdx, rdx
    mov rcx, 3
    div rcx
    mov [comp_val], dl

    ; print your_choice
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, your_choice
    mov rdx, len_your_choice
    syscall

    movzx rax, byte [user_val]
    call print_choice

    ; print comp_choice
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, comp_choice
    mov rdx, len_comp_choice
    syscall

    movzx rax, byte [comp_val]
    call print_choice

    ; game logic
    movzx rax, byte [user_val]
    movzx rbx, byte [comp_val]
    sub rax, rbx
    add rax, 3
    xor rdx, rdx
    mov rcx, 3
    div rcx
    cmp rdx, 0
    je draw
    cmp rdx, 1
    je win
    jmp lose

win:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, msg_win
    mov rdx, len_win
    syscall
    jmp exit

lose:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, msg_lose
    mov rdx, len_lose
    syscall
    jmp exit

draw:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, msg_draw
    mov rdx, len_draw
    syscall
    jmp exit

invalid_input:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, invalid
    mov rdx, len_invalid
    syscall

exit:
    mov rax, 0x2000001
    xor rdi, rdi
    syscall

print_choice:
    cmp rax, 0
    je .rock
    cmp rax, 1
    je .paper
    cmp rax, 2
    je .scissors
    ret

.rock:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, rock
    mov rdx, len_rock
    syscall
    ret

.paper:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, paper
    mov rdx, len_paper
    syscall
    ret

.scissors:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, scissors
    mov rdx, len_scissors
    syscall
    ret
