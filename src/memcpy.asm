section .text
global _memcpy

; void *_memcpy(void *dest, const void *src, size_t n);

; Input:
;   RDI = dest
;   RSI = src
;   RDX = len

_memcpy:
    cmp rdx, 0       ; Check if the length is zero
    je .end

    mov rax, rdi     ; Copy the destination pointer to rax
    mov rcx, rdx     ; Copy the length to rcx

    .copy_loop:
        mov bl, byte [rsi + rcx - 1]   ; Load a byte from source
        mov [rdi + rcx - 1], bl        ; Store the byte in destination
        loop .copy_loop                ; Continue until rcx becomes 0

    .end:
        ret