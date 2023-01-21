SRetro:
		move.w	#0,($FFFFFF38).w
		move.b	#$E4,d0
		command	mus_Stop ; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		move	#$2700,sr
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

SRetro_ClrObjRam:
		move.l	#0,(a1)+
		dbf	d1,SRetro_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0
		move	#$2300,sr
		
		lea	($FFFF8400).w,a1
		moveq	#0,d0
		move.w	#$BF,d1

SRetro_ClrVars4:
		move.l	d0,(a1)+
		dbf	d1,SRetro_ClrVars4 ; clear object variables

SRetro_LoadArt:
		move.l	#$40000000,($C00004).l
		lea	(Art_SRetro).l,a0 		; load Sonic Retro Logo patterns
		jsr	NemDec
		
		move.l	#$60400000,($C00004).l
		lea	(Art_SRetro_Emerald).l,a0 	; load Sonic Retro Emerald patterns
		jsr	NemDec
		
		move.l	#$6AE00000,($C00004).l
		lea	(Art_SRetro_Sonic).l,a0 	; load Sonic Retro Sonic & Tails patterns
		jsr	NemDec

SRetro_LoadPalMusicBG:
		bsr.w	ClearScreen		
		move	#$2300,sr
		moveq	#0,d0				; load SRetro palette
		lea	(SRetro_PalPointer).l,a1
		move.b 	#1, d1
		bsr.w	PalLoad1_Retro
		music	mus_ExtraLife
		bsr.w	SRetro_DrawText

SRetro_LoadObjects:
		move.b	#1,($FFFFD000).w		; load SRetro Logo object
		move.b	#0,($FFFFD028).w			; Sub-object type (Emerald)
		
SRetro_LoadObjects_STK:
		move.b	#1,($FFFFD040).w		; load SRetro Logo object
		move.b	#1,($FFFFD068).w			; Sub-object type (Sonic & Tails)
		move.b	#1,($FFFFD080).w		; load SRetro Logo object
		move.b	#2,($FFFFD0A8).w			; Sub-object type (Japan Text)
		jsr	SRetro_ObjectsLoad
		jsr	BuildSprites
		bsr.w	PaletteFadeIn


SRetro_Loop:
		move.b	#$16,($FFFFF62A).w
		add.w	#1,($FFFFFF38).w
		bsr.w	WaitForVBla
		jsr	SRetro_ObjectsLoad
		jsr	BuildSprites
		moveq	#0,d1
		move.b	#$50,d1
		cmp.w	#$340,($FFFFFF38).w
		bge.s	SRetro_Exit

		bsr.w	SRetro_Deform

		moveq	#0,d1
		move.b	#$50,d1
		move.b	($FFFFF605).w,d0
		btst	#4,d0
		bne.w	SRetro_Exit
		btst	#5,d0
		bne.w	SRetro_Exit
		btst	#6,d0
		bne.w	SRetro_Exit
		btst	#7,d0
		bne.w	SRetro_Exit
		bra.w	SRetro_Loop

SRetro_Deform:
		lea (v_bgscroll_buffer),a1
		moveq   #0, d0
		moveq	#0, d3					;Avoid using d1 (Calcsine modifies it)
		move.w  #224-1, d2				;Line count to decrease (-1 for dbf)
		move.w  ($FFFFF5C0).w, d0			;Get counter
		move.w	d0, d3					;d0 will be changed, save counter

	@loop:
		moveq	#0, d0
		move.w	d3, d0					;For Calcsine
		bsr.w   CalcSine
		lsr.w	#3, d0					;Make the wave smaller
		neg.w	d3					;Flip per-line counter
		bmi		@OddFrame			;Only add 1 to it on an even frame
		addq	#5, d3					;Next line will be at a different pos (Change for wavy-ness)
	@OddFrame:
		move.l	d0, (a1)+				;Upload to HScroll in RAM (B Plane in bottom word)
		dbf 	d2, @loop
		addq	#2,($FFFFF5C0).w			;Incrementing Speed (Change to adjust speed)
		
		tst.w	($FFFFF614).w				; Check if the timer is up
		andi.b	#$80,($FFFFF605).w			; Check if start was pressed
		rts
		
SRetro_Exit:
		move.b	#0,($FFFFFF86).w
		move.w	#0,($FFFFFF38).w
		move.b	#0,($FFFFFEB2).w
		move.b	#0,($FFFFFEB3).w
		move.b	#id_Title,($FFFFF600).w	; goto title
		rts
		
; ===========================================================================
		
SRetro_DrawText:
		lea	(SRetroText).l,a1
		lea	($C00000).l,a6
		move.l	#$40000003,d4	; screen position (text)
		moveq	#$1B,d1		; number of lines of text
		
SRetro_TextLoop:
		move.l	d4,4(a6)
		bsr.w	SRetro_ChgLine
		addi.l	#$800000,d4
		dbf	d1,SRetro_TextLoop
		rts
		
