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

@Init:
        addq.b  #2, obRoutine(a0)               ; Next Action (Main)
        move.w  #$191, obX(a0)                  ; X Position
        move.w  #$E2, obScreenY(a0)             ; Y Position
        move.l  #Map_Sonic, obMap(a0)           ; Mappings
        move.b  #0, obRender(a0)                ; Action Flags
        move.b  #0, obPriority(a0)              ; Sprite Priority (0 = Front)
		move.b	#0, obDPLCFrame(a0)

@Main:
        move.b	#$FF, obDPLCFrame(a0)

        lea     (SonAni_Run).l, a1
        jsr     AnimateSprite

		lea		@DPLCConfig(pc), a6
		jsr		UpdateDPLC
        
        jmp     DisplaySprite

; ====================================================================================

@DPLCConfig:
	dc.l	PLC_Sonic   ; DPLC pointer
	dc.l	Art_Sonic   ; Art pointer
	dc.w	$184*20     ; VRAM address