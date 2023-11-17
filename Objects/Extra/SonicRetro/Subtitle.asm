; ---------------------------------------------------------------------------
; Object 03 - 「ソニック・レトロ」
; ---------------------------------------------------------------------------   
RetroSubtitle:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @Index(pc, d0.w), d1
        jmp     @Index(pc, d1.w)

@Index:
        dc.w @Main-@Index
        dc.w @Display-@Index

@Main:
        addq.b  #2, obRoutine(a0)               ; Next Action (Display)
        move.w  #$124, obX(a0)                  ; X Position
        move.w  #$FF, obScreenY(a0)             ; Y Position
        move.l  #@SubtitleMappings, obMap(a0)   ; Mappings
        move.w  #$0, obGfx(a0)                  ; Art Offset in VRAM
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #0, obPriority(a0)              ; Sprite Priority (0 = Front)

@Display:
        jmp     DisplaySprite

; ====================================================================================

@SubtitleMappings: include "Data/Mappings/Sprites/RetroSubtitle.asm"
    even