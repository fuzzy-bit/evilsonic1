
; ===============================================================
; Info Screen
; ===============================================================

_InfoScreen_BGM = $9C
_MoveSpeed = $30

; TODO: Rename all of the stuff in Variables to these
; ---------------------------------------------------------------
; Memory variables
; ---------------------------------------------------------------

VDP_Data	equ	$C00000
VDP_Ctrl	equ	$C00004

KosOutput	equ	$FF0000
HScrollBuff	equ	$FFFFCC00	; $380	Hscroll Buffer
ObjectsRAM	equ	$FFFFD000	; $1000	Objects RAM
PalActive	equ	$FFFFFB00	; $80	Active palette buffer
PalTarget	equ	$FFFFFB80	; $80	Target palette
PLCBuffer	equ	$FFFFF680	; $60	PLC buffer

GameMode	equ	$FFFFF600	; b
Joypad	equ	$FFFFF604
VScroll	equ	$FFFFF616	; l	VScroll (A/B)     
PalFadePos	equ	$FFFFF626	; b
PalFadeLen	equ	$FFFFF627	; b
VBlankSub	equ	$FFFFF62A	; b
WaterState	equ	$FFFFF64E	; b

Credits:
		moveq	#$FFFFFFE4,d0
		jsr	PlaySound_Special	; stop music
		jsr ClearScreen
		jsr	ClearPLC		; clear pattern load cues

		move.b 	#0, (v_zone).w
		move.b 	#1, (v_gamecomplete).w
		jsr SaveSRAM

		jsr	PaletteFadeIn		; fade out pallete
		move	#$2700,sr		; disable interrupts

		; Setup VDP registers
		lea	VDP_Ctrl,a6
		move.w	#$8004,(a6)		; Disable HInt
		move.w	#$8134,(a6)		; Disable DISPLAY
		move.w	#$8200+(_VRAM_PlaneA/$400),(a6)
		move.w	#$8400+(_VRAM_PlaneB/$2000),(a6)
		move.w	#$8700,(a6)     	; Backdrop color
		move.w	#$8B00,(a6)		; HScroll mode = 'full'
		
		; Clear stuff
		moveq	#0,d0
		move.b	d0,WaterState
		move.l	d0,VScroll
		jsr	ClearScreen

		; Load font
		lea	Art_CreditsFont,a0
		lea	KosOutput,a1
		jsr	KosDec
		writeVRAM	KosOutput,$20*$74,_VRAM_Font	; Menu font
		
		; Load palette
		lea	PalActive,a0
		move.w	#$000,2(a0)
		move.w	#$EEE,$E(a0)
		move.w	#$000,$22(a0)
		move.w	#$0EE,$2E(a0)

		; Play music
		; moveq	#$FFFFFF00|_InfoScreen_BGM,d0
		; jsr	PlaySound

		; Enable DISPLAY
		move.w	#$8174,VDP_Ctrl

	; ===============================================================
															
		lea	VDP_Ctrl,a6
		lea	-4(a6),a5
		
		cmpi.b	#137,(v_betaolve).w ; check if beta olve syory
		beq		Load_BetaOlveStory  ; if yes,   load Beta

		moveq  	#$FFFFFF9F,d0
		jsr    	PlaySample
		lea		EndCreditsText, a0

InfoScreen_Con:
		locVRAM	_VRAM_PlaneA, d7		; d7 = VRAM Req Base
		moveq	#28,d6			; d6 = Row number
		moveq	#15,d5			; d5 = Row counter
		move.b	#$24,GameMode
		bra.s	InfoScreen_DrawString

InfoScreen_Loop:
		move.b	#2,VBlankSub
		jsr		WaitForVBla
		
		tst.w	d5			; Strings over?
		beq.s	InfoScreen_Quit

		; Scroll screen
		move.l	VScroll,d0
		move.l	d0,d1
		swap	d1			; d1 = Old pos
		addi.l	#_MoveSpeed<<8,d0
		move.l	d0,VScroll
		swap	d0			; d0 = New pos
		eor.w	d1,d0
		andi.w	#$10,d0
		beq.s	InfoScreen_Loop		; if row didn't change, branch

