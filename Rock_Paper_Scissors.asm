section .data
    msg_input db "Secimini gir (0: Tas, 1: Kagit, 2: Makas): ", 0
    len_input equ $ - msg_input

    label_user db "Senin choice : ", 0
    len_label_user equ $ - label_user

    label_comp db "Computer choice : ", 0
    len_label_comp equ $ - label_comp

    new_line db 10, 0

    msg_win db "Kazandin!", 10, 0
    len_win equ $ - msg_win

    msg_lose db "Kaybettin!", 10, 0
    len_lose equ $ - msg_lose

    msg_draw db "Berabere!", 10, 0
    len_draw equ $ - msg_draw

    msg_invalid db "Gecersiz giris!", 10, 0
    len_invalid equ $ - msg_invalid

section .bss
    user_input resb 1
    user_val resb 1
    comp_val resb 1
    comp_ascii resb 1

section .text
    global _start

_start:

    ; Kullanıcıdan seçim al
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

    ; ASCII → int
    movzx eax, byte [user_input]
    sub eax, '0'
    cmp eax, 2
    ja invalid_choice
    mov [user_val], al

    ; Bilgisayar seçimi (0-2)
    rdtsc
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [comp_val], dl

    ; --------- YAZDIR: Kullanıcı Seçimi ----------
    mov eax, 4
    mov ebx, 1
    mov ecx, label_user
    mov edx, len_label_user
    int 0x80

    movzx eax, byte [user_val]
    add al, '0'
    mov [user_input], al

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80

    ; --------- YAZDIR: Bilgisayar Seçimi ----------
    mov eax, 4
    mov ebx, 1
    mov ecx, label_comp
    mov edx, len_label_comp
    int 0x80

    movzx eax, byte [comp_val]
    add al, '0'
    mov [comp_ascii], al

    mov eax, 4
    mov ebx, 1
    mov ecx, comp_ascii
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80

    ; --------- Oyun sonucu hesapla ----------
    movzx eax, byte [user_val]
movzx ebx, byte [comp_val]
sub eax, ebx
add eax, 3
mov ecx, 3
xor edx, edx
div ecx        ; edx = (user - comp + 3) % 3

cmp edx, 0
je draw
cmp edx, 1
je win
jmp lose


; -------- MESAJLAR --------
win:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_win
    mov edx, len_win2
    int 0x80
    jmp exit

lose:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_lose
    mov edx, len_lose
    int 0x80
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
