	even
_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	40(a2), d0
	beq	@L2
	cmp.b	#1, d0
	beq	@L3
	illegal	
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L2:
	move.b	41(a2), d0
	cmp.b	#2, d0
	beq	@L5
	bhi	@L6
	tst.b	d0
	beq	@L52
	move.w	12(a2), d0
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L10
	move.w	18(a2), d0
	bgt	@L53
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L10
	clr.b	44(a2)
	move.w	#-512, 16(a2)
	move.w	#384, 18(a2)
	move.b	#2, 41(a2)
@L10:
	tst.b	32(a2)
	bne	@L37
	move.b	42(a2), d0
	beq	@L54
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L39
@L57:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L40
	clr.w	d0
@L40:
	move.w	d0, -1246.w
@L37:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L56:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L6:
	cmp.b	#3, d0
	bne	@L10
	move.b	43(a2), d0
	bne	@L55
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	-2300.w, a0
	lea	(32, a0), a0
	move.w	12(a2), d1
	cmp.w	a0, d1
	ble	@L17
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L19
	subq.w	#4, d0
@L19:
	move.w	d0, 18(a2)
	move.w	8(a2), d0
	cmp.w	a1, d0
	ble	@L21
	move.w	16(a2), d0
	cmp.w	#512, d0
	ble	@L10
	add.w	#-12, d0
	move.w	d0, 16(a2)
	bra	@L10
@L3:
	move.b	41(a2), d0
	beq	@L25
	cmp.b	#1, d0
	bne	@L10
	move.w	8(a2), d0
	move.w	12(a2), d2
	move.w	16(a2), a0
@L26:
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L27
	addq.w	#2, a0
	subq.w	#1, d1
@L28:
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	ble	@L29
	tst.w	d1
	ble	@L30
	subq.w	#6, d1
	move.w	d1, 18(a2)
@L30:
	move.b	43(a2), d1
	beq	@L34
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L10
@L34:
	add.w	#-201, d0
	cmp.w	#73, d0
	bhi	@L10
	add.w	#-33, d2
	cmp.w	#43, d2
	bhi	@L10
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L44
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L35:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L36
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L36:
	move.b	#90, 43(a2)
	bra	@L10
@L39:
	move.b	#15, 32(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L56
@L54:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L39
	bra	@L57
@L29:
	cmp.w	#11, d2
	bgt	@L30
	tst.w	d1
	blt	@L58
	move.b	43(a2), d1
	beq	@L10
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L10
	bra	@L34
@L27:
	subq.w	#1, a0
	addq.w	#1, d1
	bra	@L28
@L25:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d2
	add.w	#32, d2
	move.w	d2, 12(a2)
	move.b	#1, 41(a2)
	move.w	#768, a0
	bra	@L26
@L5:
	move.w	16(a2), d0
	cmp.w	#1023, d0
	bgt	@L14
	add.w	#24, d0
	move.w	d0, 16(a2)
@L14:
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L15
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L15:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#256, d0
	ble	@L10
	addq.b	#2, v_dle_routine
	move.b	#60, 43(a2)
	move.b	#3, 41(a2)
	bra	@L10
@L52:
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
	ble	@L10
	move.w	#500, d0
	move.w	d0, 18(a2)
	bra	@L10
@L58:
	addq.w	#8, d1
	move.w	d1, 18(a2)
	move.b	43(a2), d1
	beq	@L10
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L10
	bra	@L34
@L55:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bra	@L10
@L17:
	cmp.w	a0, d1
	bge	@L43
	move.w	18(a2), d0
	cmp.w	#511, d0
	bgt	@L19
	addq.w	#4, d0
	bra	@L19
@L21:
	cmp.w	a1, d0
	blt	@L22
	move.w	#768, 16(a2)
	cmp.w	a0, d1
	bne	@L10
	cmp.l	#50331648, 16(a2)
	bne	@L10
	move.w	#256, 40(a2)
	bra	@L10
@L43:
	clr.w	d0
	bra	@L19
@L22:
	move.w	16(a2), d0
	cmp.w	#1279, d0
	bgt	@L24
	add.w	#12, d0
@L24:
	move.w	d0, 16(a2)
	bra	@L10
@L53:
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L10
@L44:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L35
	even
