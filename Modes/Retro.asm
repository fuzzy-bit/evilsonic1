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
        
        ; Palette
        moveq   #0, d0
        lea     (@PalettePointer).l, a1
        jsr     LoadUnindexedPalette1

        ; Music
        music   mus_retro

        ; Objects
        move.b  #1, (v_objspace+$40).w        ; Emerald
        move.b  #2, (v_objspace+$40*2).w      ; Sonic
        move.b  #3, (v_objspace+$40*3).w      ; 「ソニック・レトロ」

        ; Initialize
        bsr.w   @DrawLogo
        jsr     @ExecuteObjects
        jsr     BuildSprites
        jsr     PaletteFadeIn

        move.w  #13*60, (v_demolength).w

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
        dc.l    @Emerald   ; $01
        dc.l    @Sonic   ; $02
        dc.l    @Subtitle  ; $03
        dc.l    DeleteObject ; $04
        even

; ===========================================================================   

; ---------------------------------------------------------------------------
; Object 01 - Emerald
; ---------------------------------------------------------------------------   
@Emerald:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @EmeraldIndex(pc, d0.w), d1
        jmp     @EmeraldIndex(pc, d1.w)

@EmeraldIndex: 
        dc.w @EmeraldMain-@EmeraldIndex
        dc.w @EmeraldDisplay-@EmeraldIndex

@EmeraldMain:
        addq.b #2, obRoutine(a0)                ; Next Action (Display)
        move.w #$193, obX(a0)                   ; X Position
        move.w #$102, obScreenY(a0)             ; Y Position
        move.l #@EmeraldMappings, obMap(a0)     ; Mappings
        move.w #$100, obGfx(a0)                 ; Art Offset in VRAM
        move.b #0, obRender(a0)                 ; Render Flags
        move.b #4, obPriority(a0)               ; Sprite Priority (0 = Front)

@EmeraldDisplay:
        jmp DisplaySprite

; ---------------------------------------------------------------------------
; Object 02 - Sonic
; ---------------------------------------------------------------------------
@NextFrame:     equ $30
@FrameTimer:    equ $31
@Sonic:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @SonicIndex(pc, d0.w), d1
        jmp     @SonicIndex(pc, d1.w)

@SonicIndex:
        dc.w @SonicMain-@SonicIndex
        dc.w @SonicDisplay-@SonicIndex

@SonicMain:
        addq.b  #2, obRoutine(a0)               ; Next Action (Display)
        move.w  #$191, obX(a0)                  ; X Position
        move.w  #$E2, obScreenY(a0)             ; Y Position
        move.l  #@SonicMappings, obMap(a0)      ; Mappings
        move.w  #$157, obGfx(a0)                ; Art Offset in VRAM
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #3, obPriority(a0)              ; Sprite Priority (0 = Front)

@SonicDisplay:
        add.b   #1, @FrameTimer(a0)
        cmp.b   #$B, @FrameTimer(a0)
        blt.w   @SonicDisplayGo

        move.b  #0, @FrameTimer(a0)
        add.b   #1, @NextFrame(a0)
        cmp.b   #2, @NextFrame(a0)
        bne.w   @SonicDisplayGo

        move.b  #0, @NextFrame(a0)

@SonicDisplayGo:
        move.b  @NextFrame(a0), obFrame(a0)
        jmp     DisplaySprite

; ---------------------------------------------------------------------------
; Object 03 - 「ソニック・レトロ」
; ---------------------------------------------------------------------------   
@Subtitle:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @SubtitleIndex(pc, d0.w), d1
        jmp     @SubtitleIndex(pc, d1.w)

@SubtitleIndex: 
        dc.w @SubtitleMain-@SubtitleIndex
        dc.w @SubtitleDisplay-@SubtitleIndex

@SubtitleMain:
        addq.b  #2, obRoutine(a0)               ; Next Action (Display)
        move.w  #$124, obX(a0)                  ; X Position
        move.w  #$FF, obScreenY(a0)             ; Y Position
        move.l  #@SubtitleMappings, obMap(a0)   ; Mappings
        move.w  #$0, obGfx(a0)                  ; Art Offset in VRAM
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #0, obPriority(a0)              ; Sprite Priority (0 = Front)

@SubtitleDisplay:
        jmp     DisplaySprite

; ====================================================================================

@DrawLogo:
        lea     @LogoMappings, a0   ; Put the mappings into d0
        lea     ($FF0000), a1       ; ...and the location to decompress in a1
        move.w  #0, d0              ; VRAM 0ffset (not per-tile)
        jsr     EniDec.w            ; Decompress!

        move.l  #$60000003, d0      ; What plane? BG B!
        moveq   #39, d1             ; Width
        moveq   #30, d2             ; Height
        jsr     TilemapToVRAM       ; And we're good to go~
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
@LogoArt: incbin "Data/Art/Nemesis/Sonic Retro - Logo.bin"
    even

@EmeraldArt: incbin "Data/Art/Nemesis/Sonic Retro - Emerald.bin"
    even
@EmeraldMappings: include "Data/Mappings/Sprites/RetroEmerald.asm"
    even

@SonicArt: incbin "Data/Art/Nemesis/Sonic Retro - Sonic.bin"
    even
@SonicMappings: include "Data/Mappings/Sprites/RetroSonic.asm"
    even

@SubtitleMappings: include "Data/Mappings/Sprites/RetroSubtitle.asm"
    even

@Palette: incbin "Data/Palette/Sonic Retro.bin"
    even
@PalettePointer: PalettePointer @Palette, v_pal_dry, $2F
    even