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
	bne	@L19
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
	ble	@L21
@L19:
	move.b	28(a2), d0
@L22:
	cmp.b	#1, d0
	beq	@L64
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
	bge	@L65
@L53:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L66
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
@L9:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L64
@L8:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L64
@L5:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L48
	bra	@L64
@L3:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L46
@L11:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#139, -(sp)
	jsr	playSound__cdecl
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	addq.l	#2, sp
	bpl	@L12
@L13:
	cmp.b	#-128, d2
	beq	@L15
	cmp.b	#-127, d2
	bne	@L10
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d2
	cmp.b	(a1, d1.l), d2
	bls	@L18
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L13
@L12:
	move.b	d2, 36(a2)
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
	bra	@L21
@L7:
	move.b	37(a2), d1
	beq	@L29
	cmp.b	#1, d1
	bne	@L30
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
	bne	@L33
	swap	d2
	ext.l	d2
	cmp.w	#9344, d2
	ble	@L36
	moveq	#5, d1
@L36:
	move.b	d1, 36(a2)
	clr.b	37(a2)
@L33:
	cmp.b	#1, d0
	bne	@L48
@L56:
	moveq	#7, d0
@L49:
	and.w	v_framecount, d0
	bne	@L48
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L48
@L6:
	move.b	37(a2), d0
	beq	@L37
	cmp.b	#1, d0
	beq	@L67
@L30:
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L48
	bra	@L56
@L64:
	cmp.b	#2, 36(a2)
	bne	@L56
	moveq	#3, d0
	bra	@L49
@L51:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L46
	move.b	#11, 32(a2)
	bra	@L46
@L52:
	cmp.w	d1, d0
	bge	@L53
	cmp.w	#511, 16(a0)
	bgt	@L53
	move.w	#512, v_player+16
	bra	@L53
@L15:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L13
	bra	@L12
@L66:
	move.w	#1792, 36(a2)
	bra	@L46
@L21:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bpl	@L23
@L24:
	cmp.b	#-128, d2
	beq	@L25
	cmp.b	#-127, d2
	bne	@L19
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d3
	cmp.b	(a1, d1.l), d3
	bls	@L28
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L24
@L23:
	move.b	d2, 36(a2)
	clr.b	37(a2)
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L48
	bra	@L64
@L65:
	move.w	#-512, v_player+16
	bra	@L53
@L18:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L13
	bra	@L12
@L67:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.b	28(a2), d0
@L38:
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L33
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bpl	@L40
@L41:
	cmp.b	#-128, d3
	beq	@L42
	cmp.b	#-127, d3
	bne	@L33
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d3
	cmp.b	(a1, d2.l), d3
	bls	@L45
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L41
@L40:
	move.b	d3, 36(a2)
	clr.b	37(a2)
	cmp.b	#1, d0
	bne	@L48
	bra	@L64
@L25:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
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
@L37:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d1
	bra	@L38
@L28:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L24
	bra	@L23
@L42:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L41
	bra	@L40
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
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L41
	bra	@L40
	even
_ZN13ObjPlasmaBoss23setNextActionFromScriptEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	45(a0), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bpl	@L69
@L70:
	cmp.b	#-128, d2
	beq	@L72
	cmp.b	#-127, d2
	bne	@L68
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d1
	move.b	33(a0), d2
	cmp.b	(a2, d1.l), d2
	bls	@L75
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a2, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L70
@L69:
	move.b	d2, 36(a0)
	clr.b	37(a0)
@L68:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L72:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L70
	bra	@L69
@L75:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L70
	bra	@L69
	even
_ZN13ObjPlasmaBoss12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L79
	move.b	44(a2), d0
	beq	@L89
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L79
	move.b	#11, 32(a2)
@L79:
	move.l	(sp)+, a2
	rts	
@L89:
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L83
	cmp.w	#-511, 16(a0)
	blt	@L84
	move.w	#-512, v_player+16
@L84:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L90
	move.b	#32, 44(a2)
	move.l	(sp)+, a2
	rts	
@L83:
	cmp.w	d1, d0
	bge	@L84
	cmp.w	#511, 16(a0)
	bgt	@L84
	move.w	#512, v_player+16
	bra	@L84
@L90:
	move.w	#1792, 36(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L92
	cmp.b	#1, d0
	beq	@L105
@L91:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L105:
	move.w	16(a0), d0
	ext.l	d0
	lsl.l	#8, d0
@L94:
	add.l	8(a0), d0
	move.l	d0, 8(a0)
	move.w	18(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a0)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L91
	move.w	#9480, 8(a0)
	clr.w	16(a0)
	move.b	45(a0), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bpl	@L96
