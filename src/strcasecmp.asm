section .text
global _strcasecmp

; int _strcasecmp(const char *s1, const char *s2);

; Input:
;   RDI = str1
;   RSI = str2
; Output:
;   RAX = 0 if the strings are equal

_strcasecmp:

    .loop:
        mov al, byte [rdi]    ; Load a byte from str1
        mov bl, byte [rsi]    ; Load a byte from str2

        cmp al, 65             ; Compare al (ASCII value) with 'A'
        jl .check_str2         ; Jump if al is less than 'A'
        cmp al, 90             ; Compare al (ASCII value) with 'Z'
        jg .check_str2         ; Jump if al is greater than 'Z'
        add al, 32             ; Convert uppercase to lowercase (ASCII)

    .check_str2:
        cmp bl, 65             ; Compare bl (ASCII value) with 'A'
        jl .compare_chars      ; Jump if bl is less than 'A'
        cmp bl, 90             ; Compare bl (ASCII value) with 'Z'
        jg .compare_chars      ; Jump if bl is greater than 'Z'
        add bl, 32             ; Convert uppercase to lowercase (ASCII)

    .compare_chars:
        cmp al, bl             ; Compare the lowercase characters
        jne .not_equal         ; Jump if they are not equal

        cmp al, 0              ; Check if we've reached the end of the strings
        je .equal              ; If yes, the strings are equal

        inc rdi                ; Move to the next character in str1
        inc rsi                ; Move to the next character in str2
        jmp .loop              ; Repeat the loop

    .equal:
        xor rax, rax           ; Set RAX to 0 (strings are equal)
        ret

    .not_equal:
        movzx rax, al          ; Move the ASCII value of the differing character to RAX
        sub rax, rbx           ; Calculate the difference between the characters
        ret