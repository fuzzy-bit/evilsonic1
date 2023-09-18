; ---------------------------------------------------------------------------
; Object 73 - Eggman (SLZ)
; ---------------------------------------------------------------------------
BossStarLight:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc, d0.w), d1
		jmp	@Index(pc, d1.w)

; ===========================================================================

@AttackPattern:		equ $2A

@Bounces:			equ $2C ; missile's bounces
@MissileTimer:		equ $2C
@MissileTypeFlag:	equ $26

@TargetX:			equ $30
@TargetY:			equ $38

@FaceStatus:		equ $34
@DelayTimer:		equ $3C
@FlashTimer:		equ $3E

@Index:	
		dc.w @Main-@Index
		dc.w @ShipMain-@Index
		dc.w @FaceMain-@Index
		dc.w @FlameMain-@Index
		dc.w @TubeMain-@Index

@ObjData:	
		; routine number, animation, sprite priority
		dc.b 2, 0, 4	; Ship
		dc.b 4, 1, 4	; Face
		dc.b 6, 7, 4	; Flame
		dc.b 8, 0, 3	; Tube

; ===========================================================================

@Main:	; Routine 0
		move.w	obX(a0), @TargetX(a0)
		move.w	obY(a0), @TargetY(a0)
		move.b	#$F, obColType(a0)
		move.b	#12, obColProp(a0) 		; set number of hits

		lea	@ObjData(pc), a2 			; setup sprites
		movea.l	a0, a1
		moveq	#3, d1
		
		bra.s	@LoadBoss

; ===========================================================================

@Loop:
		jsr	(FindNextFreeObj).l
		bne.s	@ShipMain

		move.b	#id_BossStarLight, 0(a1)
		move.w	obX(a0), obX(a1)
		move.w	obY(a0), obY(a1)

@LoadBoss:
		bclr	#0, obStatus(a0)
		clr.b	ob2ndRout(a1)
		
		move.b	(a2)+, obRoutine(a1)
		move.b	(a2)+, obAnim(a1)
		move.b	(a2)+, obPriority(a1)
		move.l	#Map_Eggman, obMap(a1)

		move.w	#$400, obGfx(a1)
		move.b	#4, obRender(a1)
		move.b	#$20, obActWid(a1)
		move.b	#23, obHeight(a1)

		move.l	a0, @FaceStatus(a1)
		
		dbf	d1, @Loop	; repeat sequence 3 more times
		move.b	#$30, @MissileTimer(a0)
		move.b 	#$1, @MissileTypeFlag(a0)
		
@ShipMain:	; Routine 2
		moveq	#0, d0

		move.b	ob2ndRout(a0), d0
		move.w	@ShipIndex(pc, d0.w), d1

		jsr	@ShipIndex(pc, d1.w)
		lea	(Ani_Eggman).l, a1

		jsr	(AnimateSprite).l
		moveq	#3, d0
		and.b	obStatus(a0), d0

		andi.b	#$FC, obRender(a0)
		or.b	d0, obRender(a0)
		
		cmp.b	#6, ob2ndRout(a0)
		beq.s 	@DoNotBob
		bsr.w 	@BobShip

@DoNotBob:
		jmp	(DisplaySprite).l

; ===========================================================================
@ShipIndex:
		dc.w @MoveIn-@ShipIndex
		dc.w @RunBoss-@ShipIndex
		dc.w @StartFalling-@ShipIndex
		dc.w @Fall-@ShipIndex
; ===========================================================================

@MoveIn:
		move.w	#-$100, obVelX(a0)
		bsr.w	BossMove

		cmpi.w	#$2115, @TargetX(a0) ; are we done with the intro?
		bne.s	@IntroRandomFace ; fuck you o'm straight
		
		addq.b	#2, ob2ndRout(a0)
		clr.b	obSubtype(a0)
		clr.l	obVelX(a0)

@IntroRandomFace:
		jsr	(RandomNumber).l
		move.b	d0, @FaceStatus(a0)

