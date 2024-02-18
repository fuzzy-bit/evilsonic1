; ---------------------------------------------------------------------------
; Object 85 - Eggman (FZ)
; ---------------------------------------------------------------------------

BossFinal:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	BFinal_Index(pc,d0.w),d1
		jmp		BFinal_Index(pc,d1.w)

; ===========================================================================
BFinal_Index:
		dc.w 	BFinal_Main-BFinal_Index
		dc.w 	BFinal_ShipMain-BFinal_Index
		dc.w 	BFinal_FaceMain-BFinal_Index
		dc.w 	BFinal_FlameMain-BFinal_Index

BFinal_ObjData:
		dc.b 	2,	0					; routine counter, animation
		dc.b 	4,	1
		dc.b 	6,	7
; ===========================================================================

BFinal_Main:	; Routine 0
		lea		BFinal_ObjData(pc), a2
		movea.l	a0, a1
		moveq	#3-1,d1					; number of object - 1
		bra.s	@InitBossSubobject

	; ---------------------------------------------------------------------------
	@CreateBossSubobject:
			jsr		FindNextFreeObj
			bne.s	@InitBossDone

	@InitBossSubobject:
			move.b	(a2)+, obRoutine(a1)
			move.b	#id_BossFinal, (a1)
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
BFinal_ShipMain:	; Routine 2
		move.w	a0, -(sp)					; backup A0, because it's a scratch register in C/C++ ABI
		move.l	a0, -(sp)					; push first argument for C++ function call
		jsr		executeMasterScript_ObjEggmanShipFZ	; execute C++ call
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
BFinal_FaceMain:	; Routine 4
		moveq	#0,d0
		moveq	#1,d1
		movea.l	$34(a0),a1
		cmp.b	#2, $28(a1)		; is script defated?
		blo.s	loc2_17A46		; if not, branch
		cmp.b	#2, $29(a1)		; is subscript run away?
		beq.s	@PanicFace
		moveq	#$A,d1			; defeated face
		bra.s	loc2_17A5A

@PanicFace:
		moveq	#6,d1			; panicing face
		bra.s	loc2_17A5A

; ===========================================================================

loc2_17A46:
		tst.b	obColType(a1)
		bne.s	loc2_17A50
		moveq	#5,d1			; hurt face
		bra.s	loc2_17A5A
; ===========================================================================

loc2_17A50:
		tst.b	$2C(a1)
		bne.s	@ForceLaugh
		cmpi.b	#4,(v_player+obRoutine).w
		bcs.s	loc2_17A5A
	@ForceLaugh:
		moveq	#4,d1			; laughing face

loc2_17A5A:
		move.b	d1,obAnim(a0)
		subq.b	#2,d0
		bne.s	BFinal_FaceDisp
		move.b	#6,obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	BFinal_FaceDel

BFinal_FaceDisp:
		bra.s	BFinal_Display
; ===========================================================================

BFinal_FaceDel:
		jmp	(DeleteObject).l
; ===========================================================================

BFinal_FlameMain:	; Routine 6
		move.b	#7,obAnim(a0)
		movea.l	$34(a0),a1
		cmpi.b	#$C,ob2ndRout(a1)
		bne.s	loc2_17A96
		move.b	#$B,obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	BFinal_FlameDel
		bra.s	BFinal_FlameDisp
; ===========================================================================

loc2_17A96:
		move.w	obVelX(a1),d0
		beq.s	BFinal_FlameDisp
		move.b	#8,obAnim(a0)

BFinal_FlameDisp:
		bra.s	BFinal_Display
; ===========================================================================

BFinal_FlameDel:
		jmp	(DeleteObject).l
; ===========================================================================

BFinal_Display:
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