SRetro_ChgLine:
		moveq	#$27,d2		; number of characters per line

SRetro_ChgLine_Loop1:
		moveq	#0,d0
		move.w	(a1)+,d0
		bpl.s	SRetro_ChgLine_Loop2
		move.w	#0,(a6)
		dbf	d2,SRetro_ChgLine_Loop1
		rts	

SRetro_ChgLine_Loop2:
		move.w	d0,(a6)
		dbf	d2,SRetro_ChgLine_Loop1
		rts
		
SRetroText:
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$001,$002,$003,$004,$005,$006,$007,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$008,$009,$00A,$00B,$00C,$00D,$00E,$00F,$010,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$011,$012,$013,$014,$015,$016,$017,$018,$019,$01A,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$01B,$01C,$01D,$01E,$01F,$020,$021,$022,$023,$024,$025,$026,$027,$028,$029,$02A,$02B,$02C,$02D,$02E,$02F,$030,$031,$032,$033,$034,$035,$036,$037,$038,$039,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$03A,$03B,$03C,$03D,$03E,$03F,$040,$041,$042,$043,$044,$045,$046,$047,$048,$049,$04A,$04B,$04C,$04D,$04E,$04F,$050,$051,$052,$053,$054,$055,$056,$057,$058,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$059,$05A,$05B,$05C,$05D,$05E,$05F,$060,$061,$062,$063,$064,$065,$066,$067,$068,$069,$06A,$06B,$06C,$06D,$06E,$06F,$070,$071,$072,$073,$074,$075,$076,$077,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$078,$079,$07A,$07B,$07C,$07D,$07E,$07F,$080,$081,$082,$083,$084,$085,$086,$087,$088,$089,$08A,$08B,$08C,$08D,$08E,$08F,$090,$091,$092,$093,$094,$095,$096,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$097,$098,$099,$09A,$09B,$09C,$09D,$09E,$09F,$0A0,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$0A1,$0A2,$0A3,$0A4,$0A5,$0A6,$0A7,$0A8,$0A9,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$0AA,$0AB,$0AC,$0AD,$0AE,$0AF,$0B0,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$0B1,$0B2,$0B2,$0B3,$0B4,$0B5,$0B5,$0B6,$0B6,$0B6,$0B7,$0B8,$0B9,$0BA,$0BB,$0BC,$0BD,$0BE,$0B2,$0BD,$0B9,$0B7,$0B9,$0BD,$0BF,$000,$000,$000,$000,$000,$000,$000,$000
		dc.w	$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000,$000
		even

; ===========================================================================

SRetro_PalPointer:
		dc.l Pal_SRetro
		dc.w $FB00
		dc.w $1F
		even
		
Pal_SRetro:	dc.w	$0000,$0222,$0444,$0666,$0888,$0AAA,$0000,$0EEE,$0600,$0822,$0C44,$0EAA,$0246,$006E,$00AE,$00CE
		dc.w	$0000,$0020,$0040,$0060,$0080,$00C0,$04E6,$0EEE,$0024,$0046,$04AC,$0222,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0822,$0A44,$0C66,$0E88,$0EEE,$0AAA,$0888,$0444,$08AE,$046A,$000E,$0008,$0004,$00EE
		dc.w	$0000,$0000,$0206,$020C,$064E,$0080,$0EEE,$0AAA,$0888,$0444,$08AE,$046A,$000E,$0008,$00AE,$008E
		even
		
; ====================================================================================

SRetro_ObjectsLoad:				; XREF: TitleScreen; et al
		lea	($FFFFD000).w,a0 ; set address for object RAM
		moveq	#$7F,d7
		moveq	#0,d0
		cmpi.b	#6,($FFFFD024).w
		bcc.s	SRetro_loc_D362

SRetro_loc_D348:
		move.b	(a0),d0		; load object number from RAM
		beq.s	SRetro_loc_D358
		add.w	d0,d0
		add.w	d0,d0
		movea.l	SRetro_Obj_Index-4(pc,d0.w),a1
		jsr	(a1)		; run the object's code
		moveq	#0,d0

SRetro_loc_D358:
		lea	$40(a0),a0	; next object
		dbf	d7,SRetro_loc_D348
		rts	

SRetro_loc_D362:
		moveq	#$1F,d7
		bsr.s	SRetro_loc_D348
		moveq	#$5F,d7

SRetro_loc_D368:
		moveq	#0,d0
		move.b	(a0),d0
		beq.s	SRetro_loc_D378
		tst.b	1(a0)
		bpl.s	SRetro_loc_D378
		jsr	DisplaySprite

SRetro_loc_D378:
		lea	$40(a0),a0

SRetro_loc_D37C:
		dbf	d7,SRetro_loc_D368
		rts	
; End of function SRetro_ObjectsLoad

; ===========================================================================

SRetro_Obj_Index:
		dc.l	ObjSRetro
		even
		
