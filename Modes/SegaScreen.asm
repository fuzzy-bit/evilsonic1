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
		locVRAM	 $200
		lea	(Art_Sega).l,a0 ; load Sega	logo patterns
		bsr.w	NemDec
		lea	($FF0000).l,a1

	@loadpal:
		moveq	#palid_SegaBG,d0
		bsr.w	PalLoad2	; load Sega logo palette
		move.w	#-$A,(v_pcyc_num).w
		move.w	#0,(v_pcyc_time).w
		move.w	#0,(v_pal_buffer+$12).w
		move.w	#0,(v_pal_buffer+$10).w
		clr.b	v_csum_start.w			; clear start button check
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0					; enable display
		move.w	d0,(vdp_control_port).l

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

	@clrobjram:
		move.l	d0,(a1)+
		dbf	d1,@clrobjram ; clear object RAM

		Instance.new SegaLetter, a1

Sega_WaitPal:
		move.b	#2,(v_vbla_routine).w
		
		bsr.w	WaitForVBla

		jsr 	(ExecuteObjects).l
		jsr		(BuildSprites).l

		move.b	(v_jpadpress1).w,d0		; is Start button pressed?
		or.b	d0,v_csum_start.w		; if so, save it in a variable

		moveq  	#$FFFFFF8F,d0
        jsr    	PlaySample

		move.b	#$14,(v_vbla_routine).w
		bsr.w	WaitForVBla

Sega_WaitEnd:
		move.b	#2,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	DoChecksum
		jsr 	(ExecuteObjects).l
		jsr		(BuildSprites).l
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

		include "Data\Mappings\Sprites\Sega Logo.asm"

Art_Sega: 	incbin "Data\Art\Nemesis\Sega Logo Sprites.bin"
		even