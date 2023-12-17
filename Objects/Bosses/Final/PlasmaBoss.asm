	even
_ZN13ObjPlasmaBoss10cameraBaseE:
	dc.w	9184
	dc.w	1408
_ZN13ObjPlasmaBoss12actionScriptE:
	dc.b	$1, $2, $3, $3, $3, $81, $a, $2, $6, $4, $3, $3, $3, $6, $4, $3
	dc.b	$3, $3, $81, $8, $8, $6, $4, $3, $3, $3, $3, $3, $3, $6, $4, $3
	dc.b	$3, $3, $3, $3, $80, $8
	even
_ZN13ObjPlasmaBoss7executeEv:
	movem.l	d2/d3/d4/a2, -(sp)
	move.l	20(sp), a2
	cmp.b	#7, 36(a2)
	bhi	@L1
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L4(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L4:
	dc.w	@L11-@L4
	dc.w	@L10-@L4
	dc.w	@L9-@L4
	dc.w	@L8-@L4
	dc.w	@L7-@L4
	dc.w	@L6-@L4
	dc.w	@L5-@L4
	dc.w	@L3-@L4
@L1:
	movem.l	(sp)+, d2/d3/d4/a2
	rts	
@L10:
	move.b	37(a2), d0
	beq	@L14
	cmp.b	#1, d0
	beq	@L65
@L19:
	move.b	28(a2), d0
@L22:
	cmp.b	#1, d0
	beq	@L66
@L48:
	tst.b	32(a2)
	bne	@L46
	move.b	44(a2), d0
	bne	@L51
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L52
	cmp.w	#-511, 16(a0)
	bge	@L67
@L53:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L68
	move.b	#32, 44(a2)
@L46:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L1
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L66:
	cmp.b	#2, 36(a2)
	beq	@L58
	moveq	#7, d0
@L49:
	and.w	v_framecount, d0
	bne	@L48
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L48
@L51:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L46
	move.b	#11, 32(a2)
	bra	@L46
@L9:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L66
@L8:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L66
@L7:
	move.b	37(a2), d1
	beq	@L29
	cmp.b	#1, d1
	bne	@L19
	move.w	40(a2), d4
	subq.w	#1, d4
	move.b	28(a2), d0
	move.w	16(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	8(a2), d2
	move.l	d2, 8(a2)
	move.w	18(a2), d3
	ext.l	d3
	lsl.l	#8, d3
	add.l	d3, 12(a2)
	move.w	d4, 40(a2)
	bne	@L62
	swap	d2
	ext.l	d2
	cmp.w	#9344, d2
	ble	@L35
	moveq	#5, d1
@L35:
	move.b	d1, 36(a2)
	clr.b	37(a2)
@L62:
	cmp.b	#1, d0
	bne	@L48
	moveq	#7, d0
	bra	@L49
@L6:
	move.b	37(a2), d0
	beq	@L36
	cmp.b	#1, d0
	bne	@L19
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.b	28(a2), d0
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L62
@L69:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bpl	@L39
@L40:
	cmp.b	#-128, d1
	beq	@L41
	cmp.b	#-127, d1
	bne	@L62
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d3
	move.b	33(a2), d1
	cmp.b	(a1, d3.l), d1
	bls	@L45
	addq.b	#2, d2
	and.l	#255, d2
	move.b	(a1, d2.l), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L40
@L39:
	move.b	d1, 36(a2)
	clr.b	37(a2)
	cmp.b	#1, d0
	bne	@L48
	bra	@L66
@L3:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L46
@L5:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L66
@L11:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#139, -(sp)
	jsr	playSound__cdecl
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	addq.l	#2, sp
	bpl	@L12
@L13:
	cmp.b	#-128, d0
	beq	@L15
	cmp.b	#-127, d0
	bne	@L10
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L18
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L13
@L12:
	move.b	d0, 36(a2)
@L14:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L19
@L21:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bpl	@L23
@L24:
	cmp.b	#-128, d0
	beq	@L25
	cmp.b	#-127, d0
	bne	@L19
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L28
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L24
@L23:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L48
	bra	@L66
@L65:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L19
	bra	@L21
@L58:
	moveq	#3, d0
	bra	@L49
@L52:
	cmp.w	d1, d0
	bge	@L53
	cmp.w	#511, 16(a0)
	bgt	@L53
	move.w	#512, v_player+16
	bra	@L53
@L15:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L13
	bra	@L12
@L68:
	move.w	#1792, 36(a2)
	bra	@L46
@L67:
	move.w	#-512, v_player+16
	bra	@L53
@L18:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L13
	bra	@L12
@L25:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L24
	bra	@L23
@L29:
	cmp.w	#9344, 8(a2)
	ble	@L57
	move.l	#98304, d0
	move.w	#384, d1
	move.w	d1, 16(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.w	#59, 40(a2)
	bra	@L48
@L36:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L62
	bra	@L69
@L28:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L24
	bra	@L23
@L41:
	and.l	#255, d3
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d3.l), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L40
	bra	@L39
@L57:
	move.l	#-98304, d0
	move.w	#-384, d1
	move.w	d1, 16(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.w	#59, 40(a2)
	bra	@L48
@L45:
	addq.b	#3, d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L40
	bra	@L39
	even
_ZN13ObjPlasmaBoss23setNextActionFromScriptEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	45(a0), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bpl	@L71
@L72:
	cmp.b	#-128, d0
	beq	@L74
	cmp.b	#-127, d0
	bne	@L70
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d2
	move.b	33(a0), d0
	cmp.b	(a2, d2.l), d0
	bls	@L77
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a2, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L72
@L71:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L70:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L74:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L72
	bra	@L71
@L77:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L72
	bra	@L71
	even
_ZN13ObjPlasmaBoss12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L81
	move.b	44(a2), d0
	beq	@L91
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L81
	move.b	#11, 32(a2)
@L81:
	move.l	(sp)+, a2
	rts	
@L91:
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L85
	cmp.w	#-511, 16(a0)
	blt	@L86
	move.w	#-512, v_player+16
@L86:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L92
	move.b	#32, 44(a2)
	move.l	(sp)+, a2
	rts	
@L85:
	cmp.w	d1, d0
	bge	@L86
	cmp.w	#511, 16(a0)
	bgt	@L86
	move.w	#512, v_player+16
	bra	@L86
@L92:
	move.w	#1792, 36(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L94
	cmp.b	#1, d0
	bne	@L93
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
	cmp.w	#9480, d0
	ble	@L107
@L93:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L107:
	move.w	#9480, 8(a0)
	clr.w	16(a0)
	move.b	45(a0), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bpl	@L98
@L99:
	cmp.b	#-128, d0
	beq	@L100
	cmp.b	#-127, d0
	bne	@L93
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d2
	move.b	33(a0), d0
	cmp.b	(a2, d2.l), d0
	bls	@L103
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a2, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L99
@L98:
	move.b	d0, 36(a0)
	clr.b	37(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L94:
	clr.b	28(a0)
	and.b	#-2, 1(a0)
	and.b	#-2, 34(a0)
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
	cmp.w	#9480, d0
	bgt	@L93
	bra	@L107
@L103:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L99
	bra	@L98
@L100:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L99
	bra	@L98
	even
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L109
	cmp.b	#1, d0
	bne	@L108
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L127
@L114:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L108
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bpl	@L117
@L118:
	cmp.b	#-128, d0
	beq	@L119
	cmp.b	#-127, d0
	bne	@L108
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L122
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L118
@L117:
	move.b	d0, 36(a2)
	clr.b	37(a2)
@L108:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L109:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L112
	move.w	#179, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L122:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L118
	bra	@L117
@L119:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L118
	bra	@L117
@L112:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L128
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
	bra	@L114
@L128:
	move.w	40(a2), d0
	bra	@L114
@L127:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L112
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
	even
_ZN13ObjPlasmaBoss23action03_VerticalAttackEv:
	movem.l	d2/d3/d4/d5/a2/a3, -(sp)
	move.l	28(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L130
	cmp.b	#2, d0
	beq	@L131
	tst.b	d0
	beq	@L186
@L129:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L186:
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	and.w	#1, d0
	lsl.w	#5, d0
	add.w	#1504, d0
	move.w	d0, 42(a2)
	move.w	12(a2), d2
	move.w	#-256, d1
	cmp.w	d0, d2
	bge	@L135
	move.w	#256, d1
@L135:
	move.w	d1, 18(a2)
	cmp.b	#3, 33(a2)
	bls	@L168
	moveq	#60, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
@L134:
	cmp.w	d2, d0
	beq	@L137
@L187:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L131:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L129
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bpl	@L159
@L160:
	cmp.b	#-128, d0
	beq	@L161
	cmp.b	#-127, d0
	bne	@L129
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L164
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L160
@L159:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L130:
	move.w	12(a2), d2
	move.w	42(a2), d0
	cmp.w	d2, d0
	bne	@L187
@L137:
	move.w	40(a2), d0
	beq	@L139
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L168:
	moveq	#30, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L134
@L139:
	move.b	#1, 28(a2)
	move.w	8(a2), d0
	move.w	d2, d3
	add.w	#-48, d3
	cmp.w	#1407, d3
	ble	@L188
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d4
	moveq	#8, d2
	cmp.w	#9343, d0
	ble	@L143
@L146:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L144
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	cmp.b	#3, 33(a2)
	bhi	@L169
	move.w	d2, d0
	move.w	d0, 52(a0)
@L144:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L146
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L155
	move.l	a2, d3
@L142:
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
@L154:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L152
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	cmp.b	#3, 33(a2)
	bhi	@L172
	move.w	d4, d0
	move.w	d0, 52(a0)
@L152:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L154
@L155:
	cmp.b	#3, 33(a2)
	bls	@L171
	moveq	#120, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
@L190:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L170:
	move.w	d4, d0
	move.w	d0, 52(a0)
@L148:
	add.w	#-24, d3
	cmp.w	#1407, d3
	ble	@L189
@L143:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L148
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L170
	move.w	d2, d0
	move.w	d0, 52(a0)
	bra	@L148
@L169:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L144
@L161:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L160
	bra	@L159
@L189:
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L155
	move.l	a2, d3
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
@L158:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L156
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L173
	move.w	d4, d0
	move.w	d0, 52(a0)
@L156:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L158
	bra	@L155
@L164:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L160
	bra	@L159
@L173:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L156
@L172:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L152
@L171:
	moveq	#60, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L190
@L188:
	add.w	#48, d2
	move.l	a2, d3
	cmp.w	#9343, d0
	bgt	@L142
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
	bra	@L158
	even
_ZN13ObjPlasmaBoss23action04_ChangePositionEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L192
	cmp.b	#1, d0
	bne	@L191
	move.w	40(a0), d3
	subq.w	#1, d3
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	8(a0), d1
	move.l	d1, 8(a0)
	move.w	18(a0), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a0)
	move.w	d3, 40(a0)
	bne	@L191
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L196
	moveq	#5, d0
@L196:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L191:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L192:
	cmp.w	#9344, 8(a0)
	ble	@L197
	move.l	#98304, d0
	move.w	#384, d1
	move.w	d1, 16(a0)
	clr.b	28(a0)
	move.b	#1, 37(a0)
	add.l	d0, 8(a0)
	move.w	18(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.w	#59, 40(a0)
@L200:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L197:
	move.l	#-98304, d0
	move.w	#-384, d1
	move.w	d1, 16(a0)
	clr.b	28(a0)
	move.b	#1, 37(a0)
	add.l	d0, 8(a0)
	move.w	18(a0), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.w	#59, 40(a0)
	bra	@L200
	even
_ZN13ObjPlasmaBoss18action05_EnterLeftEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L202
	cmp.b	#1, d0
	bne	@L201
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
	cmp.w	#9207, d0
	bgt	@L215
@L201:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L215:
	move.w	#9208, 8(a0)
	clr.w	16(a0)
	move.b	45(a0), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bpl	@L206
@L207:
	cmp.b	#-128, d0
	beq	@L208
	cmp.b	#-127, d0
	bne	@L201
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d2
	move.b	33(a0), d0
	cmp.b	(a2, d2.l), d0
	bls	@L211
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a2, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L207
@L206:
	move.b	d0, 36(a0)
	clr.b	37(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L202:
	clr.b	28(a0)
	or.b	#1, 1(a0)
	or.b	#1, 34(a0)
	move.w	#9152, 8(a0)
	move.w	#1440, 12(a0)
	move.w	#192, 16(a0)
	move.b	#1, 37(a0)
	move.l	#49152, d0
	add.l	8(a0), d0
	move.l	d0, 8(a0)
	move.w	18(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a0)
	swap	d0
	ext.l	d0
	cmp.w	#9207, d0
	ble	@L201
	bra	@L215
@L211:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L207
	bra	@L206
@L208:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a0)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a1, d0.l), d0
	bmi	@L207
	bra	@L206
	even
_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv:
	movem.l	d2/d3/d4/d5/a2/a3, -(sp)
	move.l	28(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L217
	cmp.b	#2, d0
	beq	@L218
	tst.b	d0
	beq	@L246
@L216:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L246:
	move.w	12(a2), d0
	cmp.w	#1439, d0
	ble	@L247
	move.w	#-256, 18(a2)
	clr.b	28(a2)
	move.w	#60, 40(a2)
	move.b	#1, 37(a2)
	cmp.w	#1440, d0
	bne	@L242
	moveq	#59, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
@L250:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L218:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L216
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bpl	@L236
@L237:
	cmp.b	#-128, d0
	beq	@L238
	cmp.b	#-127, d0
	bne	@L216
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L241
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L237
@L236:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L217:
	move.w	12(a2), d3
	cmp.w	#1440, d3
	beq	@L223
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L248:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L247:
	move.w	#256, 18(a2)
	clr.b	28(a2)
	move.w	#60, 40(a2)
	move.b	#1, 37(a2)
	moveq	#1, d1
	swap	d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L248
@L223:
	move.w	40(a2), d2
	bne	@L249
	move.b	#1, 28(a2)
	cmp.w	#9343, 8(a2)
	bgt	@L226
	move.w	#510, 40(a2)
	moveq	#60, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L229:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L235
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	add.w	#24, d3
	add.w	d2, d3
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	move.w	d4, 52(a0)
@L235:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L233
	move.w	12(a2), d3
	bra	@L229
@L238:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L237
	bra	@L236
@L226:
	move.w	#330, 40(a2)
	moveq	#30, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L234:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L232
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	add.w	#24, d3
	add.w	d2, d3
	move.w	d3, 48(a0)
	move.w	d4, 52(a0)
@L232:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L233
	move.w	12(a2), d3
	bra	@L234
@L241:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L237
	bra	@L236
@L233:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L242:
	moveq	#-1, d1
	not.w	d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L248
@L249:
	subq.w	#1, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
	bra	@L250
	even
_ZN13ObjPlasmaBoss17action07_DefeatedEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L252
	cmp.b	#2, d0
	beq	@L253
	tst.b	d0
	beq	@L264
@L251:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L264:
	clr.w	16(a2)
	clr.w	18(a2)
	move.w	#180, 40(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
@L252:
	move.w	v_framecount, d0
	move.w	d0, d1
	and.w	#7, d1
	beq	@L265
	moveq	#7, d2
	and.l	d2, d0
	subq.l	#4, d0
	beq	@L266
@L257:
	move.w	40(a2), d0
	beq	@L259
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L253:
	clr.w	8(a2)
	clr.w	12(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L259:
	move.w	18(a2), d0
	cmp.w	#-383, d0
	blt	@L260
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L260:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a2)
	ext.l	d0
	lsl.l	#8, d0
	add.l	12(a2), d0
	move.l	d0, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#1360, d0
	bgt	@L251
	clr.w	18(a2)
	jsr	findFreeObj__cdecl
	tst.l	d0
	beq	@L261
	move.l	d0, a1
	move.b	#-123, (a1)
@L261:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L266:
	move.w	#3, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L257
	jsr	randomNumber__cdecl
	move.l	d0, d3
	move.w	d0, d2
	and.w	#255, d2
	move.w	d2, -(sp)
	lea	calcSine__cdecl, a4
	jsr	(a4)
	move.w	d0, d2
	add.b	#64, d3
	and.w	#255, d3
	move.w	d3, -(sp)
	jsr	(a4)
	move.l	8(a2), a0
	move.l	12(a2), a1
	move.l	a0, 8(a3)
	move.l	a1, 12(a3)
	lsl.w	#2, d0
	move.w	d0, 16(a3)
	add.w	d2, d2
	add.w	d2, d2
	move.w	d2, 18(a3)
	addq.l	#4, sp
	bra	@L257
@L265:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L257
	jsr	randomNumber__cdecl
	move.l	d0, d2
	and.w	#255, d0
	move.w	d0, -(sp)
	lea	calcSine__cdecl, a4
	jsr	(a4)
	move.w	d0, d3
	add.b	#64, d2
	and.w	#255, d2
	move.w	d2, -(sp)
	jsr	(a4)
	move.b	#63, (a3)
	move.l	8(a2), d1
	move.l	12(a2), d2
	move.l	d1, 8(a3)
	move.l	d2, 12(a3)
	lsl.w	#1, d0
	move.w	d0, 16(a3)
	add.w	d3, d3
	move.w	d3, 18(a3)
	addq.l	#4, sp
	bra	@L257
	even
_ZN13ObjPlasmaBoss9setActionENS_6ActionE:
	move.l	4(sp), a0
	move.b	9(sp), 36(a0)
	clr.b	37(a0)
	rts	
	even
execute_ObjPlasmaBoss:
	movem.l	d2/d3/d4/a2, -(sp)
	move.l	20(sp), a2
	cmp.b	#7, 36(a2)
	bhi	@L269
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L272(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L272:
	dc.w	@L279-@L272
	dc.w	@L278-@L272
	dc.w	@L277-@L272
	dc.w	@L276-@L272
	dc.w	@L275-@L272
	dc.w	@L274-@L272
	dc.w	@L273-@L272
	dc.w	@L271-@L272
@L269:
	movem.l	(sp)+, d2/d3/d4/a2
	rts	
@L278:
	move.b	37(a2), d0
	beq	@L282
	cmp.b	#1, d0
	beq	@L333
@L287:
	move.b	28(a2), d0
@L290:
	cmp.b	#1, d0
	beq	@L334
@L316:
	tst.b	32(a2)
	bne	@L314
	move.b	44(a2), d0
	bne	@L319
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L320
	cmp.w	#-511, 16(a0)
	bge	@L335
@L321:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L336
	move.b	#32, 44(a2)
@L314:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L269
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L334:
	cmp.b	#2, 36(a2)
	beq	@L326
	moveq	#7, d0
@L317:
	and.w	v_framecount, d0
	bne	@L316
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L316
@L319:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L314
	move.b	#11, 32(a2)
	bra	@L314
@L277:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L316
	bra	@L334
@L276:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L316
	bra	@L334
@L275:
	move.b	37(a2), d1
	beq	@L297
	cmp.b	#1, d1
	bne	@L287
	move.w	40(a2), d4
	subq.w	#1, d4
	move.b	28(a2), d0
	move.w	16(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	8(a2), d2
	move.l	d2, 8(a2)
	move.w	18(a2), d3
	ext.l	d3
	lsl.l	#8, d3
	add.l	d3, 12(a2)
	move.w	d4, 40(a2)
	bne	@L330
	swap	d2
	ext.l	d2
	cmp.w	#9344, d2
	ble	@L303
	moveq	#5, d1
@L303:
	move.b	d1, 36(a2)
	clr.b	37(a2)
@L330:
	cmp.b	#1, d0
	bne	@L316
	moveq	#7, d0
	bra	@L317
@L274:
	move.b	37(a2), d0
	beq	@L304
	cmp.b	#1, d0
	bne	@L287
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.b	28(a2), d0
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L330
@L337:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bpl	@L307
@L308:
	cmp.b	#-128, d1
	beq	@L309
	cmp.b	#-127, d1
	bne	@L330
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d3
	move.b	33(a2), d1
	cmp.b	(a1, d3.l), d1
	bls	@L313
	addq.b	#2, d2
	and.l	#255, d2
	move.b	(a1, d2.l), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L308
@L307:
	move.b	d1, 36(a2)
	clr.b	37(a2)
	cmp.b	#1, d0
	bne	@L316
	bra	@L334
@L271:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L314
@L273:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L316
	bra	@L334
@L279:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#139, -(sp)
	jsr	playSound__cdecl
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	addq.l	#2, sp
	bpl	@L280
@L281:
	cmp.b	#-128, d0
	beq	@L283
	cmp.b	#-127, d0
	bne	@L278
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L286
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L281
@L280:
	move.b	d0, 36(a2)
@L282:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L287
@L289:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bpl	@L291
@L292:
	cmp.b	#-128, d0
	beq	@L293
	cmp.b	#-127, d0
	bne	@L287
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d0
	cmp.b	(a1, d2.l), d0
	bls	@L296
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L292
@L291:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L316
	bra	@L334
@L333:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L287
	bra	@L289
@L326:
	moveq	#3, d0
	bra	@L317
@L320:
	cmp.w	d1, d0
	bge	@L321
	cmp.w	#511, 16(a0)
	bgt	@L321
	move.w	#512, v_player+16
	bra	@L321
@L283:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L281
	bra	@L280
@L336:
	move.w	#1792, 36(a2)
	bra	@L314
@L335:
	move.w	#-512, v_player+16
	bra	@L321
@L286:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L281
	bra	@L280
@L293:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L292
	bra	@L291
@L297:
	cmp.w	#9344, 8(a2)
	ble	@L325
	move.l	#98304, d0
	move.w	#384, d1
	move.w	d1, 16(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.w	#59, 40(a2)
	bra	@L316
@L304:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L330
	bra	@L337
@L296:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d0
	move.b	d1, d0
	move.b	(a0, d0.l), d0
	bmi	@L292
	bra	@L291
@L309:
	and.l	#255, d3
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d3.l), d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L308
	bra	@L307
@L325:
	move.l	#-98304, d0
	move.w	#-384, d1
	move.w	d1, 16(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	move.w	#59, 40(a2)
	bra	@L316
@L313:
	addq.b	#3, d2
	move.b	d2, d3
	addq.b	#1, d3
	move.b	d3, 45(a2)
	moveq	#0, d1
	move.b	d2, d1
	move.b	(a0, d1.l), d1
	bmi	@L308
	bra	@L307
