; ---------------------------------------------------------------------------
; Object 75 - Eggman (SYZ)
; ---------------------------------------------------------------------------

BossSpringYard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	SYZBossIndex(pc,d0.w),d1
		jmp	SYZBossIndex(pc,d1.w)
; ===========================================================================
SYZBossIndex:	dc.w SYZBossMain-SYZBossIndex
		dc.w SYZBossShipMain-SYZBossIndex
		dc.w SYZBossFaceMain-SYZBossIndex
		dc.w SYZBossFlameMain-SYZBossIndex
		dc.w SYZBossSpikeMain-SYZBossIndex

SYZBossTargetX:			equ $30
SYZBossTargetY:			equ $38
SYZBossTimer:			equ $3C

SYZBossComparisonX:	equ $34
SYZBossGrabbedBlock:	equ $36

SYZBossObjData:	dc.b 2,	0, 5		; routine number, animation, priority
		dc.b 4,	1, 5
		dc.b 6,	7, 5
		dc.b 8,	0, 5
; ===========================================================================

SYZBossMain:	; Routine 0
		move.w	#$2DB0,obX(a0)
		move.w	#$4DA,obY(a0)
		move.w	obX(a0),SYZBossTargetX(a0)
		move.w	obY(a0),SYZBossTargetY(a0)
		move.b	#$F,obColType(a0)
		move.b	#8,obColProp(a0) ; set number of hits to 8
		lea	SYZBossObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	SYZBossLoadBoss
; ===========================================================================

SYZBossLoop:
		jsr	(FindNextFreeObj).l
		bne.s	SYZBossShipMain
		move.b	#id_BossSpringYard,(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

