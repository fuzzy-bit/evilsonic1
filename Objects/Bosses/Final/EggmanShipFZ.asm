	even
_ZN15ObjEggmanShipFZ10cameraBaseE:
	dc.w	9184
	dc.w	1408
	even
_ZN15ObjEggmanShipFZ19executeMasterScriptEv:
	move.l	a3, -(sp)
	move.l	a2, -(sp)
	move.l	12(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L2
	cmp.b	#2, d0
	beq	@L3
	tst.b	d0
	beq	@L27
	illegal	
	move.l	(sp)+, a2
	move.l	(sp)+, a3
	rts	
@L2:
	move.w	v_framecount, d0
	and.w	#63, d0
	beq	@L28
@L15:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#4, sp
@L10:
	tst.b	32(a2)
	bne	@L17
	move.b	42(a2), d0
	beq	@L29
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L20
	move.b	#15, 32(a2)
@L17:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L31:
	move.l	(sp)+, a2
	move.l	(sp)+, a3
	rts	
@L27:
	move.w	v_framecount, d0
	and.w	#63, d0
	beq	@L30
@L6:
	move.b	41(a2), d0
	beq	@L8
@L33:
	cmp.b	#1, d0
	bne	@L10
	cmp.w	#1424, 12(a2)
	ble	@L10
	move.w	18(a2), d0
	ble	@L12
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L10
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
	bra	@L31
@L8:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#8, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L10
@L29:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L32
	move.b	#32, 42(a2)
@L20:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L22
	clr.w	d0
@L22:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L31
@L30:
	move.w	#4, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L6
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a3)
	move.w	#1384, 12(a3)
	move.b	41(a2), d0
	bne	@L33
	bra	@L8
@L28:
	move.w	#4, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L15
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a3)
	move.w	#1384, 12(a3)
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#4, sp
	bra	@L10
@L12:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L10
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L10
@L32:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L31
	even
_ZN15ObjEggmanShipFZ12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L34
	move.b	42(a2), d0
	beq	@L44
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L38
	move.b	#15, 32(a2)
@L34:
	move.l	(sp)+, a2
	rts	
@L44:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L45
	move.b	#32, 42(a2)
@L38:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L40
	clr.w	d0
@L40:
	move.w	d0, -1246.w
	move.l	(sp)+, a2
	rts	
@L45:
	move.w	#512, 40(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN15ObjEggmanShipFZ14script00_IntroEv:
	move.l	4(sp), a0
	move.b	41(a0), d0
	beq	@L47
	cmp.b	#1, d0
	bne	@L46
	cmp.w	#1424, 12(a0)
	ble	@L46
	move.w	18(a0), d0
	ble	@L51
	add.w	#-12, d0
	move.w	d0, 18(a0)
@L46:
	rts	
@L47:
	move.w	#9344, 8(a0)
	move.w	#1312, 12(a0)
	move.w	#320, 18(a0)
	move.b	#1, 44(a0)
	or.b	#1, 34(a0)
	move.b	#8, 33(a0)
	move.b	#30, 43(a0)
	move.b	#1, 41(a0)
	rts	
@L51:
	clr.w	18(a0)
	move.b	43(a0), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a0)
	tst.b	d0
	bne	@L46
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
	blt	@L64
@L56:
	asr.w	#3, d0
	add.w	#9344, d0
	move.w	8(a2), a0
	move.w	16(a2), d1
	cmp.w	a0, d0
	bge	@L58
	cmp.w	#-511, d1
	bge	@L65
@L59:
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	ble	@L60
@L66:
	cmp.w	#-384, d0
	blt	@L61
	subq.w	#2, d0
	move.w	d0, 18(a2)
@L61:
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L65:
	subq.w	#4, d1
	move.w	d1, 16(a2)
	and.b	#-2, 34(a2)
@L58:
	cmp.w	a0, d0
	ble	@L59
	cmp.w	#511, d1
	bgt	@L59
	addq.w	#4, d1
	move.w	d1, 16(a2)
	or.b	#1, 34(a2)
	move.w	12(a2), d2
	move.w	18(a2), d0
	cmp.w	#1456, d2
	bgt	@L66
