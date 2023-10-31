	even
_ZN15ObjEggmanShipFZ10cameraBaseE:
	dc.w	9184
	dc.w	1408
	even
_ZN15ObjEggmanShipFZ19executeMasterScriptEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L2
	cmp.b	#2, d0
	beq	@L3
	tst.b	d0
	beq	@L21
	illegal	
	move.l	(sp)+, a2
	rts	
@L2:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#8, sp
@L7:
	tst.b	32(a2)
	bne	@L11
	move.b	42(a2), d0
	beq	@L22
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L14
	move.b	#15, 32(a2)
@L11:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L23:
	move.l	(sp)+, a2
	rts	
@L21:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L5
	cmp.b	#1, d0
	bne	@L7
	cmp.w	#1424, 12(a2)
	ble	@L7
	move.w	18(a2), d0
	ble	@L9
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L7
@L3:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ17script02_DefeatedEv
	addq.l	#4, sp
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L23
@L5:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#8, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L7
@L22:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L24
	move.b	#32, 42(a2)
@L14:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L16
	clr.w	d0
@L16:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L23
@L9:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L7
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L7
@L24:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L23
	even
_ZN15ObjEggmanShipFZ12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L25
	move.b	42(a2), d0
	beq	@L35
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L29
	move.b	#15, 32(a2)
@L25:
	move.l	(sp)+, a2
	rts	
@L35:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L36
	move.b	#32, 42(a2)
@L29:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L31
	clr.w	d0
@L31:
	move.w	d0, -1246.w
	move.l	(sp)+, a2
	rts	
@L36:
	move.w	#512, 40(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN15ObjEggmanShipFZ14script00_IntroEv:
	move.l	4(sp), a0
	move.b	41(a0), d0
	beq	@L38
	cmp.b	#1, d0
	bne	@L37
	cmp.w	#1424, 12(a0)
	ble	@L37
	move.w	18(a0), d0
	ble	@L42
	add.w	#-12, d0
	move.w	d0, 18(a0)
@L37:
	rts	
@L38:
	move.w	#9344, 8(a0)
	move.w	#1312, 12(a0)
	move.w	#320, 18(a0)
	move.b	#1, 44(a0)
	or.b	#1, 34(a0)
	move.b	#8, 33(a0)
	move.b	#30, 43(a0)
	move.b	#1, 41(a0)
	rts	
@L42:
	clr.w	18(a0)
	move.b	43(a0), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a0)
	tst.b	d0
	bne	@L37
	clr.b	44(a0)
	move.w	#256, 40(a0)
	rts	
	even
_ZN15ObjEggmanShipFZ15script01_AttackEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	43(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 43(a2)
	and.w	#255, d0
	move.w	d0, -(sp)
	jsr	calcSine__cdecl
	addq.l	#2, sp
	tst.w	d0
	blt	@L55
@L47:
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	bge	@L49
	cmp.w	#-511, d1
	bge	@L56
@L50:
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	ble	@L51
@L57:
	cmp.w	#-384, d0
	blt	@L52
	subq.w	#2, d0
	move.w	d0, 18(a2)
@L52:
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L56:
	subq.w	#4, d1
	move.w	d1, 16(a2)
	and.b	#-2, 34(a2)
@L49:
	cmp.w	a0, d0
	ble	@L50
	cmp.w	#511, d1
	bgt	@L50
	addq.w	#4, d1
	move.w	d1, 16(a2)
	or.b	#1, 34(a2)
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	bgt	@L57
@L51:
	cmp.w	#1456, d2
	beq	@L52
	cmp.w	#256, d0
	bgt	@L52
	addq.w	#2, d0
	move.w	d0, 18(a2)
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L55:
	addq.w	#7, d0
	bra	@L47
	even
_ZN15ObjEggmanShipFZ17script02_DefeatedEv:
	movem.l	a2/a3/a4, -(sp)
	move.l	16(sp), a2
	move.b	41(a2), d0
	cmp.b	#1, d0
	beq	@L59
	cmp.b	#2, d0
	beq	@L60
	tst.b	d0
	beq	@L73
@L58:
	movem.l	(sp)+, a2/a3/a4
	rts	
@L73:
	move.b	#-76, 43(a2)
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	#1, 41(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L62
	move.b	#-77, 43(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
@L60:
	clr.w	8(a2)
	clr.w	12(a2)
	move.w	#224, -(sp)
	jsr	playSound__cdecl
	addq.b	#2, v_dle_routine
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	movem.l	(sp)+, a2/a3/a4
	rts	
@L59:
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L62
@L66:
	move.b	43(a2), d0
	bne	@L74
	move.w	18(a2), d0
	beq	@L58
	cmp.w	#767, d0
	bgt	@L69
	add.w	#24, d0
	move.w	d0, 18(a2)
@L69:
	cmp.w	#1728, 12(a2)
	ble	@L70
	addq.b	#1, 41(a2)
@L70:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
@L62:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L66
	move.b	#63, (a3)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a3)
	move.l	d1, 12(a3)
	lea	randomNumber__cdecl, a4
	jsr	(a4)
	lsr.l	#2, d0
	moveq	#63, d1
	and.l	d1, d0
	moveq	#-32, d1
	add.l	d1, d0
	add.w	d0, 8(a3)
	jsr	(a4)
	lsr.l	#3, d0
	moveq	#31, d1
	and.l	d1, d0
	add.w	d0, 12(a3)
	bra	@L66
@L74:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L58
	add.w	#24, 18(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
	even
_ZN15ObjEggmanShipFZ19generateProjectilesEv:
	move.l	a2, -(sp)
	move.l	8(sp), a0
	move.w	v_framecount, d0
	move.w	d0, d1
	and.w	#63, d1
	beq	@L83
	and.w	#31, d0
	bne	@L75
	move.b	#8, v_shaketimer
@L75:
	move.l	(sp)+, a2
	rts	
@L83:
	move.w	#4, -(sp)
	move.l	a0, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a2
	addq.l	#6, sp
	tst.l	d0
	beq	@L84
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a2)
	move.w	#1384, 12(a2)
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L75
	move.b	#63, (a0)
	move.w	8(a2), 8(a0)
	move.w	12(a2), a2
	lea	(24, a2), a2
	move.w	a2, 12(a0)
	move.l	(sp)+, a2
	rts	
@L84:
	move.l	(sp)+, a2
	jmp	findFreeObj__cdecl
	even
executeMasterScript_ObjEggmanShipFZ:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L86
	cmp.b	#2, d0
	beq	@L87
	tst.b	d0
	beq	@L105
	illegal	
	move.l	(sp)+, a2
	rts	
@L86:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#8, sp
@L91:
	tst.b	32(a2)
	bne	@L95
	move.b	42(a2), d0
	beq	@L106
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L98
	move.b	#15, 32(a2)
@L95:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L107:
	move.l	(sp)+, a2
	rts	
@L105:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L89
	cmp.b	#1, d0
	bne	@L91
	cmp.w	#1424, 12(a2)
	ble	@L91
	move.w	18(a2), d0
	ble	@L93
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L91
@L87:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ17script02_DefeatedEv
	addq.l	#4, sp
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L107
@L89:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#8, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L91
@L106:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L108
	move.b	#32, 42(a2)
@L98:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L100
	clr.w	d0
@L100:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L107
@L93:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L91
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L91
@L108:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L107
