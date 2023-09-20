_ZN23ObjGHZBossEggmanMonitor7executeEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	beq	@L2
	cmp.b	#1, d0
	beq	@L3
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L2:
	move.b	#4, 1(a2)
	move.l	#Map_Monitor, 4(a2)
	move.w	#1664, 2(a2)
	move.b	#1, 28(a2)
	move.w	#1551, 24(a2)
	move.b	#1, 36(a2)
@L3:
	move.w	16(a2), d0
	ble	@L5
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L5:
	tst.b	40(a2)
	bne	@L6
	add.w	#56, 18(a2)
@L6:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	add.w	#-15, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L15
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L10
@L16:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L10:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	pea	Ani_Monitor
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L15:
	add.w	d0, 12(a2)
	move.w	18(a2), d0
	cmp.w	#256, d0
	ble	@L8
	move.w	#1024, d1
	cmp.w	#2047, d0
	bgt	@L9
	move.w	d0, d1
	moveq	#15, d2
	lsr.w	d2, d1
	add.w	d0, d1
	asr.w	#1, d1
	neg.w	d1
@L9:
	move.w	d1, 18(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L10
	bra	@L16
@L8:
	clr.w	18(a2)
	move.b	#1, 40(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L10
	bra	@L16
execute_ObjGHZBossEggmanMonitor:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	beq	@L18
	cmp.b	#1, d0
	beq	@L19
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L18:
	move.b	#4, 1(a2)
	move.l	#Map_Monitor, 4(a2)
	move.w	#1664, 2(a2)
	move.b	#1, 28(a2)
	move.w	#1551, 24(a2)
	move.b	#1, 36(a2)
@L19:
	move.w	16(a2), d0
	ble	@L21
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L21:
	tst.b	40(a2)
	bne	@L22
	add.w	#56, 18(a2)
@L22:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	add.w	#-15, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L31
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L26
@L32:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L26:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	pea	Ani_Monitor
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L31:
	add.w	d0, 12(a2)
	move.w	18(a2), d0
	cmp.w	#256, d0
	ble	@L24
	move.w	#1024, d1
	cmp.w	#2047, d0
	bgt	@L25
	move.w	d0, d1
	moveq	#15, d2
	lsr.w	d2, d1
	add.w	d0, d1
	asr.w	#1, d1
	neg.w	d1
@L25:
	move.w	d1, 18(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L26
	bra	@L32
@L24:
	clr.w	18(a2)
	move.b	#1, 40(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-24, d0
	bge	@L26
	bra	@L32