@L60:
	cmp.w	#1456, d2
	beq	@L61
	cmp.w	#256, d0
	bgt	@L61
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
@L64:
	addq.w	#7, d0
	bra	@L56
	even
_ZN15ObjEggmanShipFZ17script02_DefeatedEv:
	movem.l	a2/a3/a4, -(sp)
	move.l	16(sp), a2
	move.b	41(a2), d0
	cmp.b	#1, d0
	beq	@L68
	cmp.b	#2, d0
	beq	@L69
	tst.b	d0
	beq	@L82
@L67:
	movem.l	(sp)+, a2/a3/a4
	rts	
@L82:
	move.b	#-76, 43(a2)
	clr.w	16(a2)
	clr.w	18(a2)
	clr.b	44(a2)
	move.b	#1, 41(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L71
	move.b	#-77, 43(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
@L69:
	clr.w	8(a2)
	clr.w	12(a2)
	move.w	#224, -(sp)
	jsr	playSound__cdecl
	addq.b	#2, v_dle_routine
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	movem.l	(sp)+, a2/a3/a4
	rts	
@L68:
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L71
@L75:
	move.b	43(a2), d0
	bne	@L83
	move.w	18(a2), d0
	beq	@L67
	cmp.w	#767, d0
	bgt	@L78
	add.w	#24, d0
	move.w	d0, 18(a2)
@L78:
	cmp.w	#1728, 12(a2)
	ble	@L79
	addq.b	#1, 41(a2)
@L79:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
@L71:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L75
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
	bra	@L75
@L83:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bne	@L67
	add.w	#24, 18(a2)
	movem.l	(sp)+, a2/a3/a4
	rts	
	even
_ZN15ObjEggmanShipFZ19generateProjectilesEv:
	move.l	a2, -(sp)
	move.w	v_framecount, d0
	and.w	#63, d0
	beq	@L90
@L84:
	move.l	(sp)+, a2
	rts	
@L90:
	move.w	#4, -(sp)
	move.l	10(sp), -(sp)
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
	move.l	(sp)+, a2
	rts	
	even
executeMasterScript_ObjEggmanShipFZ:
	move.l	a3, -(sp)
	move.l	a2, -(sp)
	move.l	12(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L92
	cmp.b	#2, d0
	beq	@L93
	tst.b	d0
	beq	@L117
	illegal	
	move.l	(sp)+, a2
	move.l	(sp)+, a3
	rts	
@L92:
	move.w	v_framecount, d0
	and.w	#63, d0
	beq	@L118
@L105:
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#4, sp
@L100:
	tst.b	32(a2)
	bne	@L107
	move.b	42(a2), d0
	beq	@L119
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L110
	move.b	#15, 32(a2)
@L107:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L121:
	move.l	(sp)+, a2
	move.l	(sp)+, a3
	rts	
@L117:
	move.w	v_framecount, d0
	and.w	#63, d0
	beq	@L120
@L96:
	move.b	41(a2), d0
	beq	@L98
@L123:
	cmp.b	#1, d0
	bne	@L100
	cmp.w	#1424, 12(a2)
	ble	@L100
	move.w	18(a2), d0
	ble	@L102
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L100
@L93:
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
	bra	@L121
@L98:
	move.w	#9344, 8(a2)
	move.w	#1312, 12(a2)
	move.w	#320, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#8, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	bra	@L100
@L119:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L122
	move.b	#32, 42(a2)
@L110:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L112
	clr.w	d0
@L112:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L121
@L120:
	move.w	#4, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L96
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a3)
	move.w	#1384, 12(a3)
	move.b	41(a2), d0
	bne	@L123
	bra	@L98
@L118:
	move.w	#4, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L105
	jsr	randomNumber__cdecl
	and.w	#7, d0
	muls.w	#39, d0
	add.w	#9200, d0
	move.w	d0, 8(a3)
	move.w	#1384, 12(a3)
	move.l	a2, -(sp)
	jsr	_ZN15ObjEggmanShipFZ15script01_AttackEv
	addq.l	#4, sp
	bra	@L100
@L102:
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L100
	clr.b	44(a2)
	move.w	#256, 40(a2)
	bra	@L100
@L122:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L121