@CheckHit:
		move.w	@TargetY(a0), obY(a0) ; apply our target position
		move.w	@TargetX(a0), obX(a0)

		cmpi.b	#4, ob2ndRout(a0) ; are we on the face routine?
		bcc.s	@rts

		tst.b	obStatus(a0) ; has boss been defeated?
		bmi.s	@Defeat ; hell yea

		tst.b	obColType(a0) ; check the collision type, no duplicate hits
		bne.s	@rts

		tst.b	@FlashTimer(a0) ; still flashing?
		bne.s	@Flash ; eye candy!

		move.b	#$28, @FlashTimer(a0) ; set flash timer
		sfx	sfx_BossHit	; play boss damage sound

@Flash:
		lea	(v_pal_dry+$22).w, a1
		moveq	#0, d0

		tst.w	(a1)
		bne.s	@SetCollisionOnFlash

		move.w	#cWhite, d0

@SetCollisionOnFlash:
		move.w	d0, (a1)
		subq.b	#1, @FlashTimer(a0)
		bne.s	@rts ; gtfo if flash timer is over
		
		move.b	#$F, obColType(a0)

@rts:
		rts

; ===========================================================================

@BobShip:
		move.b	$3F(a0), d0
		addq.b	#2, $3F(a0)
		jsr	(CalcSine).l

		asr.w	#2, d0
		neg.w 	d0
		move.w	d0, obVelY(a0)
		rts

; ===========================================================================

@Defeat:
		moveq	#100, d0
		bsr.w	AddPoints
		
		move.b	#4, ob2ndRout(a0)
		move.w	#$50, @DelayTimer(a0)

		rts	

; ===========================================================================

@RunBoss:
		cmp.b 	#4, obColProp(a0)
		bhi.b 	@NotPhase2
		
		move.b	#1, @AttackPattern(a0)
		bra.s 	@RunAttackPattern

@NotPhase2:
		moveq	#0, d0
		move.b	@AttackPattern(a0), d0

@RunAttackPattern:
		move.w	@AttackIndex(pc, d0.w), d0
		jsr		@AttackIndex(pc, d0.w)

		andi.b	#6, @AttackPattern(a0)
		bra.w	@CheckHit

@RunPattern1:
		moveq	#0, d0
		move.b	obSubtype(a0), d0
		move.w	@Pattern1(pc, d0.w), d0

		jsr		@Pattern1(pc, d0.w)
		rts

@RunPattern2:
		moveq	#0, d0
		move.b	obSubtype(a0), d0
		move.w	@Pattern2(pc, d0.w), d0

		jsr		@Pattern2(pc, d0.w)
		rts

; ===========================================================================
@AttackIndex:	
		dc.w @RunPattern1-@AttackIndex
		dc.w @RunPattern2-@AttackIndex

@Pattern1:	
		dc.w @ControlDirection-@Pattern1
		dc.w @FireMissile-@Pattern1
		dc.w @Wait-@Pattern1

@Pattern2:	
		dc.w @ControlDirection2-@Pattern2
		dc.w @FireMissile-@Pattern2
		dc.w @Wait-@Pattern2
; ===========================================================================

@ControlDirection:
		subi.b	#1, @MissileTimer(a0)
		tst.b 	@MissileTimer(a0) ; bruh
		bmi.s 	@FireAndReset

		tst.w	obVelX(a0) ; is eggman not moving?
		bne.s	@SwapMove ; gang shit
		
		moveq	#$40, d0
		bsr.s	@Swap ; we're good to go
		bcs.s	@ContinueMoving ; less than $22C, keep going

		neg.w	d0

@ContinueMoving:
		bra.w	BossMove

@FireAndReset:
		move.b	#$23,  @MissileTimer(a0)
		bsr.w 	@MakeMissile
		sub.w 	#$5, obY(a1)
		tst.b 	@MissileTypeFlag(a0)
		bmi.s 	@SwitchMissileType

		move.b 	#-$3, obVelY(a1)

@SwitchMissileType:
		neg.b 	@MissileTypeFlag(a0)
		rts

