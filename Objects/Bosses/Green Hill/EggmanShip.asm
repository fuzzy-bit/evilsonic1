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
	beq	@L16
	illegal	
	move.l	(sp)+, a2
	rts	
@L2:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip22script01_ThrowSequenceEv
	addq.l	#4, sp
@L5:
	tst.b	32(a2)
	bne	@L6
	move.b	42(a2), d0
	beq	@L17
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
@L18:
	move.l	(sp)+, a2
	rts	
@L16:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip14script00_IntroEv
	addq.l	#4, sp
	bra	@L5
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
	bra	@L18
@L17:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L19
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
	bra	@L18
@L19:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L18
	even
_ZN13ObjEggmanShip12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L20
	move.b	42(a2), d0
	beq	@L30
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L24
	move.b	#15, 32(a2)
@L20:
	move.l	(sp)+, a2
	rts	
@L30:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L31
	move.b	#32, 42(a2)
@L24:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L26
	clr.w	d0
@L26:
	move.w	d0, -1246.w
	move.l	(sp)+, a2
	rts	
@L31:
	move.w	#512, 40(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN13ObjEggmanShip14script00_IntroEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	41(a2), d0
	cmp.b	#2, d0
	beq	@L33
	bhi	@L34
	tst.b	d0
	beq	@L58
	move.w	12(a2), d0
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L32
	move.w	18(a2), d0
	bgt	@L59
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L32
	clr.b	44(a2)
	move.w	#-512, 16(a2)
	move.w	#384, 18(a2)
	move.b	#2, 41(a2)
@L32:
	move.l	(sp)+, a2
	rts	
@L34:
	cmp.b	#3, d0
	bne	@L32
	move.b	43(a2), d0
	bne	@L60
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	12(a2), a0
	cmp.w	a0, d1
	bge	@L45
	move.w	18(a2), d0
	cmp.w	#-511, d0
	bge	@L61
@L47:
	move.w	d0, 18(a2)
	move.w	8(a2), d0
	cmp.w	a1, d0
	ble	@L49
	move.w	16(a2), d0
	cmp.w	#576, d0
	ble	@L32
	add.w	#-12, d0
	move.w	d0, 16(a2)
	move.l	(sp)+, a2
	rts	
@L33:
	move.w	16(a2), d0
	cmp.w	#1023, d0
	bgt	@L42
	add.w	#24, d0
	move.w	d0, 16(a2)
@L42:
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L43
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L43:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#256, d0
	ble	@L32
	addq.b	#2, v_dle_routine
	move.w	#140, -(sp)
	jsr	playSound__cdecl
	move.b	#60, 43(a2)
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	move.l	(sp)+, a2
	rts	
@L58:
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
	ble	@L32
	move.w	#500, d0
	move.w	d0, 18(a2)
@L62:
	move.l	(sp)+, a2
	rts	
@L60:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	move.l	(sp)+, a2
	rts	
@L45:
	cmp.w	a0, d1
	ble	@L54
	move.w	18(a2), d0
	cmp.w	#511, d0
	bgt	@L47
	addq.w	#4, d0
	bra	@L47
@L49:
	cmp.w	a1, d0
	blt	@L50
	move.w	#768, 16(a2)
	cmp.w	a0, d1
	bne	@L32
	cmp.l	#50331648, 16(a2)
	bne	@L32
	move.w	#256, 40(a2)
	move.l	(sp)+, a2
	rts	
@L61:
	subq.w	#4, d0
	bra	@L47
@L50:
	move.w	16(a2), d0
	cmp.w	#1279, d0
	bgt	@L52
	add.w	#12, d0
@L52:
	move.w	d0, 16(a2)
	move.l	(sp)+, a2
	rts	
@L54:
	clr.w	d0
	bra	@L47
@L59:
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L62
	even
_ZN13ObjEggmanShip22script01_ThrowSequenceEv:
	movem.l	d2/d3/a2, -(sp)
	move.l	16(sp), a2
	move.b	41(a2), d0
	beq	@L64
	cmp.b	#1, d0
	bne	@L63
	move.w	8(a2), d0
	move.w	12(a2), d3
	move.w	16(a2), d1
	move.w	d0, d2
	sub.w	-2304.w, d2
	sub.w	-2300.w, d3
	move.w	18(a2), d0
	cmp.w	#239, d2
	bgt	@L67
@L86:
	addq.w	#2, d1
	subq.w	#1, d0
	move.w	d1, 16(a2)
	move.w	d0, 18(a2)
	cmp.w	#40, d3
	ble	@L69
@L85:
	tst.w	d0
	ble	@L70
	subq.w	#6, d0
	move.w	d0, 18(a2)
@L70:
	cmp.b	#8, 33(a2)
	bhi	@L63
	move.b	43(a2), d0
	beq	@L79
	subq.b	#1, d0
	move.b	d0, 43(a2)
	cmp.b	#90, d0
	beq	@L83
	cmp.b	#60, d0
	beq	@L84
	tst.b	d0
	beq	@L79
