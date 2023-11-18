; ---------------------------------------------------------------------------
; Object 05 - Running Sonic
; ---------------------------------------------------------------------------   
RetroRunningSonic:
        moveq   #0, d0
        move.b  obRoutine(a0), d0
        move.w  @Index(pc, d0.w), d1
        jmp     @Index(pc, d1.w)

@Index:
        dc.w @Init-@Index
        dc.w @Main-@Index
        dc.w @Crushed-@Index

@Init:
        addq.b  #2, obRoutine(a0)               ; Next Action (Main)
        move.w  #$172, obGfx(a0)                ; Art Offset in VRAM
        move.w  #$20, obX(a0)                   ; X Position
        move.w  #$102, obScreenY(a0)            ; Y Position
        move.l  #RetroSonicMappings, obMap(a0)  ; Mappings
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #0, obPriority(a0)              ; Sprite Priority (0 = Front)
        move.b  #$A, obVelX(a0)                 ; nyooom

@Main:
        lea	    (@Animation).l, a1
        jsr     AnimateSprite

        cmpi.w  #740, (v_demolength).w
        bgt.s   @Display

        cmpi.w  #$190, obX(a0)
        bgt.s   @ModsCrushHisSkull

        jsr     SpeedToPos
        jsr     @Display

        rts

@ModsCrushHisSkull:
        addq.b  #2, obRoutine(a0)
		move.w	#0, obVelX(a0)
		move.w	#-$500, obVelY(a0)
        move.b  #7, obFrame(a0)
        move.b  #4, (v_flashtimer).w
        sfx     sfx_violence

@Crushed:
        cmpi.w  #$190, obScreenY(a0)
        bgt.s   @Display

        jsr     ScreenObjectFall

@Display:
        jmp     DisplaySprite

; ====================================================================================

@Animation: dc.w @Run-@Animation
@Run:       dc.b afEnd, 3, 4, 5, 6, afEnd, afEnd, afEnd, afEnd, afEnd
		even