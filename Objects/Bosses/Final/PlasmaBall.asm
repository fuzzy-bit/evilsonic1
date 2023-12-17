	even
_ZN13ObjPlasmaBall7executeEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	cmp.b	#4, 36(a2)
	bhi	@L1
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L4(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L4:
	dc.w	@L8-@L4
	dc.w	@L7-@L4
	dc.w	@L6-@L4
	dc.w	@L5-@L4
	dc.w	@L3-@L4
@L8:
	move.b	#-124, 1(a2)
	move.w	#8960, 2(a2)
	move.l	#Map_Plasma, 4(a2)
	clr.b	28(a2)
	move.b	#3, 24(a2)
	move.b	41(a2), 36(a2)
@L1:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L5:
	move.w	16(a2), d0
@L22:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L14:
	tst.b	1(a2)
	bge	@L21
@L11:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L3:
	move.w	18(a2), d0
	beq	@L19
	ext.l	d0
	lsl.l	#8, d0
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	add.l	12(a2), d0
	move.l	d0, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	-2300.w, d0
	cmp.w	#248, d0
	ble	@L11
@L21:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L7:
	move.l	8(a2), d1
	move.l	42(a2), a0
	move.l	8(a0), d0
	sub.l	d1, d0
	bmi	@L26
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L27
@L10:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L28
@L12:
	cmp.w	#2, d0
	ble	@L21
@L25:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L6:
	move.w	50(a2), d0
	cmp.w	#255, d0
	bgt	@L13
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
	ble	@L14
	move.w	52(a2), d0
	bne	@L15
	moveq	#30, d0
@L15:
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	tst.b	1(a2)
	blt	@L11
	bra	@L21
@L26:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L10
@L27:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L12
@L28:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L25
	bra	@L21
@L19:
	move.w	#384, 18(a2)
	move.b	#1, 28(a2)
	move.b	#-102, 32(a2)
	move.l	#98304, d0
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	add.l	12(a2), d0
	move.l	d0, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	-2300.w, d0
	cmp.w	#248, d0
	ble	@L11
	bra	@L21
@L13:
	move.w	52(a2), d0
	bne	@L29
	move.w	16(a2), d0
	btst	#0, 34(a2)
	beq	@L17
	cmp.w	#1023, d0
	bgt	@L22
	add.w	#12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L14
@L29:
	subq.w	#1, d0
	move.w	d0, 52(a2)
	tst.b	1(a2)
	blt	@L11
	bra	@L21
@L17:
	cmp.w	#-1023, d0
	blt	@L22
	add.w	#-12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L14
	even
execute_ObjPlasmaBall:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	cmp.b	#4, 36(a2)
	bhi	@L30
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L33(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L33:
	dc.w	@L37-@L33
	dc.w	@L36-@L33
	dc.w	@L35-@L33
	dc.w	@L34-@L33
	dc.w	@L32-@L33
@L37:
	move.b	#-124, 1(a2)
	move.w	#8960, 2(a2)
	move.l	#Map_Plasma, 4(a2)
	clr.b	28(a2)
	move.b	#3, 24(a2)
	move.b	41(a2), 36(a2)
@L30:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L34:
	move.w	16(a2), d0
@L51:
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L43:
	tst.b	1(a2)
	bge	@L50
@L40:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L32:
	move.w	18(a2), d0
	beq	@L48
	ext.l	d0
	lsl.l	#8, d0
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	add.l	12(a2), d0
	move.l	d0, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	-2300.w, d0
	cmp.w	#248, d0
	ble	@L40
@L50:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L36:
	move.l	8(a2), d1
	move.l	42(a2), a0
	move.l	8(a0), d0
	sub.l	d1, d0
	bmi	@L55
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bmi	@L56
@L39:
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bmi	@L57
@L41:
	cmp.w	#2, d0
	ble	@L50
@L54:
	pea	Ani_Plasma
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L35:
	move.w	50(a2), d0
	cmp.w	#255, d0
	bgt	@L42
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
	ble	@L43
	move.w	52(a2), d0
	bne	@L44
	moveq	#30, d0
@L44:
	move.w	d0, 52(a2)
	move.b	#-102, 32(a2)
	move.b	#1, 28(a2)
	move.w	#256, 50(a2)
	tst.b	1(a2)
	blt	@L40
	bra	@L50
@L55:
	moveq	#15, d2
	add.l	d2, d0
	asr.l	#4, d0
	add.l	d1, d0
	move.l	d0, 8(a2)
	move.l	12(a2), a1
	move.l	12(a0), d1
	sub.l	a1, d1
	bpl	@L39
@L56:
	moveq	#15, d2
	add.l	d2, d1
	asr.l	#4, d1
	add.l	a1, d1
	move.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	8(a0), d0
	bpl	@L41
@L57:
	neg.w	d0
	cmp.w	#2, d0
	bgt	@L54
	bra	@L50
@L48:
	move.w	#384, 18(a2)
	move.b	#1, 28(a2)
	move.b	#-102, 32(a2)
	move.l	#98304, d0
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	add.l	12(a2), d0
	move.l	d0, 12(a2)
	swap	d0
	ext.l	d0
	sub.w	-2300.w, d0
	cmp.w	#248, d0
	ble	@L40
	bra	@L50
@L42:
	move.w	52(a2), d0
	bne	@L58
	move.w	16(a2), d0
	btst	#0, 34(a2)
	beq	@L46
	cmp.w	#1023, d0
	bgt	@L51
	add.w	#12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L43
@L58:
	subq.w	#1, d0
	move.w	d0, 52(a2)
	tst.b	1(a2)
	blt	@L40
	bra	@L50
@L46:
	cmp.w	#-1023, d0
	blt	@L51
	add.w	#-12, d0
	move.w	d0, 16(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L43
	even
create_ObjPlasmaBall:
	move.l	d2, -(sp)
	move.l	8(sp), d2
	pea	execute_ObjPlasmaBall
	move.l	d2, -(sp)
	jsr	createCppObject__cdecl
	addq.l	#8, sp
	tst.l	d0
	beq	@L59
	move.l	d0, a0
	move.l	d2, 42(a0)
	move.w	12(sp), 40(a0)
@L59:
	move.l	(sp)+, d2
	rts	
