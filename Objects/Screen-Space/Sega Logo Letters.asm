; ---------------------------------------------------------------------------
; Letters in the Sega Screen
; ---------------------------------------------------------------------------
SegaLetter:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc, d0.w), d1
		jmp		@Index(pc, d1.w)

@Bouncification: 		equ $3A

; ===========================================================================
@Index:	dc.w @Init-@Index
		dc.w @Fall-@Index
		dc.w @SecondFall-@Index
; ===========================================================================

@Init:	; Routine 0
		move.l	#Map_SegaLogo, obMap(a0)
		move.w	#$200/$20, obGfx(a0)
		move.b	#0, obRender(a0)
		move.b	#1, obPriority(a0)
		move.b	#8, obActWid(a0)
		move.b	#10,obDelayAni(a0) ; set time delay to 0.5 seconds
		addq.b	#2, obRoutine(a0)

@Fall:
		tst.w 	@Bouncification(a0)
		bpl.s 	@Lock

		jsr 	ScreenObjectFall

		cmpi.w 	#$EE, obScreenY(a0)
		ble.s 	@Display

		sfx 	sfx_bouncy
		move.w	@Bouncification(a0), obVelY(a0)
		addi.w 	#$80, @Bouncification(a0)

		jmp		DisplaySprite

@Lock:
		cmp.w 	#45, v_demolength
		bge.s 	@ContinueLocking

		addq.b	#2, obRoutine(a0)
		bra.s 	@SecondFall

@ContinueLocking:
		move.w 	#$EE, obScreenY(a0)
		jmp		DisplaySprite

@SecondFall:
		jsr 	ScreenObjectFall
		jmp		DisplaySprite

; ===========================================================================

@Display:
		jmp		DisplaySprite

@DeleteObject:
		jmp 	DeleteObject