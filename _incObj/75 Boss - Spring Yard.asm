; ---------------------------------------------------------------------------
; Object 75 - Eggman (SYZ)
; ---------------------------------------------------------------------------

BossSpringYard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jmp	@Index(pc,d1.w)
; ===========================================================================
@Index:	dc.w @Main-@Index
		dc.w @ShipMain-@Index
		dc.w @FaceMain-@Index
		dc.w @FlameMain-@Index
		dc.w @SpikeMain-@Index

@TargetX:			equ $30
@TargetY:			equ $38
@Timer:			equ $3C
@PickUpFlag:		equ $3D

@ComparisonX:	equ $34
@GrabbedBlock:	equ $36

@ObjData:	dc.b 2,	0, 5		; routine number, animation, priority
		dc.b 4,	1, 5
		dc.b 6,	7, 5
		dc.b 8,	0, 5
; ===========================================================================

@Main:	; Routine 0
		move.w	#$2DB0,obX(a0)
		move.w	#$4DA,obY(a0)
		move.w	obX(a0),@TargetX(a0)
		move.w	obY(a0),@TargetY(a0)
		move.b	#$F,obColType(a0)
		move.b	#8,obColProp(a0) ; set number of hits to 8
		lea	@ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	@LoadBoss
; ===========================================================================

@Loop:
		jsr	(FindNextFreeObj).l
		bne.s	@ShipMain
		move.b	#id_BossSpringYard,(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

