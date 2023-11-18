; ---------------------------------------------------------------------------
; Object 01 - Emerald
; ---------------------------------------------------------------------------   
RetroEmerald:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @Index(pc, d0.w), d1
        jmp     @Index(pc, d1.w)

@Index: 
        dc.w @Init-@Index
        dc.w @Main-@Index

@Init:
        addq.b  #2, obRoutine(a0)                ; Next Action (Main)
        move.w  #$193, obX(a0)                   ; X Position
        move.w  #$102, obScreenY(a0)             ; Y Position
        move.l  #@EmeraldMappings, obMap(a0)     ; Mappings
        move.w  #$100, obGfx(a0)                 ; Art Offset in VRAM
        move.b  #0, obRender(a0)                 ; Render Flags
        move.b  #4, obPriority(a0)               ; Sprite Priority (0 = Front)

        tst.b   obSubtype(a0)
        beq.s   @Main

        move.w  #$30, obScreenY(a0)

@Main:
        tst.b   obSubtype(a0)
        beq.s   @Display

        cmpi.w  #745, (v_demolength).w
        bgt.s   @Display

        cmpi.w  #$102, obScreenY(a0)
        bgt.s   @Bloody

        jsr     ScreenObjectFall
        jsr     SpeedToPos
        jmp     @Display

@Bloody:
        move.b  #3, obFrame(a0)

@Display:
        jmp     DisplaySprite

; ====================================================================================

@EmeraldMappings: include "Data/Mappings/Sprites/RetroEmerald.asm"
    even