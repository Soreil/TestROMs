INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]

EntryPoint:
    di
    jp Start

REPT $150 - $104
    db 0
ENDR

SECTION "Functions", ROM0

StringFunctions:
.copyFont
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .copyFont
    ret

.copyString
    ld a, [de]
    ld [hli], a
    inc de
    and a
    jr nz, .copyString
    ret

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
    call StringFunctions.copyFont

    ld hl, $9800
    ld de, HelloWorldStr
    call StringFunctions.copyString

    ld hl, $9c00
    ld de, WindowStr
    call StringFunctions.copyString

    ld hl, $9c20
    ld de, OffByOneStr
    call StringFunctions.copyString

    ld a, %11100100
    ld [rBGP], a

    xor a
    ld [rSCY], a
    ld [rSCX], a
    ld [rNR52], a

    ld a, %11100001
    ld [rLCDC], a

    ld a, 8
    ld [rWY], a
    ld a, 7
    ld [rWX], a

    ;hang self
    .lockup
        jr .lockup
    
SECTION "Font", ROM0

FontTiles:
INCBIN "font.chr"
FontTilesEnd:


SECTION "Hello World string", ROM0
SECTION "Window string", ROM0

HelloWorldStr:
    db "Hello World!", 0

WindowStr:
    db "Lets see that window.", 0
OffByOneStr:
    db "yahoo off by 1 gamer.", 0