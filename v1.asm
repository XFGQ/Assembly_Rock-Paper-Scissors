section .bss
    user_input resb 5
    rand_num   resb 4

section .text
    global _start

_start:

    ; -- input al --
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, user_input
    mov edx, 5
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
    mov ecx, rand_num
    mov edx, 2
    int 0x80

    ; -- çıkış yap --
    mov eax, 1
    xor ebx, ebx
    int 0x80
