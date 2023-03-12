; ---------------------------------------------------------------------------
; Object 74 - Boss Missile
; ---------------------------------------------------------------------------

BossMissile:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jmp	@Index(pc,d1.w)
; ===========================================================================
@Index:	dc.w @Main-@Index
		dc.w @Animate-@Index
		dc.w @HandlePhysics-@Index
		dc.w @Delete-@Index

@Bounces:	equ $2C

; ===========================================================================

@Main:	; Routine 0
		subq.w	#1,$32(a0)
		addq.b	#2,obRoutine(a0)

		move.l	#Map_BSBall,obMap(a0)
		move.w	#$518,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#5,obPriority(a0)
		move.b	#8,obActWid(a0)
		andi.b	#3,obStatus(a0)

; ===========================================================================

@Animate:	; Routine 2
		move.b	#0,obFrame(a0)
		jsr	DisplaySprite ; jmp?

; ===========================================================================

@HandlePhysics:	; Routine 4
		jsr		(ObjFloorDist).l
		cmpi.w	#4, d1		; has ball hit the floor?
		ble.s	@Bounce

		jsr		ObjectFall
		move.b	#$87,obColType(a0)
		jsr		SpeedToPos
		jsr		DisplaySprite
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below the level boundary?
		bcs.s	@Delete	; if yes, branch
		rts	
; ===========================================================================

@Bounce:
		subi.w 	#1, @Bounces(a0)

		tst.w 	@Bounces(a0)
		bmi.s 	@Explode	

		move.w	#-$300,obVelY(a0) ; :3c
		jsr		SpeedToPos

		jsr		FindFreeObj
		bne.s	@rts
		move.b	#id_ExplosionBomb, 0(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

		add.w 	#-10, obY(a0) ; preventing duplicate Bounces
		rts

@Explode:
		move.b	#id_ExplosionBomb,0(a0)	; change object	to an explosion	($3F)
		move.b	#0,obRoutine(a0) ; reset routine counter
		move.w 	#0, @Bounces(a0)
		jsr		ExplosionBomb	; jump to explosion code

@rts:
		rts
; ===========================================================================

@Delete:	; Routine 6
		jsr		DeleteObject
		rts	
