	even
_ZN23ObjGHZBossEggmanMonitor7executeEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	cmp.b	#1, d0
	beq	@L2
	cmp.b	#3, d0
	beq	@L3
	tst.b	d0
	bne	@L1
	move.b	#4, 1(a2)
	move.l	#Map_Monitor, 4(a2)
	move.w	#1664, 2(a2)
	move.b	#70, 32(a2)
	move.b	#1, 28(a2)
	move.w	#1551, 24(a2)
	move.b	#1, 36(a2)
@L2:
	move.b	42(a2), d0
	bne	@L20
	tst.b	40(a2)
	bne	@L7
	move.w	16(a2), d0
	ble	@L8
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L8:
	add.w	#56, 18(a2)
@L7:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	add.w	#-15, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L9
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L6:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L13
@L21:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L3:
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L14
	move.b	#63, (a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L14:
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L15
	move.b	#46, (a0)
	move.l	8(a2), d1
	move.l	12(a2), d2
	move.l	d1, 8(a0)
	move.l	d2, 12(a0)
	move.b	28(a2), 28(a0)
@L15:
	clr.w	18(a2)
	move.b	#9, 28(a2)
	clr.b	32(a2)
	move.b	#1, 36(a2)
	move.b	#1, 41(a2)
	moveq	#14, d0
	move.b	d0, 42(a2)
@L22:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	blt	@L21
@L13:
	pea	Ani_Monitor
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L1:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L20:
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bra	@L22
@L9:
	add.w	d0, 12(a2)
	tst.b	41(a2)
	bne	@L11
	move.w	18(a2), d0
	cmp.w	#256, d0
	ble	@L11
	cmp.w	#2047, d0
	bgt	@L17
	move.w	d0, d1
	moveq	#15, d2
	lsr.w	d2, d1
	add.w	d1, d0
	asr.w	#1, d0
	neg.w	d0
	move.w	d0, d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	d0, 18(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L23:
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L6
@L11:
	clr.w	16(a2)
	clr.w	18(a2)
	move.b	#1, 40(a2)
	moveq	#0, d1
	moveq	#0, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L6
@L17:
	moveq	#4, d1
	swap	d1
	move.w	#1024, d0
	move.w	d0, 18(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	bra	@L23
	even
execute_ObjGHZBossEggmanMonitor:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	cmp.b	#1, d0
	beq	@L25
	cmp.b	#3, d0
	beq	@L26
	tst.b	d0
	bne	@L24
	move.b	#4, 1(a2)
	move.l	#Map_Monitor, 4(a2)
	move.w	#1664, 2(a2)
	move.b	#70, 32(a2)
	move.b	#1, 28(a2)
	move.w	#1551, 24(a2)
	move.b	#1, 36(a2)
@L25:
	move.b	42(a2), d0
	bne	@L43
	tst.b	40(a2)
	bne	@L30
	move.w	16(a2), d0
	ble	@L31
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L31:
	add.w	#56, 18(a2)
@L30:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	add.w	#-15, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L32
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L29:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L36
@L44:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L26:
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L37
	move.b	#63, (a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L37:
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L38
	move.b	#46, (a0)
	move.l	8(a2), d1
	move.l	12(a2), d2
	move.l	d1, 8(a0)
	move.l	d2, 12(a0)
	move.b	28(a2), 28(a0)
@L38:
	clr.w	18(a2)
	move.b	#9, 28(a2)
	clr.b	32(a2)
	move.b	#1, 36(a2)
	move.b	#1, 41(a2)
	moveq	#14, d0
	move.b	d0, 42(a2)
@L45:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	blt	@L44
@L36:
	pea	Ani_Monitor
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L24:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L43:
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bra	@L45
@L32:
	add.w	d0, 12(a2)
	tst.b	41(a2)
	bne	@L34
	move.w	18(a2), d0
	cmp.w	#256, d0
	ble	@L34
	cmp.w	#2047, d0
	bgt	@L40
	move.w	d0, d1
	moveq	#15, d2
	lsr.w	d2, d1
	add.w	d1, d0
	asr.w	#1, d0
	neg.w	d0
	move.w	d0, d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	d0, 18(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L46:
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L29
@L34:
	clr.w	16(a2)
	clr.w	18(a2)
	move.b	#1, 40(a2)
	moveq	#0, d1
	moveq	#0, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L29
@L40:
	moveq	#4, d1
	swap	d1
	move.w	#1024, d0
	move.w	d0, 18(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	bra	@L46
