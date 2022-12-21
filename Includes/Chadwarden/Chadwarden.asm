Chadwarden:
		jsr 	PaletteFadeOut
		move.w	#$2700, sr			; i have no fucking clue what this does
ChadwardenSetUpVDP:
		lea	$C00004,a6
		move.w	#$8004, (a6)			; H-Int disabled
		move.w	#$8B03, (a6)			; screen resolution / shadow-highlight mode disabled
		move.w	#$8720, (a6)			; Backdrop color setting (1st entry from 3rd palette)
		jsr	ClearScreen			; Clear the screen maps and palette
		
		lea	$FFFFD000, a1
		moveq	#0, d0
		move.w	#(($F000-$D000)/4)-1, d1	; $7FF
	@clr:						; OH THE MISERY
		move.l	d0, (a1)+
		dbf	d1, @clr
		move.l	#$40200000, ($C00004).l
		
		lea	ChadwardenSplashArt, a0
		jsr	NemDec
		
		lea	ChadwardenSplashMappings,a0
		lea	$FF0000,a1
		move.w	#0,d0
		bsr.w	EniDec
		
		moveq	#palid_Chadwarden, d0
		jsr 	PalLoad1
		
		copyTilemap	$FF0000,$C000,40,27
		
		jsr	PaletteFadeIn
		move.w	#4*60, $FFFFF614		; 6 seconds

; ---------------------------------------------------------------------------------------------------------------------

ChadwardenLoop:
		move.b  #4,($FFFFF62A).w 		; Function 2 in vInt
		jsr     WaitForVBla           		; Run delay program
		
		tst.w	$FFFFF614			; timer expired?
		beq.s	@quit				; if yes, quit
		
		btst	#bitStart, v_jpadpress1
		beq.s	ChadwardenLoop
@quit:		
		move.b	#id_Title,(v_gamemode).w	; go to title screen
		rts
		
; ======================================================================

ChadwardenSplashArt:		incbin	"Includes\Chadwarden\SplashArt.bin"
		even
ChadwardenSplashPalette:	incbin	"Includes\Chadwarden\SplashPalette.bin"
		even
ChadwardenSplashMappings:	incbin	"Includes\Chadwarden\SplashMappings.bin"
		even
; ======================================================================