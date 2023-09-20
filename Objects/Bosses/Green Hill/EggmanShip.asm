_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	40(a2)
	beq	@L11
	illegal	
@L3:
	tst.b	32(a2)
	bne	@L4
	move.b	42(a2), d0
	beq	@L12
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L6
@L13:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L7
	clr.w	d0
@L7:
	move.w	d0, -1246.w
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
@L6:
	move.b	#15, 32(a2)
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
@L11:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip16script00_TestSeqEv
	addq.l	#4, sp
	bra	@L3
@L12:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L6
	bra	@L13
_ZN13ObjEggmanShip12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L14
	move.b	42(a2), d0
	beq	@L22
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L17
@L23:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L18
	clr.w	d0
@L18:
	move.w	d0, -1246.w
@L14:
	move.l	(sp)+, a2
	rts	
@L17:
	move.b	#15, 32(a2)
	move.l	(sp)+, a2
	rts	
@L22:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L17
	bra	@L23
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	41(a2), d0
	beq	@L25
	cmp.b	#1, d0
	bne	@L24
	move.w	8(a2), a0
	move.w	12(a2), d1
	move.w	16(a2), a1
	sub.w	-2300.w, d1
	move.w	18(a2), d0
	sub.w	-2304.w, a0
	move.w	#239, d2
	cmp.w	a0, d2
	blt	@L28
@L40:
	move.w	a1, a0
	addq.w	#2, a0
	subq.w	#1, d0
	move.w	a0, 16(a2)
	move.w	d0, 18(a2)
	cmp.w	#40, d1
	ble	@L30
@L39:
	tst.w	d0
	ble	@L31
	subq.w	#6, d0
	move.w	d0, 18(a2)
@L31:
	move.b	43(a2), d0
	beq	@L34
@L32:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	beq	@L34
@L24:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L28:
	move.w	a1, a0
	subq.w	#1, a0
	addq.w	#1, d0
	move.w	a0, 16(a2)
	move.w	d0, 18(a2)
	cmp.w	#40, d1
	bgt	@L39
@L30:
	cmp.w	#11, d1
	bgt	@L31
	tst.w	d0
	bge	@L31
	addq.w	#8, d0
	move.w	d0, 18(a2)
	move.b	43(a2), d0
	bne	@L32
@L34:
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L36
	lea	BGHZ_CreateEggmanMonitor__cdecl, a0
@L33:
	move.l	a2, -(sp)
	jsr	(a0)
	move.l	d0, a0
	addq.l	#4, sp
	tst.l	d0
	beq	@L35
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L35:
	move.b	#90, 43(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L25:
	move.w	-2304.w, a0
	lea	(208, a0), a0
	move.w	a0, 8(a2)
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	d1, 12(a2)
	or.b	#1, 34(a2)
	st	33(a2)
	move.b	#1, 41(a2)
	move.w	#768, a1
	sub.w	-2300.w, d1
	move.w	18(a2), d0
	sub.w	-2304.w, a0
	move.w	#239, d2
	cmp.w	a0, d2
	blt	@L28
	bra	@L40
@L36:
	lea	BGHZ_CreateSpikedBall__cdecl, a0
	bra	@L33
_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.l	a2, -(sp)
	move.l	16(sp), a0
	jsr	(a0)
	move.l	d0, a0
	addq.l	#4, sp
	tst.l	d0
	beq	@L41
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L41:
	move.l	(sp)+, a2
	rts	
executeMasterScript_ObjEggmanShip:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	40(a2)
	beq	@L55
	illegal	
@L47:
	tst.b	32(a2)
	bne	@L48
	move.b	42(a2), d0
	beq	@L56
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L50
@L57:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L51
	clr.w	d0
@L51:
	move.w	d0, -1246.w
@L48:
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
@L50:
	move.b	#15, 32(a2)
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
@L55:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip16script00_TestSeqEv
	addq.l	#4, sp
	bra	@L47
@L56:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L50
	bra	@L57
