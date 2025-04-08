; rock_paper_scissors_win.asm
extern printf, scanf, srand, rand, ExitProcess, time
import printf msvcrt.dll
import scanf msvcrt.dll
import srand msvcrt.dll
import rand msvcrt.dll
import ExitProcess kernel32.dll
import time msvcrt.dll

section .data
    input_fmt db "%d", 0
    output_fmt db "%s", 10, 0
    user_label db "Your choice is: ", 0
    comp_label db "Computer's choice is: ", 0

    rock db "Rock", 0
    paper db "Paper", 0
    scissors db "Scissors", 0

    msg_win db "YOU WON!", 0
    msg_lose db "YOU LOST!", 0
    msg_draw db "It's a DRAW!", 0
    msg_invalid db "Invalid input!", 0

    msg_rbs db "Rock beats Scissors because it crushes it.", 0
    msg_pbr db "Paper beats Rock because it covers it.", 0
    msg_sbp db "Scissors beat Paper because they cut it.", 0

    prompt db "Enter your choice (0: Rock, 1: Paper, 2: Scissors): ", 0

section .bss
    user_input resd 1
    comp_input resd 1
    result resd 1

section .text
global main
main:
    ; srand(time(NULL))
    call time
    push eax
    call srand

    ; printf(prompt)
    push prompt
    call printf
    add esp, 4

    ; scanf("%d", &user_input)
    push user_input
    push input_fmt
    call scanf
    add esp, 8

    mov eax, [user_input]
    cmp eax, 0
    jl invalid
    cmp eax, 2
    jg invalid

    ; comp_input = rand() % 3
    call rand
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [comp_input], edx

    ; Show user choice
    push user_label
    call printf
    add esp, 4

    mov eax, [user_input]
    call print_choice

    ; Show comp choice
    push comp_label
    call printf
    add esp, 4

    mov eax, [comp_input]
    call print_choice

    ; result = (user - comp + 3) % 3
    mov eax, [user_input]
    sub eax, [comp_input]
    add eax, 3
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [result], edx

    cmp edx, 0
    je draw
    cmp edx, 1
    je win
    jmp lose

invalid:
    push msg_invalid
    call printf
    add esp, 4
    jmp done

draw:
    push msg_draw
    call printf
    add esp, 4
    jmp done

win:
    push msg_win
    call printf
    add esp, 4
    call explain
    jmp done

lose:
    push msg_lose
    call printf
    add esp, 4
    call explain
    jmp done

done:
    push 0
    call ExitProcess

print_choice:
    cmp eax, 0
    je .rock
    cmp eax, 1
    je .paper
    cmp eax, 2
    je .scissors
    ret

.rock:
    push rock
    call printf
    add esp, 4
    ret

.paper:
    push paper
    call printf
    add esp, 4
    ret

.scissors:
    push scissors
    call printf
    add esp, 4
    ret

explain:
    mov eax, [user_input]
    mov ebx, [comp_input]
    cmp eax, 0
    je .u_rock
    cmp eax, 1
    je .u_paper
    cmp eax, 2
    je .u_scissors
    ret

.u_rock:
    cmp ebx, 2
    je .rbs
    cmp ebx, 1
    je .pbr
    ret

.u_paper:
    cmp ebx, 0
    je .pbr
    cmp ebx, 2
    je .sbp
    ret

.u_scissors:
    cmp ebx, 1
    je .sbp
    cmp ebx, 0
    je .rbs
    ret

.rbs:
    push msg_rbs
    call printf
    add esp, 4
    ret

.pbr:
    push msg_pbr
    call printf
    add esp, 4
    ret

.sbp:
    push msg_sbp
    call printf
    add esp, 4
    ret
