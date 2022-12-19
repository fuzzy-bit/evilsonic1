; ---------------------------------------------------------------------------
; Object 75 - Eggman (SYZ)
; ---------------------------------------------------------------------------

BossSpringYard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	SYZBoss_Index(pc,d0.w),d1
		jmp	SYZBoss_Index(pc,d1.w)
; ===========================================================================
SYZBoss_Index:	dc.w SYZBoss_Main-SYZBoss_Index
		dc.w SYZBoss_ShipMain-SYZBoss_Index
		dc.w SYZBoss_FaceMain-SYZBoss_Index
		dc.w SYZBoss_FlameMain-SYZBoss_Index
		dc.w SYZBoss_SpikeMain-SYZBoss_Index

SYZBoss_TargetX:			equ $30
SYZBoss_TargetY:			equ $38
SYZBoss_Timer:			equ $3C
SYZBoss_PickUpFlag:		equ $3D

SYZBoss_ComparisonX:	equ $34
SYZBoss_GrabbedBlock:	equ $36

SYZBoss_ObjData:	dc.b 2,	0, 5		; routine number, animation, priority
		dc.b 4,	1, 5
		dc.b 6,	7, 5
		dc.b 8,	0, 5
; ===========================================================================

SYZBoss_Main:	; Routine 0
		move.w	#$2DB0,obX(a0)
		move.w	#$4DA,obY(a0)
		move.w	obX(a0),SYZBoss_TargetX(a0)
		move.w	obY(a0),SYZBoss_TargetY(a0)
		move.b	#$F,obColType(a0)
		move.b	#8,obColProp(a0) ; set number of hits to 8
		lea	SYZBoss_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	SYZBoss_LoadBoss
; ===========================================================================

SYZBoss_Loop:
		jsr	(FindNextFreeObj).l
		bne.s	SYZBoss_ShipMain
		move.b	#id_BossSpringYard,(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

