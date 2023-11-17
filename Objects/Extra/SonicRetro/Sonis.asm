; ---------------------------------------------------------------------------
; Object 04 - Sonis
; ---------------------------------------------------------------------------   
RetroSonis:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @Index(pc, d0.w), d1
        jmp     @Index(pc, d1.w)

@NextFrame:     equ $30
@FrameTimer:    equ $31

@Index: 
        dc.w @Main-@Index
        dc.w @Display-@Index

@Main:
        addq.b  #2, obRoutine(a0)               ; Next Action (Display)
        move.w  #$191, obX(a0)                  ; X Position
        move.w  #$E2, obScreenY(a0)             ; Y Position
        move.l  #RetroSonicMappings, obMap(a0)  ; Mappings
        move.w  #$157, obGfx(a0)                ; Art Offset in VRAM
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #3, obPriority(a0)              ; Sprite Priority (0 = Front)
        move.b  #2, obFrame(a0)                 ; Mapping Frame

@Display:
        add.b   #1, @FrameTimer(a0)
        cmp.b   #$8, @FrameTimer(a0)
        blt.w   @DisplayGo

        move.b  #0, @FrameTimer(a0)
        add.b   #1, @NextFrame(a0)
        cmp.b   #2, @NextFrame(a0)
        bne.w   @DisplayGo

        move.b  #0, @NextFrame(a0)
        
@DisplayGo:
        move.b  @NextFrame(a0), obRender(a0)
        jmp     DisplaySprite