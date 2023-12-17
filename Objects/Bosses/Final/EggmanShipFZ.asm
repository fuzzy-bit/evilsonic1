	even
_ZN15ObjEggmanShipFZ10cameraBaseE:
	dc.w	9184
	dc.w	1408
	even
_ZL13initialHealth:
	dc.w	15
	even
_ZN15ObjEggmanShipFZ19executeMasterScriptEv:
	movem.l	a2/a3/a4, -(sp)
	move.l	16(sp), a2
	move.b	40(a2), d0
	cmp.b	#2, d0
	beq	@L2
	bhi	@L3
	tst.b	d0
	beq	@L33
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L15
	cmp.b	#1, d0
	bne	@L11
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	43(a2), d0
	bne	@L34
@L11:
	tst.b	32(a2)
	bne	@L20
	move.b	42(a2), d0
	beq	@L35
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L23
	move.b	#15, 32(a2)
@L20:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L1:
	movem.l	(sp)+, a2/a3/a4
	rts	
@L3:
	cmp.b	#3, d0
	bne	@L36
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ17script03_DefeatedEv
	addq.l	#4, sp
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L1
@L36:
	illegal	
	movem.l	(sp)+, a2/a3/a4
	rts	
@L2:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ10moveAroundEv
	addq.l	#8, sp
	bra	@L11
@L33:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L8
	cmp.b	#1, d0
	bne	@L11
	cmp.w	#1424, 12(a2)
	ble	@L11
	move.w	18(a2), d0
	ble	@L13
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L11
@L15:
	cmp.b	#8, 33(a2)
	bhi	@L17
	move.b	#-102, 32(a2)
	move.b	#100, 43(a2)
	move.b	#1, 41(a2)
@L17:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ10moveAroundEv
	addq.l	#4, sp
	bra	@L11
@L8:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#15, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L11
@L35:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L37
	move.b	#32, 42(a2)
@L23:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L25
	clr.w	d0
@L25:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L1
@L34:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L38
@L18:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L11
	move.b	#1, 44(a2)
	move.b	#15, 32(a2)
	move.b	#2, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L1
@L13:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L11
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L11
@L38:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L30
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
@L30:
	move.b	43(a2), d0
	bra	@L18
@L37:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L1
	even
_ZN15ObjEggmanShipFZ12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L39
	move.b	42(a2), d0
	beq	@L49
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L43
	move.b	#15, 32(a2)
@L39:
	move.l	(sp)+, a2
	rts	
@L49:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L50
	move.b	#32, 42(a2)
@L43:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L45
	clr.w	d0
@L45:
	move.w	d0, -1246.w
	move.l	(sp)+, a2
	rts	
@L50:
	move.w	#512, 40(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN15ObjEggmanShipFZ10moveAroundEv:
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
	blt	@L59
@L52:
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	bge	@L53
	cmp.w	#-511, d1
	bge	@L60
@L54:
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	ble	@L55
@L61:
	cmp.w	#-384, d0
	blt	@L56
	subq.w	#2, d0
	move.w	d0, 18(a2)
@L56:
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L53:
	cmp.w	a0, d0
	ble	@L54
	cmp.w	#511, d1
	bgt	@L54
	addq.w	#4, d1
	move.w	d1, 16(a2)
	or.b	#1, 34(a2)
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	bgt	@L61
@L55:
	cmp.w	#1456, d2
	beq	@L56
	cmp.w	#256, d0
	bgt	@L56
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
@L59:
	addq.w	#7, d0
	bra	@L52
@L60:
	subq.w	#4, d1
	move.w	d1, 16(a2)
	and.b	#-2, 34(a2)
	bra	@L54
	even
_ZN15ObjEggmanShipFZ7explodeEv:
	move.l	a3, -(sp)
	move.l	a2, -(sp)
	jsr	findFreeObj__cdecl
	move.l	d0, a2
	tst.l	d0
	beq	@L62
	move.b	#63, (a2)
	move.l	12(sp), a0
	move.l	8(a0), d0
	move.l	12(a0), d1
	move.l	d0, 8(a2)
	move.l	d1, 12(a2)
	lea	randomNumber__cdecl, a3
	jsr	(a3)
	lsr.l	#2, d0
	moveq	#63, d1
	and.l	d1, d0
	moveq	#-32, d1
	add.l	d1, d0
	add.w	d0, 8(a2)
	jsr	(a3)
	lsr.l	#3, d0
	moveq	#31, d1
	and.l	d1, d0
	add.w	d0, 12(a2)