_ZN13ObjEggmanShip12handleDamageEv:
	move.l	a2, -(sp)
	move.l	8(sp), a2
	tst.b	32(a2)
	bne	@L59
	move.b	42(a2), d0
	beq	@L67
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L62
@L68:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L63
	clr.w	d0
@L63:
	move.w	d0, -1246.w
@L59:
	move.l	(sp)+, a2
	rts	
@L62:
	move.b	#15, 32(a2)
	move.l	(sp)+, a2
	rts	
@L67:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L62
	bra	@L68
	even
_ZN13ObjEggmanShip14script00_IntroEv:
	move.l	d2, -(sp)
	move.l	8(sp), a0
	move.b	41(a0), d0
	cmp.b	#2, d0
	beq	@L70
	bhi	@L71
	tst.b	d0
	beq	@L95
	move.w	12(a0), d0
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L69
	move.w	18(a0), d0
	bgt	@L96
	clr.w	18(a0)
	move.b	43(a0), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a0)
	tst.b	d0
	bne	@L69
	clr.b	44(a0)
	move.w	#-512, 16(a0)
	move.w	#384, 18(a0)
	move.b	#2, 41(a0)
@L69:
	move.l	(sp)+, d2
	rts	
@L71:
	cmp.b	#3, d0
	bne	@L69
	move.b	43(a0), d0
	bne	@L97
	move.w	-2304.w, d2
	add.w	#208, d2
	move.w	-2300.w, d1
	add.w	#32, d1
	move.w	12(a0), a1
	cmp.w	a1, d1
	bge	@L82
	move.w	18(a0), d0
	cmp.w	#-511, d0
	bge	@L98
@L84:
	move.w	d0, 18(a0)
	move.w	8(a0), d0
	cmp.w	d0, d2
	bge	@L86
	move.w	16(a0), d0
	cmp.w	#512, d0
	ble	@L69
	add.w	#-12, d0
	move.w	d0, 16(a0)
	move.l	(sp)+, d2
	rts	
@L70:
	move.w	16(a0), d0
	cmp.w	#1023, d0
	bgt	@L79
	add.w	#24, d0
	move.w	d0, 16(a0)
@L79:
	move.w	18(a0), d0
	cmp.w	#-511, d0
	blt	@L80
	subq.w	#8, d0
	move.w	d0, 18(a0)
@L80:
	move.w	8(a0), d0
	sub.w	-2304.w, d0
	cmp.w	#256, d0
	ble	@L69
	addq.b	#2, v_dle_routine
	move.b	#60, 43(a0)
	move.b	#3, 41(a0)
	move.l	(sp)+, d2
	rts	
@L95:
	move.w	-2304.w, d0
	add.w	#160, d0
	move.w	d0, 8(a0)
	move.w	-2300.w, d0
	add.w	#-64, d0
	move.w	d0, 12(a0)
	move.w	#512, 18(a0)
	move.b	#1, 44(a0)
	or.b	#1, 34(a0)
	move.b	#10, 33(a0)
	move.b	#30, 43(a0)
	move.b	#1, 41(a0)
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L69
	move.w	#500, d0
	move.w	d0, 18(a0)
@L99:
	move.l	(sp)+, d2
	rts	
@L97:
	subq.b	#1, d0
	move.b	d0, 43(a0)
	move.l	(sp)+, d2
	rts	
@L82:
	cmp.w	a1, d1
	ble	@L91
	move.w	18(a0), d0
	cmp.w	#511, d0
	bgt	@L84
	addq.w	#4, d0
	bra	@L84
@L86:
	cmp.w	d0, d2
	bgt	@L87
	move.w	#768, 16(a0)
	cmp.w	a1, d1
	bne	@L69
	cmp.l	#50331648, 16(a0)
	bne	@L69
	move.w	#256, 40(a0)
	move.l	(sp)+, d2
	rts	
@L98:
	subq.w	#4, d0
	bra	@L84
@L87:
	move.w	16(a0), d0
	cmp.w	#1279, d0
	bgt	@L89
	add.w	#12, d0
@L89:
	move.w	d0, 16(a0)
	move.l	(sp)+, d2
	rts	
@L91:
	clr.w	d0
	bra	@L84
@L96:
	add.w	#-12, d0
	move.w	d0, 18(a0)
	bra	@L99
	even
