; ---------------------------------------------------------------------------
; Title	screen
; ---------------------------------------------------------------------------

StartingZone: 	equ 0

; Gonna redo the whole title screen at some point
	rsset	$FFFF8000
TitleScrollTimer:	rs.l	1		; scroll count

TitleScreen:
		command	mus_fadeout	; stop music
		bsr.w	ClearPLC
		jsr 	VDPSetup


		disable_ints
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$9001,(a6)	; 64-cell hscroll size
		move.w	#$9200,(a6)	; window vertical position
		move.w	#$8B03,(a6)
		move.w	#$8701,(a6)	; set background colour (palette line 0, entry 1)
		clr.b	(f_wtr_state).w
		bsr.w	ClearScreen

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

	Tit_ClrObj1:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrObj1	; fill object space ($D000-$EFFF) with 0

		lea	(v_pal_dry_dup).w,a1
		moveq	#cBlack,d0
		move.w	#$1F,d1

	Tit_ClrPal:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrPal	; fill palette with 0 (black)

		move.b	#0,(v_lastlamp).w ; clear lamppost counter
		move.w	#0,(v_debuguse).w ; disable debug item placement mode
		move.w	#0,(f_demo).w	; disable debug mode
		move.w	#0,($FFFFFFEA).w ; unused variable
		move.w	#(StartingZone<<8),(v_zone).w	; set level to GHZ (00)
		move.w	#0,(v_pcyc_time).w ; disable palette cycling

		bsr.w	PaletteFadeOut
		disable_ints
		bsr.w	ClearScreen
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_bgscreenposx).w,a3

		; STILL RUSHED
		lea    ($FF0000), a1 ; load background here
		lea    TitleBGMap, a0
		move.w #800, d0
		jsr    EniDec.w

		copyTilemap	$FF0000,$E000,39,30

		locVRAM	800*$20
		lea     TitleBGArt, a0
		jsr     NemDec

		lea    ($FF0000), a1 ; load background here
		lea    TitleFGMap, a0
		move.w #400-1, d0
		jsr    EniDec.w

		copyTilemap	$FF0000,$C000,33,21
		
		locVRAM	400*$20
		lea     TitleFGArt, a0
		jsr     NemDec

		moveq	#palid_Title,d0	; load title screen palette
		bsr.w	PalLoad1
		move.b	#0,(f_debugmode).w ; disable debug mode
		lea	(v_objspace+$80).w,a1
		moveq	#0,d0
		moveq	#$10-1,d1		; this was causing some problems, fixed the bug

	Tit_ClrObj2:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrObj2

		;move.b	#id_SegaLetter,(v_objspace+$40).w ; load big Sonic object
		;move.b	#id_PSBTM,(v_objspace+$80).w ; load "PRESS START BUTTON" object

		if Revision=0
		else
			tst.b   (v_megadrive).w	; is console Japanese?
			bpl.s   @isjap		; if yes, branch
		endc

		nop
		;move.b	#id_PSBTM,(v_objspace+$C0).w ; load "TM" object
		;move.b	#3,(v_objspace+$C0+obFrame).w
	@isjap:
		;move.b	#id_PSBTM,(v_objspace+$100).w ; load object which hides part of Sonic
		;move.b	#2,(v_objspace+$100+obFrame).w

		move.b	#4,(v_vbla_routine).w	; we can not afford to run the sound driver too
		bsr.w	WaitForVBla		; late, or we will lose the YM data and break music
		music	mus_Title		; play title screen music

		jsr	(ExecuteObjects).l

		lea		TitleScrollTimer, a0
		addi.l	#65536*32/16, (a0)
		move.w	(a0), d0
		neg.w	d0 ; go left
		move.w	d0, (v_hscrolltablebuffer+2).w

		bsr.w 	TitleSine

		add.b	#1, (v_bgscroll_buffer).w
		move.w	#$10, (v_scrposy_dup+2).w

		;jsr	(BuildSprites).l
		moveq	#plcid_Main,d0
		bsr.w	NewPLC
		move.w	#0,(v_title_dcount).w
		move.w	#0,(v_title_ccount).w
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l
		bsr.w	PaletteFadeIn

Tit_MainLoop:
		move.w	#$178,(v_demolength).w ; run title screen 4eva
		move.b	#4,(v_vbla_routine).w
		bsr.w	WaitForVBla
		jsr	(ExecuteObjects).l
		; bsr.w	DeformLayers
		jsr	(BuildSprites).l

		lea		TitleScrollTimer, a0
		addi.l	#65536*32/16, (a0)
		move.w	(a0), d0
		neg.w	d0 ; go left
		move.w	d0, (v_hscrolltablebuffer+2).w

		bsr.w 	TitleSine

		add.b	#1, (v_bgscroll_buffer).w
		move.w	#$10, (v_scrposy_dup+2).w

		add.w 	#$1000/8, v_autosave
		bcc.s	Tit_ChkRegion
		bsr.w 	SaveRandom

