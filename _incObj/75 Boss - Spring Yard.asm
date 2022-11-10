; ---------------------------------------------------------------------------
; Object 75 - Eggman (SYZ)
; soulja boy tell em
; ---------------------------------------------------------------------------

BossSpringYard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj75_Index(pc,d0.w),d1
		jmp	Obj75_Index(pc,d1.w)
; ===========================================================================
Obj75_Index:	dc.w Obj75_Main-Obj75_Index
		dc.w Obj75_ShipMain-Obj75_Index
		dc.w Obj75_FaceMain-Obj75_Index
		dc.w Obj75_FlameMain-Obj75_Index
		dc.w Obj75_SpikeMain-Obj75_Index

targetX:			equ $30
targetY:			equ $38

comparisonX:	equ $34
grabbedBlock:	equ $36

Obj75_ObjData:	dc.b 2,	0, 5		; routine number, animation, priority
		dc.b 4,	1, 5
		dc.b 6,	7, 5
		dc.b 8,	0, 5
; ===========================================================================

Obj75_Main:	; Routine 0
		move.w	#$2DB0,obX(a0)
		move.w	#$4DA,obY(a0)
		move.w	obX(a0),targetX(a0)
		move.w	obY(a0),targetY(a0)
		move.b	#$F,obColType(a0)
		move.b	#8,obColProp(a0) ; set number of hits to 8
		lea	Obj75_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	Obj75_LoadBoss
; ===========================================================================

Obj75_Loop:
		jsr	(FindNextFreeObj).l
		bne.s	Obj75_ShipMain
		move.b	#id_BossSpringYard,(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