@Swap:
		move.w	#$150, obVelX(a0)
		btst	#0, obStatus(a0) ; is bit 0 clear
		bne.s	@SwapMove ; if true, check if we should shoot a missile

		tst.b	obRender(a0)
		beq.s 	@SwapMove

		neg.w	obVelX(a0)

@SwapMove:
		bsr.w	BossMove

@RandomFace:
		jsr	(RandomNumber).l
		andi.b	#$1F, d0
		addi.b	#$40, d0
		move.b	d0, @FaceStatus(a0)

@IsShipRight:
		btst	#0, obStatus(a0)
		beq.s	@IsShipLeft
		cmpi.w	#$2120, @TargetX(a0)
		blt.s	@IsShipRight_rts
		move.w	#$2120, @TargetX(a0)
		bra.s	@StopMoving

@IsShipLeft:
		cmpi.w	#$2115-$100, @TargetX(a0)
		bgt.s	@IsShipRight_rts
		move.w	#$2115-$100, @TargetX(a0)

@StopMoving:
		clr.w	obVelX(a0)
		cmpi.w	#$22C, @TargetY(a0)
		bcc.s	@StartFiring
		rts

@StartFiring:
		bchg	#0, obStatus(a0)
		addq.b	#2, obSubtype(a0) ; make the missile

@IsShipRight_rts:
		rts	

; ===========================================================================

@ControlDirection2:
		lea     (v_player).w, a1
		move.w  #$250, d0
		move.w  #$BA, d1
		jsr     ChaseObject

		move.w  #0, obVelY(a0)
		addq.b	#2, obSubtype(a0) ; make the missile

		tst.w 	obVelX(a0)
		bpl.s 	@Flip

		bclr 	#0, obStatus(a0)
		bra.s 	@ControlDirection2_Return

@Flip:
		bset	#0, obStatus(a0)

@ControlDirection2_Return
		rts

; ===========================================================================

@FireMissile:
		bsr.w	BossMove
		move.w	#$22C, d0
		move.w	#$10, @DelayTimer(a0)
		
		; this sub routine spawn penis
		Instance.new	SLZBossMissile, a1	; load missile object
		bsr.s 	@MakeMissile

		subi.w	#$5,obY(a1)
		move.w	#$100,obVelY(a1) ; move missile downwards

@CancelMissile:
		addq.b	#2, obSubtype(a0)
		rts	

; ===========================================================================

@MakeMissile:
		Instance.new	SLZBossMissile, a1	; load missile object
		move.w 	#0, @Bounces(a1) ; meh, default bounces. only a move so it shouldn't use too many cycles
		move.w	@TargetX(a0), obX(a1)
		move.w	@TargetY(a0), obY(a1)
		addi.w	#$18, obY(a1)

		subi.w	#$5,obY(a1)
		move.w	#$100,obVelY(a1) ; move missile downwards
		
		rts

; ===========================================================================

@Wait:
		bsr.w 	@BobShip
		bsr.w	BossMove

		subq.w	#1, @DelayTimer(a0)
		bne.s	@Wait_rts

		move.b	#0, obSubtype(a0)

@Wait_rts:
		rts

; ===========================================================================

@StartFalling:
		subq.w	#1, @DelayTimer(a0)
		bclr	#7, obStatus(a0)
		
		addq.b	#2, ob2ndRout(a0)
		move.w	#-$26, @DelayTimer(a0)

		tst.b	(v_bossstatus).w
		bne.s	@StartFalling_rts
		
		move.b	#1, (v_bossstatus).w
		move.w 	#-$500, @MissileTimer(a0)

@StartFalling_rts:
		rts	
; ===========================================================================

@Fall:
		bsr.w	BossDefeated
		cmpi.w	#0, @MissileTimer(a0)
		bpl.s 	@Fall2

		jsr		(ObjFloorDist).l
		cmpi.w	#$C, d1
		ble.s	@Bounce

		jsr		ObjectFall
		rts

@Bounce:
		move.w	@MissileTimer(a0), obVelY(a0)
		addi.w 	#$130, @MissileTimer(a0)
		jsr		SpeedToPos

		rts
