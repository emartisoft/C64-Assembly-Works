; 10 SYS (4096)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00


*=$1000
        jsr $e544       ; clear screen
        lda #<pressanykey
        ldy #>pressanykey
        jsr $ab1e
        
        jsr $ffe4       ; press any key to continue
        beq *-3
        
        ; load a file
        lda #end-filename
        ldx #<filename
        ldy #>filename
        jsr $ffbd     ; call setnam

        lda #$01
        ldx $ba       ; last used device number
        bne skip
        ldx #$08      ; default to device 8

skip    ldy #$00      ; not $01 means: load to address stored in file
        jsr $ffba     ; call setlfs

        ldx #$00
        ldy #$60      ; load address is $6000
        lda #$00
        jsr $ffd5     ; call load
        bcs error     ; if carry set, a load error has happened
        
        lda #<fileloaded
        ldy #>fileloaded
        jsr $ab1e
        rts
error
        ; accumulator contains basic error code
        cmp #$00
        beq break
        cmp #$05
        beq devicenotpresent
        cmp #$04
        beq filenotfound
        cmp #$1d
        beq loaderror
        rts
break   
        lda #<tbreak
        ldy #>tbreak
        jsr $ab1e
        rts
devicenotpresent
        lda #<tdevicenotpresent
        ldy #>tdevicenotpresent
        jsr $ab1e
        rts
filenotfound
        lda #<tfilenotfound
        ldy #>tfilenotfound
        jsr $ab1e
        rts
loaderror
        lda #<tloaderror
        ldy #>tloaderror
        jsr $ab1e
        rts

filename
        text "sadwoman.pic"
end     

fileloaded
        text "file is loaded"
        byte $0d, $00
tbreak
        text "?break, run/stop has been pressed during loading"
        byte $0d, $00
tdevicenotpresent
        text "?device not present"
        byte $0d, $00
tfilenotfound
        text "?file not found"
        byte $0d, $00
tloaderror
        text "?load error"
        byte $0d, $00
pressanykey
        byte $0d,$0d
        text "press any key to load a file"
        byte $0d
        text "(sadwoman.pic) to $6000 address"
        byte $0d, $00
