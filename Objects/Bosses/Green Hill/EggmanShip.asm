	even
_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L2
	cmp.b	#2, d0
	beq	@L3
	tst.b	d0
	bne	@L4
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip14script00_IntroEv
	addq.l	#4, sp
@L5:
	tst.b	32(a2)
	bne	@L6
	move.b	42(a2), d0
	beq	@L16
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L9
	move.b	#15, 32(a2)
@L6:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L1:
	move.l	(sp)+, a2
	rts	
@L3:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip17script02_DefeatedEv
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
@L4:
	illegal	
	move.l	(sp)+, a2
	rts	
@L2:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip22script01_ThrowSequenceEv
	addq.l	#4, sp
	bra	@L5
@L16:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L17
	move.b	#32, 42(a2)
@L9:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L11
	clr.w	d0
@L11:
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
@L17:
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
_ZN13ObjEggmanShip12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L18
	move.b	42(a2), d0
	beq	@L28
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L22
	move.b	#15, 32(a2)
@L18:
	move.l	(sp)+, a2
	rts	
@L28:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L29
	move.b	#32, 42(a2)
@L22:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L24
	clr.w	d0
@L24:
	move.w	d0, -1246.w
	move.l	(sp)+, a2
	rts	
@L29:
	move.w	#512, 40(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN13ObjEggmanShip14script00_IntroEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	41(a2), d0
	cmp.b	#2, d0
	beq	@L31
	bhi	@L32
	tst.b	d0
	beq	@L56
	move.w	12(a2), d0
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L30
	move.w	18(a2), d0
	bgt	@L57
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L30
	clr.b	44(a2)
	move.w	#-512, 16(a2)
	move.w	#384, 18(a2)
	move.b	#2, 41(a2)
@L30:
	move.l	(sp)+, a2
	rts	
@L32:
	cmp.b	#3, d0
	bne	@L30
	move.b	43(a2), d0
	bne	@L58
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	12(a2), a0
	cmp.w	a0, d1
	bge	@L43
	move.w	18(a2), d0
	cmp.w	#-511, d0
	bge	@L59
@L45:
	move.w	d0, 18(a2)
	move.w	8(a2), d0
	cmp.w	a1, d0
	ble	@L47
	move.w	16(a2), d0
	cmp.w	#576, d0
	ble	@L30
	add.w	#-12, d0
	move.w	d0, 16(a2)
	move.l	(sp)+, a2
	rts	
@L31:
	move.w	16(a2), d0
	cmp.w	#1023, d0
	bgt	@L40
	add.w	#24, d0
	move.w	d0, 16(a2)
@L40:
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L41
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L41:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#256, d0
	ble	@L30
	addq.b	#2, v_dle_routine
	move.b	#1, f_timecount
	move.w	#140, -(sp)
	jsr	playSound__cdecl
	move.b	#60, 43(a2)
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	move.l	(sp)+, a2
	rts	
@L56:
	move.w	-2304.w, d0
	add.w	#160, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d0
	add.w	#-64, d0
	move.w	d0, 12(a2)
	move.w	#512, 18(a2)
	move.b	#1, 44(a2)
	or.b	#1, 34(a2)
	move.b	#10, 33(a2)
	move.b	#30, 43(a2)
	move.b	#1, 41(a2)
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L30
	move.w	#500, d0
	move.w	d0, 18(a2)
@L60:
	move.l	(sp)+, a2
	rts	
@L58:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	move.l	(sp)+, a2
	rts	
@L43:
	cmp.w	a0, d1
	ble	@L52
	move.w	18(a2), d0
	cmp.w	#511, d0
	bgt	@L45
	addq.w	#4, d0
	bra	@L45
@L47:
	cmp.w	a1, d0
	blt	@L48
	move.w	#768, 16(a2)
	cmp.w	a0, d1
	bne	@L30
	cmp.l	#50331648, 16(a2)
	bne	@L30
	move.w	#256, 40(a2)
	move.l	(sp)+, a2
	rts	
@L59:
	subq.w	#4, d0
	bra	@L45
@L48:
	move.w	16(a2), d0
	cmp.w	#1279, d0
	bgt	@L50
	add.w	#12, d0
@L50:
	move.w	d0, 16(a2)
	move.l	(sp)+, a2
	rts	
@L52:
	clr.w	d0
	bra	@L45
@L57:
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L60
	even
_ZN13ObjEggmanShip22script01_ThrowSequenceEv:
	movem.l	d2/d3/a2, -(sp)
	move.l	16(sp), a2
	move.b	41(a2), d0
	beq	@L62
	cmp.b	#1, d0
	beq	@L81
@L61:
	movem.l	(sp)+, d2/d3/a2
	rts	
@L81:
	move.w	8(a2), d0
	move.w	12(a2), d3
	move.w	16(a2), d1