@L97:
	cmp.b	#-128, d2
	beq	@L98
	cmp.b	#-127, d2
	bne	@L91
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d1
	move.b	33(a0), d2
	cmp.b	(a2, d1.l), d2
	bls	@L101
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a2, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L97
@L96:
	move.b	d2, 36(a0)
	clr.b	37(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L92:
	clr.b	28(a0)
	and.b	#-2, 1(a0)
	and.b	#-2, 34(a0)
	move.w	#9536, 8(a0)
	move.w	#1440, 12(a0)
	move.w	#-192, 16(a0)
	move.b	#1, 37(a0)
	move.l	#-49152, d0
	bra	@L94
@L98:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L97
	bra	@L96
@L101:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L97
	bra	@L96
	even
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L107
	cmp.b	#1, d0
	beq	@L108
@L106:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L108:
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L110
@L111:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L106
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bpl	@L115
@L116:
	cmp.b	#-128, d2
	beq	@L117
	cmp.b	#-127, d2
	bne	@L106
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d2
	cmp.b	(a1, d1.l), d2
	bls	@L120
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L116
@L115:
	move.b	d2, 36(a2)
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L107:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	#180, d0
@L110:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L124
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L117:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L116
	bra	@L115
@L124:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L125
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
	moveq	#15, d2
	lsl.l	d2, d1
	add.l	12(a2), d1
	move.l	d1, 12(a3)
	move.w	40(a2), d0
	addq.l	#4, sp
	bra	@L111
@L120:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L116
	bra	@L115
@L125:
	move.w	40(a2), d0
	bra	@L111
	even
_ZN13ObjPlasmaBoss23action03_VerticalAttackEv:
	movem.l	d2/d3/d4/a2/a3, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L127
	cmp.b	#2, d0
	beq	@L128
	tst.b	d0
	bne	@L126
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	and.w	#1, d0
	neg.w	d0
	and.w	#32, d0
	add.w	#1504, d0
	move.w	d0, 42(a2)
	move.w	12(a2), d2
	move.w	#-256, d1
	cmp.w	d0, d2
	bge	@L132
	move.w	#256, d1
@L132:
	move.w	d1, 18(a2)
	cmp.b	#3, 33(a2)
	bls	@L163
	moveq	#60, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
@L131:
	cmp.w	d2, d0
	beq	@L134
@L181:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L126:
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L128:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L126
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bpl	@L156
@L157:
	cmp.b	#-128, d2
	beq	@L158
	cmp.b	#-127, d2
	bne	@L126
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d2
	cmp.b	(a1, d1.l), d2
	bls	@L161
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L157
@L156:
	move.b	d2, 36(a2)
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L127:
	move.w	12(a2), d2
	move.w	42(a2), d0
	cmp.w	d2, d0
	bne	@L181
@L134:
	move.w	40(a2), d0
	beq	@L136
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L163:
	moveq	#30, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L131
@L136:
	move.b	#1, 28(a2)
	move.w	8(a2), d0
	move.w	d2, d3
	add.w	#-48, d3
	cmp.w	#1407, d3
	ble	@L182
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d4
	moveq	#8, d2
	cmp.w	#9343, d0
	ble	@L140
@L143:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L141
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	cmp.b	#3, 33(a2)
	bhi	@L164
	move.w	d2, d0
	move.w	d0, 52(a0)
@L141:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L143
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L152
@L139:
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d4
	moveq	#8, d3
@L151:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L149
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	cmp.b	#3, 33(a2)
	bhi	@L167
	move.w	d3, d0
	move.w	d0, 52(a0)
@L149:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L151
@L152:
	cmp.b	#3, 33(a2)
	bls	@L166
	moveq	#120, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
@L184:
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L165:
	move.w	d4, d0
	move.w	d0, 52(a0)
@L145:
	add.w	#-24, d3
	cmp.w	#1407, d3
	ble	@L183
@L140:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L145
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L165
	move.w	d2, d0
	move.w	d0, 52(a0)
	bra	@L145
@L164:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L141
@L158:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L157
	bra	@L156
@L183:
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L152
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d4
	moveq	#8, d3
@L155:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L153
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L168
	move.w	d3, d0
	move.w	d0, 52(a0)
@L153:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L155
	bra	@L152
@L161:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L157
	bra	@L156
@L168:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L153
@L167:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L149
@L166:
	moveq	#60, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L184
@L182:
	add.w	#48, d2
	cmp.w	#9343, d0
	bgt	@L139
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d4
	moveq	#8, d3
	bra	@L155
	even
_ZN13ObjPlasmaBoss23action04_ChangePositionEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L186
	cmp.b	#1, d0
	bne	@L185
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
	bne	@L185
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L190
	moveq	#5, d0
@L190:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L185:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L186:
	cmp.w	#9344, 8(a0)
	ble	@L191
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
@L194:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L191:
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
	bra	@L194
	even
_ZN13ObjPlasmaBoss18action05_EnterLeftEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L196
	cmp.b	#1, d0
	beq	@L209
@L195:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L209:
	move.w	16(a0), d0
	ext.l	d0
	lsl.l	#8, d0
@L198:
	add.l	8(a0), d0
	move.l	d0, 8(a0)
	move.w	18(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a0)
	swap	d0
	ext.l	d0
	cmp.w	#9207, d0
	ble	@L195
	move.w	#9208, 8(a0)
	clr.w	16(a0)
	move.b	45(a0), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bpl	@L200
@L201:
	cmp.b	#-128, d2
	beq	@L202
	cmp.b	#-127, d2
	bne	@L195
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	and.l	#255, d1
	move.b	33(a0), d2
	cmp.b	(a2, d1.l), d2
	bls	@L205
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a2, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L201
@L200:
	move.b	d2, 36(a0)
	clr.b	37(a0)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L196:
	clr.b	28(a0)
	or.b	#1, 1(a0)
	or.b	#1, 34(a0)
	move.w	#9152, 8(a0)
	move.w	#1440, 12(a0)
	move.w	#192, 16(a0)
	move.b	#1, 37(a0)
	move.l	#49152, d0
	bra	@L198
@L202:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a2
	move.b	(a2, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L201
	bra	@L200
@L205:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a0)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a1, d2.l), d2
	bmi	@L201
	bra	@L200
	even
