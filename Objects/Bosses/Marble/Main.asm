; ---------------------------------------------------------------------------
; Object 73 - Eggman (MZ)
; ---------------------------------------------------------------------------
BossMarble:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc, d0.w), d1
		jmp	@Index(pc, d1.w)
; ===========================================================================
Obj73_TargetX:			equ $30
Obj73_TargetY:			equ $38

Obj73_FaceStatus:		equ $34
Obj73_FlashTimer:		equ $3E
Obj73_DelayTimer:		equ $3C

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
		move.w	obX(a0), Obj73_TargetX(a0)
		move.w	obY(a0), Obj73_TargetY(a0)
		move.b	#$F, obColType(a0)
		move.b	#8, obColProp(a0) ; set number of hits to 8

		lea	@ObjData(pc), a2 ; setup sprites
		movea.l	a0, a1
		moveq	#3, d1
		
		bra.s	@LoadBoss
; ===========================================================================

@Loop:
		jsr	(FindNextFreeObj).l
		bne.s	@ShipMain

		move.b	#id_BossMarble, 0(a1)
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

		move.l	a0, Obj73_FaceStatus(a1)
		
		dbf	d1, @Loop	; repeat sequence 3 more times

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
		
		jmp	(DisplaySprite).l
; ===========================================================================
@ShipIndex:
		dc.w @MoveIn-@ShipIndex
		dc.w @RunBoss-@ShipIndex
		dc.w @OnDefeated-@ShipIndex
		dc.w @Fall-@ShipIndex
		dc.w @Flee-@ShipIndex
; ===========================================================================

@MoveIn:
		move.b	$3F(a0), d0
		addq.b	#2, $3F(a0)
		jsr	(CalcSine).l

		asr.w	#2, d0
		move.w	d0, obVelY(a0)
		move.w	#-$100, obVelX(a0)
		bsr.w	BossMove

		cmpi.w	#$1910, Obj73_TargetX(a0) ; are we done with the intro?
		bne.s	@IntroRandomFace ; fuck you o'm straight

		addq.b	#2, ob2ndRout(a0)
		clr.b	obSubtype(a0)
		clr.l	obVelX(a0)

@IntroRandomFace:
		jsr	(RandomNumber).l
		move.b	d0, Obj73_FaceStatus(a0)

@CheckHit:
		move.w	Obj73_TargetY(a0), obY(a0) ; apply our target position
		move.w	Obj73_TargetX(a0), obX(a0)

		cmpi.b	#4, ob2ndRout(a0) ; are we on the face routine?
		bcc.s	@rts

		tst.b	obStatus(a0) ; has boss been defeated?
		bmi.s	@Defeat ; hell yea

		tst.b	obColType(a0) ; check the collision type, no duplicate hits
		bne.s	@rts

		tst.b	Obj73_FlashTimer(a0) ; still flashing?
		bne.s	@Flash ; eye candy!

		move.b	#$28, Obj73_FlashTimer(a0) ; set flash timer
		sfx	sfx_BossHit	; play boss damage sound

@Flash:
		lea	(v_pal_dry+$22).w, a1
		moveq	#0, d0

		tst.w	(a1)
		bne.s	@SetCollisionOnFlash

		move.w	#cWhite, d0

@SetCollisionOnFlash:
		move.w	d0, (a1)
		subq.b	#1, Obj73_FlashTimer(a0)
		bne.s	@rts ; gtfo if flash timer is over
		
		move.b	#$F, obColType(a0)

@rts:
		rts
; ===========================================================================

@Defeat:
		moveq	#100, d0
		bsr.w	AddPoints
		
		move.b	#4, ob2ndRout(a0)
		move.w	#$B4, Obj73_DelayTimer(a0)
		clr.w	obVelX(a0)

		rts	
; ===========================================================================

@RunBoss:
		moveq	#0, d0
		move.b	obSubtype(a0), d0
		move.w	@ShipIndex2(pc, d0.w), d0

		jsr		@ShipIndex2(pc, d0.w)
		
		andi.b	#6, obSubtype(a0)
		bra.w	@CheckHit
; ===========================================================================
@ShipIndex2:	
		dc.w @ControlDirection-@ShipIndex2
		dc.w @MakeBottomLava-@ShipIndex2
		dc.w @ControlDirection-@ShipIndex2
		dc.w @MakeBottomLava-@ShipIndex2
; ===========================================================================

@ControlDirection:
		tst.w	obVelX(a0) ; is eggman not moving?
		bne.s	@CheckFireball ; gang shit
		
		moveq	#$40, d0
		cmpi.w	#$22C, Obj73_TargetY(a0) ; have we reached the other side?
		beq.s	@SwapSides ; we're good to go
		bcs.s	@ContinueMoving ; less than $22C, keep going

		neg.w	d0

@ContinueMoving:
		move.w	d0, obVelY(a0)
		bra.w	BossMove
; ===========================================================================

@SwapSides:
		move.w	#$200, obVelX(a0)
		move.w	#$100, obVelY(a0)
		btst	#0, obStatus(a0) ; is bit 0 clear
		bne.s	@CheckFireball ; if true, check if we should shoot fireball

		neg.w	obVelX(a0)

@CheckFireball:
		cmpi.b	#$18, Obj73_FlashTimer(a0) ; shoot fireball if flash timer >= #$18
		bcc.s	@FireLava ; pew pew
		
		bsr.w	BossMove
		subq.w	#4, obVelY(a0)

@FireLava:
		subq.b	#1, Obj73_FaceStatus(a0)
		bcc.s	@IsShipRight

		jsr	(FindFreeObj).l
		bne.s	@RandomFace
		move.b	#id_LavaBall, 0(a1) ; load lava ball object
		move.w	#$2E8, obY(a1)	; set Y	position

		jsr	(RandomNumber).l
		andi.l	#$FFFF, d0
		divu.w	#$50, d0
		swap	d0

		addi.w	#$1878, d0
		move.w	d0, obX(a1)
		lsr.b	#7, d1
		move.w	#$FF, obSubtype(a1)

