ObjectsBossesFinalPlasmaBall_s__LC0:
	dc.b	"Updating position: ", $83, "", $e0, 0
	even
_ZN13ObjPlasmaBall7executeEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	cmp.b	#1, d0
	beq	@L2
	cmp.b	#2, d0
	beq	@L3
	tst.b	d0
	beq	@L16
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L16:
	move.b	#-124, 1(a2)
	move.w	#8960, 2(a2)
	move.l	#Map_Plasma, 4(a2)
	clr.b	28(a2)
	move.b	#3, 24(a2)
	move.b	41(a2), 36(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L3:
	move.w	50(a2), d1
	cmp.w	#255, d1
	ble	@L17
	move.w	52(a2), d0
	beq	@L11
	subq.w	#1, d0
	move.w	d0, 52(a2)
@L10:
	tst.b	1(a2)
	bge	@L13
@L7:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L2:
	move.l	8(a2), d1
	move.l	42(a2), a0
	move.l	8(a0), d0
	sub.l	d1, d0
	bmi	@L18
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L19
@L6:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L20
@L8:
	cmp.w	#2, d0
	bgt	@L7
@L13:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L20:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L7
	bra	@L13
@L19:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L8
	bra	@L20
@L18:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L6
	bra	@L19
@L17:
	move.w	46(a2), d2
	move.w	48(a2), d0
	sub.w	d2, d0
	muls.w	d1, d0
	lsl.l	#8, d0
	swap	d2
	clr.w	d2
	add.l	d2, d0
	move.l	d0, 12(a2)
	move.l	d0, -(sp)
	pea	ObjectsBossesFinalPlasmaBall_s__LC0
	jsr	kwrite_cdecl
	move.w	50(a2), d0
	addq.w	#4, d0
	move.w	d0, 50(a2)
	addq.l	#8, sp
	cmp.w	#255, d0
	ble	@L10
	move.w	#30, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	tst.b	1(a2)
	blt	@L7
	bra	@L13
@L11:
	move.w	16(a2), d0
	cmp.w	#-1023, d0
	blt	@L12
	add.w	#-12, d0
	move.w	d0, 16(a2)
@L12:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	tst.b	1(a2)
	blt	@L7
	bra	@L13
execute_ObjPlasmaBall:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	cmp.b	#1, d0
	beq	@L22
	cmp.b	#2, d0
	beq	@L23
	tst.b	d0
	beq	@L36
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L36:
	move.b	#-124, 1(a2)
	move.w	#8960, 2(a2)
	move.l	#Map_Plasma, 4(a2)
	clr.b	28(a2)
	move.b	#3, 24(a2)
	move.b	41(a2), 36(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L23:
	move.w	50(a2), d1
	cmp.w	#255, d1
	ble	@L37
	move.w	52(a2), d0
	beq	@L31
	subq.w	#1, d0
	move.w	d0, 52(a2)
@L30:
	tst.b	1(a2)
	bge	@L33
@L27:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L22:
	move.l	8(a2), d1
	move.l	42(a2), a0
	move.l	8(a0), d0
	sub.l	d1, d0
	bmi	@L38
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L39
@L26:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L40
@L28:
	cmp.w	#2, d0
	bgt	@L27
@L33:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L40:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L27
	bra	@L33
@L39:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L28
	bra	@L40
@L38:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L26
	bra	@L39
@L37:
	move.w	46(a2), d2
	move.w	48(a2), d0
	sub.w	d2, d0
	muls.w	d1, d0
	lsl.l	#8, d0
	swap	d2
	clr.w	d2
	add.l	d2, d0
	move.l	d0, 12(a2)
	move.l	d0, -(sp)
	pea	ObjectsBossesFinalPlasmaBall_s__LC0
	jsr	kwrite_cdecl
	move.w	50(a2), d0
	addq.w	#4, d0
	move.w	d0, 50(a2)
	addq.l	#8, sp
	cmp.w	#255, d0
	ble	@L30
	move.w	#30, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	tst.b	1(a2)
	blt	@L27
	bra	@L33
@L31:
	move.w	16(a2), d0
	cmp.w	#-1023, d0
	blt	@L32
	add.w	#-12, d0
	move.w	d0, 16(a2)
@L32:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	tst.b	1(a2)
	blt	@L27
	bra	@L33
create_ObjPlasmaBall:
	move.l	d2, -(sp)
	move.l	8(sp), d2
	pea	execute_ObjPlasmaBall
	move.l	d2, -(sp)
	jsr	createCppObject__cdecl
	addq.l	#8, sp
	tst.l	d0
	beq	@L41
	move.l	d0, a0
	move.l	d2, 42(a0)
	move.w	12(sp), 40(a0)
@L41:
	move.l	(sp)+, d2
	rts	
