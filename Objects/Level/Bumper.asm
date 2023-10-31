; ---------------------------------------------------------------------------
; Object 47 - pinball bumper (SYZ)
; ---------------------------------------------------------------------------

Bumper:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc,d0.w), d1
		jmp		@Index(pc,d1.w)

; ===========================================================================
@ResizeDelay:		equ $2
; ===========================================================================
@Index:		dc.w @Main-@Index
			dc.w @Hit-@Index
; ===========================================================================

@Main:	; Routine 0
		addq.b	#2, obRoutine(a0)
		move.l	#Map_Bump, obMap(a0)
		move.w	#$380, obGfx(a0)
		move.b	#4, obRender(a0)
		move.b	#$10, obActWid(a0)
		move.b	#1, obPriority(a0)
		move.b	#$D7, obColType(a0)

@Hit:	; Routine 2
		tst.b	obColProp(a0)	; has Sonic touched the	bumper?
		beq.w	@display	; if not, branch
		clr.b	obColProp(a0)

		lea		(v_player).w, a1
		move.w	obX(a0), d1
		move.w	obY(a0), d2
		sub.w	obX(a1), d1
		sub.w	obY(a1), d2

		jsr		(CalcAngle).l
		jsr		(CalcSine).l

		muls.w	#-$700, d1
		asr.l	#8, d1
		move.w	d1, obVelX(a1)	; bounce Sonic away
		
		muls.w	#-$700, d0
		asr.l	#8, d0
		move.w	d0, obVelY(a1)	; bounce Sonic away
		
		bset	#1, obStatus(a1)
		bclr	#4, obStatus(a1)
		bclr	#5, obStatus(a1)
		clr.b	$3C(a1)
		move.b	#1, obAnim(a0)	; use "hit" animation
		
		sfx	sfx_Bumper	; play bumper sound
		
		lea	(v_objstate).w, a2
		moveq	#0, d0
		move.b	obRespawnNo(a0), d0
		
		beq.s	@AddScore
		cmpi.b	#$8A, @ResizeDelay(a2,d0.w)	; has bumper been hit 10 times?
		
		bcc.s	@Display	; if yes, Sonic	gets no	points
		addq.b	#1, @ResizeDelay(a2,d0.w)

@AddScore:
		moveq	#1, d0
		jsr	(AddPoints).l	; add 10 to score

@Display:
		lea		(Ani_Bump).l, a1
		bsr.w	AnimateSprite
		out_of_range.s	@Resetcount
		bra.w	DisplaySprite

; ===========================================================================

@Resetcount:
		lea		(v_objstate).w, a2
		moveq	#0, d0
		move.b	obRespawnNo(a0), d0
		beq.s	@Delete
		bclr	#7, @ResizeDelay(a2,d0.w)

@Delete:
		bra.w	DeleteObject