Obj75_LoadBoss:
		bclr	#0,obStatus(a0)
		clr.b	ob2ndRout(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,obAnim(a1)
		move.b	(a2)+,obPriority(a1)
		move.l	#Map_Eggman,obMap(a1)
		move.w	#$400,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.l	a0,comparisonX(a1)
		dbf	d1,Obj75_Loop	; repeat sequence 3 more times

Obj75_ShipMain:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj75_ShipIndex(pc,d0.w),d1
		jsr	Obj75_ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================
Obj75_ShipIndex:dc.w SYZBossStart-Obj75_ShipIndex,	SYZBossRoam-Obj75_ShipIndex
		dc.w SYZBossStartAttack-Obj75_ShipIndex,	SYZBossDefeated-Obj75_ShipIndex
		dc.w SYZBossFlee-Obj75_ShipIndex,	SYZBossFlee4-Obj75_ShipIndex
; ===========================================================================

SYZBossStart:
		move.w	#-$100,obVelX(a0)
		cmpi.w	#$2D38,targetX(a0)
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
		move.w	targetY(a0),obY(a0)
		move.w	targetX(a0),obX(a0)

SYZDamageBoss:
		move.w	obX(a0),d0
		subi.w	#$2C00,d0	; some offset stuff
		lsr.w	#5,d0
		move.b	d0,comparisonX(a0)		; before checking if we should damage the boss, we allow it to attack by setting the X comparison value
		
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
		move.w	#$B4,$3C(a0)
		clr.w	obVelX(a0)
		rts	
; ===========================================================================

SYZBossRoam:
		move.w	targetX(a0),d0
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
		bgt.s		SYZBossPrepareAttackBob
		
		tst.b		$3D(a0)
		bne.s	SYZBossPrepareAttackBob
		
		move.w	(v_player+obX).w,d1
		subi.w	#$2C00,d1
		
		asr.w	#5,d1
		cmp.b	comparisonX(a0),d1
		bne.s	SYZBossPrepareAttackBob
		
		moveq	#0,d0
		move.b	comparisonX(a0),d0
		
		asl.w	#5,d0
		addi.w	#$2C10,d0
		
		move.w	d0,targetX(a0)
		bsr.w	Obj75_FindBlocks
		
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
; ===========================================================================
SYZBossAttackIndex:	dc.w SYZBossAttack-SYZBossAttackIndex
		dc.w SYZBossPrepareLifting-SYZBossAttackIndex
		dc.w SYZBossStartGettingUp-SYZBossAttackIndex
		dc.w SYZBossBreakBlock-SYZBossAttackIndex
; ===========================================================================

SYZBossAttack:
		move.w	#$180,obVelY(a0)
		move.w	targetY(a0),d0
		
		cmpi.w	#$556,d0
		bcs.s	SYZBossAttackMove
		move.w	#$556,targetY(a0)
		clr.w	$3C(a0)
		moveq	#-1,d0
		move.w	grabbedBlock(a0),d0
		beq.s	SYZBossAttackBreak
		movea.l	d0,a1
		move.b	#-1,$29(a1)
		move.b	#-1,$29(a0)
		move.l	a0,comparisonX(a1)
		move.w	#$32,$3C(a0)

SYZBossAttackBreak:
		clr.w	obVelY(a0)
		addq.b	#2,obSubtype(a0)

SYZBossAttackMove:
		bra.w	SYZMoveBoss
; ===========================================================================

SYZBossPrepareLifting:
		subq.w	#1,$3C(a0)
		bpl.s	SYZBossCheckForUpdateGrabbing
		addq.b	#2,obSubtype(a0)
		move.w	#-$800,obVelY(a0)
		tst.w	grabbedBlock(a0)
		bne.s	SYZBossSomeShitIdk
		asr	obVelY(a0)

SYZBossSomeShitIdk:
		moveq	#0,d0
		bra.s	SYZBossUpdateHurtStateGrabbing
; ===========================================================================

SYZBossCheckForUpdateGrabbing:
		moveq	#0,d0
		cmpi.w	#$1E,$3C(a0)
		bgt.s	SYZBossUpdateHurtStateGrabbing
		moveq	#2,d0
		btst	#1,$3D(a0)
		beq.s	SYZBossUpdateHurtStateGrabbing
		neg.w	d0

SYZBossUpdateHurtStateGrabbing:	; what a mouthful!
		add.w	targetY(a0),d0
		move.w	d0,obY(a0)
		move.w	targetX(a0),obX(a0)
		bra.w	SYZDamageBoss
; ===========================================================================

SYZBossStartGettingUp:
		move.w	#$4DA,d0
		tst.w	grabbedBlock(a0)
		beq.s	SYZBossStartGettingUp2
		subi.w	#$18,d0

SYZBossStartGettingUp2:
		cmp.w	targetY(a0),d0
		blt.s	SYZBossGetUp
		move.w	#8,$3C(a0)
		tst.w	grabbedBlock(a0)
		beq.s	SYZBossStartGettingUp3
		move.w	#$2D,$3C(a0)

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

SYZBossBreakBlock:
		subq.w	#1,$3C(a0)
		bgt.s	SYZBossShake1
		bmi.s	SYZBossResumeMovement
		moveq	#-1,d0
		move.w	grabbedBlock(a0),d0
		beq.s	SYZBossRemoveBlock
		movea.l	d0,a1
		move.b	#$A,$29(a1)

SYZBossRemoveBlock:
		clr.w	grabbedBlock(a0)
		bra.s	SYZBossShake1
; ===========================================================================

SYZBossResumeMovement:
		cmpi.w	#-$1E,$3C(a0)
		bne.s	SYZBossShake1
		clr.b	$29(a0)
		subq.b	#2,ob2ndRout(a0)
		move.b	#-1,$3D(a0)
		bra.s	SYZBossDamageOnResuming
; ===========================================================================

SYZBossShake1:
		moveq	#1,d0
		tst.w	grabbedBlock(a0)
		beq.s	SYZBossStopShake1
		moveq	#2,d0

SYZBossStopShake1:
		cmpi.w	#$4DA,targetY(a0)
		beq.s	SYZBossShake2
		blt.s	SYZBossPositionAfterShake1
		neg.w	d0

SYZBossPositionAfterShake1:
		tst.w	grabbedBlock(a0)
		add.w	d0,targetY(a0)

SYZBossShake2:
		nop
		moveq	#0,d0
		tst.w	grabbedBlock(a0)
		beq.s	SYZBossPositionAfterShake2
		moveq	#2,d0
		btst	#0,$3D(a0)
		beq.s	SYZBossPositionAfterShake2
		neg.w	d0

SYZBossPositionAfterShake2:
		add.w	targetY(a0),d0
		move.w	d0,obY(a0)
		move.w	targetX(a0),8(a0)

SYZBossDamageOnResuming:
		bra.w	SYZDamageBoss

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj75_FindBlocks:
		clr.w	grabbedBlock(a0)
		lea	(v_objspace+$40).w,a1
		moveq	#$3E,d0
		moveq	#$76,d1
		move.b	comparisonX(a0),d2

Obj75_FindLoop:
		cmp.b	(a1),d1		; is object a SYZ boss block?
		bne.s	Obj75_NotABlock	; if not, branch
		cmp.b	obSubtype(a1),d2
		bne.s	Obj75_NotABlock
		move.w	a1,grabbedBlock(a0)
		bra.s	Obj75_FindLoop_rts
; ===========================================================================

Obj75_NotABlock:
		lea	$40(a1),a1	; next object RAM entry
		dbf	d0,Obj75_FindLoop

Obj75_FindLoop_rts:
		rts	
; End of function Obj75_FindBlocks

; ===========================================================================

SYZBossDefeated:
		subq.w	#1,$3C(a0)
		bmi.s	SYZBossSetDefeatStatus
		bra.w	BossDefeated
; ===========================================================================

SYZBossSetDefeatStatus:
		addq.b	#2,ob2ndRout(a0)
		clr.w	obVelY(a0)
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		move.w	#-1,$3C(a0)
		tst.b	(v_bossstatus).w
		bne.s	SYZBossDamageWhileDefeated
		move.b	#1,(v_bossstatus).w

SYZBossDamageWhileDefeated:
		bra.w	SYZDamageBoss
; ===========================================================================

SYZBossFlee:
		addq.w	#1,$3C(a0)
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
		cmpi.w	#$20,$3C(a0)
		bcs.s	SYZBossFleeSlowY
		beq.s	SYZBossFleePlayMusic
		cmpi.w	#$2A,$3C(a0)
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
		bpl.s	Obj75_ShipDelete

SYZBossFleeMove2:
		bsr.w	BossMove
		bra.w	SYZShipBobbing
; ===========================================================================

Obj75_ShipDelete:
		jmp	(DeleteObject).l
; ===========================================================================

Obj75_FaceMain:	; Routine 4
		moveq	#1,d1
		movea.l	comparisonX(a0),a1
		moveq	#0,d0
		move.b	ob2ndRout(a1),d0
		move.w	off_19546(pc,d0.w),d0
		jsr	off_19546(pc,d0.w)
		move.b	d1,obAnim(a0)
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.s	Obj75_FaceDelete
		bra.s	loc_195BE
; ===========================================================================

Obj75_FaceDelete:
		jmp	(DeleteObject).l
; ===========================================================================
off_19546:	dc.w loc_19574-off_19546, loc_19574-off_19546
		dc.w loc_1955A-off_19546, loc_19552-off_19546
		dc.w loc_19552-off_19546, loc_19556-off_19546
; ===========================================================================

loc_19552:
		moveq	#$A,d1
		rts	
; ===========================================================================

loc_19556:
		moveq	#6,d1
		rts	
; ===========================================================================

loc_1955A:
		moveq	#0,d0
		move.b	obSubtype(a1),d0
		move.w	off_19568(pc,d0.w),d0
		jmp	off_19568(pc,d0.w)
; ===========================================================================
off_19568:	dc.w loc_19570-off_19568, loc_19572-off_19568
		dc.w loc_19570-off_19568, loc_19570-off_19568
; ===========================================================================

loc_19570:
		bra.s	loc_19574
; ===========================================================================

loc_19572:
		moveq	#6,d1

loc_19574:
		tst.b	obColType(a1)
		bne.s	loc_1957E
		moveq	#5,d1
		rts	
; ===========================================================================

loc_1957E:
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	locret_19588
		moveq	#4,d1

locret_19588:
		rts	
; ===========================================================================

Obj75_FlameMain:; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	comparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	loc_195AA
		move.b	#$B,obAnim(a0)
		tst.b	1(a0)
		bpl.s	Obj75_FlameDelete
		bra.s	loc_195B6
; ===========================================================================

loc_195AA:
		tst.w	obVelX(a1)
		beq.s	loc_195B6
		move.b	#8,obAnim(a0)

loc_195B6:
		bra.s	loc_195BE
; ===========================================================================

Obj75_FlameDelete:
		jmp	(DeleteObject).l
; ===========================================================================

loc_195BE:
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		movea.l	comparisonX(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)

loc_195DA:
		move.b	obStatus(a1),obStatus(a0)
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

Obj75_SpikeMain:; Routine 8
		move.l	#Map_BossItems,obMap(a0)
		move.w	#$246C,obGfx(a0)
		move.b	#5,obFrame(a0)
		movea.l	comparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	loc_1961C
		tst.b	obRender(a0)
		bpl.s	Obj75_SpikeDelete

loc_1961C:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.w	$3C(a0),d0
		cmpi.b	#4,ob2ndRout(a1)
		bne.s	loc_19652
		cmpi.b	#6,obSubtype(a1)
		beq.s	loc_1964C
		tst.b	obSubtype(a1)
		bne.s	loc_19658
		cmpi.w	#$94,d0
		bge.s	loc_19658
		addq.w	#7,d0
		bra.s	loc_19658
; ===========================================================================

loc_1964C:
		tst.w	$3C(a1)
		bpl.s	loc_19658

loc_19652:
		tst.w	d0
		ble.s	loc_19658
		subq.w	#5,d0

loc_19658:
		move.w	d0,$3C(a0)
		asr.w	#2,d0
		add.w	d0,obY(a0)
		move.b	#8,obActWid(a0)
		move.b	#$C,obHeight(a0)
		clr.b	obColType(a0)
		movea.l	comparisonX(a0),a1
		tst.b	obColType(a1)
		beq.s	loc_19688
		tst.b	$29(a1)
		bne.s	loc_19688
		move.b	#$84,obColType(a0)

loc_19688:
		bra.w	loc_195DA
; ===========================================================================

Obj75_SpikeDelete:
		jmp	(DeleteObject).l
