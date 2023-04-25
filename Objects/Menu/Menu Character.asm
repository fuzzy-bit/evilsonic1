; ---------------------------------------------------------------------------
; Character in the menu
; ---------------------------------------------------------------------------
MenuCharacter:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jsr		@Index(pc,d1.w)
		jmp		DisplaySprite

; ===========================================================================
@Index:	dc.w @Main-@Index
		dc.w @Slower-@Index
; ===========================================================================

@Main:	; Routine 0
		move.l	#Map_Poi, obMap(a0)
		move.w	#$2797, obGfx(a0)
		move.b	#4, obRender(a0)
		move.b	#1, obPriority(a0)
		move.b	#8, obActWid(a0)
		rts

@Slower:	; Routine 2
		tst.w	obVelY(a0)	; is object moving?
		bpl.w	@DeleteObject	; if not, delete
		jsr		SpeedToPos

		addi.w	#$18,obVelY(a0)	; reduce object	speed
		rts	

@DeleteObject:
		jsr 	DeleteObject