_ZN13ObjEggmanShip16script01_TestSeqEv:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	41(a2), d0
	beq	@L101
	cmp.b	#1, d0
	bne	@L100
	move.w	8(a2), d0
	move.w	12(a2), d2
	move.w	16(a2), a0
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L104
@L122:
	addq.w	#2, a0
	subq.w	#1, d1
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	ble	@L106
@L120:
	tst.w	d1
	ble	@L107
	subq.w	#6, d1
	move.w	d1, 18(a2)
@L107:
	move.b	43(a2), d1
	beq	@L112
	subq.b	#1, d1
	move.b	d1, 43(a2)
	beq	@L112
@L100:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L104:
	subq.w	#1, a0
	addq.w	#1, d1
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	bgt	@L120
@L106:
	cmp.w	#11, d2
	bgt	@L107
	tst.w	d1
	blt	@L121
	move.b	43(a2), d1
	beq	@L100
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L100
@L112:
	add.w	#-201, d0
	cmp.w	#73, d0
	bhi	@L100
	add.w	#-33, d2
	cmp.w	#43, d2
	bhi	@L100
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L115
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L113:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L114
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L114:
	move.b	#90, 43(a2)
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L101:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d2
	add.w	#32, d2
	move.w	d2, 12(a2)
	move.b	#1, 41(a2)
	move.w	#768, a0
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L104
	bra	@L122
@L121:
	addq.w	#8, d1
	move.w	d1, 18(a2)
	move.b	43(a2), d1
	beq	@L100
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L100
	bra	@L112
@L115:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L113
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
	beq	@L123
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L123:
	move.l	(sp)+, a2
	rts	
	even
executeMasterScript_ObjEggmanShip:
	move.l	a2, -(sp)
	move.l	d2, -(sp)
	move.l	12(sp), a2
	move.b	40(a2), d0
	beq	@L128
	cmp.b	#1, d0
	beq	@L129
	illegal	
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L128:
	move.b	41(a2), d0
	cmp.b	#2, d0
	beq	@L131
	bhi	@L132
	tst.b	d0
	beq	@L178
	move.w	12(a2), d0
	sub.w	-2300.w, d0
	cmp.w	#16, d0
	ble	@L136
	move.w	18(a2), d0
	bgt	@L179
	clr.w	18(a2)
	move.b	43(a2), d0
	move.b	d0, d1
	subq.b	#1, d1
	move.b	d1, 43(a2)
	tst.b	d0
	bne	@L136
	clr.b	44(a2)
	move.w	#-512, 16(a2)
	move.w	#384, 18(a2)
	move.b	#2, 41(a2)
@L136:
	tst.b	32(a2)
	bne	@L163
	move.b	42(a2), d0
	beq	@L180
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L165
@L183:
	move.w	#3822, d0
	tst.w	-1246.w
	beq	@L166
	clr.w	d0
@L166:
	move.w	d0, -1246.w
@L163:
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
@L182:
	move.l	(sp)+, d2
	move.l	(sp)+, a2
	rts	
@L132:
	cmp.b	#3, d0
	bne	@L136
	move.b	43(a2), d0
	bne	@L181
	move.w	-2304.w, a1
	lea	(208, a1), a1
	move.w	-2300.w, a0
	lea	(32, a0), a0
	move.w	12(a2), d1
	cmp.w	a0, d1
	ble	@L143
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L145
	subq.w	#4, d0
@L145:
	move.w	d0, 18(a2)
	move.w	8(a2), d0
	cmp.w	a1, d0
	ble	@L147
	move.w	16(a2), d0
	cmp.w	#512, d0
	ble	@L136
	add.w	#-12, d0
	move.w	d0, 16(a2)
	bra	@L136
@L129:
	move.b	41(a2), d0
	beq	@L151
	cmp.b	#1, d0
	bne	@L136
	move.w	8(a2), d0
	move.w	12(a2), d2
	move.w	16(a2), a0
@L152:
	sub.w	-2304.w, d0
	sub.w	-2300.w, d2
	move.w	18(a2), d1
	cmp.w	#239, d0
	bgt	@L153
	addq.w	#2, a0
	subq.w	#1, d1