SYZBossLoadBoss:
		bclr	#0,obStatus(a0)
		clr.b	ob2ndRout(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,obAnim(a1)
		move.b	(a2)+,obPriority(a1)
		move.l	#Map_Eggman,obMap(a1)
		move.w	#$400,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.l	a0,SYZBossComparisonX(a1)
		dbf	d1,SYZBossLoop	; repeat sequence 3 more times

SYZBossShipMain:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	SYZBossShipIndex(pc,d0.w),d1
		jsr	SYZBossShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================
SYZBossShipIndex:dc.w SYZBossStart-SYZBossShipIndex,	SYZBossRoam-SYZBossShipIndex
		dc.w SYZBossStartAttack-SYZBossShipIndex,	SYZBossDefeated-SYZBossShipIndex
		dc.w SYZBossFlee-SYZBossShipIndex,	SYZBossFlee4-SYZBossShipIndex
; ===========================================================================

SYZBossStart:
		move.w	#-$100,obVelX(a0)
		cmpi.w	#$2D38,SYZBossTargetX(a0)
		bcc.s	SYZShipBobbing
		addq.b	#2,ob2ndRout(a0)

SYZShipBobbing:
		move.b	$3F(a0),d0
		addq.b	#2,$3F(a0)
		jsr	(CalcSine).l
		asr.w	#2,d0
		move.w	d0,obVelY(a0)

SYZMoveBoss:
		bsr.w	BossMove
		move.w	SYZBossTargetY(a0),obY(a0)
		move.w	SYZBossTargetX(a0),obX(a0)

SYZDamageBoss:
		move.w	obX(a0),d0
		subi.w	#$2C00,d0	; some offset stuff
		lsr.w	#5,d0
		move.b	d0,SYZBossComparisonX(a0)		; before checking if we should damage the boss, we allow it to attack by setting the X comparison value
		
		cmpi.b	#6,ob2ndRout(a0)
		bcc.s	SYZDamageBoss_rts
		
		tst.b	obStatus(a0)
		bmi.s	SYZBossPreventNoCollision
		
		tst.b	obColType(a0)
		bne.s	SYZDamageBoss_rts
		
		tst.b	$3E(a0)
		bne.s	SYZBossHitFlash
		
		move.b	#$20,$3E(a0)
		sfx	sfx_BossHit	; play boss damage sound

SYZBossHitFlash:
		lea	(v_pal_dry+$22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	SYZBossUndoHitFlash
		move.w	#cWhite,d0

SYZBossUndoHitFlash:
		move.w	d0,(a1)
		subq.b	#1,$3E(a0)
		bne.s	SYZDamageBoss_rts
		move.b	#$F,obColType(a0)

SYZDamageBoss_rts:
		rts	
; ===========================================================================

SYZBossPreventNoCollision:
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,ob2ndRout(a0)
		move.w	#$B4,SYZBossTimer(a0)
		clr.w	obVelX(a0)
		rts	
; ===========================================================================

SYZBossRoam:
		move.w	SYZBossTargetX(a0),d0
		move.w	#$140,obVelX(a0)
		
		btst	#0,obStatus(a0)
		bne.s	SYZBossChangeDirection
		
		neg.w	obVelX(a0)
		
		cmpi.w	#$2C08,d0
		bgt.s	SYZBossStop
		bra.s	SYZBossChangeDirection2

; ===========================================================================

SYZBossChangeDirection:
		cmpi.w	#$2D38,d0
		blt.s	SYZBossStop

SYZBossChangeDirection2:
		bchg	#0,obStatus(a0)
		clr.b	$3D(a0)

SYZBossStop:
		subi.w	#$2C10,d0
		andi.w	#$1F,d0
		subi.w	#$1F,d0
		bpl.s	SYZBossPrepareAttack
		neg.w	d0

SYZBossPrepareAttack:
		subq.w	#1,d0
		bgt.s	SYZBossPrepareAttackBob
		
		move.w	(v_player+obX).w,d1
		subi.w	#$2C00,d1
		
		asr.w	#5,d1
		cmp.b	SYZBossComparisonX(a0),d1
		bne.s	SYZBossPrepareAttackBob
		
		tst.w	SYZBossGrabbedBlock(a0)
		bne.w 	SYZBossBreakBlock
		
		tst.b	$3D(a0)
		bne.s	SYZBossPrepareAttackBob
		
		moveq	#0,d0
		move.b	SYZBossComparisonX(a0),d0
		
		asl.w	#5,d0
		addi.w	#$2C10,d0
		
		move.w	d0,SYZBossTargetX(a0)
		bsr.w	SYZBossFindBlocks
		
		addq.b	#2,ob2ndRout(a0)
		
		clr.w	obSubtype(a0)
		clr.w	obVelX(a0)

SYZBossPrepareAttackBob:
		bra.w	SYZShipBobbing
; ===========================================================================

SYZBossStartAttack:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		move.w	SYZBossAttackIndex(pc,d0.w),d0
		jmp	SYZBossAttackIndex(pc,d0.w)
		
SYZBossBreakBlock:
		moveq	#-1,d0
		move.w	SYZBossGrabbedBlock(a0),d0
		beq.s	SYZBossRemoveBlock
		movea.l	d0,a1
		move.b	#$A,$29(a1)

SYZBossRemoveBlock:
		clr.w	SYZBossGrabbedBlock(a0)
		bra.w	SYZShipBobbing
		
; ===========================================================================
SYZBossAttackIndex:	dc.w SYZBossAttack-SYZBossAttackIndex
		dc.w SYZBossPrepareLifting-SYZBossAttackIndex
		dc.w SYZBossStartGettingUp-SYZBossAttackIndex
		dc.w SYZBossStabilize-SYZBossAttackIndex
; ===========================================================================

SYZBossAttack:
		move.w	#$180,obVelY(a0)
		move.w	SYZBossTargetY(a0),d0
		
		cmpi.w	#$556,d0
		bcs.s	SYZBossAttackMove
		move.w	#$556,SYZBossTargetY(a0)
		clr.w	SYZBossTimer(a0)
		moveq	#-1,d0
		move.w	SYZBossGrabbedBlock(a0),d0
		beq.s	SYZBossAttackBreak
		movea.l	d0,a1
		move.b	#-1,$29(a1)
		move.b	#-1,$29(a0)
		move.l	a0,SYZBossComparisonX(a1)
		move.w	#$32,SYZBossTimer(a0)

SYZBossAttackBreak:
		clr.w	obVelY(a0)
		addq.b	#2,obSubtype(a0)

SYZBossAttackMove:
		bra.w	SYZMoveBoss
; ===========================================================================

SYZBossPrepareLifting:
		subq.w	#1,SYZBossTimer(a0)
		bpl.s	SYZBossCheckForUpdateGrabbing
		addq.b	#2,obSubtype(a0)
		move.w	#-$800,obVelY(a0)
		tst.w	SYZBossGrabbedBlock(a0)
		bne.s	SYZBossSomeShitIdk
		asr	obVelY(a0)

SYZBossSomeShitIdk:
		moveq	#0,d0
		bra.s	SYZBossUpdateHurtStateGrabbing
; ===========================================================================

SYZBossCheckForUpdateGrabbing:
		moveq	#0,d0
		cmpi.w	#$1E,SYZBossTimer(a0)
		bgt.s	SYZBossUpdateHurtStateGrabbing
		moveq	#2,d0
		btst	#1,$3D(a0)
		beq.s	SYZBossUpdateHurtStateGrabbing
		neg.w	d0

SYZBossUpdateHurtStateGrabbing:	; what a mouthful!
		add.w	SYZBossTargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	SYZBossTargetX(a0),obX(a0)
		bra.w	SYZDamageBoss
; ===========================================================================

SYZBossStartGettingUp:
		move.w	#$4DA,d0
		tst.w	SYZBossGrabbedBlock(a0)
		beq.s	SYZBossStartGettingUp2
		subi.w	#$18,d0

SYZBossStartGettingUp2:
		cmp.w	SYZBossTargetY(a0),d0
		blt.s	SYZBossGetUp
		move.w	#8,SYZBossTimer(a0)
		tst.w	SYZBossGrabbedBlock(a0)
		beq.s	SYZBossStartGettingUp3
		move.w	#$2D,SYZBossTimer(a0)

SYZBossStartGettingUp3:
		addq.b	#2,obSubtype(a0)
		clr.w	obVelY(a0)
		bra.s	SYZBossGetUpMove
; ===========================================================================

SYZBossGetUp:
		cmpi.w	#-$40,obVelY(a0)
		bge.s	SYZBossGetUpMove
		addi.w	#$C,obVelY(a0)

SYZBossGetUpMove:
		bra.w	SYZMoveBoss
; ===========================================================================

SYZBossStabilize:
		subq.w	#1,SYZBossTimer(a0)
		bgt.w	SYZBossShake1
		bmi.w	SYZBossResumeMovement

; ===========================================================================

SYZBossResumeMovement:
		cmpi.w	#-$4,SYZBossTimer(a0)
		bne.s	SYZBossShake1
		clr.b	$29(a0)
		subq.b	#2,ob2ndRout(a0)
		move.b	#-1,$3D(a0)
		bra.s	SYZBossDamageOnResuming
; ===========================================================================

SYZBossShake1:
		moveq	#1,d0
		tst.w	SYZBossGrabbedBlock(a0)
		beq.s	SYZBossStopShake1
		moveq	#2,d0

SYZBossStopShake1:
		cmpi.w	#$4DA,SYZBossTargetY(a0)
		beq.s	SYZBossShake2
		blt.s	SYZBossPositionAfterShake1
		neg.w	d0

SYZBossPositionAfterShake1:
		tst.w	SYZBossGrabbedBlock(a0)
		add.w	d0,SYZBossTargetY(a0)

SYZBossShake2:
		nop
		moveq	#0,d0
		tst.w	SYZBossGrabbedBlock(a0)
		beq.s	SYZBossPositionAfterShake2
		moveq	#2,d0
		btst	#0,$3D(a0)
		beq.s	SYZBossPositionAfterShake2
		neg.w	d0

SYZBossPositionAfterShake2:
		add.w	SYZBossTargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	SYZBossTargetX(a0),8(a0)

SYZBossDamageOnResuming:
		bra.w	SYZDamageBoss

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SYZBossFindBlocks:
		clr.w	SYZBossGrabbedBlock(a0)
		lea	(v_objspace+$40).w,a1
		moveq	#$3E,d0
		moveq	#$76,d1
		move.b	SYZBossComparisonX(a0),d2

SYZBossFindLoop:
		cmp.b	(a1),d1		; is object a SYZ boss block?
		bne.s	SYZBossNotABlock	; if not, branch
		cmp.b	obSubtype(a1),d2
		bne.s	SYZBossNotABlock
		move.w	a1,SYZBossGrabbedBlock(a0)
		bra.s	SYZBossFindLoop_rts
; ===========================================================================

SYZBossNotABlock:
		lea	$40(a1),a1	; next object RAM entry
		dbf	d0,SYZBossFindLoop

SYZBossFindLoop_rts:
		rts	
; End of function SYZBossFindBlocks

; ===========================================================================

SYZBossDefeated:
		subq.w	#1,SYZBossTimer(a0)
		bmi.s	SYZBossSetDefeatStatus
		bra.w	BossDefeated
; ===========================================================================

SYZBossSetDefeatStatus:
		addq.b	#2,ob2ndRout(a0)
		clr.w	obVelY(a0)
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		move.w	#-1,SYZBossTimer(a0)
		tst.b	(v_bossstatus).w
		bne.s	SYZBossDamageWhileDefeated
		move.b	#1,(v_bossstatus).w

SYZBossDamageWhileDefeated:
		bra.w	SYZDamageBoss
; ===========================================================================

SYZBossFlee:
		addq.w	#1,SYZBossTimer(a0)
		beq.s	SYZBossFlee2
		bpl.s	SYZBossFlee3
		addi.w	#$18,obVelY(a0)
		bra.s	SYZBossFleeMove
; ===========================================================================

SYZBossFlee2:
		clr.w	obVelY(a0)
		bra.s	SYZBossFleeMove
; ===========================================================================

SYZBossFlee3:
		cmpi.w	#$20,SYZBossTimer(a0)
		bcs.s	SYZBossFleeSlowY
		beq.s	SYZBossFleePlayMusic
		cmpi.w	#$2A,SYZBossTimer(a0)
		bcs.s	SYZBossFleeMove
		addq.b	#2,ob2ndRout(a0)
		bra.s	SYZBossFleeMove
; ===========================================================================

SYZBossFleeSlowY:
		subq.w	#8,obVelY(a0)
		bra.s	SYZBossFleeMove
; ===========================================================================

SYZBossFleePlayMusic:
		clr.w	obVelY(a0)
		music	mus_SYZ		; play SYZ music

SYZBossFleeMove:
		bra.w	SYZMoveBoss
; ===========================================================================

SYZBossFlee4:
		move.w	#$400,obVelX(a0)
		move.w	#-$40,obVelY(a0)
		cmpi.w	#$2D40,(v_limitright2).w
		bcc.s	SYZBossFleeCheckRender
		addq.w	#2,(v_limitright2).w
		bra.s	SYZBossFleeMove2
; ===========================================================================

SYZBossFleeCheckRender:
		tst.b	obRender(a0)
		bpl.s	SYZBossShipDelete

SYZBossFleeMove2:
		bsr.w	BossMove
		bra.w	SYZShipBobbing
; ===========================================================================

SYZBossShipDelete:
		jmp	(DeleteObject).l
; ===========================================================================

SYZBossFaceMain:	; Routine 4
		moveq	#1,d1
		movea.l	SYZBossComparisonX(a0),a1
		moveq	#0,d0
		move.b	ob2ndRout(a1),d0
		move.w	SYZBossFace(pc,d0.w),d0
		jsr	SYZBossFace(pc,d0.w)
		move.b	d1,obAnim(a0)
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.s	SYZBossFaceDelete
		bra.s	SYZBossDisplayFace
; ===========================================================================

SYZBossFaceDelete:
		jmp	(DeleteObject).l
; ===========================================================================
SYZBossFace:	dc.w SYZBossFaceTestHurt-SYZBossFace, SYZBossFaceTestHurt-SYZBossFace
		dc.w SYZBossFaceUnknown3-SYZBossFace, SYZBossFaceDefeated-SYZBossFace
		dc.w SYZBossFaceDefeated-SYZBossFace, SYZBossFaceDefeated2-SYZBossFace
; ===========================================================================

SYZBossFaceDefeated:
		moveq	#$A,d1
		rts	
; ===========================================================================

SYZBossFaceDefeated2:
		moveq	#6,d1
		rts
; ===========================================================================

SYZBossFaceUnknown3:
		moveq	#0,d0
		move.b	obSubtype(a1),d0
		move.w	SYZBossFace2(pc,d0.w),d0
		jmp	SYZBossFace2(pc,d0.w)
; ===========================================================================
SYZBossFace2:	dc.w SYZBossFaceTestHurtShort-SYZBossFace2, SYZBossFace2Unknown-SYZBossFace2
		dc.w SYZBossFaceTestHurtShort-SYZBossFace2, SYZBossFaceTestHurtShort-SYZBossFace2
; ===========================================================================

SYZBossFaceTestHurtShort:
		bra.s	SYZBossFaceTestHurt
; ===========================================================================

SYZBossFace2Unknown:
		moveq	#6,d1

SYZBossFaceTestHurt:
		tst.b	obColType(a1)		; is eggman being hurt?
		bne.s	SYZBossFaceTestLaugh	; if not, branch
		moveq	#5,d1
		rts	
; ===========================================================================

SYZBossFaceTestLaugh:
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	SYZBossFaceTestLaugh_rts
		moveq	#4,d1

SYZBossFaceTestLaugh_rts:
		rts	
; ===========================================================================

SYZBossFlameMain:; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	SYZBossComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	SYZBossFaceFleeing
		move.b	#$B,obAnim(a0)
		tst.b	1(a0)
		bpl.s	SYZBossFlameDelete
		bra.s	SYZBossDisplayFaceShort
; ===========================================================================

SYZBossFaceFleeing:
		tst.w	obVelX(a1)
		beq.s	SYZBossDisplayFaceShort
		move.b	#8,obAnim(a0)

SYZBossDisplayFaceShort:
		bra.s	SYZBossDisplayFace
; ===========================================================================

SYZBossFlameDelete:
		jmp	(DeleteObject).l
; ===========================================================================

SYZBossDisplayFace:
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		movea.l	SYZBossComparisonX(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)

SYZBossDisplayFace2:
		move.b	obStatus(a1),obStatus(a0)
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

SYZBossSpikeMain:; Routine 8
		move.l	#Map_BossItems,obMap(a0)
		move.w	#$246C,obGfx(a0)
		move.b	#5,obFrame(a0)
		movea.l	SYZBossComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	SYZBossSpikeOut
		tst.b	obRender(a0)
		bpl.s	SYZBossSpikeDelete

SYZBossSpikeOut:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.w	SYZBossTimer(a0),d0
		cmpi.b	#4,ob2ndRout(a1)
		bne.s	SYZBossSpikeTimerCheck2
		cmpi.b	#6,obSubtype(a1)
		beq.s	SYZBossSpikeTimerCheck
		tst.b	obSubtype(a1)
		bne.s	SYZBossSpikeIn
		cmpi.w	#$94,d0
		bge.s	SYZBossSpikeIn
		addq.w	#7,d0
		bra.s	SYZBossSpikeIn
; ===========================================================================

SYZBossSpikeTimerCheck:
		tst.w	SYZBossTimer(a1)
		bpl.s	SYZBossSpikeIn

SYZBossSpikeTimerCheck2:
		tst.w	d0
		ble.s	SYZBossSpikeIn
		subq.w	#5,d0

SYZBossSpikeIn:
		move.w	d0,SYZBossTimer(a0)
		asr.w	#2,d0
		add.w	d0,obY(a0)
		move.b	#8,obActWid(a0)
		move.b	#$C,obHeight(a0)
		clr.b	obColType(a0)
		movea.l	SYZBossComparisonX(a0),a1
		tst.b	obColType(a1)
		beq.s	SYZBossDisplayFaceShort2
		tst.b	$29(a1)
		bne.s	SYZBossDisplayFaceShort2
		move.b	#$84,obColType(a0)

SYZBossDisplayFaceShort2:
		bra.w	SYZBossDisplayFace2
; ===========================================================================

SYZBossSpikeDelete:
		jmp	(DeleteObject).l
