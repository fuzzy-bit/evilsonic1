
; ---------------------------------------------------------------------------
; Green Hill boss
; ---------------------------------------------------------------------------

BossGreenHill:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	BGHZ_Index(pc,d0.w),d1
		jmp		BGHZ_Index(pc,d1.w)

; ===========================================================================
BGHZ_Index:
		dc.w 	BGHZ_Main-BGHZ_Index
		dc.w 	BGHZ_ShipMain-BGHZ_Index
		dc.w 	BGHZ_FaceMain-BGHZ_Index
		dc.w 	BGHZ_FlameMain-BGHZ_Index

BGHZ_ObjData:
		dc.b 	2,	0					; routine counter, animation
		dc.b 	4,	1
		dc.b 	6,	7
; ===========================================================================

BGHZ_Main:	; Routine 0
		lea		BGHZ_ObjData(pc), a2
		movea.l	a0, a1
		moveq	#3-1,d1					; number of object - 1
		bra.s	@InitBossSubobject

	; ---------------------------------------------------------------------------
	@CreateBossSubobject:
			jsr		FindNextFreeObj
			bne.s	@InitBossDone

	@InitBossSubobject:
			move.b	(a2)+, obRoutine(a1)
			move.b	#id_BossGreenHill, (a1)
			move.w	obX(a0), obX(a1)
			move.w	obY(a0), obY(a1)
			move.l	#Map_Eggman, obMap(a1)
			move.w	#$400, obGfx(a1)
			move.b	#4, obRender(a1)
			move.b	#$20, obActWid(a1)
			move.b	#3, obPriority(a1)
			move.b	(a2)+, obAnim(a1)
			move.l	a0, $34(a1)			; link the parent
			dbf		d1, @CreateBossSubobject	; repeat sequence 2 more times

@InitBossDone:
		move.w	obX(a0),$30(a0)
		move.w	obY(a0),$38(a0)
		move.b	#$F,obColType(a0)
		move.b	#8,obColProp(a0) ; set number of hits to 8
		;fallthrough

; ===========================================================================
BGHZ_ShipMain:	; Routine 2
		move.w	a0, -(sp)					; backup A0, because it's a scratch register in C/C++ ABI
		move.l	a0, -(sp)					; push first argument for C++ function call
		jsr		executeMasterScript_ObjEggmanShip	; execute C++ call
		addq.w	#4, sp						; deallocate stack reserved for C++ function arguments
		move.w	(sp)+, a0					; restore A0

		lea		(Ani_Eggman).l,a1
		jsr		AnimateSprite
		move.b	obStatus(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp		(DisplaySprite).l

; ===========================================================================
BGHZ_FaceMain:	; Routine 4
		moveq	#0,d0
		moveq	#1,d1
		movea.l	$34(a0),a1
		move.b	ob2ndRout(a1),d0
		subq.b	#4,d0
		bne.s	loc_17A3E
		cmpi.w	#$2A00,$30(a1)
		bne.s	loc_17A46
		moveq	#4,d1

loc_17A3E:
		subq.b	#6,d0
		bmi.s	loc_17A46
		moveq	#$A,d1
		bra.s	loc_17A5A
; ===========================================================================

loc_17A46:
		tst.b	obColType(a1)
		bne.s	loc_17A50
		moveq	#5,d1
		bra.s	loc_17A5A
; ===========================================================================

loc_17A50:
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	loc_17A5A
		moveq	#4,d1

loc_17A5A:
		move.b	d1,obAnim(a0)
		subq.b	#2,d0
		bne.s	BGHZ_FaceDisp
		move.b	#6,obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	BGHZ_FaceDel

BGHZ_FaceDisp:
		bra.s	BGHZ_Display
; ===========================================================================

BGHZ_FaceDel:
		jmp	(DeleteObject).l
; ===========================================================================

BGHZ_FlameMain:	; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	$34(a0),a1
		cmpi.b	#$C,ob2ndRout(a1)
		bne.s	loc_17A96
		move.b	#$B,obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	BGHZ_FlameDel
		bra.s	BGHZ_FlameDisp
; ===========================================================================

loc_17A96:
		move.w	obVelX(a1),d0
		beq.s	BGHZ_FlameDisp
		move.b	#8,obAnim(a0)

BGHZ_FlameDisp:
		bra.s	BGHZ_Display
; ===========================================================================

BGHZ_FlameDel:
		jmp	(DeleteObject).l
; ===========================================================================

BGHZ_Display:
		movea.l	$34(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		lea		(Ani_Eggman).l,a1
		jsr		(AnimateSprite).l
		move.b	obStatus(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp		(DisplaySprite).l

; ===========================================================================
; ---------------------------------------------------------------------------
; A convenience call to create spiked ball object
; ---------------------------------------------------------------------------

BGHZ_CreateSpikedBall__cdecl:
		move.l	4(sp), a0
		jsr		FindNextFreeObj			; a1 = object
		bne.s	@NullPtr
		move.b	#id_ObjDynamic, (a1)
		move.l	#@ObjectLauncher, obCodePtr(a1)
		move.l	a1, d0
		rts

@NullPtr:
		moveq	#0, d0
		rts

; ===========================================================================
@ObjectLauncher:
		move.l	a0, -(sp)
		move.l	a0, -(sp)
		jsr		execute_ObjGHZBossSpikedBall
		addq.w	#4, sp
		move.l	(sp)+, a0
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; A convenience call to create eggman monitor object
; ---------------------------------------------------------------------------

BGHZ_CreateEggmanMonitor__cdecl:
		move.l	4(sp), a0
		jsr		FindNextFreeObj			; a1 = object
		bne.s	@NullPtr
		move.b	#id_ObjDynamic, (a1)
		move.l	#@ObjectLauncher, obCodePtr(a1)
		move.l	a1, d0
		rts

@NullPtr:
		moveq	#0, d0
		rts

; ===========================================================================
@ObjectLauncher:
		move.l	a0, -(sp)
		move.l	a0, -(sp)
		jsr		execute_ObjGHZBossEggmanMonitor
		addq.w	#4, sp
		move.l	(sp)+, a0
		rts
