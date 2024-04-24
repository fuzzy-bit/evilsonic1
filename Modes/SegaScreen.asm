; ---------------------------------------------------------------------------
; Sega screen
; ---------------------------------------------------------------------------
SegaScreen_RAM:	equ	$FFFFA000

		rsset	SegaScreen_RAM
SegaScreen_Secret:			rs.b	1	; Secret enabled
SegaScreen_SecretPlaying:	rs.b	1	; Secret playing (lol)
SegaScreen_SampleId:		rs.b 	1	; Sample ID
							rs.b 	1	;
SegaScreen_AdditionalTime:	rs.w 	1	; Additional time

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

		add.w	#4*60, (v_demolength).w ; set delay time (4 seconds on a 60hz system)

@Loop:
		move.b	#2, (v_vbla_routine).w 	; demo time routine
		jsr 	WaitForVBla

		tst.b 	SegaScreen_Secret
		bne.s 	@SecretCheck

		cmp.w 	#(4*60)-10, v_demolength
		blt.s 	@StartCheck

		lea		@ButtonCombinations, a0
		move.b 	(v_jpadhold1).w, d3

@ButtonCheckLoop:
		move.w 	(a0)+, d2	; load time into d2
		bmi.s  @StartCheck	; exit if we're at the end of the table (time entry is negative)

		cmp.b	(a0)+, d3	; check button combination
		beq.s	@FoundMatchingButtons	; if v_jpadhold1 == (a0), branch

		addq.w	#1, a0		; skip sample id
		bra.s	@ButtonCheckLoop	; loop back

@FoundMatchingButtons:
		move.b 	(a0), SegaScreen_SampleId
		move.w 	d2, SegaScreen_AdditionalTime
		add.w 	d2, v_demolength

		move.b 	#1, SegaScreen_Secret
		bra.s 	@StartCheck

@SecretCheck:
		tst.b 	SegaScreen_SecretPlaying
		bne.s 	@StartCheck
		
		move.w 	v_demolength, d0
		move.w 	v_demolength, d1
		move.w 	SegaScreen_AdditionalTime, d2
		sub.w 	#$40, d1
		sub.w 	d2, d1

		tst.w 	d1
		bne.s 	@StartCheck

		move.b 	#1, SegaScreen_SecretPlaying
		
		move.b  SegaScreen_SampleId, d0
		jsr    	PlaySample

@StartCheck:
		tst.b	(v_jpadpress1).w		; have we pressed the start button?
		bmi.s	@NextScreen 			; if yes, go to the next screen

		tst.w	(v_demolength).w
		beq.s	@NextScreen

		jsr 	(ExecuteObjects).l
		jsr 	(BuildSprites).l

		bra.w 	@Loop

@NextScreen:
		bsr.w	PaletteFadeOut
		move.b	#$28, (v_gamemode).w
		rts
		
; ===========================================================================

@ButtonCombinations:
		; Time
		; Buttons ; Sample

		; Genesis Does
		dc.w 	7*60
		dc.b 	btnABC, $9C

		; もげーたんと
		; いいことしよ？
		; Moge-tan to... Ii koto shi yo?
		dc.w 	2*60
		dc.b 	btnA, $A1

		; Oh Jeez
		dc.w 	60
		dc.b 	btnB, $A2

		; The One And Only
		dc.w 	4*60
		dc.b 	btnC, $A5

		dc.w	$FFFF

; ===========================================================================
		include "Data\Mappings\Sprites\Sega Logo.asm"

Art_Sega: 	incbin "Data\Art\Nemesis\Sega Logo Sprites.bin"
		even
; ===========================================================================