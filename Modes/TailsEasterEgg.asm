; LITTLE KNOWN FACT: ALSO DOPE ON THE MIC
TailsEasterEgg:
		lea    $FFFF0000, a0
		move.l    #(($FFFF/2)/4)-1, d0
		moveq    #0, d1
@ClearRAM:
		move.l    d1, (a0)+
		dbra    d0, @ClearRAM

		lea	(vdp_control_port).l, a6
		move.w	#$9011, (a6)

		music  	mus_fadeout
		jsr    PaletteFadeOut
		jsr    ClearScreen

		; im not putting in the effort to convert these to macros just for this screen
		lea    ($FF0000), a1 ; load background here
		lea    @Mappings, a0
		move.w #320, d0
		jsr    EniDec.w

		lea     ($FF0000), a1
		move.l  #$60000003, d0
		moveq   #39, d1
		moveq   #30, d2
		jsr	   	TilemapToVRAM 	; mpaaings -> vram

		lea    ($FF0000), a1 ; load background here
		lea    @MappingsFG, a0
		move.w #320, d0
		jsr    EniDec.w

		lea     ($FF0000), a1
		move.l  #$40000003, d0
		moveq   #39, d1
		moveq   #30, d2
		jsr	   	TilemapToVRAM 	; mpaaings -> vram

		move.l  #$68000000, ($FFC00004).l
		lea     @Art, a0
		jsr     NemDec

		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$1F, d0
 
@PaletteLoop:
		move.l  (a0)+, (a1)+
		
		dbf 	d0, @PaletteLoop
		jsr 	PaletteFadeIn

		moveq  	#$FFFFFF9E,d0
        jsr    	PlaySample
		move.b 	#2, (v_countdown)

@MainLoop:
		moveq  	#$0, d0
		lea 	($FFFFFB00), a1
		move.w  #$1F, d0

		subi.b	#1, (v_countdown)
		bsr.s 	@InvertPalette
		
		move.b  #2, $FFFFF62A ; vblank routine #2
		jsr 	WaitForVBla

		bra.s   @MainLoop

@InvertPalette:
		tst.b 	(v_countdown)
		bne.s 	@Return

		move.l  (a1), d1
		not.l	d1
		andi.l 	#%00001110111011100000111011101110, d1
		move.l  d1, (a1)+

		dbf 	d0, @InvertPalette
		move.b 	#2, (v_countdown)

@Return:
		rts

@Mappings: incbin "Data/Mappings/TileMaps/Tails Easter Egg.bin"
	even
@MappingsFG: incbin "Data/Mappings/TileMaps/Tails Easter Egg - Text.bin"
	even
@Art: incbin "Data/Art/Nemesis/Tails Easter Egg.bin"
	even
@Palette: incbin "Data/Palette/Tails Easter Egg.bin"
	even