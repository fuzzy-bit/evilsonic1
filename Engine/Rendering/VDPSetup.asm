; ---------------------------------------------------------------------------
; Subroutine to	set up the VDP
; ---------------------------------------------------------------------------
VDPSetup:
		lea	(vdp_control_port).l,a0
		lea	(vdp_data_port).l,a1
		lea	(VDPSetupArray).l,a2
		moveq	#$12,d7

	@setreg:
		move.w	(a2)+,(a0)
		dbf	d7,@setreg	; set the VDP registers

		move.w	(VDPSetupArray+2).l,d0
		move.w	d0,(v_vdp_buffer1).w
		move.w	#$8A00+223,(v_hbla_hreg).w	; H-INT every 224th scanline
		moveq	#0,d0
		move.l	#$C0000000,(vdp_control_port).l ; set VDP to CRAM write
		move.w	#$3F,d7

	@clrCRAM:
		move.w	d0,(a1)
		dbf	d7,@clrCRAM	; clear	the CRAM

		clr.l	(v_scrposy_dup).w
		clr.l	(v_scrposx_dup).w
		move.l	d1,-(sp)
		fillVRAM	0,$FFFF,0

	@waitforDMA:
		move.w	(a5),d1
		btst	#1,d1		; is DMA (fillVRAM) still running?
		bne.s	@waitforDMA	; if yes, branch

		move.w	#$8F02,(a5)	; set VDP increment size
		move.l	(sp)+,d1
		rts
; End of function VDPSetup

; ===========================================================================
VDPSetupArray:	dc.w $8004		; 8-colour mode
		dc.w $8134		; enable V.interrupts, enable DMA
		dc.w $8200+(vram_fg>>10) ; set foreground nametable address
		dc.w $8300+($A000>>10)	; set window nametable address
		dc.w $8400+(vram_bg>>13) ; set background nametable address
		dc.w $8500+(vram_sprites>>9) ; set sprite table address
		dc.w $8600		; unused
		dc.w $8700		; set background colour (palette entry 0)
		dc.w $8800		; unused
		dc.w $8900		; unused
		dc.w $8A00		; default H.interrupt register
		dc.w $8B00		; full-screen vertical scrolling
		dc.w $8C81		; 40-cell display mode
		dc.w $8D00+(vram_hscroll>>10) ; set background hscroll address
		dc.w $8E00		; unused
		dc.w $8F02		; set VDP increment size
		dc.w $9001		; 64-cell hscroll size
		dc.w $9100		; window horizontal position
		dc.w $9200		; window vertical position