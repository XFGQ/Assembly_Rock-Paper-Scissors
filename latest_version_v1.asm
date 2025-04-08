section .data
    msg_input db "Enter your choice (0: Rock, 1: Paper, 2: Scissors): ", 0
    len_input equ $ - msg_input

    label_user db "Your choice is: ", 0
    len_label_user equ $ - label_user

    label_comp db "Computer's choice is: ", 0
    len_label_comp equ $ - label_comp

    choice_rock db "Rock", 0
    len_rock equ $ - choice_rock

    choice_paper db "Paper", 0
    len_paper equ $ - choice_paper

    choice_scissors db "Scissors", 0
    len_scissors equ $ - choice_scissors

    new_line db 10, 0

    msg_win db "YOU WON! ", 0
    len_win equ $ - msg_win

    msg_lose db "YOU LOST! ", 0
    len_lose equ $ - msg_lose

    msg_draw db "It's a DRAW! ", 0
    len_draw equ $ - msg_draw

    msg_invalid db "Invalid input!", 10, 0
    len_invalid equ $ - msg_invalid

    msg_rock_beats_scissors db "Rock beats Scissors because it crushes it.", 10, 0
    len_rbs equ $ - msg_rock_beats_scissors

    msg_paper_beats_rock db "Paper beats Rock because it covers it.", 10, 0
    len_pbr equ $ - msg_paper_beats_rock

    msg_scissors_beats_paper db "Scissors beat Paper because they cut it.", 10, 0
    len_sbp equ $ - msg_scissors_beats_paper

section .bss
    user_input resb 1
    user_val resb 1
    comp_val resb 1
    temp resb 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_input
    mov edx, len_input
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, user_input
    mov edx, 1
    int 0x80

    movzx eax, byte [user_input]
    sub eax, '0'
    cmp eax, 2
    ja invalid_choice
    mov [user_val], al

    rdtsc
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [comp_val], dl

    mov eax, 4
    mov ebx, 1
    mov ecx, label_user
    mov edx, len_label_user
    int 0x80

    movzx eax, byte [user_val]
    call print_choice

    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, label_comp
    mov edx, len_label_comp
    int 0x80

    movzx eax, byte [comp_val]
    call print_choice

    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80

    movzx eax, byte [user_val]
    movzx ebx, byte [comp_val]
    sub eax, ebx
    add eax, 3
    mov ecx, 3
    xor edx, edx
    div ecx

    cmp edx, 0
    je draw
    cmp edx, 1
    je win
    jmp lose

win:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_win
    mov edx, len_win
    int 0x80

    call explain
    jmp exit

lose:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_lose
    mov edx, len_lose
    int 0x80

    call explain
    jmp exit

draw:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_draw
    mov edx, len_draw
    int 0x80
    jmp exit

invalid_choice:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_invalid
    mov edx, len_invalid
    int 0x80

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_choice:
    cmp eax, 0
    je .rock
    cmp eax, 1
    je .paper
    cmp eax, 2
    je .scissors
    ret

.rock:
    mov eax, 4
    mov ebx, 1
    mov ecx, choice_rock
    mov edx, len_rock
    int 0x80
    ret

.paper:
    mov eax, 4
    mov ebx, 1
    mov ecx, choice_paper
    mov edx, len_paper
    int 0x80
    ret

.scissors:
    mov eax, 4
    mov ebx, 1
    mov ecx, choice_scissors
    mov edx, len_scissors
    int 0x80
    ret

explain:
    movzx eax, byte [user_val]
    movzx ebx, byte [comp_val]

    cmp eax, 0
    je .user_rock
    cmp eax, 1
    je .user_paper
    cmp eax, 2
    je .user_scissors
    ret

.user_rock:
    cmp ebx, 2
    je .show_rbs
    cmp ebx, 1
    je .show_pbr
    ret

.user_paper:
    cmp ebx, 0
    je .show_pbr
    cmp ebx, 2
    je .show_sbp
    ret

.user_scissors:
    cmp ebx, 1
    je .show_sbp
    cmp ebx, 0
    je .show_rbs
    ret

.show_rbs:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_rock_beats_scissors
    mov edx, len_rbs
    int 0x80
    ret

.show_pbr:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_paper_beats_rock
    mov edx, len_pbr
    int 0x80
    ret

.show_sbp:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_scissors_beats_paper
    mov edx, len_sbp
    int 0x80
    ret