; Draw new string
InfoScreen_DrawString:
		bsr.s	InfoScreen_CalcStringPos	; d0 = VRAM addr
		pea	InfoScreen_Loop
		move.b	(a0)+,d1
		beq.s	InfoScreen_ClearString
		bmi.s	InfoScreen_ClearString_End
		moveq	#0,d3				; d3 = pattern
		subq.b	#1,d1
		beq	InfoScreen_DrawText
		move.w	#_pal1,d3
		bra	InfoScreen_DrawText

InfoScreen_Quit:
		move.b 	#0, GameMode
		rts


; ===============================================================

InfoScreen_ClearString_End:
		subq.w	#1,a0
		subq.w	#1,d5

InfoScreen_ClearString:
		moveq	#0,d2		; d2 = fill pattern
		moveq	#1,d3		; d3 = number of rows
																	
@0		move.l	d0,(a6)
		moveq	#38/2-1,d1	; d1 = number of chars in row / 2

@1		move.l	d2,(a5)
		dbf	d1,@1
		
		addi.l	#$80<<16,d0
		dbf	d3,@0
		rts

; ===============================================================

InfoScreen_CalcStringPos:
		move.l	d6,d0		; d0 = Row
		addq.b	#2,d6
		andi.b	#$1F,d6
		lsl.w	#7,d0		; d0 = Row * $80
		addq.w	#2,d0		; +1 tile
		swap	d0
		add.l	d7,d0		; d0 = VRAM offset
		rts


; ===============================================================
; ---------------------------------------------------------------
; Info screen data array
; ----------------------------------------------------------------

EndCreditsText:
		dc.b	2,'        BRUTAL SONIC - CREDITS        ',0
		dc.b	0
		dc.b	0
		dc.b	2,'             PROJECT LEAD             ',0
		dc.b	1,'             FUZZY                    ',0
		dc.b	0
		dc.b	2,'                 CODE                 ',0
		dc.b	1,'             FUZZY                    ',0
		dc.b	1,'             VLADIKCOMPER             ',0
		dc.b	1,'             GIOVANNI                 ',0
		dc.b	0
		dc.b	2,'     VEPS SOUND DRIVER, MEGAPCM 2     ',0
		dc.b	1,'             VLADIKCOMPER             ',0
		dc.b	0
		dc.b	2,'               GRAPHICS               ',0
		dc.b	1,'             FUZZY                    ',0
		dc.b	1,'             KCEXE                    ',0
		dc.b	1,'             THEBLAD768               ',0
		dc.b	1,'             MIDWAY                   ',0
		dc.b	1,'             FUNAMUSEA                ',0
		dc.b	0
		dc.b	2,'             MUSIC, PORTS             ',0
		dc.b	1,'AMPHOBIUS - MMX SIGMA FORTRESS 1      ',0
		dc.b	1,'KCEXE - SAILOR MOON STREET TRACK      ',0
		dc.b	1,'VLADIKCOMPER - MAGICAL HAT TRACK      ',0
		dc.b	1,'LORDXERNOM - BOWSERS INS. STORY FINALE',0
		dc.b	1,'KCEXE - YUUYUU HAKUSHO - INTRODUCE    ',0
		dc.b	1,'KCEXE - SURGING POWER PORT            ',0
		dc.b	1,'KCEXE - DESTRUCTIVE POWER PORT        ',0
		dc.b	1,'VLADIKCOMPER - THUNDER FORCE IV BOSS  ',0
		dc.b	1,'FOXCONED - SLAYER - RAINING BLOOD PORT',0
		dc.b	1,'DUSTHILLRESIDENT, OERG866 - MONSQUAZ  ',0
		dc.b	1,'LIGHTNING SPLASH - CHILL TO THE MAX   ',0
		dc.b	0
		dc.b	2,'             LEVEL DESIGN             ',0
		dc.b	1,'             FUZZY                    ',0
		dc.b	1,'             GIOVANNI                 ',0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	1,'THIS IS MY FIRST FINISHED HACK, I HOPE',0
		dc.b	1,'YOU HAD AS MUCH FUN AS I DID MAKING IT',0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	2,'        LEVEL SELECT UNLOCKED!        ',0
		dc.b	1,'   THANK YOU FOR PLAYING,  IT MEANS   ',0
		dc.b	1,'            A LOT TO ME. <3           ',0
		dc.b	0

		dc.b	-1	; End of screen
		even

