section .data
    label_user db "Senin seçimin :",0
    len_label_user equ $ - label_user

    label_comp db "pc seçimi :",0
    len_label_comp equ $ - label_comp

section .bss
    user_input resb 2
    rand_num   resb 1
    user_val resb 2
    comp_val resb 1

section .text
    global _start

_start:

    ; -- input al --
    mov eax, 3        ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, user_input
    mov edx, 1
    int 0x80

    ;ASCII
    movzx eax, byte [user_input]
    sub eax, '0'
    cmp eax, 2
    mov [user_val], al

    ;kullanıcı seçimi alındı şidmi ekrana yazdıırlıyor
    mov eax,4
    mov ebx,1
    mov ecx, label_user
    mov edx, len_label_user
    int 0x80

    movzx eax, byte [user_val]
    add al,'0'
    mov [user_input], al


    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80



    ; -- zaman bilgisini al (random için) --
    mov eax, 13         ; sys_time
    xor ebx, ebx
    int 0x80            ; eax şimdi timestamp
    mov ebx, 3
    xor edx, edx
    div ebx             ; eax = eax / 3, edx = eax % 3
    add dl, '0'         ; sayıyı karaktere çevir

    ; -- yazdır: "Random number: X\n" --
    mov [rand_num], dl
    mov byte [rand_num+1], 10  ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, label_comp
    mov edx, len_label_comp
    int 0x80

    movzx eax, byte [rand_num]
    add al, '0'
    mov [user_input], al

    ; -- çıkış yap --
    mov eax, 1
    xor ebx, ebx
    int 0x80
