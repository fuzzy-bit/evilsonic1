; ---------------------------------------------------------------------------
; Letters in the Sega Screen
; ---------------------------------------------------------------------------
SegaLetter:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc, d0.w), d1
		jmp		@Index(pc, d1.w)

; ===========================================================================
@Index:	dc.w @Init-@Index
		dc.w @Main-@Index
; ===========================================================================

@Init:	; Routine 0
		move.w	#$120, obX(a0)
		move.w	#$DE, obScreenY(a0)
		move.l	#Map_SegaLogo, obMap(a0)
		move.w	#$200/$20, obGfx(a0)
		move.b	#0, obRender(a0)
		move.b	#1, obPriority(a0)
		move.b	#8, obActWid(a0)
		move.b	#10,obDelayAni(a0) ; set time delay to 0.5 seconds
		addq.b	#2, obRoutine(a0)

@Main:
		jsr 	ScreenObjectFall
		jmp		DisplaySprite

@DeleteObject:
		jmp 	DeleteObject