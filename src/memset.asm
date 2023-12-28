section .text
global _memset

; void *_memset(void *s, int c, size_t n);

; Input:
;   RDI = dest
;   RSI = char
;   RDX = count

_memset:
    test    rdx, rdx     ; Test if n is zero
    jz      .done

    .set_loop:
        mov     [rdi], sil  ; Set the byte at s to the value of c
        inc     rdi         ; Move to the next byte in the destination
        dec     rdx         ; Decrement the count of bytes remaining
        jnz     .set_loop    ; Repeat the loop until count becomes zero

    .done:
        ret