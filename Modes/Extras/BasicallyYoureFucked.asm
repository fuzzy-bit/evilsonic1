; ---------------------------------------------------------------------------
; Special game over
; ---------------------------------------------------------------------------
BasicallyYoureFucked:
		music 	mus_stop
		jsr 	ClearScreen
		move.w  #$24, (v_demolength).w

		move.l 	#$FFFFFFA3, d0
		jsr 	PlaySample

@WaitSample1:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		beq.s 	@Sample2

		bra.s 	@WaitSample1

@Sample2:
		move.l 	#$FFFFFFA4, d0
		jsr 	PlaySample

		move.l  #$68000000, ($FFC00004).l
		lea     @Art, a0
		jsr     NemDec 		; preload art

		move.w  #$40, (v_demolength).w

@WaitSample2:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		bne.s 	@WaitSample2

		lea    	($FF0000), a1 ; load background here
		lea    	@Mappings, a0
		move.w 	#320, d0
		jsr    	EniDec.w

		lea     ($FF0000), a1
		move.l  #$60000003, d0
		moveq   #39, d1
		moveq   #30, d2
		jsr	   	TilemapToVRAM 	; mappings -> vram

		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$9, d0
 
@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop
		jsr 	PaletteFadeIn

@Die:
		bra.s 	@Die

@Mappings: incbin "Data/Mappings/TileMaps/Special Game Over.bin"
	even
@Art: incbin "Data/Art/Nemesis/Special Game Over.bin"
	even
@Palette: incbin "Data/Palette/Misc/Special Game Over.bin"
	even