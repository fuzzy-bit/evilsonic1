	even
_ZN13ObjPlasmaBoss10cameraBaseE:
	dc.w	9184
	dc.w	1408
_ZN13ObjPlasmaBoss12actionScriptE:
	dc.b	$1, $2, $3, $3, $3, $81, $a, $2, $6, $4, $3, $3, $3, $6, $4, $3
	dc.b	$3, $3, $81, $8, $8, $6, $4, $3, $3, $3, $3, $3, $3, $6, $4, $3
	dc.b	$3, $3, $3, $3, $80, $8
ObjectsBossesFinalPlasmaBoss_s__LC0:
	dc.b	"Initializing...", $e0, 0
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
@L11:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC0
	jsr	kwrite_cdecl
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#140, -(sp)
	jsr	playSound__cdecl
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	lea	(10, sp), sp
@L10:
	move.b	37(a2), d0
	beq	@L12
	cmp.b	#1, d0
	beq	@L42
@L15:
	cmp.b	#1, 28(a2)
	beq	@L43
@L28:
	tst.b	32(a2)
	bne	@L26
	move.b	44(a2), d0
	bne	@L31
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L32
	cmp.w	#-511, 16(a0)
	bge	@L44
@L33:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L45
	move.b	#32, 44(a2)
@L26:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L1
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L43:
	cmp.b	#2, 36(a2)
	beq	@L38
	moveq	#7, d0
@L29:
	and.w	v_framecount, d0
	bne	@L28
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L28
@L31:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L26
	move.b	#11, 32(a2)
	bra	@L26
@L8:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L28
	bra	@L43
@L7:
	move.b	37(a2), d0
	beq	@L16
	cmp.b	#1, d0
	bne	@L15
	move.w	40(a2), d4
	subq.w	#1, d4
	move.b	28(a2), d2
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d3
	ext.l	d3
	lsl.l	#8, d3
	add.l	d3, 12(a2)
	move.w	d4, 40(a2)
	bne	@L25
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L21
	moveq	#5, d0
@L21:
	move.b	d0, 36(a2)
	clr.b	37(a2)
@L25:
	cmp.b	#1, d2
	bne	@L28
@L41:
	moveq	#7, d0
	bra	@L29
@L9:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L28
	bra	@L43
@L6:
	move.b	37(a2), d0
	beq	@L22
	cmp.b	#1, d0
	bne	@L15
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
	cmp.w	#9207, d0
	bgt	@L24
@L47:
	move.b	28(a2), d2
	cmp.b	#1, d2
	beq	@L41
	bra	@L28
@L5:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L28
	bra	@L43
@L3:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L26
@L42:
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
	bgt	@L15
@L46:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L28
	bra	@L43
@L38:
	moveq	#3, d0
	bra	@L29
@L12:
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
	bgt	@L15
	bra	@L46
@L32:
	cmp.w	d1, d0
	bge	@L33
	cmp.w	#511, 16(a0)
	bgt	@L33
	move.w	#512, v_player+16
	bra	@L33
@L45:
	move.w	#1792, 36(a2)
	bra	@L26
@L44:
	move.w	#-512, v_player+16
	bra	@L33
@L24:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L28
	bra	@L43
@L22:
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
	cmp.w	#9207, d0
	ble	@L47
	bra	@L24
@L16:
	cmp.w	#9344, 8(a2)
	ble	@L37
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
	bra	@L28
@L37:
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
	bra	@L28
ObjectsBossesFinalPlasmaBoss_s__LC1:
	dc.b	"Setting action from script: pos=", $80, ", action=", $80, $e0, 0
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
	bpl	@L49
	move.l	a0, a1
