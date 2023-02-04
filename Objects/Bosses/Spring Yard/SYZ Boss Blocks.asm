; ---------------------------------------------------------------------------
; Object 76 - blocks that Eggman picks up (SYZ)
; ---------------------------------------------------------------------------

BossBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@BlockIndex(pc,d0.w),d1
		jmp	@BlockIndex(pc,d1.w)
; ===========================================================================
@BlockIndex:	dc.w @BlockMain-@BlockIndex
		dc.w @BlockAction-@BlockIndex
		dc.w @BlockFall-@BlockIndex
		dc.w @BlockFallWithoutCheck-@BlockIndex
; ===========================================================================

@BlockMain:	; Routine 0
		moveq	#0,d4		; subtype
		move.w	#$2C10,d5	; x-position of the leftmost block
		moveq	#9,d6		; loop counter (10 blocks)
		
		lea	(a0),a1		; start with the object
		tst.b	obSubtype(a0)	; is the subtype NOT 0?
		beq.s	@BlockMakeBlock
		
	@init:
		move.l	#Map_BossBlock, obMap(a1) ; mappings
		move.w	#$4000,obGfx(a1)	  ; graphics
		move.b	#4,obRender(a1)		  ; something about rendering (i forgot :SAD:)
		move.b	#$10,obActWid(a1)	  ; collision: width
		move.b	#$10,obHeight(a1)	  ; collision: height
		move.b	#3,obPriority(a1)	  ; priority
		addq.b	#2,obRoutine(a1) 	  ; routine (won't kill everything)
		rts

; ===========================================================================

@BlockLoop:
		jsr	(FindFreeObj).l
		bne.s	@BlockExitLoop

@BlockMakeBlock:
		move.b	#id_BossBlock,(a1)
		move.l	#Map_BossBlock,obMap(a1)
		move.w	#$4000,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#$10,obHeight(a1)
		move.b	#3,obPriority(a1)
		move.w	d5,obX(a1)	; set x-position
		move.w	#$582,obY(a1)
		move.w	d4,obSubtype(a1)
		addi.w	#$101,d4
		addi.w	#$20,d5		; add $20 to next x-position
		addq.b	#2,obRoutine(a1)
		dbf	d6,@BlockLoop	; repeat sequence 9 more times

@BlockExitLoop:
		rts	
; ===========================================================================

@BlockAction:	; Routine 2
		move.b	$29(a0),d0
		cmp.b	obSubtype(a0),d0
		beq.s	@BlockSolid
		tst.b	d0
		bmi.s	@BlockPickUp

@BlockAction2:
		add.b	#2,obRoutine(a0) ; go to fall routine
		bra.s	@BlockDisplay
; ===========================================================================

@BlockPickUp:
		movea.l	$34(a0),a1
		tst.b	obColProp(a1)
		beq.s	@BlockAction2
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w	#$2C,obY(a0)
		cmpa.w	a0,a1
		bcs.s	@BlockDisplay
		move.w	obVelY(a1),d0
		ext.l	d0
		asr.l	#8,d0
		add.w	d0,obY(a0)
		bra.s	@BlockDisplay
; ===========================================================================

@BlockSolid:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	obX(a0),d4
		jsr	(SolidObject).l

@BlockDisplay:
		jmp	(DisplaySprite).l
; ===========================================================================

@BlockFall:	; Routine 4
		tst.b	obRender(a0)
		bpl.s	@BlockDelete
		
		move.b	#$87,obColType(a0)
		move.w	#$582-32,d5
		cmp.w	obY(a0), d5
		blt.w	@BlockBreak
		
		jsr	(ObjectFall).l
		jmp	(DisplaySprite).l
		
; ===========================================================================

@BlockFallWithoutCheck:	; Routine 8
			; i fucking hate this but it works
		tst.b	obRender(a0)
		bpl.s	@BlockDelete
		
		jsr	(ObjectFall).l
		jmp	(DisplaySprite).l
		
; ===========================================================================

@BlockDelete:
		jmp	(DeleteObject).l

; ===========================================================================

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


@BlockBreak:
		add.b	#2,obRoutine(a0) ; go to no-check fall routine
		
		move.l 	a1, -(sp)
		jsr	(FindFreeObj).l
		move.b	#id_ExplosionBomb, 0(a1)
		move.w	obX(a0), obX(a1)
		move.w	obY(a0), obY(a1)
		move.l 	(sp)+, a1
		
		lea	@BlockFragSpeed(pc),a4
		lea	@BlockFragPos(pc),a5
		moveq	#1,d4
		moveq	#3,d1
		moveq	#$38,d2
		
		move.b	#8,obActWid(a0)
		move.b	#8,obHeight(a0)
		lea	(a0),a1
		bra.s	@BlockMakeFrag
; ===========================================================================

@BlockLoopFrag:
		jsr	(FindNextFreeObj).l
		bne.s	@BlockPlaySfx

@BlockMakeFrag:
		lea	(a0),a2
		lea	(a1),a3
		moveq	#3,d3

@BlockMakeFrag2:
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		dbf	d3,@BlockMakeFrag2

		move.w	(a4)+,obVelX(a1)
		move.w	(a4)+,obVelY(a1)
		move.w	(a5)+,d3
		add.w	d3,obX(a1)
		move.w	(a5)+,d3
		add.w	d3,obY(a1)
		move.b	d4,obFrame(a1)
		addq.w	#1,d4
		dbf	d1,@BlockLoopFrag ; repeat sequence 3 more times

@BlockPlaySfx:
		sfx	sfx_Smash	; play smashing sound
		rts
; End of function @BlockBreak

; ===========================================================================
@BlockFragSpeed:dc.w -$180, -$200
		dc.w $180, -$200
		dc.w -$100, -$100
		dc.w $100, -$100
@BlockFragPos:dc.w -8, -8
		dc.w $10, 0
		dc.w 0,	$10
		dc.w $10, $10
