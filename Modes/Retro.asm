; ---------------------------------------------------------------------------
; Sonic Retro
; ---------------------------------------------------------------------------
SonicRetro:
        music   mus_stop
        
        jsr     PaletteFadeOut
        jsr     ClearScreen
        jsr     ClearPLC

        lea     (v_objspace).w, a0
        move.l  #$7FF, d0
        moveq   #0, d1

@ClearObjectRAM:
        move.l  d1, (a0)+
        dbra    d0, @ClearObjectRAM

        lea     (vdp_control_port).l, a6
        move.w  #$9011, (a6)

        ; Logo
        locVRAM $0
        lea     (@LogoArt).l, a0
        jsr     NemDec

        ; Emerald
        locVRAM $100*$20
        lea     (@EmeraldArt).l, a0
        jsr     NemDec
        
        ; Sonic
        locVRAM $155*$20
        move.l  #$6AE00000, (vdp_control_port).l
        lea     (@SonicArt).l, a0
        jsr     NemDec
        
        ; RESERVED DPLC GRAPHICS - RUNNING SONIC
        ; TILE $184

        ; Palette
        moveq   #0, d0
        lea     (@PalettePointer).l, a1
        jsr     LoadUnindexedPalette1

        ; Music
        music   mus_retro

        jsr	    RandomNumber
        andi.w  #$08, d0
        
	    jsr	    @InitRoutines(pc, d0)
        jmp     @Loop

; ====================================================================================

@InitRoutines:
        bra.w   @Default
        bra.w   @SonisRetros
        bra.w   @EmeraldFall
        bra.w   @EmeraldFall

; ====================================================================================

@Default:
        ; Objects
        move.b  #1, (v_objspace+$40).w        ; Emerald
        move.b  #2, (v_objspace+$40*2).w      ; Sonic
        move.b  #3, (v_objspace+$40*3).w      ; 「ソニック・レトロ」

        ; Initialize
        lea     @LogoMappings, a0
        bsr.w   @DrawLogo

        jsr     @ExecuteObjects
        jsr     BuildSprites
        jsr     PaletteFadeIn

        move.w  #13*60, (v_demolength).w
        rts

@SonisRetros:
        ; Objects
        move.b  #1, (v_objspace+$40).w        ; Emerald
        move.b  #4, (v_objspace+$40*2).w      ; Sonis
        move.b  #3, (v_objspace+$40*3).w      ; 「ソニック・レトロ」
        move.b  #1, (v_objspace+$40*3+$1A)    ; ^ Frame

        ; Initialize
        lea     @SonisLogoMappings, a0
        bsr.w   @DrawLogo

        moveq   #0, d0
        lea     (@SonisPalettePointer).l, a1
        jsr     LoadUnindexedPalette1

        jsr     @ExecuteObjects
        jsr     BuildSprites
        jsr     PaletteFadeIn

        move.w  #13*60, (v_demolength).w
        rts

@EmeraldFall:
        ; Objects
        move.b  #1, (v_objspace+$40).w        ; Emerald
        move.b  #5, (v_objspace+$40*2).w      ; Running Sonic
        move.b  #3, (v_objspace+$40*3).w      ; 「ソニック・レトロ」

        ; Initialize
        lea     @LogoMappings, a0
        bsr.w   @DrawLogo

        jsr     @ExecuteObjects
        jsr     BuildSprites
        jsr     PaletteFadeIn

        move.w  #13*60, (v_demolength).w
        rts

; ====================================================================================

@Loop:
        move.b  #$4, (v_vbla_routine).w
        jsr     WaitForVBla
        jsr     @ExecuteObjects
        jsr     BuildSprites

        tst.b   Joypad|Press
        bmi.w   @Exit

        tst.w   (v_demolength).w
        beq.w   @Exit
        
        bra.s   @Loop

; ====================================================================================

@ExecuteObjects:
        lea     (v_objspace).w, a0
        moveq   #$7F, d7
        moveq   #0, d0

@IterateObjects:
        ; Load object number from a0
        move.b  (a0), d0
        beq.s   @NextObject

        ; Do some quick increments 
        add.w   d0, d0
        add.w   d0, d0

        ; Run the object
        movea.l @ObjectIndex-4(pc, d0.w), a1
        jsr     (a1)
        
        moveq   #0, d0
        
@NextObject:
        lea     $40(a0), a0         ; Increment a0 by $40
        dbf     d7, @IterateObjects ; If we're still in object space, continue
        rts

; ===========================================================================   

@ObjectIndex:
        dc.l    RetroEmerald   ; $01
        dc.l    RetroSonic   ; $02
        dc.l    RetroSubtitle  ; $03
        dc.l    RetroSonis ; $04
        dc.l    RetroRunningSonic ; $05
        even

; ====================================================================================

@DrawLogo:
        lea     ($FF0000), a1                   ; ...and the location to decompress in a1
        move.w  #0, d0                          ; VRAM 0ffset (not per-tile)
        jsr     EniDec.w                        ; Decompress!

        move.l  #$60000003, d0                  ; What plane? BG B!
        moveq   #39, d1                         ; Width
        moveq   #30, d2                         ; Height
        jsr     TilemapToVRAM                   ; And we're good to go~
        rts

; ====================================================================================

@Exit:
        music   mus_stop    
        jsr     PaletteFadeOut
        move.b  #id_Title, (v_gamemode).w
        rts

; ====================================================================================

@LogoMappings: incbin "Data/Mappings/TileMaps/RetroLogo.bin"
    even
@SonisLogoMappings: incbin "Data/Mappings/TileMaps/RetroLogoSonis.bin"
    even
@LogoArt: incbin "Data/Art/Nemesis/Sonic Retro - Logo.bin"
    even

@EmeraldArt: incbin "Data/Art/Nemesis/Sonic Retro - Emerald.bin"
    even
@SonicArt: incbin "Data/Art/Nemesis/Sonic Retro - Sonic.bin"
    even

@Palette: incbin "Data/Palette/Sonic Retro.bin"
    even
@SonisPalette: incbin "Data/Palette/Sonis Retros.bin"
    even

@PalettePointer: PalettePointer @Palette, v_pal_dry, $2F
    even
@SonisPalettePointer: PalettePointer @SonisPalette, v_pal_dry, $2F
    even

; ====================================================================================

    include "Objects/Extra/SonicRetro/Emerald.asm"
    include "Objects/Extra/SonicRetro/Sonic.asm"
    include "Objects/Extra/SonicRetro/Subtitle.asm"
    include "Objects/Extra/SonicRetro/Sonis.asm"
    include "Objects/Extra/SonicRetro/RunningSonic.asm"

; ===========================================================================   

RetroSonicMappings: include "Data/Mappings/Sprites/RetroSonic.asm"
    even