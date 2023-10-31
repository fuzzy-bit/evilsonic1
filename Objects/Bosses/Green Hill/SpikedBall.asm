	even
_ZN20ObjGHZBossSpikedBall7executeEv:
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
	move.w	#1304, 2(a2)
	move.l	#Map_SSawBall_internal, 4(a2)
	move.b	#6, 24(a2)
	move.b	#-104, 32(a2)
	move.b	#1, 36(a2)
@L3:
	add.w	#40, 18(a2)
	move.w	16(a2), d0
	cmp.w	#-127, d0
	blt	@L5
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L5:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	subq.w	#8, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L13
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L8
@L14:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L8:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L13:
	add.w	d0, 12(a2)
	move.w	18(a2), d0
	neg.w	d0
	add.w	d0, d0
	move.w	#-1024, d1
	cmp.w	#-3071, d0
	blt	@L7
	move.w	d0, d1
	muls.w	#21846, d1
	clr.w	d1
	swap	d1
	moveq	#15, d2
	asr.w	d2, d0
	sub.w	d0, d1
@L7:
	move.w	d1, 18(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L8
	bra	@L14
	even
execute_ObjGHZBossSpikedBall:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	beq	@L16
	cmp.b	#1, d0
	beq	@L17
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L16:
	move.b	#4, 1(a2)
	move.w	#1304, 2(a2)
	move.l	#Map_SSawBall_internal, 4(a2)
	move.b	#6, 24(a2)
	move.b	#-104, 32(a2)
	move.b	#1, 36(a2)
@L17:
	add.w	#40, 18(a2)
	move.w	16(a2), d0
	cmp.w	#-127, d0
	blt	@L19
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L19:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	subq.w	#8, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L27
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L22
@L28:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L22:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L27:
	add.w	d0, 12(a2)
	move.w	18(a2), d0
	neg.w	d0
	add.w	d0, d0
	move.w	#-1024, d1
	cmp.w	#-3071, d0
	blt	@L21
	move.w	d0, d1
	muls.w	#21846, d1
	clr.w	d1
	swap	d1
	moveq	#15, d2
	asr.w	d2, d0
	sub.w	d0, d1
@L21:
	move.w	d1, 18(a2)
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L22
	bra	@L28
