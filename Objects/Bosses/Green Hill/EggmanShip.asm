_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	40(a2)
	beq	@L12
	illegal	
@L3:
	tst.b	32(a2)
	bne	@L4
	move.b	42(a2), d0
	beq	@L13
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L6
	move.b	#15, 32(a2)
@L4:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, a2
	rts	
@L13:
	move.b	#32, 42(a2)
@L6:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L8
	clr.w	d0
@L8:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, a2
	rts	
@L12:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip16script00_TestSeqEv
	addq.l	#4, sp
	bra	@L3
_ZN13ObjEggmanShip12handleDamageEv:
	move.l	4(sp), a0
	tst.b	32(a0)
	bne	@L14
	move.b	42(a0), d0
	beq	@L23
	subq.b	#1, d0
	move.b	d0, 42(a0)
	bne	@L17
	move.b	#15, 32(a0)
@L14:
	rts	
@L23:
	move.b	#32, 42(a0)
@L17:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L19
	clr.w	d0
@L19:
	move.w	d0, -1246.w
	rts	
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	41(a0), d0
	beq	@L25
	cmp.b	#1, d0
	bne	@L24
	move.w	8(a0), a1
	move.w	12(a0), d1
	move.w	16(a0), d2
	sub.w	-2300.w, d1
	move.w	18(a0), d0
	sub.w	-2304.w, a1
	move.w	#239, d3
	cmp.w	a1, d3
	blt	@L28
@L34:
	move.w	d2, a1
	addq.w	#2, a1
	subq.w	#1, d0
	move.w	a1, 16(a0)
	move.w	d0, 18(a0)
	cmp.w	#40, d1
	ble	@L30
@L33:
	tst.w	d0
	ble	@L24
	subq.w	#6, d0
	move.w	d0, 18(a0)
@L24:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L28:
	move.w	d2, a1
	subq.w	#1, a1
	addq.w	#1, d0
	move.w	a1, 16(a0)
	move.w	d0, 18(a0)
	cmp.w	#40, d1
	bgt	@L33
@L30:
	cmp.w	#15, d1
	bgt	@L24
	tst.w	d0
	bge	@L24
	addq.w	#4, d0
	move.w	d0, 18(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L25:
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	a1, 8(a0)
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	d1, 12(a0)
	or.b	#1, 34(a0)
	st	33(a0)
	move.b	#1, 41(a0)
	move.w	#768, d2
	sub.w	-2300.w, d1
	move.w	18(a0), d0
	sub.w	-2304.w, a1
	move.w	#239, d3
	cmp.w	a1, d3
	blt	@L28
	bra	@L34
executeMasterScript_ObjEggmanShip:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	tst.b	40(a0)
	beq	@L51
	illegal	
@L38:
	tst.b	32(a0)
	bne	@L43
	move.b	42(a0), d0
	beq	@L52
	subq.b	#1, d0
	move.b	d0, 42(a0)
	bne	@L45
	move.b	#15, 32(a0)
@L43:
	move.w	16(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a0)
	move.w	18(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L52:
	move.b	#32, 42(a0)
@L45:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L47
	clr.w	d0
@L47:
	move.w	d0, -1246.w
	move.w	16(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a0)
	move.w	18(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L51:
	move.b	41(a0), d0
	beq	@L37
	cmp.b	#1, d0
	bne	@L38
	move.w	8(a0), a1
	move.w	12(a0), d1
	move.w	16(a0), d2
@L39:
	sub.w	-2300.w, d1
	move.w	18(a0), d0
	sub.w	-2304.w, a1
	move.w	#239, d3
	cmp.w	a1, d3
	blt	@L40
	move.w	d2, a1
	addq.w	#2, a1
	subq.w	#1, d0
	move.w	a1, 16(a0)
	move.w	d0, 18(a0)
	cmp.w	#40, d1
	ble	@L42
@L53:
	tst.w	d0
	ble	@L38
	subq.w	#6, d0
	move.w	d0, 18(a0)
	bra	@L38
@L40:
	move.w	d2, a1
	subq.w	#1, a1
	addq.w	#1, d0
	move.w	a1, 16(a0)
	move.w	d0, 18(a0)
	cmp.w	#40, d1
	bgt	@L53
@L42:
	cmp.w	#15, d1
	bgt	@L38
	tst.w	d0
	bge	@L38
	addq.w	#4, d0
	move.w	d0, 18(a0)
	bra	@L38
@L37:
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	a1, 8(a0)
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	d1, 12(a0)
	or.b	#1, 34(a0)
	st	33(a0)
	move.b	#1, 41(a0)
	move.w	#768, d2
	bra	@L39