_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv:
	movem.l	d2/d3/d4/a2/a3, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L211
	cmp.b	#2, d0
	beq	@L212
	tst.b	d0
	bne	@L210
	move.w	12(a2), d0
	cmp.w	#1439, d0
	ble	@L236
	move.w	#-256, 18(a2)
	clr.b	28(a2)
	move.w	#60, 40(a2)
	move.b	#1, 37(a2)
	cmp.w	#1440, d0
	bne	@L232
	moveq	#59, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
@L210:
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L212:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L210
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bpl	@L226
@L227:
	cmp.b	#-128, d2
	beq	@L228
	cmp.b	#-127, d2
	bne	@L210
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d2
	cmp.b	(a1, d1.l), d2
	bls	@L231
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L227
@L226:
	move.b	d2, 36(a2)
	clr.b	37(a2)
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L211:
	move.w	12(a2), d3
	cmp.w	#1440, d3
	beq	@L217
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L237:
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L236:
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
	bra	@L237
@L217:
	move.w	40(a2), d2
	bne	@L238
	move.b	#1, 28(a2)
	cmp.w	#9343, 8(a2)
	bgt	@L239
	move.w	#510, 40(a2)
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L222:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L225
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
@L225:
	add.w	#24, d2
	add.w	#60, d4
	cmp.w	#168, d2
	beq	@L224
	move.w	12(a2), d3
	bra	@L222
@L228:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L227
	bra	@L226
@L239:
	move.w	#330, 40(a2)
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L221:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L223
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	add.w	#24, d3
	add.w	d2, d3
	move.w	d3, 48(a0)
	move.w	d4, 52(a0)
@L223:
	add.w	#24, d2
	add.w	#30, d4
	cmp.w	#168, d2
	beq	@L224
	move.w	12(a2), d3
	bra	@L221
@L231:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L227
	bra	@L226
@L224:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/d4/a2/a3
	rts	
@L232:
	moveq	#-1, d1
	not.w	d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L237
@L238:
	subq.w	#1, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
	bra	@L210
	even
_ZN13ObjPlasmaBoss17action07_DefeatedEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L241
	cmp.b	#2, d0
	beq	@L242
	tst.b	d0
	bne	@L240
	clr.w	16(a2)
	clr.w	18(a2)
	move.w	#180, 40(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
@L241:
	move.w	v_framecount, d0
	move.w	d0, d1
	and.w	#7, d1
	beq	@L253
	moveq	#7, d2
	and.l	d2, d0
	subq.l	#4, d0
	beq	@L254
@L246:
	move.w	40(a2), d0
	beq	@L248
	subq.w	#1, d0
	move.w	d0, 40(a2)