; ===========================================================================

@Fall2:
		jsr		ObjectFall

		tst.b	obRender(a0)
		bpl.s	@DeleteShip
		rts

; ===========================================================================

@DeleteShip:
		music	mus_SLZ		; play SLZ music
		add.w	#300, (v_limitright2).w

		jsr	(DeleteObject).l

; ===========================================================================

@FaceMain:	; Routine 4
		moveq	#0, d0
		moveq	#1, d1
		movea.l	@FaceStatus(a0), a1
		tst.b	(a1)				; does father exist?
		beq.s	@DeleteFace			; if not, skin his face alive				
		move.b	ob2ndRout(a1), d0
		subq.w	#2, d0
		bne.s	@IHaveNoClue
		btst	#1, obSubtype(a1)
		beq.s	@CheckHurt
		tst.w	obVelY(a1)
		bne.s	@CheckHurt
		moveq	#4, d1
		bra.s	@SetFaceGraphics
; ===========================================================================

@IHaveNoClue:
		subq.b	#2, d0
		bmi.s	@CheckHurt
		moveq	#$A, d1
		bra.s	@SetFaceGraphics
; ===========================================================================

@CheckHurt:
		tst.b	obColType(a1) ; are we in the hurting state?
		bne.s	@CheckSonicHurt ; if not, go fuck yourself

		moveq	#5, d1
		bra.s	@SetFaceGraphics
; ===========================================================================

@CheckSonicHurt:
		cmpi.b	#4, (v_player+obRoutine).w ; is sonic hurt?
		bcs.s	@SetFaceGraphics ; if not, just do neutral face
		moveq	#4, d1 ; muahahahahahahahaaha >:D

@SetFaceGraphics:
		move.b	d1, obAnim(a0)
		subq.b	#4, d0
		bne.s	@ShowFace
		move.b	#6, obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	@DeleteFace

@ShowFace:
		bra.s	@ShowFlame
; ===========================================================================

@DeleteFace:
		jmp	(DeleteObject).l
; ===========================================================================

@FlameMain:; Routine 6
		move.b	#7, obAnim(a0)
		movea.l	@FaceStatus(a0), a1
		tst.b	(a1)				; does father exist?
		beq.s	@DeleteFlame		; if not, kill object		
		cmpi.b	#8, ob2ndRout(a1)
		blt.s	@CheckXMovement
		move.b	#$B, obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	@DeleteFlame
		bra.s	@ShowFlameFromMain
; ===========================================================================

@CheckXMovement:
		tst.w	obVelX(a1) ; are we moving?
		beq.s	@ShowFlameFromMain ; if not, don't change the animation
		move.b	#8, obAnim(a0) ; engage!!!

@ShowFlameFromMain:
		bra.s	@ShowFlame
; ===========================================================================

@DeleteFlame:
		jmp	(DeleteObject).l ; does _NOT_ unload child objects :V
		
; ===========================================================================

@ShowFlame:
		lea	(Ani_Eggman).l, a1
		jsr	(AnimateSprite).l

@UpdateFace:
		movea.l	@FaceStatus(a0), a1
		move.w	obX(a1), obX(a0)
		move.w	obY(a1), obY(a0)
		move.b	obStatus(a1), obStatus(a0)
		moveq	#3, d0
		and.b	obStatus(a0), d0
		andi.b	#$FC, obRender(a0)
		or.b	d0, obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

@TubeMain:	; Routine 8
		movea.l	@FaceStatus(a0), a1
		tst.b	(a1)				; does father exist?
		beq.s	@DeleteTube			; if not, fuck YouTube			
		cmpi.b	#8, ob2ndRout(a1)
		bne.s	@ShowTube
		tst.b	obRender(a0)
		bpl.s	@DeleteTube

@ShowTube:
		move.l	#Map_BossItems, obMap(a0)
		move.w	#$246C, obGfx(a0)
		move.b	#4, obFrame(a0)
		bra.s	@UpdateFace
; ===========================================================================

@DeleteTube:
		jmp	(DeleteObject).l
