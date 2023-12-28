section .text
global _rindex

; char *_rindex(const char *s, int c);

; Input:
;   RDI = str
;   RSI = char
; Output:
;   RAX = ptr to last occurence of char in str

_rindex:
    ; Initialize rax to NULL
    xor rax, rax

    ; Check if the input string (s) is NULL
    test rdi, rdi
    jz .done

    ; Check if the character (c) is NULL
    test rsi, rsi
    jz .done

    ; Calculate the length of the string (s)
    xor rcx, rcx
    mov rax, rdi

    .loop:
        cmp byte [rax + rcx], 0
        je .search
        inc rcx
        jmp .loop

    .search:
        ; Decrement rcx to get the length of the string excluding the null terminator
        dec rcx

        ; Start searching from the end of the string
        mov rax, rdi
        add rax, rcx

        ; Search for the character (c) in reverse order

    .reverse_loop:
        cmp byte [rax], sil ; Compare the character at rax with c
        je .found
        dec rax
        cmp rax, rdi       ; Check if we have reached the beginning of the string
        jl .not_found
        jmp .reverse_loop

    .found:
        ret

    .not_found:
        ; Set rax to NULL if the character is not found
        xor rax, rax
        ret

    .done:
        ret