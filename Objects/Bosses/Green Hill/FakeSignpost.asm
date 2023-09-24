_ZN15ObjFakeSignpost11sparkleDataE:
	dc.b	$e8, $f0, $8, $8, $f0, 0
	dc.b	$18, $f8, 0
	dc.b	$f8, $10, 0
	dc.b	$e8, $8, $18, $10
	even
_ZN15ObjFakeSignpost7executeEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
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
	move.b	#4, 1(a2)
	move.w	#1664, 2(a2)
	move.l	#Map_Sign, 4(a2)
	move.w	#1048, 24(a2)
	move.b	#3, 28(a2)
	move.b	#1, 36(a2)
@L7:
	move.w	v_player+8, d0
	sub.w	8(a2), d0
	cmp.w	#31, d0
	bgt	@L17
@L10:
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L6:
	move.w	40(a2), d0
	move.w	d0, d1
	subq.w	#1, d1
	move.w	d1, 40(a2)
	tst.w	d0
	bne	@L11
	move.b	28(a2), d0
	subq.b	#1, d0
	move.b	d0, 28(a2)
	move.w	#60, 40(a2)
	tst.b	d0
	beq	@L12
@L11:
	move.w	42(a2), d0
	beq	@L13
	subq.w	#1, d0
	move.w	d0, 42(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L5:
	move.w	40(a2), d0
	move.w	d0, a0
	subq.w	#1, a0
	move.w	a0, 40(a2)
	tst.w	d0
	bne	@L10
	jsr	findFreeObj__cdecl
	tst.l	d0
	beq	@L14
	move.l	d0, a0
	move.b	#61, (a0)
@L14:
	addq.b	#1, 36(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L3:
	tst.b	1(a2)
	blt	@L10
	move.w	#1, -(sp)
	jsr	addPLC__cdecl
	addq.l	#2, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L17:
	move.w	#224, -(sp)
	jsr	playSound__cdecl
	move.w	v_limitright2, v_limitleft2
	clr.b	f_timecount
	addq.b	#1, 36(a2)
	addq.l	#2, sp
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L1:
	move.l	(sp)+, a2
	rts	
@L13:
	move.w	#11, 42(a2)
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L10
	move.w	#9476, (a0)
	move.w	#10162, 2(a0)
	move.l	#Map_Ring, 4(a0)
	move.b	#2, 24(a0)
	move.b	#6, 36(a0)
	move.w	44(a2), d0
	lea	_ZN15ObjFakeSignpost11sparkleDataE, a1
	moveq	#0, d1
	move.w	d0, d1
	move.b	(a1, d1.l), d1
	ext.w	d1
	add.w	8(a2), d1
	move.w	d1, 8(a0)
	move.w	d0, d1
	addq.w	#1, d1
	and.l	#65535, d1
	move.b	(a1, d1.l), d1
	ext.w	d1
	add.w	12(a2), d1
	move.w	d1, 12(a0)
	addq.w	#2, d0
	and.w	#14, d0
	move.w	d0, 44(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L12:
	move.b	#3, 36(a2)
	bra	@L11
	even
execute_ObjFakeSignpost:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	cmp.b	#4, 36(a2)
	bhi	@L18
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L21(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L21:
	dc.w	@L25-@L21
	dc.w	@L24-@L21
	dc.w	@L23-@L21
	dc.w	@L22-@L21
	dc.w	@L20-@L21
@L25:
	move.b	#4, 1(a2)
	move.w	#1664, 2(a2)
	move.l	#Map_Sign, 4(a2)
	move.w	#1048, 24(a2)
	move.b	#3, 28(a2)
	move.b	#1, 36(a2)
@L24:
	move.w	v_player+8, d0
	sub.w	8(a2), d0
	cmp.w	#31, d0
	bgt	@L34
@L27:
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L23:
	move.w	40(a2), d0
	move.w	d0, d1
	subq.w	#1, d1
	move.w	d1, 40(a2)
	tst.w	d0
	bne	@L28
	move.b	28(a2), d0
	subq.b	#1, d0
	move.b	d0, 28(a2)
	move.w	#60, 40(a2)
	tst.b	d0
	beq	@L29
@L28:
	move.w	42(a2), d0
	beq	@L30
	subq.w	#1, d0
	move.w	d0, 42(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L22:
	move.w	40(a2), d0
	move.w	d0, a0
	subq.w	#1, a0
	move.w	a0, 40(a2)
	tst.w	d0
	bne	@L27
	jsr	findFreeObj__cdecl
	tst.l	d0
	beq	@L31
	move.l	d0, a0
	move.b	#61, (a0)
@L31:
	addq.b	#1, 36(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L20:
	tst.b	1(a2)
	blt	@L27
	move.w	#1, -(sp)
	jsr	addPLC__cdecl
	addq.l	#2, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	deleteObject__cdecl
@L34:
	move.w	#224, -(sp)
	jsr	playSound__cdecl
	move.w	v_limitright2, v_limitleft2
	clr.b	f_timecount
	addq.b	#1, 36(a2)
	addq.l	#2, sp
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L18:
	move.l	(sp)+, a2
	rts	
@L30:
	move.w	#11, 42(a2)
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L27
	move.w	#9476, (a0)
	move.w	#10162, 2(a0)
	move.l	#Map_Ring, 4(a0)
	move.b	#2, 24(a0)
	move.b	#6, 36(a0)
	move.w	44(a2), d0
	lea	_ZN15ObjFakeSignpost11sparkleDataE, a1
	moveq	#0, d1
	move.w	d0, d1
	move.b	(a1, d1.l), d1
	ext.w	d1
	add.w	8(a2), d1
	move.w	d1, 8(a0)
	move.w	d0, d1
	addq.w	#1, d1
	and.l	#65535, d1
	move.b	(a1, d1.l), d1
	ext.w	d1
	add.w	12(a2), d1
	move.w	d1, 12(a0)
	addq.w	#2, d0
	and.w	#14, d0
	move.w	d0, 44(a2)
	pea	Ani_Sign
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L29:
	move.b	#3, 36(a2)
	bra	@L28
