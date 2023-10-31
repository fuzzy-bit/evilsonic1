; ---------------------------------------------------------------------------
; Object 76 - SYZ Boss Bumper
; ---------------------------------------------------------------------------

BossBumper:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc,d0.w), d1
		jmp		@Index(pc,d1.w)

; ===========================================================================
@ResizeDelay:		equ $2
@Parent:	equ $3C
@Bounces:	equ $2C
; ===========================================================================
@Index:		dc.w @Init-@Index
			dc.w @Main-@Index
; ===========================================================================

@Init:	; Routine 0
		addq.b	#2, obRoutine(a0)
		move.l	#Map_Bump, obMap(a0)
		move.w	#$380, obGfx(a0)
		move.b	#4, obRender(a0)
		move.b	#$10, obActWid(a0)
		move.b	#5, obPriority(a0)
		move.b	#$D7, obColType(a0)

		rts

@Main:	; Routine 2
		jsr		(ObjFloorDist).l
		cmpi.w	#$4, d1		; has ball hit the floor?
		ble.w	@Bounce

		jsr		ObjectFall
		jsr		SpeedToPos

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
		neg.w 	d1
		move.w	d1, obVelX(a0)	; bounce bumper away

		muls.w	#-$700, d0
		asr.l	#8, d0
		move.w	d0, obVelY(a1)	; bounce Sonic away
		neg.w 	d2
		move.w	d1, obVelY(a0)	; bounce bumper away
		
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
		jsr		AnimateSprite
		out_of_range.s	@Resetcount
		jmp		DisplaySprite

; ===========================================================================

@Bounce:
		subi.w 	#1, @Bounces(a0)

		move.b	#1, obAnim(a0)	; use "hit" animation
		sfx	sfx_Bumper	; play bumper sound

		tst.w 	@Bounces(a0)
		bmi.s 	@Explode	

		move.w	#-$300,obVelY(a0) ; :3c
		jsr		SpeedToPos

		add.w 	#-10, obY(a0) ; preventing duplicate Bounces
		rts

@Explode:
		move.b	#id_ExplosionBomb,0(a0)	; change object	to an explosion	($3F)
		move.b	#0,obRoutine(a0) ; reset routine counter
		move.w 	#0, @Bounces(a0)
		jmp		ExplosionBomb	; jump to explosion code

; ===========================================================================

@Resetcount:
		lea		(v_objstate).w, a2
		moveq	#0, d0
		move.b	obRespawnNo(a0), d0
		beq.s	@Delete
		bclr	#7, @ResizeDelay(a2,d0.w)

@Delete:
		jmp		DeleteObject