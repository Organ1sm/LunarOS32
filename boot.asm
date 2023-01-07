ORG 0x7c00
BITS 16

start:
    mov si, message
    call print
    jmp $

print:
    mov bx, 0
.loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char:
    ; Display a character on the screen
    ; advancing the cursor and scrolling the screen as necessary
    ; http://www.ctyme.com/intr/rb-0106.htm
    mov ah, 0eh
    int 0x10
    ret


message db 'Hello World!', 0

times 510-($ - $$) db 0
dw 0xAA55