@LoadBoss:
		bclr	#0,obStatus(a0)
		clr.b	ob2ndRout(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,obAnim(a1)
		move.b	(a2)+,obPriority(a1)
		move.l	#Map_Eggman,obMap(a1)
		move.w	#$400,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.l	a0,@ComparisonX(a1)
		dbf	d1,@Loop	; repeat sequence 3 more times

@ShipMain:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	@ShipIndex(pc,d0.w),d1
		jsr	@ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================
@ShipIndex:dc.w @Start-@ShipIndex,	@Roam-@ShipIndex
		dc.w @StartAttack-@ShipIndex,	@Defeated-@ShipIndex
		dc.w @Flee-@ShipIndex,	@Flee4-@ShipIndex
; ===========================================================================

@Start:
		move.w	#-$100,obVelX(a0)
		cmpi.w	#$2D38,@TargetX(a0)
		bcc.s	@ShipBobbing
		addq.b	#2,ob2ndRout(a0)

@ShipBobbing:
		move.b	$3F(a0),d0
		addq.b	#2,$3F(a0)
		jsr	(CalcSine).l
		asr.w	#2,d0
		move.w	d0,obVelY(a0)

@Move:
		bsr.w	BossMove
		move.w	@TargetY(a0),obY(a0)
		move.w	@TargetX(a0),obX(a0)

@Damage:
		move.w	obX(a0),d0
		subi.w	#$2C00,d0	; some offset stuff
		lsr.w	#5,d0
		move.b	d0,@ComparisonX(a0)		; before checking if we should damage the boss, we allow it to attack by setting the X comparison value
		
		cmpi.b	#6,ob2ndRout(a0)
		bcc.s	@Damage_rts
		
		tst.b	obStatus(a0)
		bmi.s	@PreventNoCollision
		
		tst.b	obColType(a0)
		bne.s	@Damage_rts
		
		tst.b	$3E(a0)
		bne.s	@HitFlash
		
		move.b	#$20,$3E(a0)
		sfx	sfx_BossHit	; play boss damage sound

@HitFlash:
		lea	(v_pal_dry+$22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	@UndoHitFlash
		move.w	#cWhite,d0

@UndoHitFlash:
		move.w	d0,(a1)
		subq.b	#1,$3E(a0)
		bne.s	@Damage_rts
		move.b	#$F,obColType(a0)

@Damage_rts:
		rts	
; ===========================================================================

@PreventNoCollision:
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,ob2ndRout(a0)
		move.w	#$B4,@Timer(a0)
		clr.w	obVelX(a0)
		rts	
; ===========================================================================

@Roam:
		move.w	@TargetX(a0),d0
		move.w	#$140,obVelX(a0)
		
		btst	#0,obStatus(a0)
		bne.s	@ChangeDirection
		
		neg.w	obVelX(a0)
		
		cmpi.w	#$2C08,d0
		bgt.s	@Stop
		bra.s	@ChangeDirection2

; ===========================================================================

@ChangeDirection:
		cmpi.w	#$2D38,d0
		blt.s	@Stop

@ChangeDirection2:
		bchg	#0,obStatus(a0)
		clr.b	@PickUpFlag(a0)

@Stop:
		subi.w	#$2C10,d0
		andi.w	#$1F,d0
		subi.w	#$1F,d0
		bpl.s	@PrepareAttack
		neg.w	d0

@PrepareAttack:
		subq.w	#1,d0
		bgt.s	@PrepareAttackBob
		
		move.w	(v_player+obX).w,d1
		subi.w	#$2C00,d1
		
		asr.w	#5,d1
		cmp.b	@ComparisonX(a0),d1
		bne.s	@PrepareAttackBob
		
		tst.w	@GrabbedBlock(a0)
		bne.w 	@BreakBlock
		
		tst.b	@PickUpFlag(a0)
		bne.s	@PrepareAttackBob
		
		moveq	#0,d0
		move.b	@ComparisonX(a0),d0
		
		asl.w	#5,d0
		addi.w	#$2C10,d0
		
		move.w	d0,@TargetX(a0)
		bsr.w	@FindBlocks
		
		addq.b	#2,ob2ndRout(a0)
		
		clr.w	obSubtype(a0)
		clr.w	obVelX(a0)

@PrepareAttackBob:
		bra.w	@ShipBobbing
; ===========================================================================

@StartAttack:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		move.w	@AttackIndex(pc,d0.w),d0
		jmp	@AttackIndex(pc,d0.w)
		
@BreakBlock:
		moveq	#-1,d0
		move.w	@GrabbedBlock(a0),d0
		beq.s	@RemoveBlock
		movea.l	d0,a1
		move.b	#$A,$29(a1)

@RemoveBlock:
		clr.w	@GrabbedBlock(a0)
		bra.w	@ShipBobbing
		
; ===========================================================================
@AttackIndex:	dc.w @Attack-@AttackIndex
		dc.w @PrepareLifting-@AttackIndex
		dc.w @StartGettingUp-@AttackIndex
		dc.w @Stabilize-@AttackIndex
; ===========================================================================

@Attack:
		move.w	#$180,obVelY(a0)
		move.w	@TargetY(a0),d0
		
		cmpi.w	#$556,d0
		bcs.s	@AttackMove
		move.w	#$556,@TargetY(a0)
		clr.w	@Timer(a0)
		moveq	#-1,d0
		move.w	@GrabbedBlock(a0),d0
		beq.s	@AttackBreak
		movea.l	d0,a1
		move.b	#-1,$29(a1)
		move.b	#-1,$29(a0)
		move.l	a0,@ComparisonX(a1)
		move.w	#$32,@Timer(a0)

@AttackBreak:
		clr.w	obVelY(a0)
		addq.b	#2,obSubtype(a0)

@AttackMove:
		bra.w	@Move
; ===========================================================================

@PrepareLifting:
		subq.w	#1,@Timer(a0)
		bpl.s	@CheckForUpdateGrabbing
		addq.b	#2,obSubtype(a0)
		move.w	#-$800,obVelY(a0)
		tst.w	@GrabbedBlock(a0)
		bne.s	@SomeShitIdk
		asr	obVelY(a0)

@SomeShitIdk:
		moveq	#0,d0
		bra.s	@UpdateHurtStateGrabbing
; ===========================================================================

@CheckForUpdateGrabbing:
		moveq	#0,d0
		cmpi.w	#$1E,@Timer(a0)
		bgt.s	@UpdateHurtStateGrabbing
		moveq	#2,d0
		btst	#1,@PickUpFlag(a0)
		beq.s	@UpdateHurtStateGrabbing
		neg.w	d0

@UpdateHurtStateGrabbing:
		add.w	@TargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	@TargetX(a0),obX(a0)
		bra.w	@Damage
; ===========================================================================

@StartGettingUp:
		move.w	#$4DA,d0
		tst.w	@GrabbedBlock(a0)
		beq.s	@StartGettingUp2
		subi.w	#$18,d0

@StartGettingUp2:
		cmp.w	@TargetY(a0),d0
		blt.s	@GetUp
		move.w	#8,@Timer(a0)
		tst.w	@GrabbedBlock(a0)
		beq.s	@StartGettingUp3
		move.w	#$2D,@Timer(a0)

@StartGettingUp3:
		addq.b	#2,obSubtype(a0)
		clr.w	obVelY(a0)
		bra.s	@GetUpMove
; ===========================================================================

@GetUp:
		cmpi.w	#-$40,obVelY(a0)
		bge.s	@GetUpMove
		addi.w	#$C,obVelY(a0)

@GetUpMove:
		bra.w	@Move
; ===========================================================================

@Stabilize:
		subq.w	#1,@Timer(a0)
		bgt.w	@Shake1
		bmi.w	@ResumeMovement

; ===========================================================================

@ResumeMovement:
		cmpi.w	#-$4,@Timer(a0)
		bne.s	@Shake1
		clr.b	$29(a0)
		subq.b	#2,ob2ndRout(a0)
		move.b	#-1,@PickUpFlag(a0)
		bra.s	@DamageOnResuming
; ===========================================================================

@Shake1:
		moveq	#1,d0
		tst.w	@GrabbedBlock(a0)
		beq.s	@StopShake1
		moveq	#2,d0

@StopShake1:
		cmpi.w	#$4DA,@TargetY(a0)
		beq.s	@Shake2
		blt.s	@PositionAfterShake1
		neg.w	d0

@PositionAfterShake1:
		tst.w	@GrabbedBlock(a0)
		add.w	d0,@TargetY(a0)

@Shake2:
		nop
		moveq	#0,d0
		tst.w	@GrabbedBlock(a0)
		beq.s	@PositionAfterShake2
		moveq	#2,d0
		btst	#0,@PickUpFlag(a0)
		beq.s	@PositionAfterShake2
		neg.w	d0

@PositionAfterShake2:
		add.w	@TargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	@TargetX(a0),8(a0)

@DamageOnResuming:
		bra.w	@Damage

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


@FindBlocks:
		clr.w	@GrabbedBlock(a0)
		lea	(v_objspace+$40).w,a1
		moveq	#$3E,d0
		moveq	#$76,d1
		move.b	@ComparisonX(a0),d2

@FindLoop:
		cmp.b	(a1),d1		; is object a SYZ boss block?
		bne.s	@NotABlock	; if not, branch
		cmp.b	obSubtype(a1),d2
		bne.s	@NotABlock
		move.w	a1,@GrabbedBlock(a0)
		bra.s	@FindLoop_rts
; ===========================================================================

@NotABlock:
		lea	$40(a1),a1	; next object RAM entry
		dbf	d0,@FindLoop

@FindLoop_rts:
		rts	
; End of function @FindBlocks

; ===========================================================================

@Defeated:
		subq.w	#1,@Timer(a0)
		bmi.s	@SetDefeatStatus
		bra.w	BossDefeated
; ===========================================================================

@SetDefeatStatus:
		addq.b	#2,ob2ndRout(a0)
		clr.w	obVelY(a0)
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		move.w	#-1,@Timer(a0)
		tst.b	(v_bossstatus).w
		bne.s	@DamageWhileDefeated
		move.b	#1,(v_bossstatus).w

@DamageWhileDefeated:
		bra.w	@Damage
; ===========================================================================

@Flee:
		addq.w	#1,@Timer(a0)
		beq.s	@Flee2
		bpl.s	@Flee3
		addi.w	#$18,obVelY(a0)
		bra.s	@FleeMove
; ===========================================================================

@Flee2:
		clr.w	obVelY(a0)
		bra.s	@FleeMove
; ===========================================================================

@Flee3:
		cmpi.w	#$20,@Timer(a0)
		bcs.s	@FleeSlowY
		beq.s	@FleePlayMusic
		cmpi.w	#$2A,@Timer(a0)
		bcs.s	@FleeMove
		addq.b	#2,ob2ndRout(a0)
		bra.s	@FleeMove
; ===========================================================================

@FleeSlowY:
		subq.w	#8,obVelY(a0)
		bra.s	@FleeMove
; ===========================================================================

@FleePlayMusic:
		clr.w	obVelY(a0)
		music	mus_SYZ		; play SYZ music

@FleeMove:
		bra.w	@Move
; ===========================================================================

@Flee4:
		move.w	#$400,obVelX(a0)
		move.w	#-$40,obVelY(a0)
		cmpi.w	#$2D40,(v_limitright2).w
		bcc.s	@FleeCheckRender
		addq.w	#2,(v_limitright2).w
		bra.s	@FleeMove2
; ===========================================================================

@FleeCheckRender:
		tst.b	obRender(a0)
		bpl.s	@ShipDelete

@FleeMove2:
		bsr.w	BossMove
		bra.w	@ShipBobbing
; ===========================================================================

@ShipDelete:
		jmp	(DeleteObject).l
; ===========================================================================

@FaceMain:	; Routine 4
		moveq	#1,d1
		movea.l	@ComparisonX(a0),a1
		moveq	#0,d0
		move.b	ob2ndRout(a1),d0
		move.w	@Face(pc,d0.w),d0
		jsr	@Face(pc,d0.w)
		move.b	d1,obAnim(a0)
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.s	@FaceDelete
		bra.s	@DisplayFace
; ===========================================================================

@FaceDelete:
		jmp	(DeleteObject).l
; ===========================================================================
@Face:	dc.w @FaceTestHurt-@Face, @FaceTestHurt-@Face
		dc.w @FaceUnknown3-@Face, @FaceDefeated-@Face
		dc.w @FaceDefeated-@Face, @FaceDefeated2-@Face
; ===========================================================================

@FaceDefeated:
		moveq	#$A,d1
		rts	
; ===========================================================================

@FaceDefeated2:
		moveq	#6,d1
		rts
; ===========================================================================

@FaceUnknown3:
		moveq	#0,d0
		move.b	obSubtype(a1),d0
		move.w	@Face2(pc,d0.w),d0
		jmp	@Face2(pc,d0.w)
; ===========================================================================
@Face2:	dc.w @FaceTestHurtShort-@Face2, @Face2Unknown-@Face2
		dc.w @FaceTestHurtShort-@Face2, @FaceTestHurtShort-@Face2
; ===========================================================================

@FaceTestHurtShort:
		bra.s	@FaceTestHurt
; ===========================================================================

@Face2Unknown:
		moveq	#6,d1

@FaceTestHurt:
		tst.b	obColType(a1)		; is eggman being hurt?
		bne.s	@FaceTestLaugh	; if not, branch
		moveq	#5,d1
		rts	
; ===========================================================================

@FaceTestLaugh:
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	@FaceTestLaugh_rts
		moveq	#4,d1

@FaceTestLaugh_rts:
		rts	
; ===========================================================================

@FlameMain:; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	@ComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	@FaceFleeing
		move.b	#$B,obAnim(a0)
		tst.b	1(a0)
		bpl.s	@FlameDelete
		bra.s	@DisplayFaceShort
; ===========================================================================

@FaceFleeing:
		tst.w	obVelX(a1)
		beq.s	@DisplayFaceShort
		move.b	#8,obAnim(a0)

@DisplayFaceShort:
		bra.s	@DisplayFace
; ===========================================================================

@FlameDelete:
		jmp	(DeleteObject).l
; ===========================================================================

@DisplayFace:
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		movea.l	@ComparisonX(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)

@DisplayFace2:
		move.b	obStatus(a1),obStatus(a0)
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

@SpikeMain:; Routine 8
		move.l	#Map_BossItems,obMap(a0)
		move.w	#$246C,obGfx(a0)
		move.b	#5,obFrame(a0)
		movea.l	@ComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	@SpikeOut
		tst.b	obRender(a0)
		bpl.s	@SpikeDelete

@SpikeOut:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.w	@Timer(a0),d0
		cmpi.b	#4,ob2ndRout(a1)
		bne.s	@SpikeTimerCheck2
		cmpi.b	#6,obSubtype(a1)
		beq.s	@SpikeTimerCheck
		tst.b	obSubtype(a1)
		bne.s	@SpikeIn
		cmpi.w	#$94,d0
		bge.s	@SpikeIn
		addq.w	#7,d0
		bra.s	@SpikeIn
; ===========================================================================

@SpikeTimerCheck:
		tst.w	@Timer(a1)
		bpl.s	@SpikeIn

@SpikeTimerCheck2:
		tst.w	d0
		ble.s	@SpikeIn
		subq.w	#5,d0

@SpikeIn:
		move.w	d0,@Timer(a0)
		asr.w	#2,d0
		add.w	d0,obY(a0)
		move.b	#8,obActWid(a0)
		move.b	#$C,obHeight(a0)
		clr.b	obColType(a0)
		movea.l	@ComparisonX(a0),a1
		tst.b	obColType(a1)
		beq.s	@DisplayFaceShort2
		tst.b	$29(a1)
		bne.s	@DisplayFaceShort2
		move.b	#$84,obColType(a0)

@DisplayFaceShort2:
		bra.w	@DisplayFace2
; ===========================================================================

@SpikeDelete:
		jmp	(DeleteObject).l
