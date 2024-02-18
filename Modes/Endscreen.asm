; ---------------------------------------------------------------------------
; Endscreen
; ---------------------------------------------------------------------------
Endscreen:
		jsr    PaletteFadeOut
		jsr    ClearScreen
		
		lea    $FFFF0000, a0
		move.l    #(($FFFF/2)/4)-1, d0
		moveq    #0, d1

@ClearRAM:
		move.l    d1, (a0)+
		dbra    d0, @ClearRAM

		lea	(vdp_control_port).l, a6
		move.w	#$9011, (a6)

		music  	mus_stop

		lea    ($FF0000), a1 ; load background here
		lea    @Mappings, a0
		move.w #320, d0
		jsr    EniDec.w

		lea     ($FF0000), a1
		move.l  #$60000003, d0
		moveq   #39, d1
		moveq   #30, d2
		jsr	   	TilemapToVRAM 	; mappings -> vram

		move.l  #$68000000, ($FFC00004).l
		lea     @Art, a0
		jsr     NemDec

		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$1F, d0
 
@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop

		move.w  #$19, (v_demolength).w
		jsr 	PaletteFadeIn

@PreSampleLoop:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		bne.s 	@PreSampleLoop

		move.w  #$40, (v_demolength).w
		moveq  	#$FFFFFFA6,d0
        jsr    	PlaySample

@NoStartCheckLoop:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		bne.s 	@NoStartCheckLoop
		move.w  #137*2, (v_demolength).w

@MainLoop:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.b	Joypad|Press
		bmi.s	@Return

		tst.w 	(v_demolength).w
		bne.s 	@MainLoop

@Return:
		move.b 	#id_Sega, (v_gamemode).w
		rts

@Mappings: incbin "Data/Mappings/TileMaps/Endscreen.bin"
	even
@Art: incbin "Data/Art/Nemesis/Endscreen.bin"
	even
@Palette: incbin "Data/Palette/Misc/Endscreen.bin"
	even