@L240:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L242:
	clr.w	8(a2)
	clr.w	12(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L248:
	move.w	18(a2), d0
	cmp.w	#-383, d0
	blt	@L249
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L249:
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
	bgt	@L240
	clr.w	18(a2)
	jsr	findFreeObj__cdecl
	tst.l	d0
	beq	@L250
	move.l	d0, a1
	move.b	#-123, (a1)
@L250:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L254:
	move.w	#3, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L246
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
	bra	@L246
@L253:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L246
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
	bra	@L246
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
	bhi	@L257
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L260(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L260:
	dc.w	@L267-@L260
	dc.w	@L266-@L260
	dc.w	@L265-@L260
	dc.w	@L264-@L260
	dc.w	@L263-@L260
	dc.w	@L262-@L260
	dc.w	@L261-@L260
	dc.w	@L259-@L260
@L257:
	movem.l	(sp)+, d2/d3/d4/a2
	rts	
@L266:
	move.b	37(a2), d0
	beq	@L270
	cmp.b	#1, d0
	bne	@L275
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
	ble	@L277
@L275:
	move.b	28(a2), d0
@L278:
	cmp.b	#1, d0
	beq	@L320
@L304:
	tst.b	32(a2)
	bne	@L302
	move.b	44(a2), d0
	bne	@L307
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L308
	cmp.w	#-511, 16(a0)
	bge	@L321
@L309:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L322
	move.b	#32, 44(a2)
@L302:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L257
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L265:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L304
	bra	@L320
@L264:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L304
	bra	@L320
@L261:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	move.b	28(a2), d0
	addq.l	#4, sp
	cmp.b	#1, d0
	bne	@L304
	bra	@L320
@L259:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L302
@L267:
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#139, -(sp)
	jsr	playSound__cdecl
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	addq.l	#2, sp
	bpl	@L268
@L269:
	cmp.b	#-128, d2
	beq	@L271
	cmp.b	#-127, d2
	bne	@L266
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d2
	cmp.b	(a1, d1.l), d2
	bls	@L274
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L269
@L268:
	move.b	d2, 36(a2)
@L270:
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
	bgt	@L275
	bra	@L277
@L263:
	move.b	37(a2), d1
	beq	@L285
	cmp.b	#1, d1
	bne	@L286
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
	bne	@L289
	swap	d2
	ext.l	d2
	cmp.w	#9344, d2
	ble	@L292
	moveq	#5, d1
@L292:
	move.b	d1, 36(a2)
	clr.b	37(a2)
@L289:
	cmp.b	#1, d0
	bne	@L304
@L312:
	moveq	#7, d0
@L305:
	and.w	v_framecount, d0
	bne	@L304
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L304
@L262:
	move.b	37(a2), d0
	beq	@L293
	cmp.b	#1, d0
	beq	@L323
@L286:
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L304
	bra	@L312
@L320:
	cmp.b	#2, 36(a2)
	bne	@L312
	moveq	#3, d0
	bra	@L305
@L307:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L302
	move.b	#11, 32(a2)
	bra	@L302
@L308:
	cmp.w	d1, d0
	bge	@L309
	cmp.w	#511, 16(a0)
	bgt	@L309
	move.w	#512, v_player+16
	bra	@L309
@L271:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L269
	bra	@L268
@L322:
	move.w	#1792, 36(a2)
	bra	@L302
@L277:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bpl	@L279
@L280:
	cmp.b	#-128, d2
	beq	@L281
	cmp.b	#-127, d2
	bne	@L275
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d1
	move.b	33(a2), d3
	cmp.b	(a1, d1.l), d3
	bls	@L284
	addq.b	#2, d0
	and.l	#255, d0
	move.b	(a1, d0.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L280
@L279:
	move.b	d2, 36(a2)
	clr.b	37(a2)
	move.b	28(a2), d0
	cmp.b	#1, d0
	bne	@L304
	bra	@L320
@L321:
	move.w	#-512, v_player+16
	bra	@L309
@L274:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L269
	bra	@L268
@L323:
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.b	28(a2), d0
@L294:
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	swap	d1
	ext.l	d1
	cmp.w	#9207, d1
	ble	@L289
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.b	45(a2), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bpl	@L296
@L297:
	cmp.b	#-128, d3
	beq	@L298
	cmp.b	#-127, d3
	bne	@L289
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	and.l	#255, d2
	move.b	33(a2), d3
	cmp.b	(a1, d2.l), d3
	bls	@L301
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a1, d1.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L297
@L296:
	move.b	d3, 36(a2)
	clr.b	37(a2)
	cmp.b	#1, d0
	bne	@L304
	bra	@L320
@L281:
	and.l	#255, d1
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d1.l), d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L280
	bra	@L279
@L285:
	cmp.w	#9344, 8(a2)
	ble	@L313
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
	bra	@L304
@L293:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d1
	bra	@L294
@L284:
	addq.b	#3, d0
	move.b	d0, d1
	addq.b	#1, d1
	move.b	d1, 45(a2)
	moveq	#0, d2
	move.b	d0, d2
	move.b	(a0, d2.l), d2
	bmi	@L280
	bra	@L279
@L298:
	and.l	#255, d2
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a1
	move.b	(a1, d2.l), d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L297
	bra	@L296
@L313:
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
	bra	@L304
@L301:
	addq.b	#3, d1
	move.b	d1, d2
	addq.b	#1, d2
	move.b	d2, 45(a2)
	moveq	#0, d3
	move.b	d1, d3
	move.b	(a0, d3.l), d3
	bmi	@L297
	bra	@L296
