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
	beq	@L19
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L19:
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
	move.w	50(a2), d0
	cmp.w	#255, d0
	bgt	@L9
	move.w	46(a2), d2
	move.w	48(a2), d1
	sub.w	d2, d1
	muls.w	d0, d1
	lsl.l	#8, d1
	swap	d2
	clr.w	d2
	add.l	d2, d1
	move.l	d1, 12(a2)
	addq.w	#4, d0
	move.w	d0, 50(a2)
	cmp.w	#255, d0
	ble	@L10
	move.w	52(a2), d0
	beq	@L20
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
@L10:
	tst.b	1(a2)
	bge	@L15
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
	bmi	@L21
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L22
@L6:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L23
@L8:
	cmp.w	#2, d0
	bgt	@L7
@L15:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L9:
	move.w	52(a2), d0
	beq	@L12
	subq.w	#1, d0
	move.w	d0, 52(a2)
	tst.b	1(a2)
	blt	@L7
	bra	@L15
@L23:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L7
	bra	@L15
@L22:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L8
	bra	@L23
@L21:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L6
	bra	@L22
@L12:
	move.w	16(a2), d0
	btst	#0, 34(a2)
	beq	@L13
	cmp.w	#1023, d0
	bgt	@L14
	add.w	#12, d0
	move.w	d0, 16(a2)
@L14:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L24:
	tst.b	1(a2)
	blt	@L7
	bra	@L15
@L13:
	cmp.w	#-1023, d0
	blt	@L14
	add.w	#-12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L24
@L20:
	moveq	#30, d0
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	bra	@L10
	even
execute_ObjPlasmaBall:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	cmp.b	#1, d0
	beq	@L26
	cmp.b	#2, d0
	beq	@L27
	tst.b	d0
	beq	@L43
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L43:
	move.b	#-124, 1(a2)
	move.w	#8960, 2(a2)
	move.l	#Map_Plasma, 4(a2)
	clr.b	28(a2)
	move.b	#3, 24(a2)
	move.b	41(a2), 36(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L27:
	move.w	50(a2), d0
	cmp.w	#255, d0
	bgt	@L33
	move.w	46(a2), d2
	move.w	48(a2), d1
	sub.w	d2, d1
	muls.w	d0, d1
	lsl.l	#8, d1
	swap	d2
	clr.w	d2
	add.l	d2, d1
	move.l	d1, 12(a2)
	addq.w	#4, d0
	move.w	d0, 50(a2)
	cmp.w	#255, d0
	ble	@L34
	move.w	52(a2), d0
	beq	@L44
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
@L34:
	tst.b	1(a2)
	bge	@L39
@L31:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L26:
	move.l	8(a2), d1
	move.l	42(a2), a0
	move.l	8(a0), d0
	sub.l	d1, d0
	bmi	@L45
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L46
@L30:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L47
@L32:
	cmp.w	#2, d0
	bgt	@L31
@L39:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L33:
	move.w	52(a2), d0
	beq	@L36
	subq.w	#1, d0
	move.w	d0, 52(a2)
	tst.b	1(a2)
	blt	@L31
	bra	@L39
@L47:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L31
	bra	@L39
@L46:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L32
	bra	@L47
@L45:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L30
	bra	@L46
@L36:
	move.w	16(a2), d0
	btst	#0, 34(a2)
	beq	@L37
	cmp.w	#1023, d0
	bgt	@L38
	add.w	#12, d0
	move.w	d0, 16(a2)
@L38:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L48:
	tst.b	1(a2)
	blt	@L31
	bra	@L39
@L37:
	cmp.w	#-1023, d0
	blt	@L38
	add.w	#-12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L48
@L44:
	moveq	#30, d0
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	bra	@L34
	even
create_ObjPlasmaBall:
	move.l	d2, -(sp)
	move.l	8(sp), d2
	pea	execute_ObjPlasmaBall
	move.l	d2, -(sp)
	jsr	createCppObject__cdecl
	addq.l	#8, sp
	tst.l	d0
	beq	@L49
	move.l	d0, a0
	move.l	d2, 42(a0)
	move.w	12(sp), 40(a0)
@L49:
	move.l	(sp)+, d2
	rts	
