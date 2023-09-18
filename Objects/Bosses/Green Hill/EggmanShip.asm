_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l	d2, -(sp)
	move.l	8(sp), a0
	tst.b	40(a0)
	beq	@L13
	illegal	
	move.w	18(a0), d0
@L9:
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L13:
	move.b	41(a0), d1
	move.w	18(a0), d0
	tst.b	d1
	beq	@L3
	cmp.b	#1, d1
	bne	@L9
	move.w	8(a0), d2
	move.w	12(a0), d1
@L5:
	sub.w	-2304.w, d2
	sub.w	-2300.w, d1
	cmp.w	#191, d2
	bgt	@L6
	add.w	#32, 16(a0)
@L7:
	cmp.w	#48, d1
	ble	@L8
@L14:
	add.w	#-24, d0
	move.w	d0, 18(a0)
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L6:
	cmp.w	#208, d2
	ble	@L7
	subq.w	#8, 16(a0)
	cmp.w	#48, d1
	bgt	@L14
@L8:
	cmp.w	#31, d1
	bgt	@L9
	add.w	#12, d0
	move.w	d0, 18(a0)
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L3:
	move.w	-2304.w, d2
	add.w	#224, d2
	move.w	d2, 8(a0)
	move.w	-2300.w, d1
	add.w	#176, d1
	move.w	d1, 12(a0)
	move.b	#1, 41(a0)
	bra	@L5
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l	4(sp), a0
	move.b	41(a0), d0
	beq	@L16
	cmp.b	#1, d0
	bne	@L15
	move.w	8(a0), d1
	move.w	12(a0), d0
	sub.w	-2304.w, d1
	sub.w	-2300.w, d0
	cmp.w	#191, d1
	bgt	@L19
@L25:
	add.w	#32, 16(a0)
@L20:
	cmp.w	#48, d0
	ble	@L21
@L24:
	add.w	#-24, 18(a0)
@L15:
	rts	
@L19:
	cmp.w	#208, d1
	ble	@L20
	subq.w	#8, 16(a0)
	cmp.w	#48, d0
	bgt	@L24
@L21:
	cmp.w	#31, d0
	bgt	@L15
	add.w	#12, 18(a0)
	rts	
@L16:
	move.w	-2304.w, d1
	add.w	#224, d1
	move.w	d1, 8(a0)
	move.w	-2300.w, d0
	add.w	#176, d0
	move.w	d0, 12(a0)
	move.b	#1, 41(a0)
	sub.w	-2304.w, d1
	sub.w	-2300.w, d0
	cmp.w	#191, d1
	bgt	@L19
	bra	@L25
executeMasterScript_ObjEggmanShip:
	move.l	d2, -(sp)
	move.l	8(sp), a0
	tst.b	40(a0)
	beq	@L38
	illegal	
	move.w	18(a0), d0
@L34:
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L38:
	move.b	41(a0), d1
	move.w	18(a0), d0
	tst.b	d1
	beq	@L28
	cmp.b	#1, d1
	bne	@L34
	move.w	8(a0), d2
	move.w	12(a0), d1
@L30:
	sub.w	-2304.w, d2
	sub.w	-2300.w, d1
	cmp.w	#191, d2
	bgt	@L31
	add.w	#32, 16(a0)
@L32:
	cmp.w	#48, d1
	ble	@L33
@L39:
	add.w	#-24, d0
	move.w	d0, 18(a0)
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L31:
	cmp.w	#208, d2
	ble	@L32
	subq.w	#8, 16(a0)
	cmp.w	#48, d1
	bgt	@L39
@L33:
	cmp.w	#31, d1
	bgt	@L34
	add.w	#12, d0
	move.w	d0, 18(a0)
	move.w	16(a0), d1
	ext.l	d1
	lsl.l	#8, d1
	add.l	d1, 8(a0)
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a0)
	move.l	(sp)+, d2
	rts	
@L28:
	move.w	-2304.w, d2
	add.w	#224, d2
	move.w	d2, 8(a0)
	move.w	-2300.w, d1
	add.w	#176, d1
	move.w	d1, 12(a0)
	move.b	#1, 41(a0)
	bra	@L30
