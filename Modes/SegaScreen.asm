; ---------------------------------------------------------------------------
; Sega screen
; ---------------------------------------------------------------------------
SegaScreen_RAM:	equ	$FFFFA000

		rsset	SegaScreen_RAM
SegaScreen_Secret:			rs.b	1	; Secret enabled
SegaScreen_SecretPlaying:	rs.b	1	; Secret playing (lol)

SegaScreen:
		command	mus_Stop
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l, a6
		move.w	#$8004, (a6)			; use 8-colour mode
		move.w	#$8200+(vram_fg>>10), (a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13), (a6) ; set background nametable address
		move.w	#$8700, (a6)			; set background colour (palette entry 0)
		move.w	#$8B00, (a6)			; full-screen vertical scrolling

		tst.b 	(v_sramgameover).W
		beq.s	@NotGameOver

		move.b 	#0, (v_sramgameover).W

		move.b 	#0, (v_zone).w
		move.b 	#3, (v_lives).w
		jsr 	SaveSRAM

@NotGameOver:
        jsr     LoadRandom
		clr.b	(f_wtr_state).w

		disable_ints
		move.w	(v_vdp_buffer1).w, d0
		andi.b	#$BF, d0
		move.w	d0, (vdp_control_port).l
		bsr.w	ClearScreen

		locVRAM	 $200
		lea		(Art_Sega).l, a0 		; load Sega logo patterns
		bsr.w	NemDec
		lea		($FF0000).l, a1

		moveq	#palid_SegaBG, d0
		bsr.w	PalLoad2				; load Sega logo palette

		clr.b	v_csum_start.w			; clear start button check

		move.w	(v_vdp_buffer1).w, d0
		ori.b	#$40, d0				; enable display
		move.w	d0, (vdp_control_port).l

		lea		(v_objspace).w, a1
		moveq	#0, d0
		move.w	#$7FF, d1

@InitObjects:
		move.l	d0, (a1)+ 				; clear object RAM first
		dbf	d1, @InitObjects 

		; THIS SUCKS SO MUCH
		Instance.new SegaLetter, a1
		move.w	#$E0-$6, obX(a1)
		move.w	#$50+2, obScreenY(a1)
		move.w	#-$400, $3A(a1)

		Instance.new SegaLetter, a1
		move.w	#$FF0A-$6, obX(a1)
		move.w	#$50-$6, obScreenY(a1)
		move.b 	#1, obFrame(a1)
		move.w	#-$400+16, $3A(a1)

		Instance.new SegaLetter, a1
		move.w	#$FF36-$6, obX(a1)
		move.w	#$50-$F, obScreenY(a1)
		move.b 	#2, obFrame(a1)
		move.w	#-$400+32, $3A(a1)

		Instance.new SegaLetter, a1
		move.w	#$FF68-$6, obX(a1)
		move.w	#$50-$18, obScreenY(a1)
		move.b 	#3, obFrame(a1)
		move.w	#-$400+64, $3A(a1)
		; End of suckage

		add.w	#4*60, (v_demolength).w ; set delay time (3 seconds on a 60hz system)

@Loop:
		move.b	#2, (v_vbla_routine).w 	; demo time routine
		jsr 	WaitForVBla

		tst.b 	SegaScreen_Secret
		bne.s 	@SecretCheck

		cmp.w 	#(4*60)-10, v_demolength
		blt.s 	@StartCheck

		cmp.b	#btnABC, (v_jpadhold1).w
		bne.s	@StartCheck

		move.b 	#1, SegaScreen_Secret
		add.w 	#7*60, v_demolength
		bra.s 	@StartCheck

@SecretCheck:
		tst.b 	SegaScreen_SecretPlaying
		bne.s 	@StartCheck
		
		cmp.w 	#(8*60), v_demolength
		bge.s 	@StartCheck

		move.b 	#1, SegaScreen_SecretPlaying
		
		moveq  	#$FFFFFF9C,d0
		jsr    	PlaySample

@StartCheck:
		tst.b	(v_jpadpress1).w		; have we pressed the start button?
		bmi.s	@NextScreen 			; if yes, go to the next screen

		tst.w	(v_demolength).w
		beq.s	@NextScreen

		jsr 	(ExecuteObjects).l
		jsr 	(BuildSprites).l

		bra.s 	@Loop

@NextScreen:
		bsr.w	PaletteFadeOut
		move.b	#$28, (v_gamemode).w
		rts
		
; ===========================================================================
		include "Data\Mappings\Sprites\Sega Logo.asm"

Art_Sega: 	incbin "Data\Art\Nemesis\Sega Logo Sprites.bin"
		even
; ===========================================================================