section .text
global _strcmp

; int _strcmp(const char *s1, const char *s2);

; Input:
;   RDI = str1
;   RSI = str2
; Output:
;   RAX = 0 if the strings are equal

_strcmp:

    ; Initialize rax to zero (égalité par défaut)
    xor rax, rax

    ; Check if the input strings (s1 and s2) are NULL
    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done

    .compare:
        ; Load the current characters from both strings into al and bl
        mov al, byte [rdi]
        mov bl, byte [rsi]

        ; Compare the current characters
        cmp al, bl
        jne .not_equal

        ; Check if we have reached the end of both strings
        cmp al, 0
        je .done

        ; Move to the next characters in both strings
        inc rdi
        inc rsi
        jmp .compare

    .not_equal:
        ; Set rax to the difference between the characters
        movzx rax, al
        sub rax, rbx
        ret

    .done:
        ret
