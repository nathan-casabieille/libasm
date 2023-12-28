section .text
global _strlen

; size_t _strlen(const char *s);

; Input:
;   RDI = str
; Output:
;   RAX = len

_strlen:
    ; Initialize rax to zero (default length is zero)
    xor rax, rax

    ; Check if the input string is NULL
    test rdi, rdi
    jz .done

    .count:
        ; Load the current character from the string into al
        mov dl, byte [rdi + rax]

        ; Check if the current character is null terminator
        cmp dl, 0
        je .done

        ; Increment rax to move to the next character in the string
        inc rax
        jmp .count

    .done:
        ; Return the length of the string (rax)
        ret