BetaOlveStory:
		dc.b	2,'MY  SUPER   BNETA  OLVE STORY         ',0
		dc.b	2,' BY FENGISH                           ',0
		dc.b 	0
		dc.b 	1,'ONCE APON A TIMESNEWROMAN,            ',0
		dc.b	1,'I WAS A LITTLE BRAPPY WITH A DREAM    ',0
		dc.b	1,'NOT TO BE CONFUSED WITH THE WHITE GUY)',0
		dc.b 	0
		dc.b	1,' I WANTED  TO OBTSAIN THE SONIS 1 TTS ',0
		dc.b	1,'#PROTOTYPECORE CHARTRAGE. I DID NOT BE',0
		dc.b	1,'LIEVE THE BADDY BAD LIES OF FUJI KAKA ',0
		dc.b	1,'FROM LEGA; WHOM SAIDS "THIS BETA IS LO',0
		dc.b	1,'ST MEDIAS, STOP  FUCKING ASKING ME ABO',0
		dc.b	1,'UT IT". NOPERINOS.  I WANTED TO PROVE ',0
		dc.b	1,'TO @EVERYONE, ESPECIALLY THAT UNKINOLY',0
		dc.b	1,' BRAPPAMOID SHITHEAD ERIC (WHO IS VERY',0
		dc.b	1,' #MEANIECORE,) THAT I COULD FIND MY LE',0
		dc.b	1,'GASONIS BETAS, MUCH LIKE ONE CASUALLY ',0
		dc.b	1,'FINDS THEM PIBBYS. I GOOGLESEARCHED FA',0
		dc.b	1,'R AND WIDE ACROSS THE INTER-WEBS, BUT ',0
		dc.b	1,'IT WAS ALL FAKER #HOAXCORE  #BULLSHIT.',0
		dc.b	1,'I HATED SEEING THOSE #FALSIFICATIONC  ',0
		dc.b	1,'ORE INFERIOR COPYS, FOR THEY WERE FULL',0
		dc.b	1,' OF UNKINOLY SIN. I WILL DECLARE MY #@',0
		dc.b	1,'REVENGEANCY ON ALL BNETASLOPPERS, THEY',0
		dc.b	1,' ARE NO-THINGS BUT SERVANTS OF MODERN ',0
		dc.b	1,'DECLINE ZEGACORP.  THEY UNDERSTANDS NO',0
		dc.b	1,'T THE BRILLIANT VISION OF GREAT BROSHI',0
		dc.b	1,'MA. THEY JUST CONSUMES PRODUCTIOS, AND',0
		dc.b	1,' HOT CHIP.  THEY WILL ALL PAY FOR THEI',0
		dc.b	1,'R TERRIBLE SINS, .  END OF RANT; I AM ',0
		dc.b	1,'NOW BECOME #CALMEDCORE, DESTROYER OF Z',0
		dc.b	1,'EGASLOP. I  EVEN SEARCHED I.R.L. (FOR ',0
		dc.b	1,'THOSE, HEH, STUPID #NON-INTELLECTUALCO',0
		dc.b	1,'RE ZOOMERS WHO ARE STUPID AND DUMB AND',0
		dc.b	1,' KNOW NOTHINGS  ABOUT THIS DARIOWORLD,',0
		dc.b	1,' IT MEANSES IN. REAL. LIFE!!!!!!!!!!!!',0
		dc.b	1,'! SOMETHING  THEY WOULDNT KNOW CAUSE  ',0
		dc.b	1,' THYER TOO BUSY PLAYSING MEDIOCRITY   ',0
		dc.b	1,'. GRRRRRR.) FOR THE HOLYKINOS  OF LEGA',0
		dc.b	1,'HISTORY. MY MOMENTUMS WERE OFFTHECHART',0
		dc.b	1,'S THAT DAY; JUST LIKE LEGASONIS, I WAS',0
		dc.b	1,'  MOMENTUMING DOWN VARIOUS INCLINES (S',0
		dc.b	1,'LOPES, FOR THE DUMB ZOOMERS.) AND GAIN',0
		dc.b	1,'ING SPEED! IT WAS TRULY KINOLICIOUS. B',0
		dc.b	1,'UTT. WHEN  I REACHEDS STATE OF "JAPAN"',0
		dc.b	1,', THE LEGABUILDING  WAS NOT THERE. INS',0
		dc.b	1,'TEAD, IT WAS REPLACEDS WITH ZEGA. I BR',0
		dc.b	1,'OKE INTO THE ZEGABULDING AND SEARCHED ',0
		dc.b	1,'EVERYWHERE, BUT ZEGA HAD #IRREPERABLYC',0
		dc.b	1,'ORE DESTROYSED ALL OF  LEGARCHIVES. NO',0
		dc.b	1,'THING WAS LEFT. NOT A SINGLE TRACE OF ',0
		dc.b	1,'LEGASONIS CONCEPTS, EVEN. I WAS LATER ',0
		dc.b	1,'ARRESTED FOR BREAKING INTO THE BUILDIN',0
		dc.b	1,'G.                                    ',0
		dc.b	0
		dc.b 	1,'LESSON OF THE DAY: ONCE AGAIN, THE    ',0
		dc.b	1,'ZEGASLOP RUINS EVERYTHINGS. THEY TOOK ',0
		dc.b	1,'LEGA AWAY FROM US. THEY TOOK OUR KINOS',0
		dc.b	1,'. OUR MOMENTUMS. OUR * SONIS *. THAT I',0
		dc.b	1,'MPOSTER (AMOIMA) ZEGASONIS IS NOT HIM.',0
		dc.b	1,' DO NOT BELIEVER HIS LIES. WE MUST FIG',0
		dc.b	1,'HT TO THE ENDOFCHAPTER TO RESTOR BALAN',0
		dc.b	1,'(CE) ACROSS OUR (DARIO)WONDERWORLD. WE',0
		dc.b	1,' MUST MAKE LEGA #PROUDCORE.           ',0
		dc.b	0
		dc.b	0
		dc.b	1,'EMND OF STORY. I HOPE WHATEVER        ',0
		dc.b	1,'LITTLE BRAPPYS ARE PLAYING            ',0
		dc.b	1,'ENHJOYED MY. TALE                     ',0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	1,'	KILL ME                              ',0
		dc.b	-1	; End of screen
		even

