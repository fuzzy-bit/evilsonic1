; ---------------------------------------------------------------------------
; Object 73 - Eggman (SYZ)
; ---------------------------------------------------------------------------
BossSpringYard:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc, d0.w), d1
		jmp	@Index(pc, d1.w)

; ===========================================================================

@AttackPattern:		equ $2A

@BossBounceAmount:		equ $2C
@Bounces:			equ $2C

@TargetX:			equ $30
@TargetY:			equ $38

@FaceStatus:		equ $34

@SwapsLeft:			equ $3B
@DelayTimer:		equ $3C
@FlashTimer:		equ $3E
@ThrowTimer:		equ $3F

@StartX:			equ $2D15
@ThrowCooldown:		equ $1B

@Index:	
		dc.w @Main-@Index
		dc.w @ShipMain-@Index
		dc.w @FaceMain-@Index
		dc.w @FlameMain-@Index
		dc.w @SpikeMain-@Index

@ObjData:	
		; routine number, animation, sprite priority
		dc.b 2, 0, 4	; Ship
		dc.b 4, 1, 4	; Face
		dc.b 6, 7, 4	; Flame
		dc.b 8, 0, 5	; Spike

; ===========================================================================

@Main:	; Routine 0
		move.w	obX(a0), @TargetX(a0)
		move.w	obY(a0), @TargetY(a0)
		move.b	#$F, obColType(a0)
		move.b	#8, obColProp(a0) 		; set number of hits

		lea	@ObjData(pc), a2 			; setup sprites
		movea.l	a0, a1
		moveq	#3, d1
		
		bra.s	@LoadBoss

; ===========================================================================

@InitLoop:
		jsr	(FindNextFreeObj).l
		bne.s	@ShipMain

		move.b	#id_BossSpringYard, 0(a1)
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
		
		dbf	d1, @InitLoop	; repeat sequence 3 more times
		move.b	#@ThrowCooldown, @ThrowTimer(a0)
		move.b 	#4, @SwapsLeft(a0)

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

		cmpi.w	#@StartX, @TargetX(a0) ; are we done with the intro?
		bne.s	@IntroRandomFace ; fuck you o'm straight
		
		; run this if we are done
		move.w	#$4A, @DelayTimer(a0)
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

		asr.w	#3, d0
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

; ===========================================================================
@AttackIndex:	
		dc.w @RunPattern1-@AttackIndex
		dc.w @RunPattern1-@AttackIndex

@Pattern1:	
		dc.w @ControlDirection-@Pattern1
		dc.w @Wait-@Pattern1

; ===========================================================================

@ControlDirection:
		tst.b 	@SwapsLeft(a0)
		beq.w	@StartGroundpound

		tst.w 	@DelayTimer(a0)
		bne.s 	@CheckThrow
		sub.w 	#$1, @DelayTimer(a0)

@CheckThrow:
		sub.b	#$1, @ThrowTimer(a0)
		tst.b	@ThrowTimer(a0)
		beq.w 	@Throw

		tst.w	obVelX(a0) ; is eggman not moving?
		bne.s	@SwapMove ; gang shit
		
		moveq	#$40, d0
		bsr.s	@Swap ; we're good to go
		bcs.s	@ContinueMoving ; less than $22C, keep going

		neg.w	d0

@ContinueMoving:
		; TODO: 
		; - Add flag for groundpounding. If true, skip groundpound check and setup.
		; - If not groundpounding, check. Subtract Sonic's X position from the boss' X position
		;   and run `and.b #$7F, d0` on the result (gets absolute value by clearing the most significant bit), 
		;   then check if it's in bounds.
		bra.w	BossMove

@Swap:
		move.w	#$150, obVelX(a0)
		btst	#0, obStatus(a0) ; is bit 0 clear
		bne.s	@SwapMove ; if true, just move and do nothing else

		tst.b	obRender(a0)
		beq.s 	@SwapMove

		neg.w	obVelX(a0)

@SwapMove:
		bsr.w	BossMove

@IsShipRight:
		btst	#0, obStatus(a0)
		beq.s	@IsShipLeft
		cmpi.w	#$2D15+$F, @TargetX(a0)
		blt.s	@Swap_rts
		move.w	#$2D15+$F, @TargetX(a0)
		bra.s	@StopMoving

@IsShipLeft:
		cmpi.w	#$2C1D, @TargetX(a0)
		bgt.s	@Swap_rts
		move.w	#$2C1D, @TargetX(a0)

@StopMoving:
		clr.w	obVelX(a0)
		cmpi.w	#$22C, @TargetY(a0)
		bcc.s	@Flip
		rts

@Flip:
		bchg	#0, obStatus(a0)

		tst.b 	@SwapsLeft(a0)
		beq.s	@Swap_rts

		subi.b 	#1, @SwapsLeft(a0)
		
@Swap_rts:
		rts

; ===========================================================================

@StartGroundpound:
		move.w	#50, @DelayTimer(a0)
		add.b 	#1, obSubtype(a0)
		rts

; ===========================================================================

@Throw:
		Instance.new BossBumper, a1
		jsr 	RandomDirectionA1
		move.w 	obX(a0), obX(a1)
		move.w 	obY(a0), obY(a1)
		move.w 	#10, @Bounces(a1)

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
		move.w 	#-$500, @BossBounceAmount(a0)

@StartFalling_rts:
		rts	

; ===========================================================================

@Fall:
		bsr.w	BossDefeated
		cmpi.w	#0, @BossBounceAmount(a0)
		bpl.s 	@Fall2

		jsr		(ObjFloorDist).l
		cmpi.w	#$C, d1
		ble.s	@Bounce

		jsr		ObjectFall
		rts

@Bounce:
		move.w	@BossBounceAmount(a0), obVelY(a0)
		addi.w 	#$130, @BossBounceAmount(a0)
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
		music	mus_SYZ		; play SYZ music
		add.w	#300, (v_limitright2).w

		jsr	(DeleteObject).l

; ===========================================================================

@FaceMain:	; Routine 4
		moveq	#0, d0
		moveq	#1, d1
		movea.l	@FaceStatus(a0), a1
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

@SpikeMain:	; Routine 8
		movea.l	@FaceStatus(a0), a1
		cmpi.b	#8, ob2ndRout(a1)
		bne.s	@ShowSpike
		tst.b	obRender(a0)
		bpl.s	@DeleteSpike

@ShowSpike:
		move.l	#Map_BossItems, obMap(a0)
		move.w	#$246C, obGfx(a0)
		move.b	#5, obFrame(a0)
		move.b	#$84, obColType(a0)
		move.b	#8,obActWid(a0)
		move.b	#$C,obHeight(a0)

		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w 	#$24, obY(a0)
		
		move.b	obStatus(a1), obStatus(a0)
		moveq	#3, d0
		and.b	obStatus(a0), d0
		andi.b	#$FC, obRender(a0)
		or.b	d0, obRender(a0)

		jmp 	DisplaySprite
; ===========================================================================

@DeleteSpike:
		jmp	(DeleteObject).l