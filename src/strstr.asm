section .text
global _strstr

; char *strstr(const char *haystack, const char *needle);

; Input:
;   RDI = Pointer to the haystack string
;   RSI = Pointer to the needle string
; Output:
;   RAX = : Pointer to the beginning of the located substring, or NULL if not found

_strstr:
    ; Save registers
    push rbx
    push rdx

    ; Handle edge case where the needle is an empty string (always return haystack)
    cmp byte [rsi], 0
    je .found_needle

    .loop:
        ; Load current characters from haystack and needle
        lodsb                   ; Load next character from haystack (increments RDI)
        cmp al, byte [rsi]      ; Compare it with the first character of the needle
        je .check_needle        ; If equal, check the entire needle
        test al, al             ; Check for the null terminator in haystack
        jz .not_found           ; If null terminator is reached in haystack, return NULL
        jmp .loop

    .check_needle:
        ; Save the current position in haystack and the position of the first character in needle
        push rdi
        mov rbx, rdi            ; rbx points to the current position in haystack
        mov rcx, rsi            ; rcx points to the first character in needle

    .next_char:
        lodsb                   ; Load next character from haystack (increments RDI)
        lodsb                   ; Load next character from needle (increments RSI)
        cmp al, byte [rsi - 1]  ; Compare the characters
        jne .restore_positions  ; If not equal, restore positions and continue searching
        test al, al             ; Check for null terminator in needle
        jz .found_needle        ; If null terminator is reached in needle, we found the substring
        test al, al             ; Check for null terminator in haystack
        jz .not_found           ; If null terminator is reached in haystack, return NULL
        jmp .next_char

    .restore_positions:
        ; Restore the positions and continue searching
        pop rdi                 ; Restore RDI (position in haystack)
        mov rsi, rcx            ; Reset RSI to point to the first character in needle
        inc rbx                 ; Move to the next character in haystack
        mov rdi, rbx            ; Set RDI to the new position in haystack
        jmp .loop

    .found_needle:
        ; Calculate the position of the located substring and return it in RAX
        sub rdi, rcx            ; RDI now points to the beginning of the located substring
        mov rax, rdi

        ; Restore registers and return
        pop rdx
        pop rbx
        ret

    .not_found:
        ; Needle not found, return NULL
        mov rax, 0

        ; Restore registers and return
        pop rdx
        pop rbx
        ret