@L62:
	move.l	(sp)+, a2
	move.l	(sp)+, a3
	rts	
	even
_ZN15ObjEggmanShipFZ14script00_IntroEv:
	move.l	4(sp), a0
	move.b	41(a0), d0
	beq	@L67
	cmp.b	#1, d0
	bne	@L66
	cmp.w	#1424, 12(a0)
	ble	@L66
	move.w	18(a0), d0
	ble	@L71
	add.w	#-12, d0
	move.w	d0, 18(a0)
@L66:
	rts	
@L67:
	move.w	#9344, 8(a0)
	move.w	#1312, 12(a0)
	move.w	#320, 18(a0)
	move.b	#1, 44(a0)
	or.b	#1, 34(a0)
	move.b	#15, 33(a0)
	move.b	#30, 43(a0)
	move.b	#1, 41(a0)
	rts	
@L71:
	clr.w	18(a0)
	move.b	43(a0), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a0)
	tst.b	d0
	bne	@L66
	clr.b	44(a0)
	move.w	#256, 40(a0)
	rts	
	even
_ZN15ObjEggmanShipFZ15script01_Phase1Ev:
	movem.l	d2/a2/a3/a4, -(sp)
	move.l	20(sp), a2
	move.b	41(a2), d0
	beq	@L76
	cmp.b	#1, d0
	beq	@L77
@L75:
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L77:
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	43(a2), d0
	beq	@L75
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L93
@L87:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L75
	move.b	#1, 44(a2)
	move.b	#15, 32(a2)
	move.b	#2, 40(a2)
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L76:
	cmp.b	#8, 33(a2)
	bhi	@L94
	move.b	#-102, 32(a2)
	move.b	#1, 41(a2)
	moveq	#100, d0
	moveq	#101, d1
	move.b	d1, 43(a2)
	move.w	d0, -(sp)
	jsr	calcSine__cdecl
	addq.l	#2, sp
	tst.w	d0
	blt	@L95
@L81:
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	bge	@L82
@L96:
	cmp.w	#-511, d1
	blt	@L83
	subq.w	#4, d1
	move.w	d1, 16(a2)
	and.b	#-2, 34(a2)
@L83:
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	ble	@L84
@L97:
	cmp.w	#-384, d0
	blt	@L85
	subq.w	#2, d0
	move.w	d0, 18(a2)
@L85:
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L98:
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L94:
	move.b	43(a2), d1
	addq.b	#1, d1
	clr.w	d0
	move.b	43(a2), d0
	move.b	d1, 43(a2)
	move.w	d0, -(sp)
	jsr	calcSine__cdecl
	addq.l	#2, sp
	tst.w	d0
	bge	@L81
@L95:
	addq.w	#7, d0
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	blt	@L96
@L82:
	cmp.w	a0, d0
	ble	@L83
	cmp.w	#511, d1
	bgt	@L83
	addq.w	#4, d1
	move.w	d1, 16(a2)
	or.b	#1, 34(a2)
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	bgt	@L97
@L84:
	cmp.w	#1456, d2
	beq	@L85
	cmp.w	#256, d0
	bgt	@L85
	addq.w	#2, d0
	move.w	d0, 18(a2)
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L98
@L93:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L90
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
@L90:
	move.b	43(a2), d0
	bra	@L87
	even
_ZN15ObjEggmanShipFZ15script02_Phase2Ev:
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
	blt	@L107
@L100:
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	bge	@L101
	cmp.w	#-511, d1
	bge	@L108
@L102:
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	ble	@L103
@L109:
	cmp.w	#-384, d0
	blt	@L104
	subq.w	#2, d0
	move.w	d0, 18(a2)
@L104:
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L101:
	cmp.w	a0, d0
	ble	@L102
	cmp.w	#511, d1
	bgt	@L102
	addq.w	#4, d1
	move.w	d1, 16(a2)
	or.b	#1, 34(a2)
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	bgt	@L109
@L103:
	cmp.w	#1456, d2
	beq	@L104
	cmp.w	#256, d0
	bgt	@L104
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
@L107:
	addq.w	#7, d0
	bra	@L100
@L108:
	subq.w	#4, d1
	move.w	d1, 16(a2)
	and.b	#-2, 34(a2)
	bra	@L102
	even