Load_BetaOlveStory:
		music mus_secretcredits
		lea	BetaOlveStory,a0
		jmp	InfoScreen_Con

; ---------------------------------------------------------------
; Subroutine to draw text on screen
; ---------------------------------------------------------------
; INPUT:
;	d0 = VRAM addr
;	d3 = Pattern base
;	a0 = Text
; ---------------------------------------------------------------

InfoScreen_DrawText:
		lea	VDP_Ctrl,a6
		lea	-4(a6),a5
		moveq	#1,d1		; d1 = tile switcher
		swap	d1

@0		lea	(a0),a1		; a1 = copy of text
		move.l	d0,(a6)

@1		moveq	#0,d2
		move.b	(a1)+,d2	; d2 = char
		beq.s	@3
		cmpi.b	#' ',d2		; is char space?
		bls.s	@2
		add.w	d2,d2
		add.w	d3,d2
		add.w	d1,d2
		move.w	d2,(a5)		; display char
		bra.s	@1

@2		moveq	#0,d2
		move.w	d2,(a5)		; display space
		bra.s	@1

@3	 	addi.l	#$80<<16,d0	; next row
		swap	d1
		tst.w	d1
		bne.s	@0
		lea	(a1),a0		; skip char array (useful ^_^)
		rts

Art_CreditsFont:
	incbin	'Data\Art\Kosinski\Credits Font.bin'
	even

; ===========================================================================
; ---------------------------------------------------------------------------
; Levels used in the end sequence demos
; ---------------------------------------------------------------------------
EndDemo_Levels:	incbin	"Data\Miscellaneous\Demo Level Order - Ending.bin"