; ===========================================================================

ObjSRetro:
		moveq	#0,d0
		move.b	$28(a0),d0
		add.w	d0,d0
		add.w	d0,d0
		jmp	ObjSRetro_Index(pc,d0.w)
		rts
; ===========================================================================
ObjSRetro_Index:	
		bra.w ObjSRetro_Emerald
		bra.w ObjSRetro_SonicTails
		bra.w ObjSRetro_JapanText
		
; ===========================================================================			

; ---------------------------------------------------------------------------
; Sub-Object 00 - Emerald
; ---------------------------------------------------------------------------			

ObjSRetro_Emerald:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	ObjSRetro_Emerald_Index(pc,d0.w),d1
		jmp	ObjSRetro_Emerald_Index(pc,d1.w)
; ===========================================================================
ObjSRetro_Emerald_Index:	
			dc.w ObjSRetro_Emerald_Main-ObjSRetro_Emerald_Index
			dc.w ObjSRetro_Emerald_Display-ObjSRetro_Emerald_Index
; ===========================================================================
ObjSRetro_Emerald_Main:
		addq.b	#2,$24(a0)			; Next Action (Display)
		move.w	#$193,8(a0)			; X Position
		move.w	#$102,$A(a0)			; Y Position
		move.l	#Map_ObjSRetro_Emerald,4(a0)	; Mappings Set
		move.w	#$2102,2(a0)			; Art Offset in VRAM
		move.b	#0,1(a0)			; Action Flags
		move.b	#4,$18(a0)			; Sprite Priority (0 = Front)

ObjSRetro_Emerald_Display:
		jmp	DisplaySprite
		
; ---------------------------------------------------------------------------
; Sub-Object 01 - Sonic & Tails
; ---------------------------------------------------------------------------			

ObjSRetro_SonicTails:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	ObjSRetro_SonicTails_Index(pc,d0.w),d1
		jmp	ObjSRetro_SonicTails_Index(pc,d1.w)
; ===========================================================================
ObjSRetro_SonicTails_Index:	
			dc.w ObjSRetro_SonicTails_Main-ObjSRetro_SonicTails_Index
			dc.w ObjSRetro_SonicTails_Display-ObjSRetro_SonicTails_Index
; ===========================================================================
ObjSRetro_SonicTails_Main:
		addq.b	#2,$24(a0)			; Next Action (Display)
		move.w	#$191,8(a0)			; X Position
		move.w	#$E2,$A(a0)			; Y Position
		move.l	#Map_ObjSRetro_SonicWave,4(a0)	; Mappings Set
		move.w	#$4157,2(a0)			; Art Offset in VRAM
		move.b	#0,1(a0)			; Action Flags
		move.b	#3,$18(a0)			; Sprite Priority (0 = Front)
ObjSRetro_SonicTails_Display:
		add.b	#1,$31(a0)
		cmp.b	#$B,$31(a0)
		blt.w	ObjSRetro_SonicTails_Display_Go
		move.b	#0,$31(a0)
		add.b	#1,$30(a0)
		cmp.b	#2,$30(a0)
		bne.w	ObjSRetro_SonicTails_Display_Go
		move.b	#0,$30(a0)
ObjSRetro_SonicTails_Display_Go:
		move.b	$30(a0),$1A(a0)
		jmp	DisplaySprite	
		
; ---------------------------------------------------------------------------
; Sub-Object 02 - Japan Text on Logo
; ---------------------------------------------------------------------------			

ObjSRetro_JapanText:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	ObjSRetro_JapanText_Index(pc,d0.w),d1
		jmp	ObjSRetro_JapanText_Index(pc,d1.w)
; ===========================================================================
ObjSRetro_JapanText_Index:	
			dc.w ObjSRetro_JapanText_Main-ObjSRetro_JapanText_Index
			dc.w ObjSRetro_JapanText_Display-ObjSRetro_JapanText_Index
; ===========================================================================
ObjSRetro_JapanText_Main:
		addq.b	#2,$24(a0)			; Next Action (Display)
		move.w	#$124,8(a0)			; X Position
		move.w	#$FF,$A(a0)			; Y Position
		move.l	#Map_ObjSRetro_Logo,4(a0)	; Mappings Set
		move.w	#0,2(a0)			; Art Offset in VRAM
		move.b	#0,1(a0)			; Action Flags
		move.b	#0,$18(a0)			; Sprite Priority (0 = Front)

ObjSRetro_JapanText_Display:
		jmp	DisplaySprite

; ===========================================================================
		
Map_ObjSRetro_Emerald:		incbin	"Data\Mappings\sRetroEM.map"
				even
			
Map_ObjSRetro_SonicWave:	incbin	"Data\Mappings\sRetroSW.map"
				even
			
Map_ObjSRetro_Logo:		incbin	"Data\Mappings\sRetroLG.map"
			
; ===========================================================================