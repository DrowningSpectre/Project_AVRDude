.include "tn85def.inc"
.equ SlaveAddress = 0x3C

.org 0x0000
    rjmp init

init:
    ; PB0 (SDA) and PB2 (SCL) as Output
    ldi r16, (1 << PB0) | (1 << PB2)
    out DDRB, r16
    ; Initial High for SDA and SCL
    sbi PORTB, PB0
    sbi PORTB, PB2

    rcall i2c_init
    rcall display_init
    rjmp main

i2c_init:
    ; USI for Two-Wire-Modus configuration
    ldi r16, (1 << USIWM0)  ; USIWM1:0 = 01 (Two-Wire)
    out USICR, r16
    ret

display_init:
    rcall i2c_start

    ; send Slave-Adresse (Write-Mode)
    ldi r16, (SlaveAddress << 1)
    rcall i2c_write

    ; control byte for commandos (0x00)
    ldi r16, 0x00
    rcall i2c_write

    ; SSD1306 Initialize (Example for 128x32 OLED)
    ldi r16, 0xAE         ; Display OFF
    rcall i2c_write
    ldi r16, 0xD5         ; Set Display Clock Divide Ratio
    rcall i2c_write
    ldi r16, 0x80         ; Default value
    rcall i2c_write
    ldi r16, 0xA8         ; Set Multiplex Ratio
    rcall i2c_write
    ldi r16, 0x1F         ; 32 Zeilen (für 128x32)
    rcall i2c_write
    ldi r16, 0xD3         ; Set Display Offset
    rcall i2c_write
    ldi r16, 0x00         ; Kein Offset
    rcall i2c_write
    ldi r16, 0x40         ; Set Start Line
    rcall i2c_write
    ldi r16, 0x8D         ; Charge Pump Setting
    rcall i2c_write
    ldi r16, 0x14         ; Enable Charge Pump
    rcall i2c_write
    ldi r16, 0x20         ; Memory Addressing Mode
    rcall i2c_write
    ldi r16, 0x00         ; Horizontal Mode
    rcall i2c_write
    ldi r16, 0xA1         ; Segment Remap
    rcall i2c_write
    ldi r16, 0xC8         ; COM Output Scan Direction
    rcall i2c_write
    ldi r16, 0xDA         ; COM Pins Hardware Config
    rcall i2c_write
    ldi r16, 0x02         ; Für 128x32
    rcall i2c_write
    ldi r16, 0x81         ; Set Contrast
    rcall i2c_write
    ldi r16, 0x7F         ; Mittelwert
    rcall i2c_write
    ldi r16, 0xD9         ; Pre-charge Period
    rcall i2c_write
    ldi r16, 0xF1         ; Default
    rcall i2c_write
    ldi r16, 0xDB         ; VCOMH Deselect Level
    rcall i2c_write
    ldi r16, 0x40         ; Default
    rcall i2c_write
    ldi r16, 0xA4         ; Entire Display ON
    rcall i2c_write
    ldi r16, 0xA6         ; Normal Display (don't invert)
    rcall i2c_write
    ldi r16, 0xAF         ; Display ON
    rcall i2c_write

    rcall i2c_stop
    ret

i2c_start:
    ; START: SDA high → low on SCL high
    sbi PORTB, PB2        ; SCL high
    cbi PORTB, PB0        ; SDA low
    cbi PORTB, PB2        ; SCL low
    ret

i2c_stop:
    ; STOP: SDA low → high on SCL high
    cbi PORTB, PB0        ; SDA low
    sbi PORTB, PB2        ; SCL high
    sbi PORTB, PB0        ; SDA high
    ret

i2c_write:
    ; Byte in r16 send over USI
    out USIDR, r16
    ldi r17, 8            ; 8 Bits
    ldi r16, (1 << USIOIF) | (8)  ; counter set to 8
    out USISR, r16
i2c_write_loop:
    sbi PORTB, PB2        ; SCL high
    cbi PORTB, PB2        ; SCL low
    sbis USISR, USIOIF    ; waiting for transmission
    rjmp i2c_write_loop
    ; ACK ignore (for simplicity)
    sbi PORTB, PB2        ; SCL high für ACK
    cbi PORTB, PB2        ; SCL low
    ret

main:
    ; test: fill display with 0xFF  (all Pixel on)
    rcall i2c_start
    ldi r16, (SlaveAddress << 1)
    rcall i2c_write
    ldi r16, 0x40         ; control byte for Data
    rcall i2c_write
    ldi r18, 128          ; 128 Bytes (one line)
fill_loop:
    ldi r16, 0xFF         ; all Pixel on
    rcall i2c_write
    dec r18
    brne fill_loop
    rcall i2c_stop

    rjmp main             ; forever loop