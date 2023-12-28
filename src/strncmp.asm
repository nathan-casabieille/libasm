section .text
global _strncmp

; int _strncmp(const char *s1, const char *s2, size_t n);

; Input:
;   RDI = Pointer to the first string 
;   RSI = Pointer to the second string
;   RDX = Number of bytes to compare
; Output:
;   RAX = 0 if the strings are equal

_strncmp:
    xor     rax, rax                ; Initialize the result to 0

    .loop:
        mov     al, byte [rdi]         ; Load the next byte from s1
        mov     bl, byte [rsi]         ; Load the next byte from s2
        cmp     al, bl                 ; Compare the bytes
        jne     .done                  ; If they are not equal, exit
        test    al, al                 ; Check if we reached the end of s1
        jz      .done                  ; If yes, exit (strings are equal)
        dec     rdx                    ; Decrement the remaining bytes to compare
        jz      .done                  ; If n bytes compared, exit
        inc     rdi                    ; Move to the next byte in s1
        inc     rsi                    ; Move to the next byte in s2
        jmp     .loop                  ; Repeat the loop

    .done:
        sub     rax, rbx                ; Calculate the result as s1 - s2
        ret
