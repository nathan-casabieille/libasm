section .text
global _index

; char *index(const char *s, int c);

; Input:
;   RDI = string
;   RSI = char
; Output:
;   RAX = ptr to first occurrence of char in string

_index:
    ; Initialize rax to NULL
    xor rax, rax

    ; Check if the input string (s) is NULL or empty
    test rdi, rdi
    jz .done
    cmp byte [rdi], 0
    jz .done

    ; Check if the character (c) is NULL
    test rsi, rsi
    jz .done

    ; Start searching from the beginning of the string
    mov rax, rdi

    .search:
        cmp byte [rax], sil ; Compare the character at rax with c
        je .found
        inc rax
        cmp byte [rax], 0   ; Check if we have reached the end of the string
        jne .search

    .not_found:
        ; Set rax to NULL if the character is not found
        xor rax, rax
        ret

    .found:
        ret

    .done:
        ret