; ---------------------------------------------------------------------------
; Lamppost variables in the end sequence demo (Star Light Zone)
; ---------------------------------------------------------------------------
EndDemo_LampVar:
		dc.b 1,	1		; number of the last lamppost
		dc.w $A00, $62C		; x/y-axis position
		dc.w 13			; rings
		dc.l 0			; time
		dc.b 0,	0		; dynamic level event routine counter
		dc.w $800		; level bottom boundary
		dc.w $957, $5CC		; x/y axis screen position
		dc.w $4AB, $3A6, 0, $28C, 0, 0 ; scroll info
		dc.w $308		; water height
		dc.b 1,	1		; water routine and state
; ===========================================================================
; ---------------------------------------------------------------------------
; "TRY AGAIN" and "END"	screens
; ---------------------------------------------------------------------------

TryAgainEnd:
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; use 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$9001,(a6)	; 64-cell hscroll size
		move.w	#$9200,(a6)	; window vertical position
		move.w	#$8B03,(a6)	; line scroll mode
		move.w	#$8720,(a6)	; set background colour (line 3; colour 0)
		clr.b	(f_wtr_state).w
		bsr.w	ClearScreen

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
	TryAg_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,TryAg_ClrObjRam ; clear object RAM

		moveq	#plcid_TryAgain,d0
		bsr.w	QuickPLC	; load "TRY AGAIN" or "END" patterns

		lea	(v_pal_dry_dup).w,a1
		moveq	#0,d0
		move.w	#$1F,d1
	TryAg_ClrPal:
		move.l	d0,(a1)+
		dbf	d1,TryAg_ClrPal ; fill palette with black

		moveq	#palid_Ending,d0
		bsr.w	PalLoad1	; load ending palette
		clr.w	(v_pal_dry_dup+$40).w
		move.b	#id_EndEggman,(v_objspace+$80).w ; load Eggman object
		jsr	(ExecuteObjects).l
		jsr	(BuildSprites).l
		move.w	#1800,(v_demolength).w ; show screen for 30 seconds
		bsr.w	PaletteFadeIn

; ---------------------------------------------------------------------------
; "TRY AGAIN" and "END"	screen main loop
; ---------------------------------------------------------------------------
TryAg_MainLoop:
		bsr.w	PauseGame
		move.b	#4,(v_vbla_routine).w
		bsr.w	WaitForVBla
		jsr	(ExecuteObjects).l
		jsr	(BuildSprites).l
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?
		bne.s	TryAg_Exit	; if yes, branch
		tst.w	(v_demolength).w ; has 30 seconds elapsed?
		beq.s	TryAg_Exit	; if yes, branch
		cmpi.b	#id_Credits,(v_gamemode).w
		beq.s	TryAg_MainLoop

TryAg_Exit:
		move.b	#id_Sega,(v_gamemode).w ; goto Sega screen
		rts

; ===========================================================================

		include	"Objects\Screen-Space\Try Again & End Eggman.asm"
		include "Data\Animations\Try Again & End Eggman.asm"
		include	"Objects\Screen-Space\Try Again Emeralds.asm"
Map_EEgg:	include	"Data\Mappings\Objects\Try Again & End Eggman.asm"

; ---------------------------------------------------------------------------
; Ending sequence demos
; ---------------------------------------------------------------------------
Demo_EndGHZ1:	incbin	"Data\Demos\Ending - GHZ1.bin"
		even
Demo_EndMZ:	incbin	"Data\Demos\Ending - MZ.bin"
		even
Demo_EndSYZ:	incbin	"Data\Demos\Ending - SYZ.bin"
		even
Demo_EndLZ:	incbin	"Data\Demos\Ending - LZ.bin"
		even
Demo_EndSLZ:	incbin	"Data\Demos\Ending - SLZ.bin"
		even
Demo_EndSBZ1:	incbin	"Data\Demos\Ending - SBZ1.bin"
		even
Demo_EndSBZ2:	incbin	"Data\Demos\Ending - SBZ2.bin"
		even
Demo_EndGHZ2:	incbin	"Data\Demos\Ending - GHZ2.bin"
		even

		include	"Includes\LevelSizeLoad & BgScrollSpeed.asm"
		include	"Includes\DeformLayers.asm"