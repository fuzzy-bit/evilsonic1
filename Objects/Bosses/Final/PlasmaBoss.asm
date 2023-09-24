_ZN13ObjPlasmaBoss10cameraBaseE:
	dc.w	9184
	dc.w	1408
_ZN13ObjPlasmaBoss12actionScriptE:
	dc.b	$1, $2, $3, $3, $3, $81, $a, $2, $4, $3, $3, $4, $80, $2
	even
ObjectsBossesFinalPlasmaBoss_s__LC0:
	dc.b	"Initializing...", $e0, 0
	even
_ZN13ObjPlasmaBoss7executeEv:
	movem.l	d2/d3/a2, -(sp)
	move.l	16(sp), a2
	cmp.b	#5, 36(a2)
	bhi	@L1
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L4(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L4:
	dc.w	@L9-@L4
	dc.w	@L8-@L4
	dc.w	@L7-@L4
	dc.w	@L6-@L4
	dc.w	@L5-@L4
	dc.w	@L3-@L4
@L1:
	movem.l	(sp)+, d2/d3/a2
	rts	
@L9:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC0
	jsr	kwrite_cdecl
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2832, 32(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#8, sp
@L8:
	move.b	37(a2), d0
	beq	@L10
	cmp.b	#1, d0
	beq	@L32
@L12:
	tst.b	32(a2)
	bne	@L24
	move.b	44(a2), d0
	bne	@L25
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L26
	cmp.w	#-511, 16(a0)
	blt	@L27
	move.w	#-512, v_player+16
@L27:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L25:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L24
	move.b	#11, 32(a2)
@L24:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L1
	move.l	a2, 16(sp)
	movem.l	(sp)+, d2/d3/a2
	jmp	displaySprite__cdecl
@L7:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	bra	@L12
@L6:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	bra	@L12
@L5:
	move.b	37(a2), d0
	beq	@L15
	cmp.b	#1, d0
	bne	@L12
	move.w	40(a2), d3
	subq.w	#1, d3
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	move.w	d3, 40(a2)
	bne	@L12
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L20
	moveq	#5, d0
@L20:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	bra	@L12
@L3:
	move.b	37(a2), d0
	beq	@L21
	cmp.b	#1, d0
	bne	@L12
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
	cmp.w	#9215, d0
	ble	@L12
@L33:
	move.w	#9216, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	bra	@L12
@L32:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L13:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L12
	move.w	#9472, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	bra	@L12
@L26:
	cmp.w	d1, d0
	bge	@L27
	cmp.w	#511, 16(a0)
	bgt	@L27
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L25
@L10:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L13
@L15:
	cmp.w	#9344, 8(a2)
	ble	@L29
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
	bra	@L12
@L21:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9215, d0
	ble	@L12
	bra	@L33
@L29:
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
	bra	@L12
ObjectsBossesFinalPlasmaBoss_s__LC1:
	dc.b	"Setting action from script: pos=", $80, ", action=", $80, $e0, 0
	even
ObjectsBossesFinalPlasmaBoss_s__LC2:
	dc.b	"Unknown action script flag", 0
	even
_ZN13ObjPlasmaBoss23setNextActionFromScriptEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	45(a2), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	lea	_ZN13ObjPlasmaBoss12actionScriptE, a0
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bpl	@L35
	move.l	a0, a1
@L36:
	cmp.b	#-128, d2
	bne	@L47
	and.l	#255, d0
	move.b	(a0, d0.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L36
@L35:
	clr.w	d1
	move.b	d2, d1
	move.w	d1, -(sp)
	and.w	#255, d0
	subq.w	#1, d0
	move.w	d0, -(sp)
	pea	ObjectsBossesFinalPlasmaBoss_s__LC1
	jsr	kwrite_cdecl
	move.b	d2, 36(a2)
	clr.b	37(a2)
	addq.l	#8, sp
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L47:
	cmp.b	#-127, d2
	bne	@L48
	and.l	#255, d0
	move.b	33(a2), d2
	cmp.b	(a1, d0.l), d2
	bls	@L41
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a0, d1.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L36
	bra	@L35
@L41:
	addq.b	#3, d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L36
	bra	@L35
@L48:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC2
	jsr	raiseError__cdecl
_ZN13ObjPlasmaBoss12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L49
	move.b	44(a2), d0
	bne	@L52
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L53
	cmp.w	#-511, 16(a0)
	blt	@L54
	move.w	#-512, v_player+16
@L54:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L52:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L49
	move.b	#11, 32(a2)
@L49:
	move.l	(sp)+, a2
	rts	
@L53:
	cmp.w	d1, d0
	bge	@L54
	cmp.w	#511, 16(a0)
	bgt	@L54
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L52
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L59
	cmp.b	#1, d0
	bne	@L58
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
	cmp.w	#9472, d0
	ble	@L64
@L58:
	rts	
@L64:
	move.w	#9472, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L59:
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
	cmp.w	#9472, d0
	bgt	@L58
	bra	@L64
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L66
	cmp.b	#1, d0
	bne	@L65
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L76
@L71:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L65
	move.l	a2, 24(sp)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L66:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L69
	move.w	#179, 40(a2)
@L65:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L69:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L77
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
	bra	@L71
@L77:
	move.w	40(a2), d0
	bra	@L71
@L76:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L69
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
_ZN13ObjPlasmaBoss23action03_VerticalAttackEv:
	movem.l	d2/d3/a2/a3, -(sp)
	move.l	20(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L79
	cmp.b	#2, d0
	beq	@L80
	tst.b	d0
	beq	@L116
@L78:
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L116:
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	move.w	d0, d2
	and.w	#1, d2
	lsl.w	#5, d2
	add.w	#1504, d2
	move.w	d2, 42(a2)
	move.w	12(a2), d0
	cmp.w	d2, d0
	bge	@L84
	move.w	#256, 18(a2)
	move.w	#60, 40(a2)
	addq.b	#1, 37(a2)
@L85:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L80:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L78
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/a2/a3
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L79:
	move.w	12(a2), d0
	move.w	42(a2), d2
	cmp.w	d2, d0
	bne	@L85
@L86:
	move.w	40(a2), d0
	beq	@L87
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L84:
	move.w	#-256, 18(a2)
	move.w	#60, 40(a2)
	addq.b	#1, 37(a2)
	cmp.w	d2, d0
	beq	@L86
	bra	@L85
@L87:
	move.b	#1, 28(a2)
	move.w	8(a2), d0
	move.w	d2, d3
	add.w	#-48, d3
	cmp.w	#1407, d3
	ble	@L117
	lea	create_ObjPlasmaBall, a3
	cmp.w	#9343, d0
	ble	@L91
@L93:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L92
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
@L92:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L93
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L102
	move.l	a2, d3
@L90:
	lea	create_ObjPlasmaBall, a3
@L98:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L97
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
@L97:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L98
@L102:
	move.w	#120, 40(a2)
	addq.b	#1, 37(a2)
@L119:
	movem.l	(sp)+, d2/d3/a2/a3
	rts	
@L95:
	add.w	#-24, d3
	cmp.w	#1407, d3
	ble	@L118
@L91:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L95
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L91
@L118:
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L102
	move.l	a2, d3
	lea	create_ObjPlasmaBall, a3
@L101:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L100
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	or.b	#1, 34(a0)
@L100:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L101
	move.w	#120, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L119
@L117:
	add.w	#48, d2
	move.l	a2, d3
	cmp.w	#9343, d0
	bgt	@L90
	lea	create_ObjPlasmaBall, a3
	bra	@L101
_ZN13ObjPlasmaBoss23action04_ChangePositionEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L121
	cmp.b	#1, d0
	bne	@L120
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
	bne	@L120
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L125
	moveq	#5, d0
@L125:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L120:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L121:
	cmp.w	#9344, 8(a0)
	ble	@L126
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
@L129:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L126:
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
	bra	@L129
_ZN13ObjPlasmaBoss18action05_EnterLeftEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L131
	cmp.b	#1, d0
	bne	@L130
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
	cmp.w	#9215, d0
	bgt	@L136
@L130:
	rts	
@L136:
	move.w	#9216, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L131:
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
	cmp.w	#9215, d0
	ble	@L130
	bra	@L136
_ZN13ObjPlasmaBoss9setActionENS_6ActionE:
	move.l	4(sp), a0
	move.b	9(sp), 36(a0)
	clr.b	37(a0)
	rts	
execute_ObjPlasmaBoss:
	movem.l	d2/d3/a2, -(sp)
	move.l	16(sp), a2
	cmp.b	#5, 36(a2)
	bhi	@L139
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L142(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L142:
	dc.w	@L147-@L142
	dc.w	@L146-@L142
	dc.w	@L145-@L142
	dc.w	@L144-@L142
	dc.w	@L143-@L142
	dc.w	@L141-@L142
@L139:
	movem.l	(sp)+, d2/d3/a2
	rts	
@L147:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC0
	jsr	kwrite_cdecl
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2832, 32(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#8, sp
@L146:
	move.b	37(a2), d0
	beq	@L148
	cmp.b	#1, d0
	beq	@L170
@L150:
	tst.b	32(a2)
	bne	@L162
	move.b	44(a2), d0
	bne	@L163
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L164
	cmp.w	#-511, 16(a0)
	blt	@L165
	move.w	#-512, v_player+16
@L165:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L163:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L162
	move.b	#11, 32(a2)
@L162:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L139
	move.l	a2, 16(sp)
	movem.l	(sp)+, d2/d3/a2
	jmp	displaySprite__cdecl
@L145:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	bra	@L150
@L144:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	bra	@L150
@L143:
	move.b	37(a2), d0
	beq	@L153
	cmp.b	#1, d0
	bne	@L150
	move.w	40(a2), d3
	subq.w	#1, d3
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d2
	ext.l	d2
	lsl.l	#8, d2
	add.l	d2, 12(a2)
	move.w	d3, 40(a2)
	bne	@L150
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L158
	moveq	#5, d0
@L158:
	move.b	d0, 36(a2)
	clr.b	37(a2)
	bra	@L150
@L141:
	move.b	37(a2), d0
	beq	@L159
	cmp.b	#1, d0
	bne	@L150
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
	cmp.w	#9215, d0
	ble	@L150
@L171:
	move.w	#9216, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	bra	@L150
@L170:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L151:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9472, d0
	bgt	@L150
	move.w	#9472, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	bra	@L150
@L164:
	cmp.w	d1, d0
	bge	@L165
	cmp.w	#511, 16(a0)
	bgt	@L165
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L163
@L148:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L151
@L153:
	cmp.w	#9344, 8(a2)
	ble	@L167
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
	bra	@L150
@L159:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d0
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9215, d0
	ble	@L150
	bra	@L171
@L167:
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
	bra	@L150
