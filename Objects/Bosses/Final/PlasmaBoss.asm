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
	cmp.b	#6, 36(a2)
	bhi	@L1
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L4(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L4:
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
@L9:
	move.b	37(a2), d0
	beq	@L11
	cmp.b	#1, d0
	beq	@L41
@L13:
	cmp.b	#1, 28(a2)
	beq	@L42
@L27:
	tst.b	32(a2)
	bne	@L30
	move.b	44(a2), d0
	bne	@L31
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L32
	cmp.w	#-511, 16(a0)
	blt	@L33
	move.w	#-512, v_player+16
@L33:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L31:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L30
	move.b	#11, 32(a2)
@L30:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L1
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L42:
	cmp.b	#2, 36(a2)
	beq	@L37
	moveq	#7, d0
@L28:
	and.w	v_framecount, d0
	bne	@L27
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L27
@L8:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L27
	bra	@L42
@L7:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L27
	bra	@L42
@L6:
	move.b	37(a2), d0
	beq	@L15
	cmp.b	#1, d0
	bne	@L13
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
	bne	@L27
@L40:
	moveq	#7, d0
	bra	@L28
@L5:
	move.b	37(a2), d0
	beq	@L22
	cmp.b	#1, d0
	bne	@L13
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L23:
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
	move.b	28(a2), d2
	cmp.b	#1, d2
	beq	@L40
	bra	@L27
@L3:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L27
	bra	@L42
@L41:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L14:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L13
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L27
	bra	@L42
@L32:
	cmp.w	d1, d0
	bge	@L33
	cmp.w	#511, 16(a0)
	bgt	@L33
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L31
@L37:
	moveq	#3, d0
	bra	@L28
@L11:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L14
@L22:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d0
	bra	@L23
@L15:
	cmp.w	#9344, 8(a2)
	ble	@L36
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
	bra	@L27
@L24:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L27
	bra	@L42
@L36:
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
	bra	@L27
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
	bpl	@L44
	move.l	a0, a1
@L45:
	cmp.b	#-128, d2
	bne	@L56
	and.l	#255, d0
	move.b	(a0, d0.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L45
@L44:
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
@L56:
	cmp.b	#-127, d2
	bne	@L57
	and.l	#255, d0
	move.b	33(a2), d2
	cmp.b	(a1, d0.l), d2
	bls	@L50
	addq.b	#2, d1
	and.l	#255, d1
	move.b	(a0, d1.l), d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L45
	bra	@L44
@L50:
	addq.b	#3, d1
	move.b	d1, d0
	addq.b	#1, d0
	move.b	d0, 45(a2)
	moveq	#0, d2
	move.b	d1, d2
	move.b	(a0, d2.l), d2
	bmi	@L45
	bra	@L44
@L57:
	pea	ObjectsBossesFinalPlasmaBoss_s__LC2
	jsr	raiseError__cdecl
	even
_ZN13ObjPlasmaBoss12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L58
	move.b	44(a2), d0
	bne	@L61
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L62
	cmp.w	#-511, 16(a0)
	blt	@L63
	move.w	#-512, v_player+16
@L63:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L61:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L58
	move.b	#11, 32(a2)
@L58:
	move.l	(sp)+, a2
	rts	
@L62:
	cmp.w	d1, d0
	bge	@L63
	cmp.w	#511, 16(a0)
	bgt	@L63
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L61
	even
_ZN13ObjPlasmaBoss19action01_EnterRightEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L68
	cmp.b	#1, d0
	bne	@L67
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
	ble	@L73
@L67:
	rts	
@L73:
	move.w	#9480, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L68:
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
	bgt	@L67
	bra	@L73
	even
_ZN13ObjPlasmaBoss21action02_AttractBallsEv:
	movem.l	d2/d3/a2/a3/a4, -(sp)
	move.l	24(sp), a2
	move.b	37(a2), d0
	beq	@L75
	cmp.b	#1, d0
	bne	@L74
	move.w	40(a2), d0
	cmp.w	#90, d0
	bhi	@L85
@L80:
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L74
	move.l	a2, 24(sp)
	movem.l	(sp)+, d2/d3/a2/a3/a4
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L75:
	move.b	#1, 28(a2)
	move.w	#180, 40(a2)
	move.b	#1, 37(a2)
	move.w	v_framecount, d0
	and.w	#3, d0
	beq	@L78
	move.w	#179, 40(a2)
@L74:
	movem.l	(sp)+, d2/d3/a2/a3/a4
	rts	
@L78:
	move.w	#1, -(sp)
	move.l	a2, -(sp)
	jsr	create_ObjPlasmaBall
	move.l	d0, a3
	addq.l	#6, sp
	tst.l	d0
	beq	@L86
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
	bra	@L80
@L86:
	move.w	40(a2), d0
	bra	@L80
@L85:
	move.w	v_framecount, d1
	and.w	#3, d1
	beq	@L78
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
	beq	@L88
	cmp.b	#2, d0
	beq	@L89
	tst.b	d0
	beq	@L137
@L87:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L137:
	clr.b	28(a2)
	jsr	randomNumber__cdecl
	and.w	#1, d0
	lsl.w	#5, d0
	add.w	#1504, d0
	move.w	d0, 42(a2)
	move.w	12(a2), d2
	move.w	#-256, d1
	cmp.w	d0, d2
	bge	@L93
	move.w	#256, d1
@L93:
	move.w	d1, 18(a2)
	cmp.b	#3, 33(a2)
	bls	@L120
	moveq	#60, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
@L92:
	cmp.w	d2, d0
	beq	@L95
@L138:
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
@L89:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L87
	move.l	a2, 28(sp)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L88:
	move.w	12(a2), d2
	move.w	42(a2), d0
	cmp.w	d2, d0
	bne	@L138
@L95:
	move.w	40(a2), d0
	beq	@L96
	subq.w	#1, d0
	move.w	d0, 40(a2)
	clr.w	18(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L120:
	moveq	#30, d1
	move.w	d1, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L92
@L96:
	move.b	#1, 28(a2)
	move.w	8(a2), d0
	move.w	d2, d3
	add.w	#-48, d3
	cmp.w	#1407, d3
	ble	@L139
	lea	create_ObjPlasmaBall, a3
	cmp.w	#9343, d0
	ble	@L140
	moveq	#8, d4
	moveq	#30, d2
@L103:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L101
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	cmp.b	#3, 33(a2)
	bls	@L121
	move.w	d2, d0
	move.w	d0, 52(a0)
@L101:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L103
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L116
	move.l	a2, d3
@L99:
	lea	create_ObjPlasmaBall, a3
	moveq	#8, d5
	moveq	#30, d4
@L111:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
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
	move.w	d2, 48(a0)
	cmp.b	#3, 33(a2)
	bls	@L124
	move.w	d4, d0
	move.w	d0, 52(a0)
@L109:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L111
@L116:
	cmp.b	#3, 33(a2)
	bls	@L123
	moveq	#120, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
@L141:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L140:
	moveq	#30, d4
	moveq	#8, d2
@L100:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L105
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	move.w	d3, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L122
	move.w	d2, d0
	move.w	d0, 52(a0)
@L105:
	add.w	#-24, d3
	cmp.w	#1407, d3
	bgt	@L100
	move.w	42(a2), d2
	add.w	#48, d2
	cmp.w	#1600, d2
	bgt	@L116
	move.l	a2, d3
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
@L115:
	move.w	#2, -(sp)
	move.l	d3, -(sp)
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
	move.w	d2, 48(a0)
	or.b	#1, 34(a0)
	cmp.b	#3, 33(a2)
	bhi	@L125
	move.w	d4, d0
	move.w	d0, 52(a0)
@L113:
	add.w	#24, d2
	cmp.w	#1600, d2
	ble	@L115
	bra	@L116
@L125:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L113
@L124:
	move.w	d5, d0
	move.w	d0, 52(a0)
	bra	@L109
@L121:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L101
@L122:
	move.w	d4, d0
	move.w	d0, 52(a0)
	bra	@L105
@L123:
	moveq	#60, d0
	move.w	d0, 40(a2)
	addq.b	#1, 37(a2)
	bra	@L141
@L139:
	add.w	#48, d2
	move.l	a2, d3
	cmp.w	#9343, d0
	bgt	@L99
	lea	create_ObjPlasmaBall, a3
	moveq	#30, d5
	moveq	#8, d4
	bra	@L115
	even
_ZN13ObjPlasmaBoss23action04_ChangePositionEv:
	move.l	d3, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a0
	move.b	37(a0), d0
	beq	@L143
	cmp.b	#1, d0
	bne	@L142
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
	bne	@L142
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L147
	moveq	#5, d0
@L147:
	move.b	d0, 36(a0)
	clr.b	37(a0)
@L142:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L143:
	cmp.w	#9344, 8(a0)
	ble	@L148
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
@L151:
	move.l	(sp)+, d2
	move.l	(sp)+, d3
	rts	
@L148:
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
	bra	@L151
	even
_ZN13ObjPlasmaBoss18action05_EnterLeftEv:
	move.l	4(sp), a0
	move.b	37(a0), d0
	beq	@L153
	cmp.b	#1, d0
	bne	@L152
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
	bgt	@L158
@L152:
	rts	
@L158:
	move.w	#9208, 8(a0)
	clr.w	16(a0)
	move.l	a0, 4(sp)
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L153:
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
	ble	@L152
	bra	@L158
	even
_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv:
	movem.l	d2/d3/d4/d5/a2/a3, -(sp)
	move.l	28(sp), a2
	move.b	37(a2), d0
	cmp.b	#1, d0
	beq	@L160
	cmp.b	#2, d0
	beq	@L161
	tst.b	d0
	beq	@L181
@L159:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L181:
	move.w	12(a2), d0
	cmp.w	#1439, d0
	ble	@L182
	move.w	#-256, 18(a2)
	clr.b	28(a2)
	move.w	#60, 40(a2)
	move.b	#1, 37(a2)
	cmp.w	#1440, d0
	bne	@L178
	moveq	#59, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
@L185:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L161:
	move.w	40(a2), d0
	subq.w	#1, d0
	move.w	d0, 40(a2)
	bne	@L159
	move.l	a2, 28(sp)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	bra	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
@L160:
	move.w	12(a2), d3
	cmp.w	#1440, d3
	beq	@L166
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
@L183:
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L182:
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
	bra	@L183
@L166:
	move.w	40(a2), d2
	bne	@L184
	move.b	#1, 28(a2)
	cmp.w	#9343, 8(a2)
	bgt	@L168
	move.w	#510, 40(a2)
	moveq	#60, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L171:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L177
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
@L177:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L175
	move.w	12(a2), d3
	bra	@L171
@L168:
	move.w	#330, 40(a2)
	moveq	#30, d5
	moveq	#30, d4
	lea	create_ObjPlasmaBall, a3
@L176:
	move.w	#2, -(sp)
	move.l	a2, -(sp)
	jsr	(a3)
	move.l	d0, a0
	addq.l	#6, sp
	tst.l	d0
	beq	@L174
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
	move.w	12(a2), 46(a0)
	add.w	#24, d3
	add.w	d2, d3
	move.w	d3, 48(a0)
	move.w	d4, 52(a0)
@L174:
	add.w	#24, d2
	add.w	d5, d4
	cmp.w	#168, d2
	beq	@L175
	move.w	12(a2), d3
	bra	@L176
@L175:
	addq.b	#1, 37(a2)
	movem.l	(sp)+, d2/d3/d4/d5/a2/a3
	rts	
@L178:
	moveq	#-1, d1
	not.w	d1
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	add.l	d1, 12(a2)
	bra	@L183
@L184:
	subq.w	#1, d2
	move.w	d2, 40(a2)
	clr.w	18(a2)
	bra	@L185
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
	cmp.b	#6, 36(a2)
	bhi	@L188
	moveq	#0, d0
	move.b	36(a2), d0
	add.l	d0, d0
	move.w	@L191(pc, d0.l), d0
	jmp	*+2+2(pc,d0.w)
@L191:
	dc.w	@L197-@L191
	dc.w	@L196-@L191
	dc.w	@L195-@L191
	dc.w	@L194-@L191
	dc.w	@L193-@L191
	dc.w	@L192-@L191
	dc.w	@L190-@L191
@L188:
	movem.l	(sp)+, d2/d3/d4/a2
	rts	
@L197:
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
@L196:
	move.b	37(a2), d0
	beq	@L198
	cmp.b	#1, d0
	beq	@L228
@L200:
	cmp.b	#1, 28(a2)
	beq	@L229
@L214:
	tst.b	32(a2)
	bne	@L217
	move.b	44(a2), d0
	bne	@L218
	lea	v_player, a0
	move.w	v_player+8, d1
	move.w	8(a2), d0
	cmp.w	d1, d0
	ble	@L219
	cmp.w	#-511, 16(a0)
	blt	@L220
	move.w	#-512, v_player+16
@L220:
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
@L218:
	subq.b	#1, d0
	move.b	d0, 44(a2)
	bne	@L217
	move.b	#11, 32(a2)
@L217:
	pea	Ani_PLaunch
	move.l	a2, -(sp)
	jsr	animateSprite__cdecl
	addq.l	#8, sp
	btst	#0, 44(a2)
	bne	@L188
	move.l	a2, 20(sp)
	movem.l	(sp)+, d2/d3/d4/a2
	jmp	displaySprite__cdecl
@L229:
	cmp.b	#2, 36(a2)
	beq	@L224
	moveq	#7, d0
@L215:
	and.w	v_framecount, d0
	bne	@L214
	move.w	#177, -(sp)
	jsr	playSound__cdecl
	addq.l	#2, sp
	bra	@L214
@L195:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss21action02_AttractBallsEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L214
	bra	@L229
@L194:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23action03_VerticalAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L214
	bra	@L229
@L193:
	move.b	37(a2), d0
	beq	@L202
	cmp.b	#1, d0
	bne	@L200
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
	bne	@L212
	swap	d1
	ext.l	d1
	cmp.w	#9344, d1
	ble	@L208
	moveq	#5, d0
@L208:
	move.b	d0, 36(a2)
	clr.b	37(a2)
@L212:
	cmp.b	#1, d2
	bne	@L214
@L227:
	moveq	#7, d0
	bra	@L215
@L192:
	move.b	37(a2), d0
	beq	@L209
	cmp.b	#1, d0
	bne	@L200
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L210:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9207, d0
	bgt	@L211
	move.b	28(a2), d2
	cmp.b	#1, d2
	beq	@L227
	bra	@L214
@L190:
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss27action06_VerticalWallAttackEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L214
	bra	@L229
@L228:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
@L201:
	add.l	8(a2), d0
	move.l	d0, 8(a2)
	move.w	18(a2), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 12(a2)
	swap	d0
	ext.l	d0
	cmp.w	#9480, d0
	bgt	@L200
	move.w	#9480, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L214
	bra	@L229
@L219:
	cmp.w	d1, d0
	bge	@L220
	cmp.w	#511, 16(a0)
	bgt	@L220
	move.w	#512, v_player+16
	move.b	#33, 44(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	44(a2), d0
	addq.l	#2, sp
	bra	@L218
@L224:
	moveq	#3, d0
	bra	@L215
@L198:
	clr.b	28(a2)
	and.b	#-2, 1(a2)
	and.b	#-2, 34(a2)
	move.w	#9536, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#-192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#-49152, d0
	bra	@L201
@L209:
	clr.b	28(a2)
	or.b	#1, 1(a2)
	or.b	#1, 34(a2)
	move.w	#9152, 8(a2)
	move.w	#1440, 12(a2)
	move.w	#192, 16(a2)
	move.b	#1, 37(a2)
	move.l	#49152, d0
	bra	@L210
@L202:
	cmp.w	#9344, 8(a2)
	ble	@L223
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
	bra	@L214
@L211:
	move.w	#9208, 8(a2)
	clr.w	16(a2)
	move.l	a2, -(sp)
	jsr	_ZN13ObjPlasmaBoss23setNextActionFromScriptEv
	addq.l	#4, sp
	cmp.b	#1, 28(a2)
	bne	@L214
	bra	@L229
@L223:
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
	bra	@L214
