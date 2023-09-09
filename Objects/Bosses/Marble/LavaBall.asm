
; ---------------------------------------------------------------------------
; Dynamic Object - MZ Boss Lava ball
; ---------------------------------------------------------------------------

MZBossLavaBall:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Routines(pc,d0.w), d1
		jmp	@Routines(pc,d1.w)

; ---------------------------------------------------------------------------
@Routines:
		dc.w	@Init-@Routines
		dc.w	@Main-@Routines
		dc.w	@Animate-@Routines
		dc.w	@Delete-@Routines

; ---------------------------------------------------------------------------
@Init:
		assert.l obVelY(a0), ne		; Y-velocity should be specifed by the boss

		addq.b	#2, obRoutine(a0)

		move.b	#4,obRender(a0)
		move.w	#$345,obGfx(a0)
		move.l	#Map_Fire,obMap(a0)

		move.b	#8,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.b	#3,obPriority(a0)
		move.b	#$8B,obColType(a0)
		move.b	#8,obActWid(a0)

		sfx	sfx_LavaBall	; play lava ball sound

; ---------------------------------------------------------------------------
@Main:
		; Apply friction to X-velocity if set
		move.w	obVelX(a0), d0
		beq.s	@DoCollisions
		bmi.s	@UpdateVel_Negative
		subq.w	#8, d0
		bpl.s	@UpdateVel
		bra.s	@ResetVel

	@UpdateVel_Negative:
		addq.w	#8, d0
		bcc.s	@UpdateVel
	@ResetVel:
		moveq	#0, d0
	@UpdateVel:
		move.w	d0, obVelX(a0)

@DoCollisions:
		bsr.w	ObjFloorDist
		tst.w	d1
		bpl.s	@Animate

		addq.b	#2, obRoutine(a0)
		move.b	#1, obAnim(a0)
		move.w	#0, obVelY(a0)	; stop the object when it touches the floor

; ---------------------------------------------------------------------------
@Animate:
		jsr	SpeedToPos
		lea	Ani_Fire, a1
		jsr	AnimateSprite
		jmp	DisplaySprite

; ---------------------------------------------------------------------------
@Delete:
		jmp	DeleteObject
