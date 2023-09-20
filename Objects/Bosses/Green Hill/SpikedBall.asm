_ZN6__pstl9execution2v1L3seqE:
_ZN6__pstl9execution2v1L3parE:
_ZN6__pstl9execution2v1L9par_unseqE:
_ZN6__pstl9execution2v1L5unseqE:
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
	cmp.w	#-3074, d0
	blt	@L9
	move.w	d0, d1
	muls.w	#21846, d1
	clr.w	d1
	swap	d1
	moveq	#15, d2
	asr.w	d2, d0
	sub.w	d0, d1
	move.w	d1, 18(a2)
@L15:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L8
	bra	@L14
@L9:
	move.w	#-1024, d1
	move.w	d1, 18(a2)
	bra	@L15
execute_ObjGHZBossSpikedBall:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	36(a2), d0
	beq	@L17
	cmp.b	#1, d0
	beq	@L18
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L17:
	move.b	#4, 1(a2)
	move.w	#1304, 2(a2)
	move.l	#Map_SSawBall_internal, 4(a2)
	move.b	#6, 24(a2)
	move.b	#1, 36(a2)
@L18:
	add.w	#40, 18(a2)
	move.w	16(a2), d0
	cmp.w	#-127, d0
	blt	@L20
	subq.w	#8, d0
	move.w	d0, 16(a2)
@L20:
	move.l	a2, -(sp)
	jsr	objFloorDist__cdecl
	subq.w	#8, d0
	addq.l	#4, sp
	tst.w	d0
	ble	@L28
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L23
@L29:
	move.l	a2, 12(sp)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L23:
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
@L28:
	add.w	d0, 12(a2)
	move.w	18(a2), d0
	neg.w	d0
	add.w	d0, d0
	cmp.w	#-3074, d0
	blt	@L24
	move.w	d0, d1
	muls.w	#21846, d1
	clr.w	d1
	swap	d1
	moveq	#15, d2
	asr.w	d2, d0
	sub.w	d0, d1
	move.w	d1, 18(a2)
@L30:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#-8, d0
	bge	@L23
	bra	@L29
@L24:
	move.w	#-1024, d1
	move.w	d1, 18(a2)
	bra	@L30