@RandomFace:
		jsr	(RandomNumber).l
		andi.b	#$1F, d0
		addi.b	#$40, d0
		move.b	d0, Obj73_FaceStatus(a0)

@IsShipRight:
		btst	#0, obStatus(a0)
		beq.s	@IsShipLeft
		cmpi.w	#$1910, Obj73_TargetX(a0)
		blt.s	@FireLava_rts
		move.w	#$1910, Obj73_TargetX(a0)
		bra.s	@Dive
; ===========================================================================

@IsShipLeft:
		cmpi.w	#$1830, Obj73_TargetX(a0)
		bgt.s	@FireLava_rts
		move.w	#$1830, Obj73_TargetX(a0)

@Dive:
		clr.w	obVelX(a0)
		move.w	#-$180, obVelY(a0)
		cmpi.w	#$22C, Obj73_TargetY(a0)
		bcc.s	@StartFiring
		neg.w	obVelY(a0)

@StartFiring:
		addq.b	#2, obSubtype(a0) ; make the fireball

@FireLava_rts:
		rts	
; ===========================================================================

@MakeBottomLava:
		bsr.w	BossMove
		move.w	Obj73_TargetY(a0), d0
		subi.w	#$22C, d0
		bgt.s	@MakeBottomLava_rts
		move.w	#$22C, d0
		tst.w	obVelY(a0)
		beq.s	@CancelBottomLava
		clr.w	obVelY(a0)
		move.w	#$50, Obj73_DelayTimer(a0)
		bchg	#0, obStatus(a0)
		jsr	(FindFreeObj).l
		bne.s	@CancelBottomLava
		move.w	Obj73_TargetX(a0), obX(a1)
		move.w	Obj73_TargetY(a0), obY(a1)
		addi.w	#$18, obY(a1)
		move.b	#id_BossFire, (a1)	; load lava ball object
		move.b	#1, obSubtype(a1)

@CancelBottomLava:
		subq.w	#1, Obj73_DelayTimer(a0)
		bne.s	@MakeBottomLava_rts
		addq.b	#2, obSubtype(a0)

@MakeBottomLava_rts:
		rts	
; ===========================================================================

@OnDefeated:
		subq.w	#1, Obj73_DelayTimer(a0)
		bmi.s	@StartFleeing
		bra.w	BossDefeated
; ===========================================================================

@StartFleeing:
		bset	#0, obStatus(a0) ; flip eggman's sprite
		bclr	#7, obStatus(a0)
		
		clr.w	obVelX(a0)
		addq.b	#2, ob2ndRout(a0)
		move.w	#-$26, Obj73_DelayTimer(a0)

		tst.b	(v_bossstatus).w
		bne.s	@StartFleeing_rts
		
		move.b	#1, (v_bossstatus).w
		clr.w	obVelY(a0)

@StartFleeing_rts:
		rts	
; ===========================================================================

@Fall:
		addq.w	#1, Obj73_DelayTimer(a0) ; done with the falling timer?
		beq.s	@StopFalling ; just in case the targt y check does nothing ig
		bpl.s	@Fall2 ; keep fleeing
		
		cmpi.w	#$270, Obj73_TargetY(a0) ; has the target y reached its target (also)
		bcc.s	@StopFalling ; balls in my face

		addi.w	#$18, obVelY(a0) ; he just keeps going
		bra.s	@MoveAndCheckHit
; ===========================================================================

@StopFalling:
		clr.w	obVelY(a0)
		clr.w	Obj73_DelayTimer(a0)
		bra.s	@MoveAndCheckHit
; ===========================================================================

@Fall2:
		cmpi.w	#$30, Obj73_DelayTimer(a0)
		bcs.s	@GetBackUp
		beq.s	@ResetMusic

		cmpi.w	#$38, Obj73_DelayTimer(a0)
		bcs.s	@MoveAndCheckHit

		addq.b	#2, ob2ndRout(a0)
		bra.s	@MoveAndCheckHit
; ===========================================================================

@GetBackUp:
		subq.w	#8, obVelY(a0)
		bra.s	@MoveAndCheckHit
; ===========================================================================

@ResetMusic:
		clr.w	obVelY(a0)
		music	mus_MZ		; play MZ music

@MoveAndCheckHit:
		bsr.w	BossMove
		bra.w	@CheckHit
; ===========================================================================

@Flee:
		move.w	#$500, obVelX(a0)
		move.w	#-$40, obVelY(a0)
		cmpi.w	#$1960, (v_limitright2).w
		bcc.s	@RemoveShipOutOfBounds
		addq.w	#2, (v_limitright2).w
		bra.s	@MoveFleeing
; ===========================================================================

@RemoveShipOutOfBounds:
		tst.b	obRender(a0)
		bpl.s	@DeleteShip

@MoveFleeing:
		bsr.w	BossMove
		bra.w	@CheckHit
; ===========================================================================

@DeleteShip:
		jmp	(DeleteObject).l
; ===========================================================================

@FaceMain:	; Routine 4
		moveq	#0, d0
		moveq	#1, d1
		movea.l	Obj73_FaceStatus(a0), a1
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
		movea.l	Obj73_FaceStatus(a0), a1
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
		jmp	(DeleteObject).l
; ===========================================================================

@ShowFlame:
		lea	(Ani_Eggman).l, a1
		jsr	(AnimateSprite).l

@UpdateFace:
		movea.l	Obj73_FaceStatus(a0), a1
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
		movea.l	Obj73_FaceStatus(a0), a1
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
