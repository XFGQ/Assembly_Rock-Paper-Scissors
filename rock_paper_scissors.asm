section .data
    prompt db "Secimini gir (0: Tas, 1: Kagit, 2: Makas): ", 0
    prompt_len equ $ - prompt

    invalid_input db "Gecersiz giris!", 10, 0
    lose_msg db "Kaybettin!", 10, 0
    win_msg db "Kazandin!", 10, 0
    draw_msg db "Berabere!", 10, 0

section .bss
    user_choice resb 1
    computer_choice resb 1

section .text
    global _start

_start:
    ; Prompt göster
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    ; Kullanıcı girdisi al
    mov eax, 3
    mov ebx, 0
    mov ecx, user_choice
    mov edx, 1
    int 0x80

    ; Kullanıcı girdisini ASCII'den int'e çevir
    movzx eax, byte [user_choice]
    sub eax, '0'
    cmp eax, 2
    ja invalid
    mov [user_choice], al

    ; Bilgisayar rastgele seçim (0-2)
    ; Basit rastgele için: time() kullanmadan bir sayı seçeceğiz
    rdtsc
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [computer_choice], dl

    ; Oyun mantığı:
    ; 0: taş, 1: kağıt, 2: makas
    ; user == computer → draw
    ; (user - comp + 3) % 3 == 1 → win
    ; aksi halde lose
    

    movzx eax, byte [user_choice]
    movzx ebx, byte [computer_choice]
    sub eax, ebx
    add eax, 3
    mov ecx, 3
    xor edx, edx
    div ecx

    cmp eax, 0
    je draw
    cmp eax, 1
    je win
    jmp lose

draw:
    mov eax, 4
    mov ebx, 1
    mov ecx, draw_msg
    mov edx, 10
    int 0x80
    jmp exit

lose:
    mov eax, 4
    mov ebx, 1
    mov ecx, lose_msg
    mov edx, 11
    int 0x80
    jmp exit

win:
mov eax, 4
mov ebx, 1
mov ecx, win_msg
mov edx, 10
int 0x80
jmp exit

invalid:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_input
    mov edx, 16
    int 0x80

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