_ZN15ObjEggmanShipFZ17script03_DefeatedEv:
	movem.l	a2/a3/a4, -(sp)
	move.l	16(sp), a2
	move.b	41(a2), d0
	cmp.b	#1, d0
	beq	@L111
	cmp.b	#2, d0
	beq	@L112
	tst.b	d0
	bne	@L110
	move.b	#-76, 43(a2)
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	#1, 41(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L114
	move.b	#-77, 43(a2)
@L110:
	movem.l	(sp)+, a2/a3/a4
	rts	
@L112:
	clr.w	8(a2)
	clr.w	12(a2)
	move.w	#224, -(sp)
	jsr	playSound__cdecl
	addq.b	#2, v_dle_routine
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	movem.l	(sp)+, a2/a3/a4
	rts	
@L111:
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L114
@L118:
	move.b	43(a2), d0
	bne	@L125
	move.w	18(a2), d0
	beq	@L110
	cmp.w	#767, d0
	bgt	@L121
	add.w	#24, d0
	move.w	d0, 18(a2)
@L121:
	cmp.w	#1728, 12(a2)
	ble	@L122
	addq.b	#1, 41(a2)
@L122:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
@L114:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L118
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
	bra	@L118
@L125:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L110
	add.w	#24, 18(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
	even
_ZN15ObjEggmanShipFZ19generateProjectilesEv:
	move.l	a2, -(sp)
	move.l	8(sp), a0
	move.w	v_framecount, d0
	move.w	d0, d1
	and.w	#47, d1
	beq	@L134
	and.w	#31, d0
	bne	@L126
	move.b	#8, v_shaketimer
@L126:
	move.l	(sp)+, a2
	rts	
@L134:
	move.w	#4, -(sp)
	move.l	a0, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a2
	addq.l	#6, sp
	tst.l	d0
	beq	@L135
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a2)
	move.w	#1384, 12(a2)
	jsr	findFreeObj__cdecl
	move.l	d0, a0
	tst.l	d0
	beq	@L126
	move.b	#63, (a0)
	move.w	8(a2), 8(a0)
	move.w	12(a2), a2
	lea	(24, a2), a2
	move.w	a2, 12(a0)
	move.l	(sp)+, a2
	rts	
@L135:
	move.l	(sp)+, a2
	jmp	findFreeObj__cdecl
	even
executeMasterScript_ObjEggmanShipFZ:
	movem.l	a2/a3/a4, -(sp)
	move.l	16(sp), a2
	move.b	40(a2), d0
	cmp.b	#2, d0
	beq	@L137
	bhi	@L138
	tst.b	d0
	beq	@L168
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L150
	cmp.b	#1, d0
	bne	@L146
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	43(a2), d0
	bne	@L169
@L146:
	tst.b	32(a2)
	bne	@L155
	move.b	42(a2), d0
	beq	@L170
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L158
	move.b	#15, 32(a2)
@L155:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L136:
	movem.l	(sp)+, a2/a3/a4
	rts	
@L138:
	cmp.b	#3, d0
	bne	@L171
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ17script03_DefeatedEv
	addq.l	#4, sp
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L136
@L171:
	illegal	
	movem.l	(sp)+, a2/a3/a4
	rts	
@L137:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ10moveAroundEv
	addq.l	#8, sp
	bra	@L146
@L168:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ19generateProjectilesEv
	move.b	41(a2), d0
	addq.l	#4, sp
	beq	@L143
	cmp.b	#1, d0
	bne	@L146
	cmp.w	#1424, 12(a2)
	ble	@L146
	move.w	18(a2), d0
	ble	@L148
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L146
@L150:
	cmp.b	#8, 33(a2)
	bhi	@L152
	move.b	#-102, 32(a2)
	move.b	#100, 43(a2)
	move.b	#1, 41(a2)
@L152:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ10moveAroundEv
	addq.l	#4, sp
	bra	@L146
@L143:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#15, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L146
@L170:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L172
	move.b	#32, 42(a2)
@L158:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L160
	clr.w	d0
@L160:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L136
@L169:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L173
@L153:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L146
	move.b	#1, 44(a2)
	move.b	#15, 32(a2)
	move.b	#2, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L136
@L148:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L146
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L146
@L173:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L165
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
@L165:
	move.b	43(a2), d0
	bra	@L153
@L172:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L136