@L63:
	movem.l	(sp)+, d2/d3/a2
	rts	
@L67:
	subq.w	#1, d1
	addq.w	#1, d0
	move.w	d1, 16(a2)
	move.w	d0, 18(a2)
	cmp.w	#40, d3
	bgt	@L85
@L69:
	cmp.w	#11, d3
	bgt	@L70
	tst.w	d0
	bge	@L70
	addq.w	#8, d0
	move.w	d0, 18(a2)
	bra	@L70
@L79:
	add.w	#-201, d2
	cmp.w	#73, d2
	bhi	@L63
	add.w	#-33, d3
	cmp.w	#43, d3
	bhi	@L63
	move.b	#120, 43(a2)
	move.b	#1, 44(a2)
	movem.l	(sp)+, d2/d3/a2
	rts	
@L64:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d3
	add.w	#32, d3
	move.w	d3, 12(a2)
	move.b	#1, 41(a2)
	move.w	#768, d1
	move.w	d0, d2
	sub.w	-2304.w, d2
	sub.w	-2300.w, d3
	move.w	18(a2), d0
	cmp.w	#239, d2
	bgt	@L67
	bra	@L86
@L84:
	clr.b	44(a2)
	movem.l	(sp)+, d2/d3/a2
	rts	
@L83:
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L80
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L76:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L77
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.b	43(a2), d0
	bne	@L63
	bra	@L79
@L80:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L76
@L77:
	move.b	43(a2), d0
	bne	@L63
	bra	@L79
	even
_ZN13ObjEggmanShip17script02_DefeatedEv:
	movem.l	d2/a2/a3/a4, -(sp)
	move.l	20(sp), a2
	move.b	41(a2), d0
	cmp.b	#1, d0
	beq	@L88
	cmp.b	#2, d0
	beq	@L89
	tst.b	d0
	beq	@L106
@L87:
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L106:
	move.b	#-76, 43(a2)
	clr.b	44(a2)
	move.b	#1, 41(a2)
@L88:
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	16(a2), d0
	move.w	-2304.w, d2
	add.w	#160, d2
	cmp.w	8(a2), d2
	bge	@L91
	cmp.w	#256, d0
	bgt	@L107
@L93:
	move.w	d0, 16(a2)
	move.w	18(a2), d0
	cmp.w	12(a2), d1
	bge	@L95
@L109:
	cmp.w	#-255, d0
	blt	@L97
	subq.w	#4, d0
@L97:
	move.w	d0, 18(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L108
@L100:
	move.b	43(a2), d0
	beq	@L102
	subq.b	#1, d0
	move.b	d0, 43(a2)
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L91:
	cmp.w	#1023, d0
	bgt	@L93
	add.w	#14, d0
	move.w	d0, 16(a2)
	move.w	18(a2), d0
	cmp.w	12(a2), d1
	blt	@L109
@L95:
	cmp.w	#255, d0
	bgt	@L97
	addq.w	#4, d0
	move.w	d0, 18(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	bne	@L100
	bra	@L108
@L89:
	add.w	#32, 16(a2)
	add.w	#-18, 18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L87
	clr.w	8(a2)
	clr.w	12(a2)
	move.w	#129, -(sp)
	jsr	playSound__cdecl
	addq.b	#2, v_dle_routine
	addq.b	#1, 41(a2)
	addq.l	#2, sp
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L102:
	move.b	#120, 43(a2)
	move.w	#256, 16(a2)
	move.w	#768, 18(a2)
	addq.b	#1, 41(a2)
	movem.l	(sp)+, d2/a2/a3/a4
	rts	
@L108:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L100
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
	bra	@L100
@L107:
	add.w	#-14, d0
	bra	@L93
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
	beq	@L110
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L110:
	move.l	(sp)+, a2
	rts	
	even
executeMasterScript_ObjEggmanShip:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	move.b	40(a2), d0
	cmp.b	#1, d0
	beq	@L115
	cmp.b	#2, d0
	beq	@L116
	tst.b	d0
	beq	@L129
	illegal	
	move.l	(sp)+, a2
	rts	
@L115:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip22script01_ThrowSequenceEv
	addq.l	#4, sp
@L118:
	tst.b	32(a2)
	bne	@L119
	move.b	42(a2), d0
	beq	@L130
	subq.b	#1, d0
	move.b	d0, 42(a2)
	bne	@L122
	move.b	#15, 32(a2)
@L119:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L131:
	move.l	(sp)+, a2
	rts	
@L129:
	move.l	a2, -(sp)
	jsr	_ZN13ObjEggmanShip14script00_IntroEv
	addq.l	#4, sp
	bra	@L118
@L116:
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
	bra	@L131
@L130:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L132
	move.b	#32, 42(a2)
@L122:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L124
	clr.w	d0
@L124:
	move.w	d0, -1246.w
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L131
@L132:
	move.w	#512, 40(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L131
