_ZN13ObjPlasmaBoss10cameraBaseE:
	dc.w	9184
	dc.w	1408
_ZN13ObjPlasmaBoss7executeEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	36(a2), d0
	cmp.b	#2, d0
	beq	@L2
	bhi	@L3
	tst.b	d0
	beq	@L15
	move.b	37(a2), d0
	beq	@L8
	cmp.b	#1, d0
	bne	@L9
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L10:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L9
	move.w	#9472, 8(a2)
	clr.w	16(a2)
	move.w	#512, 36(a2)
@L9:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L3:
	cmp.b	#3, d0
	bne	@L16
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L2:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L16:
	move.l	(sp)+, a2
	rts	
@L15:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 36(a2)
@L8:
	clr.b	28(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L10
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L18
	cmp.b	#1, d0
	bne	@L17
	move.w	16(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	8(a0), d0
	move.l	d0, 8(a0)
	move.w	18(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a0)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L17
@L23:
	move.w	#9472, 8(a0)
	clr.w	16(a0)
	move.w	#512, 36(a0)
@L17:
	rts	
@L18:
	clr.b	28(a0)
	move.w	#9536, 8(a0)
	move.w	#1440, 12(a0)
	move.w	#-192, 16(a0)
	move.b	#1, 37(a0)
	move.l	#-49152, d0
	add.l	8(a0), d0
	move.l	d0, 8(a0)
	move.w	18(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a0)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L17
	bra	@L23
ObjectsBossesFinalPlasmaBoss_s__LC0:
	dc.b	"Timer expired", $e0, 0
	even
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L25
	cmp.b	#1, d0
	bne	@L24
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L35
@L30:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L24
	pea	ObjectsBossesFinalPlasmaBoss_s__LC0
	jsr	kwrite_cdecl
	move.w	#768, 36(a2)
	addq.l	#4, sp
@L24:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L25:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L28
	move.w	#179, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L28:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L36
	jsr	randomNumber__cdecl
	move.l	d0, d3
	and.w	#255, d0
	move.w	d0, -(sp)
	lea	calcSine__cdecl, a4
	jsr	(a4)
	move.w	d0, d2
	add.b	#64, d3
	and.w	#255, d3
	move.w	d3, -(sp)
	jsr	(a4)
	move.w	d0, a0
	move.l	a0, d0
	add.l	a0, d0
	move.l	d0, d1
	add.l	a0, d1
	moveq	#15, d0
	lsl.l	d0, d1
	add.l	8(a2), d1
	move.l	d1, 8(a3)
	move.w	d2, a0
	move.l	a0, d0
	add.l	a0, d0
	move.l	d0, d1
	add.l	a0, d1
	moveq	#15, d0
	lsl.l	d0, d1
	add.l	12(a2), d1
	move.l	d1, 12(a3)
	move.w	40(a2), d0
	addq.l	#4, sp
	bra	@L30
@L36:
	move.w	40(a2), d0
	bra	@L30
@L35:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L28
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
_ZN13ObjPlasmaBoss23action03_VerticalAttackEv:
	movem.l	d2/d3/a2/a3, -(sp)
	move.l	20(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L38
	cmp.b	#2, d0
	beq	@L39
	tst.b	d0
	beq	@L59
@L37:
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L59:
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	and.w	#1, d0
	lsl.w	#5, d0
	add.w	#1504, d0
	move.w	d0, 42(a2)
	move.w	12(a2), d2
	cmp.w	d0, d2
	bge	@L43
	move.w	#256, 18(a2)
	move.w	#60, 40(a2)
	addq.b	#1, 37(a2)
@L44:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L39:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L37
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L38:
	move.w	12(a2), d2
	move.w	42(a2), d0
	cmp.w	d2, d0
	bne	@L44
@L45:
	move.w	40(a2), d0
	beq	@L46
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L43:
	move.w	#-256, 18(a2)
	move.w	#60, 40(a2)
	addq.b	#1, 37(a2)
	cmp.w	d2, d0
	beq	@L45
	bra	@L44
@L46:
	move.b	#1, 28(a2)
	move.w	d2, d3
	add.w	#-48, d3
	lea	create_ObjPlasmaBall, a3
	add.w	#48, d2
	cmp.w	#1407, d3
	ble	@L48
@L50:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L49
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
@L49:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L50
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L53
@L48:
	lea	create_ObjPlasmaBall, a3
@L52:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L51
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
@L51:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L52
@L53:
	move.w	#120, 40(a2)
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
_ZN13ObjPlasmaBoss9setActionENS_6ActionE:
	move.l	4(sp), a0
	move.b	9(sp), 36(a0)
	clr.b	37(a0)
	rts	
execute_ObjPlasmaBoss:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	36(a2), d0
	cmp.b	#2, d0
	beq	@L63
	bhi	@L64
	tst.b	d0
	beq	@L76
	move.b	37(a2), d0
	beq	@L69
	cmp.b	#1, d0
	bne	@L70
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L71:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L70
	move.w	#9472, 8(a2)
	clr.w	16(a2)
	move.w	#512, 36(a2)
@L70:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L64:
	cmp.b	#3, d0
	bne	@L77
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L63:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	move.l	a2, 8(sp)
	move.l	(sp)+, a2
	jmp	displaySprite__cdecl
@L77:
	move.l	(sp)+, a2
	rts	
@L76:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 36(a2)
@L69:
	clr.b	28(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L71
