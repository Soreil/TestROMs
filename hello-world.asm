INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]

EntryPoint:
    di
    jp Start

REPT $150 - $104
    db 0
ENDR

SECTION "Game code", ROM0

Start:
.waitVBlank
    ld a, [rLY]
    cp 144
    jr c, .waitVBlank
    xor a
    ld [rLCDC], a
    ld hl, $9000
    ld de, FontTiles
    ld bc, FontTilesEnd - FontTiles
.copyFont
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .copyFont

    ld hl, $9800
    ld de, HelloWorldStr
.copyString
    ld a, [de]
    ld [hli], a
    inc de
    and a
    jr nz, .copyString

    ld a, %11100100
    ld [rBGP], a

    xor a
    ld [rSCY], a
    ld [rSCX], a
    ld [rNR52], a

    ld a, %10000001
    ld [rLCDC], a

    ;hang self
    .lockup
        jr .lockup
    
SECTION "Font", ROM0

FontTiles:
INCBIN "font.chr"
FontTilesEnd:


SECTION "Hello World string", ROM0

HelloWorldStr:
    db "Hello World!", 0