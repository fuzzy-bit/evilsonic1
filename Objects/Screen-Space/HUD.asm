; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------

HUD:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	HUD_Index(pc,d0.w),d1
		jmp	HUD_Index(pc,d1.w)
; ===========================================================================
HUD_Index:	dc.w HUD_Main-HUD_Index
		dc.w HUD_Flash-HUD_Index
; ===========================================================================

HUD_Main:	; Routine 0
		move.w	#$108,obScreenY(a0)
		move.l	#Map_HUD,obMap(a0)
		move.w	#$6CA,obGfx(a0)

        cmpi.b  #7, (v_zone).w
        beq.s   @NoHUD

		move.w	 #$90, d0
		cmp.w	obX(a0),d0	; has item reached the target position?
		bgt.w	@Move
		
		addq.b	#2,obRoutine(a0)
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)
		
@Move:		
		add.w	#2,obX(a0)	; change item's position
		jmp	(DisplaySprite).l
		rts

@NoHUD:
        jsr     DeleteObject
        rts

HUD_Flash:	; Routine 2
		tst.w	(v_rings).w	; do you have any rings?
		beq.s	@norings	; if not, branch
		clr.b	obFrame(a0)	; make all counters yellow
		jmp	(DisplaySprite).l
; ===========================================================================

@norings:
		moveq	#0,d0
		btst	#3,(v_framebyte).w
		bne.s	@display
		addq.w	#1,d0		; make ring counter flash red
		cmpi.b	#9,(v_timemin).w ; have	9 minutes elapsed?
		bne.s	@display	; if not, branch
		addq.w	#2,d0		; make time counter flash red

	@display:
		move.b	d0,obFrame(a0)
		jmp	DisplaySprite
