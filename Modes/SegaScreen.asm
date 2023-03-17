; ---------------------------------------------------------------------------
; Sega screen
; ---------------------------------------------------------------------------

SegaScreen:
		command	mus_Stop	; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; use 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$8700,(a6)	; set background colour (palette entry 0)
		move.w	#$8B00,(a6)	; full-screen vertical scrolling
		clr.b	(f_wtr_state).w
		disable_ints
		move.w	(v_vdp_buffer1).w,d0
		andi.b	#$BF,d0
		move.w	d0,(vdp_control_port).l
		bsr.w	ClearScreen
		locVRAM	0
		lea	(Nem_SegaLogo).l,a0 ; load Sega	logo patterns
		bsr.w	NemDec
		lea	($FF0000).l,a1
		lea	(Eni_SegaLogo).l,a0 ; load Sega	logo mappings
		move.w	#0,d0
		bsr.w	EniDec

		copyTilemap	$FF0000,$E510,$17,7
		copyTilemap	$FF0180,$C000,$27,$1B

		if Revision=0
		else
			tst.b   (v_megadrive).w	; is console Japanese?
			bmi.s   @loadpal
			copyTilemap	$FF0A40,$C53A,2,1 ; hide "TM" with a white rectangle
		endc

	@loadpal:
		moveq	#palid_SegaBG,d0
		bsr.w	PalLoad2	; load Sega logo palette
		move.w	#-$A,(v_pcyc_num).w
		move.w	#0,(v_pcyc_time).w
		move.w	#0,(v_pal_buffer+$12).w
		move.w	#0,(v_pal_buffer+$10).w
		clr.b	v_csum_start.w			; clear start button check
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l

Sega_WaitPal:
		move.b	#2,(v_vbla_routine).w
		
		bsr.w	WaitForVBla
		bsr.w	DoChecksum
		
		move.b	(v_jpadpress1).w,d0		; is Start button pressed?
		or.b	d0,v_csum_start.w		; if so, save it in a variable
		bsr.w	PalCycle_Sega
		bne.s	Sega_WaitPal

		music	mus_SEGA	; play "SEGA" sound
		move.b	#$14,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	DoChecksum


Sega_WaitEnd:
		move.b	#2,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	DoChecksum
		move.b	(v_jpadpress1).w,d0		; is Start button pressed?
		or.b	d0,v_csum_start.w		; if so, save it in a variable
		bra.s	Sega_WaitEnd			; we go to title screen when checksum check is done

DoChecksum:
		move.l	RomEndLoc.w,a6			; load ROM end address to a6
		sub.w	#56-1,a6			; this will trip the detection before ROM ends (in case it would happen mid-transfer)
		move.l	v_csum_addr.w,a5		; load the check address to a5

		cmp.l	a5,a6				; check if checksum is done
		blo.w	ChecksumEndChk			; if yes, skip this
		move.w	v_csum_value.w,d0		; copy the last checksum value to d0
		move.w	#(127840/268)-(40000/268)-1,d1	; load a fairly safe estimate for the maximum number of loops per frame. If you get lag, just increase the 40000 to a higher number (check will take longer!)

	@loop:						; 268 cycles per loop
		movem.l	(a5)+,d2-a4			; laod 44 ($2C) bytes from ROM
		add.w	d2,d0				; add low words to d0
		swap	d2				; swap to high word
		add.w	d2,d0				; add high words to d0

		add.w	d3,d0
		swap	d3
		add.w	d3,d0

		add.w	d4,d0
		swap	d4
		add.w	d4,d0

		add.w	d5,d0
		swap	d5
		add.w	d5,d0

		add.w	d6,d0
		swap	d6
		add.w	d6,d0

		add.w	d7,d0
		swap	d7
		add.w	d7,d0

		move.l	a0,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a1,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a2,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a3,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a4,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		cmp.l	a5,a6				; check if we have passed the address
		dblo	d1,@loop			; if not, go back to loop, but only if we havent looped too many times

		move.l	a5,v_csum_addr.w		; save the check address from a5
		move.w	d0,v_csum_value.w		; save as the new checksum value

		cmp.l	a5,a6				; check if we have passed the address (again)
		bhi.s	Sega_Locret			; if not, exit
		move.l	RomEndLoc.w,a6			; load ROM end address to a6

	@end:
		add.w	(a5)+,d0			; add remaining words to d0
		cmp.l	a5,a6				; check if we have passed the final address
		bhi.s	@end				; if not, go back to loop

		cmp.w	Checksum.w,d0			; check if the checksum matches
		beq.s	ChecksumEndChk			; if yes, we are golden
		jmp	CheckSumError(pc)		; we have a checksum error

ChecksumEndChk:
		;tst.b	mComm.w				; ### REPLACE THIS CHECK! mComm is removed!
		bne.s	Sega_GotoTitle			; if yes, branch
		tst.b	v_csum_start.w			; check if start button was pressed
		bpl.s	Sega_Locret			; if not, do not return
		cmp.l	#Sega_WaitEnd,(sp)		; check if we are already in this routine
		blo.s	Sega_Locret			; if not, wait more anyway

; loc_395E:
Sega_GotoTitle:
		move.b	#id_Title,(v_gamemode).w	; go to title screen
		addq.l	#4,sp				; do not return

Sega_Locret:
		rts

; ---------------------------------------------------------------------------
; Palette cycling routine - Sega logo
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalCycle_Sega:
		tst.b	(v_pcyc_time+1).w
		bne.s	loc_206A
		lea	(v_pal_dry+$20).w,a1
		lea	(Pal_Sega1).l,a0
		moveq	#5,d1
		move.w	(v_pcyc_num).w,d0

loc_2020:
		bpl.s	loc_202A
		addq.w	#2,a0
		subq.w	#1,d1
		addq.w	#2,d0
		bra.s	loc_2020
; ===========================================================================

loc_202A:
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_2034
		addq.w	#2,d0

loc_2034:
		cmpi.w	#$60,d0
		bhs.s	loc_203E
		move.w	(a0)+,(a1,d0.w)

loc_203E:
		addq.w	#2,d0
		dbf	d1,loc_202A

		move.w	(v_pcyc_num).w,d0
		addq.w	#2,d0
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_2054
		addq.w	#2,d0

loc_2054:
		cmpi.w	#$64,d0
		blt.s	loc_2062
		move.w	#$401,(v_pcyc_time).w
		moveq	#-$C,d0

loc_2062:
		move.w	d0,(v_pcyc_num).w
		moveq	#1,d0
		rts
; ===========================================================================

loc_206A:
		subq.b	#1,(v_pcyc_time).w
		bpl.s	loc_20BC
		move.b	#4,(v_pcyc_time).w
		move.w	(v_pcyc_num).w,d0
		addi.w	#$C,d0
		cmpi.w	#$30,d0
		blo.s	loc_2088
		moveq	#0,d0
		rts
; ===========================================================================

loc_2088:
		move.w	d0,(v_pcyc_num).w
		lea	(Pal_Sega2).l,a0
		lea	(a0,d0.w),a0
		lea	(v_pal_dry+$04).w,a1
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)
		lea	(v_pal_dry+$20).w,a1
		moveq	#0,d0
		moveq	#$2C,d1

loc_20A8:
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_20B2
		addq.w	#2,d0

loc_20B2:
		move.w	(a0),(a1,d0.w)
		addq.w	#2,d0
		dbf	d1,loc_20A8

loc_20BC:
		moveq	#1,d0
		rts
; End of function PalCycle_Sega