@L64:
	move.w	d0, d2
	sub.w	-2304.w, d2
	sub.w	-2300.w, d3
	move.w	18(a2), d0
	cmp.w	#239, d2
	bgt	@L65
	addq.w	#2, d1
	subq.w	#1, d0
@L66:
	move.w	d1, 16(a2)
	move.w	d0, 18(a2)
	cmp.w	#40, d3
	ble	@L67
	tst.w	d0
	ble	@L68
	subq.w	#6, d0
	move.w	d0, 18(a2)
@L68:
	cmp.b	#8, 33(a2)
	bhi	@L61
	move.b	43(a2), d0
	beq	@L77
	subq.b	#1, d0
	move.b	d0, 43(a2)
	cmp.b	#90, d0
	beq	@L82
	cmp.b	#60, d0
	beq	@L83
	tst.b	d0
	bne	@L61
@L77:
	add.w	#-201, d2
	cmp.w	#73, d2
	bhi	@L61
	add.w	#-33, d3
	cmp.w	#43, d3
	bhi	@L61
	move.b	#120, 43(a2)
	move.b	#1, 44(a2)
	movem.l	(sp)+, d2/d3/a2
	rts	
@L67:
	cmp.w	#11, d3
	bgt	@L68
	tst.w	d0
	bge	@L68
	addq.w	#8, d0
	move.w	d0, 18(a2)
	bra	@L68
@L65:
	subq.w	#1, d1
	addq.w	#1, d0
	bra	@L66
@L62:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d3
	add.w	#32, d3
	move.w	d3, 12(a2)
	move.b	#1, 41(a2)
	move.w	#768, d1
	bra	@L64
@L83:
	clr.b	44(a2)
	movem.l	(sp)+, d2/d3/a2
	rts	
@L82:
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L78
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L74:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L75
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.b	43(a2), d0
	bne	@L61
	bra	@L77
@L78:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L74
@L75:
	move.b	43(a2), d0
	bne	@L61
	bra	@L77
	even
_ZN13ObjEggmanShip17script02_DefeatedEv:
	movem.l	d2/a2/a3/a4, -(sp)
	move.l	20(sp), a2
	move.b	41(a2), d0
	cmp.b	#1, d0
	beq	@L85
	cmp.b	#2, d0
	beq	@L86
	tst.b	d0
	bne	@L84
	move.b	#-76, 43(a2)
	clr.b	44(a2)
	move.b	#1, 41(a2)
@L85:
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	16(a2), d0
	move.w	-2304.w, d2
	add.w	#160, d2
	cmp.w	8(a2), d2
	bge	@L88
	cmp.w	#256, d0
	bgt	@L103
@L90:
	move.w	d0, 16(a2)
	move.w	18(a2), d0
	cmp.w	12(a2), d1
	bge	@L92
@L105:
	cmp.w	#-255, d0
	blt	@L94
	subq.w	#4, d0
@L94:
	move.w	d0, 18(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L104
@L97:
	move.b	43(a2), d0
	beq	@L99
	subq.b	#1, d0
	move.b	d0, 43(a2)
@L84:
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L88:
	cmp.w	#1023, d0
	bgt	@L90
	add.w	#14, d0
	move.w	d0, 16(a2)
	move.w	18(a2), d0
	cmp.w	12(a2), d1
	blt	@L105
@L92:
	cmp.w	#255, d0
	bgt	@L94
	addq.w	#4, d0
	move.w	d0, 18(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	bne	@L97
	bra	@L104
@L86:
	add.w	#32, 16(a2)
	add.w	#-18, 18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L84
	clr.w	8(a2)
	clr.w	12(a2)
	move.w	#129, -(sp)
	jsr	playSound__cdecl
	addq.b	#2, v_dle_routine
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L99:
	move.b	#120, 43(a2)
	move.w	#256, 16(a2)
	move.w	#768, 18(a2)
	addq.b	#1, 41(a2)
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L104:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L97
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
	bra	@L97
@L103:
	add.w	#-14, d0
	bra	@L90
	even
_ZN13ObjEggmanShip11throwObjectEPFvR11LevelObjectE:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.l	12(sp), -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L106
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L106:
	move.l	(sp)+, a2
	rts	
	even
executeMasterScript_ObjEggmanShip:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L111
	cmp.b	#2, d0
	beq	@L112
	tst.b	d0
	bne	@L113
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip14script00_IntroEv
	addq.l	#4, sp
@L114:
	tst.b	32(a2)
	bne	@L115
	move.b	42(a2), d0
	beq	@L125
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L118
	move.b	#15, 32(a2)
@L115:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L110:
	move.l	(sp)+, a2
	rts	
@L112:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip17script02_DefeatedEv
	addq.l	#4, sp
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L110
@L113:
	illegal	
	move.l	(sp)+, a2
	rts	
@L111:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip22script01_ThrowSequenceEv
	addq.l	#4, sp
	bra	@L114
@L125:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L126
	move.b	#32, 42(a2)
@L118:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L120
	clr.w	d0
@L120:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L110
@L126:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L110
