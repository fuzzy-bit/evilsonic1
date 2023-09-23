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
	move.w	8(a2), d0
	move.w	12(a2), d2
	move.w	16(a2), a0
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L28
@L46:
	addq.w	#2, a0
	subq.w	#1, d1
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	ble	@L30
@L44:
	tst.w	d1
	ble	@L31
	subq.w	#6, d1
	move.w	d1, 18(a2)
@L31:
	move.b	43(a2), d1
	beq	@L36
	subq.b	#1, d1
	move.b	d1, 43(a2)
	beq	@L36
@L24:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L28:
	subq.w	#1, a0
	addq.w	#1, d1
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	bgt	@L44
@L30:
	cmp.w	#11, d2
	bgt	@L31
	tst.w	d1
	blt	@L45
	move.b	43(a2), d1
	beq	@L24
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L24
@L36:
	add.w	#-201, d0
	cmp.w	#73, d0
	bhi	@L24
	add.w	#-33, d2
	cmp.w	#43, d2
	bhi	@L24
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L39
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L37:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L38
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L38:
	move.b	#90, 43(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L25:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d2
	add.w	#32, d2
	move.w	d2, 12(a2)
	or.b	#1, 34(a2)
	st	33(a2)
	move.b	#1, 41(a2)
	move.w	#768, a0
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L28
	bra	@L46
@L45:
	addq.w	#8, d1
	move.w	d1, 18(a2)
	move.b	43(a2), d1
	beq	@L24
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L24
	bra	@L36
@L39:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L37
_ZN13ObjEggmanShip11throwObjectEPFvR11LevelObjectE:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.l	12(sp), -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L47
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L47:
	move.l	(sp)+, a2
	rts	
executeMasterScript_ObjEggmanShip:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	40(a2)
	beq	@L61
	illegal	
@L53:
	tst.b	32(a2)
	bne	@L54
	move.b	42(a2), d0
	beq	@L62
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L56
@L63:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L57
	clr.w	d0
@L57:
	move.w	d0, -1246.w
@L54:
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
@L56:
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
@L61:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip16script00_TestSeqEv
	addq.l	#4, sp
	bra	@L53
@L62:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L56
	bra	@L63