@L50:
	cmp.b	#-128, d2
	bne	@L61
	and.l	#255, d0
	move.b	(a0, d0.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L50
@L49:
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
@L61:
	cmp.b	#-127, d2
	bne	@L62
	and.l	#255, d0
	move.b	33(a2), d2
	cmp.b	(a1, d0.l), d2
	bls	@L55
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a0, d1.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L50
	bra	@L49
@L55:
	addq.b	#3, d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L50
	bra	@L49
@L62:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC2
	jsr	raiseError__cdecl
	even
_ZN13ObjPlasmaBoss12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L63
	move.b	44(a2), d0
	beq	@L73
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L63
	move.b	#11, 32(a2)
@L63:
	move.l	(sp)+, a2
	rts	
@L73:
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L67
	cmp.w	#-511, 16(a0)
	blt	@L68
	move.w	#-512, v_player+16
@L68:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L74
	move.b	#32, 44(a2)
	move.l	(sp)+, a2
	rts	
@L67:
	cmp.w	d1, d0
	bge	@L68
	cmp.w	#511, 16(a0)
	bgt	@L68
	move.w	#512, v_player+16
	bra	@L68
@L74:
	move.w	#1792, 36(a2)
	move.l	(sp)+, a2
	rts	
	even
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L76
	cmp.b	#1, d0
	bne	@L75
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
	ble	@L81
@L75:
	rts	
@L81:
	move.w	#9480, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L76:
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
	bgt	@L75
	bra	@L81
	even
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L83
	cmp.b	#1, d0
	bne	@L82
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L93
@L88:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L82
	move.l	a2, 24(sp)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L83:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L86
	move.w	#179, 40(a2)
@L82:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L86:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L94
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
	bra	@L88
@L94:
	move.w	40(a2), d0
	bra	@L88
@L93:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L86
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
	beq	@L96
	cmp.b	#2, d0
	beq	@L97
	tst.b	d0
	beq	@L145
@L95:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L145:
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	and.w	#1, d0
	lsl.w	#5, d0
	add.w	#1504, d0
	move.w	d0, 42(a2)
	move.w	12(a2), d2
	move.w	#-256, d1
	cmp.w	d0, d2
	bge	@L101
	move.w	#256, d1
@L101:
	move.w	d1, 18(a2)
	cmp.b	#3, 33(a2)
	bls	@L128
	moveq	#60, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
@L100:
	cmp.w	d2, d0
	beq	@L103
@L146:
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
@L97:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L95
	move.l	a2, 28(sp)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L96:
	move.w	12(a2), d2
	move.w	42(a2), d0
	cmp.w	d2, d0
	bne	@L146
@L103:
	move.w	40(a2), d0
	beq	@L104
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L128:
	moveq	#30, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L100
@L104:
	move.b	#1, 28(a2)
	move.w	8(a2), d0
	move.w	d2, d3
	add.w	#-48, d3
	cmp.w	#1407, d3
	ble	@L147
	lea	create_ObjPlasmaBall, a3
	cmp.w	#9343, d0
	ble	@L148
	moveq	#8, d4
	moveq	#30, d2
@L111:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L109
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	cmp.b	#3, 33(a2)
	bls	@L129
	move.w	d2, d0
	move.w	d0, 52(a0)
@L109:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L111
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L124
	move.l	a2, d3
@L107:
	lea	create_ObjPlasmaBall, a3
	moveq	#8, d5
	moveq	#30, d4
@L119:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L117
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	cmp.b	#3, 33(a2)
	bls	@L132
	move.w	d4, d0
	move.w	d0, 52(a0)
@L117:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L119
@L124:
	cmp.b	#3, 33(a2)
	bls	@L131
	moveq	#120, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
@L149:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L148:
	moveq	#30, d4
	moveq	#8, d2
@L108:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L113
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L130
	move.w	d2, d0
	move.w	d0, 52(a0)
@L113:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L108
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L124
	move.l	a2, d3
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
@L123:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L121
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d2, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L133
	move.w	d4, d0
	move.w	d0, 52(a0)
@L121:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L123
	bra	@L124
@L133:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L121
@L132:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L117
@L129:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L109
@L130:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L113
@L131:
	moveq	#60, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L149
@L147:
	add.w	#48, d2
	move.l	a2, d3
	cmp.w	#9343, d0
	bgt	@L107
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
	bra	@L123
	even
_ZN13ObjPlasmaBoss23action04_ChangePositionEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L151
	cmp.b	#1, d0
	bne	@L150
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
	bne	@L150
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L155
	moveq	#5, d0
@L155:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L150:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L151:
	cmp.w	#9344, 8(a0)
	ble	@L156
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
@L159:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L156:
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
	bra	@L159
	even
_ZN13ObjPlasmaBoss18action05_EnterLeftEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L161
	cmp.b	#1, d0
	bne	@L160
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
	bgt	@L166
@L160:
	rts	
@L166:
	move.w	#9208, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L161:
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
	ble	@L160
	bra	@L166
	even
_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv:
	movem.l	d2/d3/d4/d5/a2/a3, -(sp)
	move.l	28(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L168
	cmp.b	#2, d0
	beq	@L169
	tst.b	d0
	beq	@L189
@L167:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L189:
	move.w	12(a2), d0
	cmp.w	#1439, d0
	ble	@L190
	move.w	#-256, 18(a2)
	clr.b	28(a2)
	move.w	#60, 40(a2)
	move.b	#1, 37(a2)
	cmp.w	#1440, d0
	bne	@L186
	moveq	#59, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
@L193:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L169:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L167
	move.l	a2, 28(sp)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L168:
	move.w	12(a2), d3
	cmp.w	#1440, d3
	beq	@L174
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L191:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L190:
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
	bra	@L191
@L174:
	move.w	40(a2), d2
	bne	@L192
	move.b	#1, 28(a2)
	cmp.w	#9343, 8(a2)
	bgt	@L176
	move.w	#510, 40(a2)
	moveq	#60, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L179:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L185
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
@L185:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L183
	move.w	12(a2), d3
	bra	@L179
@L176:
	move.w	#330, 40(a2)
	moveq	#30, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L184:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L182
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	add.w	#24, d3
	add.w	d2, d3
	move.w	d3, 48(a0)
	move.w	d4, 52(a0)
@L182:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L183
	move.w	12(a2), d3
	bra	@L184
@L183:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L186:
	moveq	#-1, d1
	not.w	d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L191
@L192:
	subq.w	#1, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
	bra	@L193
ObjectsBossesFinalPlasmaBoss_s__LC3:
	dc.b	"xvel=", $89, ", yvel=", $89, $e0, 0
	even
_ZN13ObjPlasmaBoss17action07_DefeatedEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L195
	cmp.b	#2, d0
	beq	@L196
	tst.b	d0
	beq	@L207
@L194:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L207:
	clr.w	16(a2)
	clr.w	18(a2)
	move.w	#180, 40(a2)
	clr.b	28(a2)
	move.b	#1, 37(a2)
@L195:
	move.w	v_framecount, d0
	move.w	d0, d1
	and.w	#7, d1
	beq	@L208
	moveq	#7, d2
	and.l	d2, d0
	subq.l	#4, d0
	beq	@L209
@L200:
	move.w	40(a2), d0
	beq	@L202
	subq.w	#1, d0
	move.w	d0, 40(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L196:
	clr.w	8(a2)
	clr.w	12(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L202:
	move.w	18(a2), d0
	cmp.w	#-383, d0
	blt	@L203
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L203:
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
	bgt	@L194
	clr.w	18(a2)
	jsr	findFreeObj__cdecl
	tst.l	d0
	beq	@L204
	move.l	d0, a1
	move.b	#-123, (a1)
@L204:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L209:
	move.w	#3, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L200
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
	move.w	d2, -(sp)
	move.w	d0, -(sp)
	pea	ObjectsBossesFinalPlasmaBoss_s__LC3
	jsr	kwrite_cdecl
	lea	(12, sp), sp
	bra	@L200
@L208:
	jsr	findFreeObj__cdecl
	move.l	d0, a3
	tst.l	d0
	beq	@L200
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
	bra	@L200
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
	bhi	@L212
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L215(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L215:
	dc.w	@L222-@L215
	dc.w	@L221-@L215
	dc.w	@L220-@L215
	dc.w	@L219-@L215
	dc.w	@L218-@L215
	dc.w	@L217-@L215
	dc.w	@L216-@L215
	dc.w	@L214-@L215
@L212:
	movem.l	(sp)+, d2/d3/d4/a2
	rts	
@L222:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC0
	jsr	kwrite_cdecl
	move.b	#4, 1(a2)
	move.w	#768, 2(a2)
	move.l	#Map_PLaunch, 4(a2)
	move.b	#3, 24(a2)
	move.b	#1, 28(a2)
	move.w	#2830, 32(a2)
	move.w	#140, -(sp)
	jsr	playSound__cdecl
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	lea	(10, sp), sp
@L221:
	move.b	37(a2), d0
	beq	@L223
	cmp.b	#1, d0
	beq	@L253
@L226:
	cmp.b	#1, 28(a2)
	beq	@L254
@L239:
	tst.b	32(a2)
	bne	@L237
	move.b	44(a2), d0
	bne	@L242
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L243
	cmp.w	#-511, 16(a0)
	bge	@L255
@L244:
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	tst.b	34(a2)
	blt	@L256
	move.b	#32, 44(a2)
@L237:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L212
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L254:
	cmp.b	#2, 36(a2)
	beq	@L249
	moveq	#7, d0
@L240:
	and.w	v_framecount, d0
	bne	@L239
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L239
@L242:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L237
	move.b	#11, 32(a2)
	bra	@L237
@L219:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L239
	bra	@L254
@L218:
	move.b	37(a2), d0
	beq	@L227
	cmp.b	#1, d0
	bne	@L226
	move.w	40(a2), d4
	subq.w	#1, d4
	move.b	28(a2), d2
	move.w	16(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	8(a2), d1
	move.l	d1, 8(a2)
	move.w	18(a2), d3
	ext.l	d3
	lsl.l	#8, d3
	add.l	d3, 12(a2)
	move.w	d4, 40(a2)
	bne	@L236
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L232
	moveq	#5, d0
@L232:
	move.b	d0, 36(a2)
	clr.b	37(a2)
@L236:
	cmp.b	#1, d2
	bne	@L239
@L252:
	moveq	#7, d0
	bra	@L240
@L220:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L239
	bra	@L254
@L217:
	move.b	37(a2), d0
	beq	@L233
	cmp.b	#1, d0
	bne	@L226
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
	cmp.w	#9207, d0
	bgt	@L235
@L258:
	move.b	28(a2), d2
	cmp.b	#1, d2
	beq	@L252
	bra	@L239
@L216:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L239
	bra	@L254
@L214:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss17action07_DefeatedEv
	addq.l	#4, sp
	bra	@L237
@L253:
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
	bgt	@L226
@L257:
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L239
	bra	@L254
@L249:
	moveq	#3, d0
	bra	@L240
@L223:
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
	bgt	@L226
	bra	@L257
@L243:
	cmp.w	d1, d0
	bge	@L244
	cmp.w	#511, 16(a0)
	bgt	@L244
	move.w	#512, v_player+16
	bra	@L244
@L256:
	move.w	#1792, 36(a2)
	bra	@L237
@L255:
	move.w	#-512, v_player+16
	bra	@L244
@L235:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L239
	bra	@L254
@L233:
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
	cmp.w	#9207, d0
	ble	@L258
	bra	@L235
@L227:
	cmp.w	#9344, 8(a2)
	ble	@L248
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
	bra	@L239
@L248:
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
	bra	@L239
