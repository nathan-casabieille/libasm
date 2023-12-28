section .text
global _write

; ssize_t _write(int fd, const void *buf, size_t count);

; Input:
;   RDI = fd
;   RSI = buffer
;   RDX = count

_write:
    mov rax, 1         ; syscall number for sys_write (1)
    syscall            ; Invoke the write system call

    cmp rax, 0         ; Check the return value (rax) for errors (negative values)
    js error           ; If the result is negative (error), jump to the error label

    ret                ; Return normally if write was successful

error:
    neg rax            ; Negate the error code to make it positive
    mov rdi, rax       ; Move the error code to rdi (used for error reporting)
    mov rax, -1        ; Set rax to -1 (indicating an error)
    ret                ; Return with an error code in rax