; ---------------------------------------------------------------
; Extremely Hot Image
; ---------------------------------------------------------------
ShowHiddenImage:
		jsr    PaletteFadeOut
		jsr    ClearScreen
		
		lea     $FFFF0000, a0
		move.l  #(($FFFF/2)/4)-1, d0
		moveq   #0, d1

@ClearRAM:
		move.l  d1, (a0)+
		dbra    d0, @ClearRAM

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

		lea	(vdp_control_port).l, a6
        move.w  #$8004,(a6)
        move.w  #$8230,(a6)
        move.w  #$8400+(vram_bg>>13),(a6)
        move.w  #$8700,(a6)
        move.w  #$8C81,(a6)
        move.w  #$9001,(a6)
		
        move.w  #$5A0, (v_demolength).w
        
        ; Art
        locVRAM $0
        lea     @Art, a0
        jsr     NemDec

        ; Mappings
		lea    ($FF0000), a1
		lea    @Mappings, a0
        move.w #0, d0
		move.w #$7FF, d1
		jsr    EniDec
        
        copyTilemap $FF0000,$E000,39,30

        ; Palette
		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$1F, d0

@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop

		bsr.s 	@Deform
		jsr 	PaletteFadeIn

@Loop:
        move.b  #2, (v_vbla_routine).w
        jsr     WaitForVBla

		bsr.s 	@Deform
        bra.s   @Loop

@Deform:
		; Update HScroll
		lea	v_hscrolltablebuffer, a0
		move.w	#224-1, d3

		; Clear some registers for use in the loop
		moveq	#0, d0
		moveq	#0, d2
		moveq	#0, d5

		; Move scroll buffer to d6
		move.b	(v_bgscroll_buffer).w, d6

		@DeformLoop:
			; Sine shit
			move.b	d6, d0	; scroll buffer -> d0
			add.w	d5, d0	; d0 + timer 

			jsr	CalcSine
			asr.w	#4, d1

			; Negate scroll buffer
			bchg.l  #7, d6
			move.b 	d6, (v_bgscroll_buffer).w

			; Increment timer and address 
			addq.w	#1, d5
			move.l	d1, (a0)+

			dbra	d3, @DeformLoop

		add.b	#255-1, (v_bgscroll_buffer).w
		rts

@Art: incbin "Data/Art/Nemesis/HiddenImage.bin"
	even
@Mappings: incbin "Data/Mappings/TileMaps/HiddenImage.bin"
	even
@Palette: incbin "Data/Palette/Misc/HiddenImage.bin"
	even