SYZBoss_LoadBoss:
		bclr	#0,obStatus(a0)
		clr.b	ob2ndRout(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,obAnim(a1)
		move.b	(a2)+,obPriority(a1)
		move.l	#Map_Eggman,obMap(a1)
		move.w	#$400,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.l	a0,SYZBoss_ComparisonX(a1)
		dbf	d1,SYZBoss_Loop	; repeat sequence 3 more times

SYZBoss_ShipMain:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	SYZBoss_ShipIndex(pc,d0.w),d1
		jsr	SYZBoss_ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================
SYZBoss_ShipIndex:dc.w SYZBoss_Start-SYZBoss_ShipIndex,	SYZBoss_Roam-SYZBoss_ShipIndex
		dc.w SYZBoss_StartAttack-SYZBoss_ShipIndex,	SYZBoss_Defeated-SYZBoss_ShipIndex
		dc.w SYZBoss_Flee-SYZBoss_ShipIndex,	SYZBoss_Flee4-SYZBoss_ShipIndex
; ===========================================================================

SYZBoss_Start:
		move.w	#-$100,obVelX(a0)
		cmpi.w	#$2D38,SYZBoss_TargetX(a0)
		bcc.s	SYZBoss_ShipBobbing
		addq.b	#2,ob2ndRout(a0)

SYZBoss_ShipBobbing:
		move.b	$3F(a0),d0
		addq.b	#2,$3F(a0)
		jsr	(CalcSine).l
		asr.w	#2,d0
		move.w	d0,obVelY(a0)

SYZBoss_Move:
		bsr.w	BossMove
		move.w	SYZBoss_TargetY(a0),obY(a0)
		move.w	SYZBoss_TargetX(a0),obX(a0)

SYZBoss_Damage:
		move.w	obX(a0),d0
		subi.w	#$2C00,d0	; some offset stuff
		lsr.w	#5,d0
		move.b	d0,SYZBoss_ComparisonX(a0)		; before checking if we should damage the boss, we allow it to attack by setting the X comparison value
		
		cmpi.b	#6,ob2ndRout(a0)
		bcc.s	SYZBoss_Damage_rts
		
		tst.b	obStatus(a0)
		bmi.s	SYZBoss_PreventNoCollision
		
		tst.b	obColType(a0)
		bne.s	SYZBoss_Damage_rts
		
		tst.b	$3E(a0)
		bne.s	SYZBoss_HitFlash
		
		move.b	#$20,$3E(a0)
		sfx	sfx_BossHit	; play boss damage sound

SYZBoss_HitFlash:
		lea	(v_pal_dry+$22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	SYZBoss_UndoHitFlash
		move.w	#cWhite,d0

SYZBoss_UndoHitFlash:
		move.w	d0,(a1)
		subq.b	#1,$3E(a0)
		bne.s	SYZBoss_Damage_rts
		move.b	#$F,obColType(a0)

SYZBoss_Damage_rts:
		rts	
; ===========================================================================

SYZBoss_PreventNoCollision:
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,ob2ndRout(a0)
		move.w	#$B4,SYZBoss_Timer(a0)
		clr.w	obVelX(a0)
		rts	
; ===========================================================================

SYZBoss_Roam:
		move.w	SYZBoss_TargetX(a0),d0
		move.w	#$140,obVelX(a0)
		
		btst	#0,obStatus(a0)
		bne.s	SYZBoss_ChangeDirection
		
		neg.w	obVelX(a0)
		
		cmpi.w	#$2C08,d0
		bgt.s	SYZBoss_Stop
		bra.s	SYZBoss_ChangeDirection2

; ===========================================================================

SYZBoss_ChangeDirection:
		cmpi.w	#$2D38,d0
		blt.s	SYZBoss_Stop

SYZBoss_ChangeDirection2:
		bchg	#0,obStatus(a0)
		clr.b	SYZBoss_PickUpFlag(a0)

SYZBoss_Stop:
		subi.w	#$2C10,d0
		andi.w	#$1F,d0
		subi.w	#$1F,d0
		bpl.s	SYZBoss_PrepareAttack
		neg.w	d0

SYZBoss_PrepareAttack:
		subq.w	#1,d0
		bgt.s	SYZBoss_PrepareAttackBob
		
		move.w	(v_player+obX).w,d1
		subi.w	#$2C00,d1
		
		asr.w	#5,d1
		cmp.b	SYZBoss_ComparisonX(a0),d1
		bne.s	SYZBoss_PrepareAttackBob
		
		tst.w	SYZBoss_GrabbedBlock(a0)
		bne.w 	SYZBoss_BreakBlock
		
		tst.b	SYZBoss_PickUpFlag(a0)
		bne.s	SYZBoss_PrepareAttackBob
		
		moveq	#0,d0
		move.b	SYZBoss_ComparisonX(a0),d0
		
		asl.w	#5,d0
		addi.w	#$2C10,d0
		
		move.w	d0,SYZBoss_TargetX(a0)
		bsr.w	SYZBoss_FindBlocks
		
		addq.b	#2,ob2ndRout(a0)
		
		clr.w	obSubtype(a0)
		clr.w	obVelX(a0)

SYZBoss_PrepareAttackBob:
		bra.w	SYZBoss_ShipBobbing
; ===========================================================================

SYZBoss_StartAttack:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		move.w	SYZBoss_AttackIndex(pc,d0.w),d0
		jmp	SYZBoss_AttackIndex(pc,d0.w)
		
SYZBoss_BreakBlock:
		moveq	#-1,d0
		move.w	SYZBoss_GrabbedBlock(a0),d0
		beq.s	SYZBoss_RemoveBlock
		movea.l	d0,a1
		move.b	#$A,$29(a1)

SYZBoss_RemoveBlock:
		clr.w	SYZBoss_GrabbedBlock(a0)
		bra.w	SYZBoss_ShipBobbing
		
; ===========================================================================
SYZBoss_AttackIndex:	dc.w SYZBoss_Attack-SYZBoss_AttackIndex
		dc.w SYZBoss_PrepareLifting-SYZBoss_AttackIndex
		dc.w SYZBoss_StartGettingUp-SYZBoss_AttackIndex
		dc.w SYZBoss_Stabilize-SYZBoss_AttackIndex
; ===========================================================================

SYZBoss_Attack:
		move.w	#$180,obVelY(a0)
		move.w	SYZBoss_TargetY(a0),d0
		
		cmpi.w	#$556,d0
		bcs.s	SYZBoss_AttackMove
		move.w	#$556,SYZBoss_TargetY(a0)
		clr.w	SYZBoss_Timer(a0)
		moveq	#-1,d0
		move.w	SYZBoss_GrabbedBlock(a0),d0
		beq.s	SYZBoss_AttackBreak
		movea.l	d0,a1
		move.b	#-1,$29(a1)
		move.b	#-1,$29(a0)
		move.l	a0,SYZBoss_ComparisonX(a1)
		move.w	#$32,SYZBoss_Timer(a0)

SYZBoss_AttackBreak:
		clr.w	obVelY(a0)
		addq.b	#2,obSubtype(a0)

SYZBoss_AttackMove:
		bra.w	SYZBoss_Move
; ===========================================================================

SYZBoss_PrepareLifting:
		subq.w	#1,SYZBoss_Timer(a0)
		bpl.s	SYZBoss_CheckForUpdateGrabbing
		addq.b	#2,obSubtype(a0)
		move.w	#-$800,obVelY(a0)
		tst.w	SYZBoss_GrabbedBlock(a0)
		bne.s	SYZBoss_SomeShitIdk
		asr	obVelY(a0)

SYZBoss_SomeShitIdk:
		moveq	#0,d0
		bra.s	SYZBoss_UpdateHurtStateGrabbing
; ===========================================================================

SYZBoss_CheckForUpdateGrabbing:
		moveq	#0,d0
		cmpi.w	#$1E,SYZBoss_Timer(a0)
		bgt.s	SYZBoss_UpdateHurtStateGrabbing
		moveq	#2,d0
		btst	#1,SYZBoss_PickUpFlag(a0)
		beq.s	SYZBoss_UpdateHurtStateGrabbing
		neg.w	d0

SYZBoss_UpdateHurtStateGrabbing:
		add.w	SYZBoss_TargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	SYZBoss_TargetX(a0),obX(a0)
		bra.w	SYZBoss_Damage
; ===========================================================================

SYZBoss_StartGettingUp:
		move.w	#$4DA,d0
		tst.w	SYZBoss_GrabbedBlock(a0)
		beq.s	SYZBoss_StartGettingUp2
		subi.w	#$18,d0

SYZBoss_StartGettingUp2:
		cmp.w	SYZBoss_TargetY(a0),d0
		blt.s	SYZBoss_GetUp
		move.w	#8,SYZBoss_Timer(a0)
		tst.w	SYZBoss_GrabbedBlock(a0)
		beq.s	SYZBoss_StartGettingUp3
		move.w	#$2D,SYZBoss_Timer(a0)

SYZBoss_StartGettingUp3:
		addq.b	#2,obSubtype(a0)
		clr.w	obVelY(a0)
		bra.s	SYZBoss_GetUpMove
; ===========================================================================

SYZBoss_GetUp:
		cmpi.w	#-$40,obVelY(a0)
		bge.s	SYZBoss_GetUpMove
		addi.w	#$C,obVelY(a0)

SYZBoss_GetUpMove:
		bra.w	SYZBoss_Move
; ===========================================================================

SYZBoss_Stabilize:
		subq.w	#1,SYZBoss_Timer(a0)
		bgt.w	SYZBoss_Shake1
		bmi.w	SYZBoss_ResumeMovement

; ===========================================================================

SYZBoss_ResumeMovement:
		cmpi.w	#-$4,SYZBoss_Timer(a0)
		bne.s	SYZBoss_Shake1
		clr.b	$29(a0)
		subq.b	#2,ob2ndRout(a0)
		move.b	#-1,SYZBoss_PickUpFlag(a0)
		bra.s	SYZBoss_DamageOnResuming
; ===========================================================================

SYZBoss_Shake1:
		moveq	#1,d0
		tst.w	SYZBoss_GrabbedBlock(a0)
		beq.s	SYZBoss_StopShake1
		moveq	#2,d0

SYZBoss_StopShake1:
		cmpi.w	#$4DA,SYZBoss_TargetY(a0)
		beq.s	SYZBoss_Shake2
		blt.s	SYZBoss_PositionAfterShake1
		neg.w	d0

SYZBoss_PositionAfterShake1:
		tst.w	SYZBoss_GrabbedBlock(a0)
		add.w	d0,SYZBoss_TargetY(a0)

SYZBoss_Shake2:
		nop
		moveq	#0,d0
		tst.w	SYZBoss_GrabbedBlock(a0)
		beq.s	SYZBoss_PositionAfterShake2
		moveq	#2,d0
		btst	#0,SYZBoss_PickUpFlag(a0)
		beq.s	SYZBoss_PositionAfterShake2
		neg.w	d0

SYZBoss_PositionAfterShake2:
		add.w	SYZBoss_TargetY(a0),d0
		move.w	d0,obY(a0)
		move.w	SYZBoss_TargetX(a0),8(a0)

SYZBoss_DamageOnResuming:
		bra.w	SYZBoss_Damage

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SYZBoss_FindBlocks:
		clr.w	SYZBoss_GrabbedBlock(a0)
		lea	(v_objspace+$40).w,a1
		moveq	#$3E,d0
		moveq	#$76,d1
		move.b	SYZBoss_ComparisonX(a0),d2

SYZBoss_FindLoop:
		cmp.b	(a1),d1		; is object a SYZ boss block?
		bne.s	SYZBoss_NotABlock	; if not, branch
		cmp.b	obSubtype(a1),d2
		bne.s	SYZBoss_NotABlock
		move.w	a1,SYZBoss_GrabbedBlock(a0)
		bra.s	SYZBoss_FindLoop_rts
; ===========================================================================

SYZBoss_NotABlock:
		lea	$40(a1),a1	; next object RAM entry
		dbf	d0,SYZBoss_FindLoop

SYZBoss_FindLoop_rts:
		rts	
; End of function SYZBoss_FindBlocks

; ===========================================================================

SYZBoss_Defeated:
		subq.w	#1,SYZBoss_Timer(a0)
		bmi.s	SYZBoss_SetDefeatStatus
		bra.w	BossDefeated
; ===========================================================================

SYZBoss_SetDefeatStatus:
		addq.b	#2,ob2ndRout(a0)
		clr.w	obVelY(a0)
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		move.w	#-1,SYZBoss_Timer(a0)
		tst.b	(v_bossstatus).w
		bne.s	SYZBoss_DamageWhileDefeated
		move.b	#1,(v_bossstatus).w

SYZBoss_DamageWhileDefeated:
		bra.w	SYZBoss_Damage
; ===========================================================================

SYZBoss_Flee:
		addq.w	#1,SYZBoss_Timer(a0)
		beq.s	SYZBoss_Flee2
		bpl.s	SYZBoss_Flee3
		addi.w	#$18,obVelY(a0)
		bra.s	SYZBoss_FleeMove
; ===========================================================================

SYZBoss_Flee2:
		clr.w	obVelY(a0)
		bra.s	SYZBoss_FleeMove
; ===========================================================================

SYZBoss_Flee3:
		cmpi.w	#$20,SYZBoss_Timer(a0)
		bcs.s	SYZBoss_FleeSlowY
		beq.s	SYZBoss_FleePlayMusic
		cmpi.w	#$2A,SYZBoss_Timer(a0)
		bcs.s	SYZBoss_FleeMove
		addq.b	#2,ob2ndRout(a0)
		bra.s	SYZBoss_FleeMove
; ===========================================================================

SYZBoss_FleeSlowY:
		subq.w	#8,obVelY(a0)
		bra.s	SYZBoss_FleeMove
; ===========================================================================

SYZBoss_FleePlayMusic:
		clr.w	obVelY(a0)
		music	mus_SYZ		; play SYZ music

SYZBoss_FleeMove:
		bra.w	SYZBoss_Move
; ===========================================================================

SYZBoss_Flee4:
		move.w	#$400,obVelX(a0)
		move.w	#-$40,obVelY(a0)
		cmpi.w	#$2D40,(v_limitright2).w
		bcc.s	SYZBoss_FleeCheckRender
		addq.w	#2,(v_limitright2).w
		bra.s	SYZBoss_FleeMove2
; ===========================================================================

SYZBoss_FleeCheckRender:
		tst.b	obRender(a0)
		bpl.s	SYZBoss_ShipDelete

SYZBoss_FleeMove2:
		bsr.w	BossMove
		bra.w	SYZBoss_ShipBobbing
; ===========================================================================

SYZBoss_ShipDelete:
		jmp	(DeleteObject).l
; ===========================================================================

SYZBoss_FaceMain:	; Routine 4
		moveq	#1,d1
		movea.l	SYZBoss_ComparisonX(a0),a1
		moveq	#0,d0
		move.b	ob2ndRout(a1),d0
		move.w	SYZBoss_Face(pc,d0.w),d0
		jsr	SYZBoss_Face(pc,d0.w)
		move.b	d1,obAnim(a0)
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.s	SYZBoss_FaceDelete
		bra.s	SYZBoss_DisplayFace
; ===========================================================================

SYZBoss_FaceDelete:
		jmp	(DeleteObject).l
; ===========================================================================
SYZBoss_Face:	dc.w SYZBoss_FaceTestHurt-SYZBoss_Face, SYZBoss_FaceTestHurt-SYZBoss_Face
		dc.w SYZBoss_FaceUnknown3-SYZBoss_Face, SYZBoss_FaceDefeated-SYZBoss_Face
		dc.w SYZBoss_FaceDefeated-SYZBoss_Face, SYZBoss_FaceDefeated2-SYZBoss_Face
; ===========================================================================

SYZBoss_FaceDefeated:
		moveq	#$A,d1
		rts	
; ===========================================================================

SYZBoss_FaceDefeated2:
		moveq	#6,d1
		rts
; ===========================================================================

SYZBoss_FaceUnknown3:
		moveq	#0,d0
		move.b	obSubtype(a1),d0
		move.w	SYZBoss_Face2(pc,d0.w),d0
		jmp	SYZBoss_Face2(pc,d0.w)
; ===========================================================================
SYZBoss_Face2:	dc.w SYZBoss_FaceTestHurtShort-SYZBoss_Face2, SYZBoss_Face2Unknown-SYZBoss_Face2
		dc.w SYZBoss_FaceTestHurtShort-SYZBoss_Face2, SYZBoss_FaceTestHurtShort-SYZBoss_Face2
; ===========================================================================

SYZBoss_FaceTestHurtShort:
		bra.s	SYZBoss_FaceTestHurt
; ===========================================================================

SYZBoss_Face2Unknown:
		moveq	#6,d1

SYZBoss_FaceTestHurt:
		tst.b	obColType(a1)		; is eggman being hurt?
		bne.s	SYZBoss_FaceTestLaugh	; if not, branch
		moveq	#5,d1
		rts	
; ===========================================================================

SYZBoss_FaceTestLaugh:
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	SYZBoss_FaceTestLaugh_rts
		moveq	#4,d1

SYZBoss_FaceTestLaugh_rts:
		rts	
; ===========================================================================

SYZBoss_FlameMain:; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	SYZBoss_ComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	SYZBoss_FaceFleeing
		move.b	#$B,obAnim(a0)
		tst.b	1(a0)
		bpl.s	SYZBoss_FlameDelete
		bra.s	SYZBoss_DisplayFaceShort
; ===========================================================================

SYZBoss_FaceFleeing:
		tst.w	obVelX(a1)
		beq.s	SYZBoss_DisplayFaceShort
		move.b	#8,obAnim(a0)

SYZBoss_DisplayFaceShort:
		bra.s	SYZBoss_DisplayFace
; ===========================================================================

SYZBoss_FlameDelete:
		jmp	(DeleteObject).l
; ===========================================================================

SYZBoss_DisplayFace:
		lea	(Ani_Eggman).l,a1
		jsr	(AnimateSprite).l
		movea.l	SYZBoss_ComparisonX(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)

SYZBoss_DisplayFace2:
		move.b	obStatus(a1),obStatus(a0)
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

SYZBoss_SpikeMain:; Routine 8
		move.l	#Map_BossItems,obMap(a0)
		move.w	#$246C,obGfx(a0)
		move.b	#5,obFrame(a0)
		movea.l	SYZBoss_ComparisonX(a0),a1
		cmpi.b	#$A,ob2ndRout(a1)
		bne.s	SYZBoss_SpikeOut
		tst.b	obRender(a0)
		bpl.s	SYZBoss_SpikeDelete

SYZBoss_SpikeOut:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.w	SYZBoss_Timer(a0),d0
		cmpi.b	#4,ob2ndRout(a1)
		bne.s	SYZBoss_SpikeTimerCheck2
		cmpi.b	#6,obSubtype(a1)
		beq.s	SYZBoss_SpikeTimerCheck
		tst.b	obSubtype(a1)
		bne.s	SYZBoss_SpikeIn
		cmpi.w	#$94,d0
		bge.s	SYZBoss_SpikeIn
		addq.w	#7,d0
		bra.s	SYZBoss_SpikeIn
; ===========================================================================

SYZBoss_SpikeTimerCheck:
		tst.w	SYZBoss_Timer(a1)
		bpl.s	SYZBoss_SpikeIn

SYZBoss_SpikeTimerCheck2:
		tst.w	d0
		ble.s	SYZBoss_SpikeIn
		subq.w	#5,d0

SYZBoss_SpikeIn:
		move.w	d0,SYZBoss_Timer(a0)
		asr.w	#2,d0
		add.w	d0,obY(a0)
		move.b	#8,obActWid(a0)
		move.b	#$C,obHeight(a0)
		clr.b	obColType(a0)
		movea.l	SYZBoss_ComparisonX(a0),a1
		tst.b	obColType(a1)
		beq.s	SYZBoss_DisplayFaceShort2
		tst.b	$29(a1)
		bne.s	SYZBoss_DisplayFaceShort2
		move.b	#$84,obColType(a0)

SYZBoss_DisplayFaceShort2:
		bra.w	SYZBoss_DisplayFace2
; ===========================================================================

SYZBoss_SpikeDelete:
		jmp	(DeleteObject).l
