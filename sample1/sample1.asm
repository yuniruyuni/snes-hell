.setcpu "65816"
.autoimport on

.segment "STARTUP"

.proc Reset
    ; ----- disable intrupt
    sei

    ; ----- start native mode
    clc
    xce

    ; ----- set databank register to 0
    phk
    plb

    ; ----- start 8bit mode
    sep #$20

    ; ----- start force blank
    lda #%10000000
    sta $2100

    ; ----- setup color add mode
    ; just using background color.
    lda #%00100000
    sta $2131

    ; ----- example1's topic: setup background fixed color.
    ; 実際には各信号線は「青/緑/赤/強さを2進数5桁」の並び
    ; "青"は、後ろの「強さ」信号線を青の明るさとして登録することを、
    ; "緑"は、後ろの「強さ」信号線を緑の明るさとして登録することを、
    ; "赤"は、後ろの「強さ」信号線を赤の明るさとして登録することを、
    ; それぞれ意味するので、これは結局「めっちゃ強く青を光らせなさい」ってこと。
    ; ということはこのサンプルは...?!?!?!?!?!
    .byte 169, %10011111
    .byte 141, $32, $21
    .byte 169, %01000000
    .byte 141, $32, $21
    .byte 169, %00100000
    .byte 141, $32, $21

    ; ----- finish forced blank
    lda #%00001111
    sta $2100

mainloop:

    jmp    mainloop

    rti

.endproc

.segment "CARTINFO"
    .byte "YUNIRU SAMPLE 1       " ; ROM Title
    .byte $01                      ; HiRom: 0x01, FastROM: 0x30
    .byte $05                      ; ROM(2nk bytes)
    .byte $00                      ; RAM(8nk bytes)
    .word $0001                    ; Developper ID
    .byte $00                      ; Version
    .byte $7f, $73, $80, $8c       ; Fixed values
    .byte $ff, $ff, $ff, $ff       ; Fixed values

    .word $0000                    ; Native:COP
    .word $0000                    ; Native:BRK
    .word $0000                    ; Native:ABORT
    .word $0000                    ; Native:NMI
    .word $0000                    ;
    .word $0000                    ; Native:IRQ

    .word $0000
    .word $0000

    .word $0000                    ; Emulation:COP
    .word $0000                    ;
    .word $0000                    ; Emulation:ABORT
    .word $0000                    ; Emulation:NMI
    .word Reset                    ; Emulation:RESET
    .word $0000                    ; Emulation:IRQ/BRK