@L154:
	move.w	a0, 16(a2)
	move.w	d1, 18(a2)
	cmp.w	#40, d2
	ble	@L155
	tst.w	d1
	ble	@L156
	subq.w	#6, d1
	move.w	d1, 18(a2)
@L156:
	move.b	43(a2), d1
	beq	@L160
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L136
@L160:
	add.w	#-201, d0
	cmp.w	#73, d0
	bhi	@L136
	add.w	#-33, d2
	cmp.w	#43, d2
	bhi	@L136
	jsr	randomNumber__cdecl
	btst	#0, d0
	beq	@L170
	move.l	#execute_ObjGHZBossEggmanMonitor, d0
@L161:
	move.l	d0, -(sp)
	move.l	a2, -(sp)
	jsr	createCppObject__cdecl
	move.l	d0, a0
	addq.l	#8, sp
	tst.l	d0
	beq	@L162
	move.l	16(a2), 16(a0)
	move.l	8(a2), d0
	move.l	12(a2), d1
	move.l	d0, 8(a0)
	move.l	d1, 12(a0)
@L162:
	move.b	#90, 43(a2)
	bra	@L136
@L165:
	move.b	#15, 32(a2)
	move.w	16(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 8(a2)
	move.w	18(a2), d0
	ext.l	d0
	lsl.l	#8, d0
	add.l	d0, 12(a2)
	bra	@L182
@L180:
	move.b	#33, 42(a2)
	move.w	#172, -(sp)
	jsr	playSound__cdecl
	move.b	42(a2), d0
	addq.l	#2, sp
	subq.b	#1, d0
	move.b	d0, 42(a2)
	beq	@L165
	bra	@L183
@L155:
	cmp.w	#11, d2
	bgt	@L156
	tst.w	d1
	blt	@L184
	move.b	43(a2), d1
	beq	@L136
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L136
	bra	@L160
@L153:
	subq.w	#1, a0
	addq.w	#1, d1
	bra	@L154
@L151:
	move.w	-2304.w, d0
	add.w	#208, d0
	move.w	d0, 8(a2)
	move.w	-2300.w, d2
	add.w	#32, d2
	move.w	d2, 12(a2)
	move.b	#1, 41(a2)
	move.w	#768, a0
	bra	@L152
@L131:
	move.w	16(a2), d0
	cmp.w	#1023, d0
	bgt	@L140
	add.w	#24, d0
	move.w	d0, 16(a2)
@L140:
	move.w	18(a2), d0
	cmp.w	#-511, d0
	blt	@L141
	subq.w	#8, d0
	move.w	d0, 18(a2)
@L141:
	move.w	8(a2), d0
	sub.w	-2304.w, d0
	cmp.w	#256, d0
	ble	@L136
	addq.b	#2, v_dle_routine
	move.b	#60, 43(a2)
	move.b	#3, 41(a2)
	bra	@L136
@L178:
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
	ble	@L136
	move.w	#500, d0
	move.w	d0, 18(a2)
	bra	@L136
@L184:
	addq.w	#8, d1
	move.w	d1, 18(a2)
	move.b	43(a2), d1
	beq	@L136
	subq.b	#1, d1
	move.b	d1, 43(a2)
	bne	@L136
	bra	@L160
@L181:
	subq.b	#1, d0
	move.b	d0, 43(a2)
	bra	@L136
@L143:
	cmp.w	a0, d1
	bge	@L169
	move.w	18(a2), d0
	cmp.w	#511, d0
	bgt	@L145
	addq.w	#4, d0
	bra	@L145
@L147:
	cmp.w	a1, d0
	blt	@L148
	move.w	#768, 16(a2)
	cmp.w	a0, d1
	bne	@L136
	cmp.l	#50331648, 16(a2)
	bne	@L136
	move.w	#256, 40(a2)
	bra	@L136
@L169:
	clr.w	d0
	bra	@L145
@L148:
	move.w	16(a2), d0
	cmp.w	#1279, d0
	bgt	@L150
	add.w	#12, d0
@L150:
	move.w	d0, 16(a2)
	bra	@L136
@L179:
	add.w	#-12, d0
	move.w	d0, 18(a2)
	bra	@L136
@L170:
	move.l	#execute_ObjGHZBossSpikedBall, d0
	bra	@L161