; ===========================================================================

Tit_ChkRegion:
		tst.b	(v_megadrive).w	; check	if the machine is US or	Japanese
		bpl.s	Tit_RegionJap	; if Japanese, branch

		lea	(LevSelCode_US).l,a0 ; load US code
		bra.s	Tit_EnterCheat

	Tit_RegionJap:
		lea	(LevSelCode_J).l,a0 ; load J code

Tit_EnterCheat:
		if Cheats=1
		move.w	(v_title_dcount).w,d0
		adda.w	d0,a0
		move.b	(v_jpadpress1).w,d0 ; get button press
		andi.b	#btnDir,d0	; read only UDLR buttons
		cmp.b	(a0),d0		; does button press match the cheat code?
		bne.s	Tit_ResetCheat	; if not, branch
		addq.w	#1,(v_title_dcount).w ; next button press
		tst.b	d0
		bne.s	Tit_CountC
		lea	(f_levselcheat).w,a0
		move.w	(v_title_ccount).w,d1
		lsr.w	#1,d1
		andi.w	#3,d1
		beq.s	Tit_PlayRing
		tst.b	(v_megadrive).w
		bpl.s	Tit_PlayRing
		moveq	#1,d1
		move.b	d1,1(a0,d1.w)	; cheat depends on how many times C is pressed

	Tit_PlayRing:
		move.b	#1,(a0,d1.w)	; activate cheat
		sfx	sfx_RingRight	; play ring sound when code is entered
		bra.s	Tit_CountC
; ===========================================================================

Tit_ResetCheat:
		tst.b	d0
		beq.s	Tit_CountC
		cmpi.w	#9,(v_title_dcount).w
		beq.s	Tit_CountC
		move.w	#0,(v_title_dcount).w ; reset UDLR counter

Tit_CountC:
		move.b	(v_jpadpress1).w,d0
		andi.b	#btnC,d0	; is C button pressed?
		beq.s	loc_3230	; if not, branch
		addq.w	#1,(v_title_ccount).w ; increment C counter
		endc

loc_3230:
		tst.w	(v_demolength).w
		beq.w	GotoDemo
		andi.b	#btnStart,(v_jpadpress1).w ; check if Start is pressed
		beq.w	Tit_MainLoop	; if not, branch

Tit_ChkLevSel:
		tst.b	(f_levselcheat).w ; check if level select code is on
		beq.w	TitleScreen_GoToMenu	; if not, play level
		btst	#bitA,(v_jpadhold1).w ; check if A is pressed
		beq.w	TitleScreen_GoToMenu	; if not, play level

		move.b 	#6, (v_countdown)
		move.w	#$C680, (v_levelselpal)
		music	mus_fadeout
		jsr    	PaletteFadeOut
		jsr 	ClearScreen

		music	mus_Model

		lea	(vdp_data_port).l,a6
		locVRAM	$D000,4(a6)
		lea	(Art_Text).l,a5	; load level select font
		move.w	#$28F,d1

	Tit_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Tit_LoadText	; load level select font

		lea 	Pal_LevelSel, a0
		lea 	($FFFFFB80), a1
		move.w  #$10, d0

	@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop

		move.w  #$10, d0

	@PaletteLoop2:
		move.l  #0, (a1)+
		dbf 	d0, @PaletteLoop2

		jsr 	PaletteFadeIn

		lea	(v_hscrolltablebuffer).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

	Tit_ClrScroll1:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrScroll1 ; clear scroll data (in RAM)

		move.l	d0,(v_scrposy_dup).w
		disable_ints
		lea	(vdp_data_port).l,a6
		locVRAM	$E000
		move.w	#$3FF,d1

	Tit_ClrScroll2:
		move.l	d0,(a6)
		dbf	d1,Tit_ClrScroll2 ; clear scroll data (in VRAM)

		bra.s 	LevelSelect

TitleSine:
		moveq	#0, d4
		moveq	#0, d5
		lea		v_hscrolltablebuffer.w, a1
		move.b	(v_bgscroll_buffer).w, d6

		move.w	(v_bg2screenposx).w, d2
		neg.w	d2
		swap	d2			;Puts plane A's X pos in topmost word

		move.w	#224, d3

@Deform:
		move.b	d6, d0
		add.w	d5, d0
		bsr.w	CalcSine
		asr.w	#4, d1
		move.w	d1, (a1)+		;Send AAAA HScroll entry
       	adda.l  #2, a1
		addq.w	#1, d5			;Inc wave every line
		dbra	d3, @Deform

		rts

; ---------------------------------------------------------------------------
TitleScreen_GoToMenu:
		move.b	#id_Menu, (v_gamemode).w
		rts

        include "Modes/Extras/LevelSelect.asm"