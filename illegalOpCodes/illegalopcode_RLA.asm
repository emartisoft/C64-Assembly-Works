;=-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=
; Illegal Opcodes
;=-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=
; Generated by CBM prg Studio
; Check "Use unpublished opcodes" from Tools/Options/Assembler

; 10 SYS (2080)


*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28, $32
        BYTE    $30, $38, $30, $29, $00, $00, $00

*=$0820

        ; RLA {addr} = rol {addr}, a = a and {addr}
        ; rol addr
        ; and addr

        lda #$f0
        
        ; rol value
        ; and value
        ;-----------or
        rla value
        
        sta result
        rts

*=$0900

value   byte $0f
result  byte $00
