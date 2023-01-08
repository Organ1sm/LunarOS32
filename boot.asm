ORG 0
BITS 16

start:
    cli ; Clear Interrupts
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti ; Enables Interrupts
    mov si, message
    lodsb 

    call print
    jmp $

print:
    mov bx, 0
.loop:
    ; lodsb => load byte at address DS:ESI into EAX
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

; db => Define bytes
message db 'Hello World!', 0

times 510-($ - $$) db 0
dw 0xAA55