Menu:

; ===============================================================
; SONIC WINTER ADVENTURES LOGO
; ===============================================================

; ---------------------------------------------------------------
; Constants
; ---------------------------------------------------------------

_Nametbl_PlaneA = $C000 ;
_Nametbl_PlaneB = $E000 ;

_VRAM_LogoBG	= $20
_VRAM_LogoBG_Pat = (_VRAM_LogoBG/$20) 
_VRAM_MenuFont	= $2000
_VRAM_MenuFont_Pat = (_VRAM_MenuFont/$20)
_VRAM_Logo	= $8000
_VRAM_Logo_Pat	= (_VRAM_Logo/$20)
_VRAM_PSB	= $A000
_VRAM_PSB_Pat	= (_VRAM_PSB/$20)

Logo_BGTiles	= $FF0000			;		uncompressed logo bg tiles
Logo_BGMap	= $FFFF8000			;		uncompressed logo bg mappings

Logo_MenuID	= $FFFFA004			; b		Currently selected menu
Logo_MenuItemID = $FFFFA005			; b		Currently selected menu item
Logo_MenuSize	= $FFFFA006			; b		Number of items in the menu	  
Logo_MenuStatus = $FFFFA007			; b		Indicates menu status ($80 - working, indicates number of objects remain)
Logo_MenuAnim_In = $FFFFA008			; b		Menu appear animation
Logo_MenuAnim_Out = $FFFFA009			; b		Menu hide anim
Logo_TargetPos	= $FFFFA00A			; w		Logo Target position

; ===============================================================
; ---------------------------------------------------------------
; Init Screen Mode
; ---------------------------------------------------------------

Logo:
	command	mus_fadeout

	jsr	PaletteFadeOut
	move	#$2700, sr			; disable interrupts

	lea	vdp_control_port, a6
	move.w	#$8C81,(a6)			; use 320x224 resolution
	move.w	#$8004,(a6)			; disable HInt
	move.w	#$8700,(a6)			; Backdrop Color: 0
	move.w	#$8200|(_Nametbl_PlaneA/$400),(a6)	; plane A base
	move.w	#$8400|(_Nametbl_PlaneB/$2000),(a6)	; plane B base
	move.w	#$8ADF,(a6)
	move.w	#$9001,(a6)			; plane size: 64x32
	move.w	#$8B03,(a6)			; VScroll: full; HScroll: 1px
	move.w	#$8134,(a6)			; disable display
	jsr	ClearScreen

	; Clear objects RAM
	lea	v_player, a0
	move.w	#$2000/$10-1, d0
	moveq	#0, d1
@clr	move.l	d1, (a0)+
	move.l	d1, (a0)+
	move.l	d1, (a0)+
	move.l	d1, (a0)+
	dbf	d0, @clr

	; Load palette ($40 bytes)
	lea	Palette+$80,a0
	lea	LogoMain_Palette,a1
	lea	-$80(a0),a2
	moveq	#5,d0
@0	move.l	(a1)+, (a0)+			; $10 bytes
	move.l	(a1)+, (a0)+			;
	move.l	(a1)+, (a0)+			;
	move.l	(a1)+, (a0)+			;
	dbf	d0, @0

	; Load patterns
	lea	Kos_MenuFont,a0			; Menu font
	lea	$FF0000,a1
	jsr	KosDec
	writeVRAM $FF0000, $1380, _VRAM_MenuFont

	music	mus_title

	; Setup screen vars
	moveq	#0, d0
	move.w	d0, $FFFFF616
	move.w	d0, LevelTimer
	move.w	d0, CamXPos

	; Prepare screen to show up
	jsr	PaletteFadeIn

; ===============================================================
; ---------------------------------------------------------------
; Prepare to menu appearence loop
; ---------------------------------------------------------------

	; Load the first menu & rock
	moveq	#1,d1
	move.b	d1, Logo_MenuID
	moveq	#0,d0
	move.b	d0, Logo_MenuItemID
	move.b	d0, Logo_MenuAnim_In
	jsr	LogoMain_LoadMenu

; ---------------------------------------------------------------
; Menu controls loop
; ---------------------------------------------------------------

LogoMain_MenuControlLoop:
	move.b	#2, (v_vbla_routine).w 	; demo time routine
	jsr	WaitForVBla

	jsr	LogoMain_BGParalax

	; Run menu objects
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	LogoMain_ControlMenu
	beq	LogoMain_MenuControlLoop 	; if nothing was selected, branch

	jmp	LogoMain_MenuExecute

; ---------------------------------------------------------------
; Menu hide loop
; ---------------------------------------------------------------

LogoMain_MenuHide:
	sfx	sfx_ringright

	move.b	Logo_MenuSize,d0
	neg.b	d0
	move.b	d0,Logo_MenuStatus

LogoMain_MenuHideLoop:
	jsr	WaitVSync
	addq.w	#2,CamXPos			; scroll bg
	jsr	LogoMain_BGParalax
	jsr	ObjectsLoad
	jsr	BuildSprites
	tst.b	Logo_MenuStatus			; has all items been done?
	bne.s	LogoMain_MenuHideLoop		; if not, branch
	
	jsr	LogoMain_LoadMenu		; load new menu
	bra	LogoMain_MenuAppearLoop

; ---------------------------------------------------------------
; Menu hide loop 2
; ---------------------------------------------------------------

LogoMain_MenuHide2:
	sfx	sfx_ringright

	move.b	Logo_MenuSize,d0
	neg.b	d0
	move.b	d0,Logo_MenuStatus
	move.w	#8,Logo_PSBTimer
	move.b	#$3F,PalEngine_FadeLen

LogoMain_MenuHideLoop2:
	jsr	WaitVSync
	addq.w	#2,CamXPos				; scroll bg
	jsr	LogoMain_BGParalax
	jsr	ObjectsLoad
	jsr	BuildSprites
	
	cmpi.w	#-30,d0
	bne.s	@0
	moveq	#$FFFFFFE0,d0
	jsr	PlaySound_Special
	bra	LogoMain_MenuHideLoop2

@0	cmpi.w	#-180,d0
	beq.s	@Quit

	; Fade out BG
	btst	#0,d0
	bne	LogoMain_MenuHideLoop2
	lea	Palette,a0
	jsr	Pal_SingleFadeFrom
	bra.s	LogoMain_MenuHideLoop2

@Quit:	move.w	#$8C81, vdp_control_port			; turn off SH
	rts

; ===============================================================











; ===============================================================
; ---------------------------------------------------------------
; Subroutine to load a menu
; ---------------------------------------------------------------
				
ypos = $A
index = $1F

LogoMain_LoadMenu:
	moveq	#0,d0
	moveq	#0,d3				; d3 = Frame Bank
	move.b	Logo_MenuID,d0			; d0 = Menu ID
	add.w	d0,d0
	lea	LogoMain_MenuElements,a1
	add.w	(a1,d0),a1			; get data pointer for this menu
	move.w	(a1)+,Logo_TargetPos
	move.b	(a1)+,Logo_MenuItemID		; set default item
	moveq	#0,d0
	move.b	(a1)+,d0
	move.b	d0,Logo_MenuStatus		; set menu status for processing shit
	move.b	d0,Logo_MenuSize
	subq.w	#1,d0				; d0 = Number of elements

	lea	v_player,a0
	moveq	#$FFFFFF8F,d1
	move.l	#Obj_MenuItem,d2

@CreateItem:
	move.b	d1,(a0)
	move.l	d2,obj(a0)			; code offset
	move.b	(a1)+,index(a0)
	move.b	(a1)+,frame(a0)
	add.b	d3,frame(a0)
	move.w	(a1)+,ypos(a0)
	lea	$40(a0),a0			; next object
	dbf	d0,@CreateItem
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to control menu 'n' shit
; ---------------------------------------------------------------

LogoMain_ControlMenu:
	move.b	v_jpadpress2,d3
	move.b	Logo_MenuItemID,d1
	move.b	Logo_MenuSize,d2

	btst	#bitDn,d3			; Down pressed?
	beq.s	@ChkUp				; if not, branch
	addq.b	#1,d1
	cmp.b	d2,d1
	bne.s	@SetNewItem
	moveq	#0,d1
	bra.s	@SetNewItem

@ChkUp	btst	#iUp,d3				; Up pressed?
	beq.s	@ChkSelect			; if not, branch
	subq.b	#1,d1
	bpl.s	@SetNewItem		 
	subq.b	#1,d2				; d2 = max item index
	move.b	d2,d1

@SetNewItem:
	move.b	d1,Logo_MenuItemID

	sfx	sfx_ringright	

@ChkSelect:
	andi.b	#btnABC+btnStart,d3		; A/B/C/Start pressed?
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to exeCUTE menu commanda
; ---------------------------------------------------------------

LogoMain_MenuExecute:
	moveq	#0, d0
	move.b	Logo_MenuID, d0
	add.w	d0, d0
	lea	LogoMain_MenuCommands, a1
	add.w	(a1,d0), a1				; get array
	move.b	Logo_MenuItemID, d0
	add.w	d0,d0					; d0 = 2x
	move.w	d0,d1
	add.w	d0,d0					; d0 = 4x
	add.w	d0,d0					; d0 = 8x
	add.w	d1,d0					; d0 = 10x
	adda.w	d0,a1					; get commanda
	move.w	(a1)+, Logo_MenuAnim_In
	movea.l (a1)+, a2
	pea	(a2)					; loop handler
	movea.l (a1), a1
	jmp	(a1)					; commanda handler


; ===============================================================
; ---------------------------------------------------------------
; Menu Datas
; ---------------------------------------------------------------

; Intro Animations
_FromBottom = $00
_FromRight = $01
_FromLeft = $02

; Outro Animations
_ToLeft = $00
_ToRight = $01
_ToBottom = $02

LogoMain_MenuCommands:
@L	dc.w	MainMenu_Full_Cmd-@L		; $00
	dc.w	MainMenu_Locked_Cmd-@L		; $01
	dc.w	OptionsMenu_Cmd-@L		; $02
	dc.w	SRAMChoice_Cmd-@L		; $03

LogoMain_MenuElements:
@L	dc.w	MainMenu_Full-@L		; $00
	dc.w	MainMenu_Locked-@L		; $01
	dc.w	OptionsMenu-@L			; $02
	dc.w	SRAMChoice-@L			; $03
; ---------------------------------------------------------------

MainMenu_Full:
	dc.w	$18				; Logo Position
	dc.b	0				; Default Item
	dc.b	3				; Size
	dc.w	$0000, $120			; Index/Frame, Y-pos
	dc.w	$0101, $132			;
	dc.w	$0202, $144			;
		
MainMenu_Full_Cmd:
	; PLAY
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	LogoMain_MenuHide2		; Loop handler
	dc.l	Hwnd_MainMenu_Play		; Code handler

	; CHALLENGES
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	LogoMain_MenuHide2		; Loop handler
	dc.l	Hwnd_MainMenu_Challenges	; Code handler

	; OPTIONS
	dc.b	_FromRight,_ToLeft		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_MainMenu_Options		; Code handler

; ---------------------------------------------------------------
MainMenu_Locked:
	dc.w	$18				; Logo Position
	dc.b	0				; Default Item
	dc.b	3				; Size
	dc.w	$0000, $120			; Index/Frame, Y-pos
	dc.w	$0107, $132			;
	dc.w	$0202, $144			;

MainMenu_Locked_Cmd:
	; PLAY
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	LogoMain_MenuHide2		; Loop handler
	dc.l	Hwnd_MainMenu_Play		; Code handler

	; ? ? ?
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	LogoMain_MenuControlLoop	; Loop handler
	dc.l	Hwnd_Locked			; Code handler

	; OPTIONS
	dc.b	_FromRight,_ToLeft		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_MainMenu_Options		; Code handler

; ---------------------------------------------------------------
OptionsMenu:
	dc.w	$28				; Logo Position
	dc.b	0				; Default Item
	dc.b	4				; Size
	dc.w	$0003, $10E			; Index/Frame, Y-pos
	dc.w	$0104, $120			;
	dc.w	$0205, $132			;
	dc.w	$0306, $144			;
	
OptionsMenu_Cmd:
	; LANGUAGE
	dc.b	_FromRight,_ToRight		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_Options_Lang		; Code handler

	; CLEAR SRAM
	dc.b	_FromRight,_ToLeft		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_Options_ClearSRAM		; Code handler

	; SOUND TEST
	dc.b	0,_ToLeft			; In/Out anim
	dc.l	LogoMain_MenuHide2		; Loop handler
	dc.l	Hwnd_Options_SoundTest		; Code handler

	; BACK
	dc.b	_FromLeft,_ToRight		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_Options_Back		; Code handler

; ---------------------------------------------------------------
SRAMChoice:
	dc.w	$28				; Logo Position
	dc.b	1				; Default Item
	dc.b	2				; Size
	dc.w	$0008, $128			; Index/Frame, Y-pos
	dc.w	$0109, $138			;

SRAMChoice_Cmd:
	; YES
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	LogoMain_MenuHide2		; Loop handler
	dc.l	Hwnd_SRAMChoice_Yes		; Code handler

	; NO
	dc.b	_FromLeft,_ToRight		; In/Out anim
	dc.l	LogoMain_MenuHide		; Loop handler
	dc.l	Hwnd_SRAMChoice_No		; Code handler


; ---------------------------------------------------------------
; Menu Handlers
; ---------------------------------------------------------------

Hwnd_MainMenu_Play:
	clr.b	$FFFFFE30			; clear lamp post counter
	clr.b	LevelMission			; clear mission
	move.b	#3,$FFFFFE12			; set lives counter to 3

	moveq	#$08,d0				; --> Level Select
;	tst.b	GameCompleteFlag		; was the game completed?
;	bne.s	@0				; if yes, branch
;	moveq	#$0C,d0				; --> Level
;	move.w	#$0000,CurrentLevel		; --> GHZ 1

	move.b	d0, GameMode
	move.b	#$04, GameMode
	rts

; ---------------------------------------------------------------
Hwnd_MainMenu_Challenges:
	move.b	#$14, GameMode
	rts

; ---------------------------------------------------------------
Hwnd_MainMenu_Options:
	move.b	#$02, Logo_MenuID
	rts

; ---------------------------------------------------------------
Hwnd_Locked:
	moveq	#$FFFFFFD4,d0			; play locked sounda
	jmp	PlaySound

; ---------------------------------------------------------------
Hwnd_Options_Lang:
	rts

; ---------------------------------------------------------------
Hwnd_Options_ClearSRAM:
	lea	v_player+$40,a0			; get DeleteProgress object
	move.l	#MenuItem_Hide_MarkGone,obj(a0) ; delete it...
	move.l	#Obj_SRAMChoice_Title,d1
	jsr	FindNextFreeObj			; create object as (A0) child
	move.w	$A(a0),$A(a1)			; fix ypos
	move.b	frame(a0),frame(a1)
	move.b	#$03,Logo_MenuID		; change menus
	rts

Hwnd_SRAMChoice_Yes:
	move.b	#$00,GameMode
	jmp	SRAM_SetDefaults
	
Hwnd_SRAMChoice_No:
	move.b	#$02,Logo_MenuID
	rts

; ---------------------------------------------------------------
Hwnd_Options_SoundTest:
	move.b	#$18,GameMode
	rts

; ---------------------------------------------------------------
Hwnd_Options_Back:
	moveq	#$00,d1				; Missions locked
	tst.b	GameCompleteFlag
	bne.s	@0
	moveq	#$01,d1				; Missions unlocked
@0	move.b	d1,Logo_MenuID
	rts


; ===============================================================













; ===============================================================
; ---------------------------------------------------------------
; Object: Menu Items
; ---------------------------------------------------------------

xpos = 8
ypos = $A
index = $1F
xpos2 = $30
ypos2 = $34
acc = $38
timer = $3A

Obj_MenuItem:

	; Select appear routine according to menu animation
	moveq	#0,d0
	move.b	Logo_MenuAnim_In,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	@AppearRoutines(pc,d0),obj(a0)
	move.l	#ObjMap_MenuItems,maps(a0)
	rts
	
@AppearRoutines:
	dc.l	MenuItem_Appear_Bottom
	dc.l	MenuItem_Appear_Right
	dc.l	MenuItem_Appear_Left

; ---------------------------------------------------------------
; Menu appears from bottom
; ---------------------------------------------------------------

MenuItem_Appear_Bottom:
	move.l	#@Appear_Process,obj(a0)
	move.w	#$80+160,xpos(a0)

	; Setup entry position and speeds
	moveq	#0,d0
	move.b	index(a0),d0
	add.w	d0,d0			; d0 = index*2
	move.w	d0,d1
	add.w	d0,d0			; d0 = index*4
	add.w	d1,d0			; d0 = index*6
	lea		@Appear_Data(pc,d0),a1
	move.w	ypos(a0),d0
	add.w	(a1)+,d0
	move.w	d0,ypos2(a0)
	move.w	(a1)+,yvel(a0)
	move.w	(a1)+,acc(a0)
	rts

; ---------------------------------------------------------------
@Appear_Process:
	move.w	yvel(a0),d1
	bmi		MenuItem_Goto_ProcessNormal
	move.w	d1,d0
	ext.l	d0
	lsl.l	#8,d0
	sub.l	d0,ypos2(a0)

	sub.w	acc(a0),d1
	move.w	d1,yvel(a0)

	move.w	ypos2(a0),d0
	move.w	d0,ypos(a0)
	cmpi.w	#$80+240,d0
	bls		MenuItem_Display
	rts	   

; ---------------------------------------------------------------
@Appear_Data:
	;		Position		Start Speed		Acceleration
	dc.w	$80+4,			$800,			$40
	dc.w	$100+$8,		$1000,			$80
	dc.w	$180+$C,		$1800,			$C0

; ---------------------------------------------------------------
; Menu appears from right
; ---------------------------------------------------------------

MenuItem_Appear_Right:
	move.w	#-$2000,xvel(a0)
	move.w	#$80+160+$100,xpos2(a0)
	move.b	index(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,timer(a0)
	move.l	#@Appear_Wait,obj(a0)

@Appear_Wait:
	subq.b	#1,timer(a0)
	bmi.s	@Appear_Process
	rts

@Appear_Process:
	move.w	#$1E8,d1
	bsr		MenuItem_MoveXAcc
	tst.w	xvel(a0)
	bmi.s	MenuItem_Display
	move.l	#MenuItem_Appear_ChkPos,obj(a0)
	bra.s	MenuItem_Appear_ChkPos

; ---------------------------------------------------------------
; Menu appears from left
; ---------------------------------------------------------------

MenuItem_Appear_Left:
	move.w	#$2000,xvel(a0)
	move.w	#$80+160-$100,xpos2(a0)
	move.b	index(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,timer(a0)
	move.l	#@Appear_Wait,obj(a0)

@Appear_Wait:
	subq.b	#1,timer(a0)
	bmi.s	@Appear_Process
	rts

@Appear_Process:
	move.w	#-$1E8,d1
	bsr		MenuItem_MoveXAcc
	tst.w	xvel(a0)
	bpl.s	MenuItem_Display
	move.l	#MenuItem_Appear_ChkPos,obj(a0)

MenuItem_Appear_ChkPos:
	moveq	#1,d0
	cmpi.w	#$80+160,xpos(a0)
	beq.s	MenuItem_Goto_ProcessNormal
	bcs.s	@Move
	moveq	#-1,d0
@Move:	add.w	d0,xpos(a0)
	bra.s	MenuItem_Display

; ---------------------------------------------------------------
MenuItem_Goto_ProcessNormal:
	move.l	#MenuItem_ProcessNormal,obj(a0)
	subq.b	#1,Logo_MenuStatus

; ---------------------------------------------------------------
; Menu item works in menu
; ---------------------------------------------------------------

MenuItem_ProcessNormal:
	tst.b	Logo_MenuStatus
	bmi.s	MenuItem_Hide

; ---------------------------------------------------------------
MenuItem_Display:
	move.w	#$8000+_VRAM_MenuFont_Pat,d1
	move.b	Logo_MenuItemID,d0
	cmp.b	index(a0),d0			; is this item selected?
	beq.s	@skip					; if yes, branch
	addi.w	#_pal3,d1
@skip	move.w	d1,art(a0)

MenuItem_Display2:
	jmp		DisplaySprite

; ---------------------------------------------------------------

MenuItem_Hide:

	; Select hide routine according to menu animation
	moveq	#0,d0
	move.b	Logo_MenuAnim_Out,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	@HideRoutines(pc,d0),obj(a0)
	bra.s	MenuItem_Display2
	
@HideRoutines:
	dc.l	MenuItem_Hide_Left
	dc.l	MenuItem_Hide_Right
	dc.l	MenuItem_Hide_Bottom

; ---------------------------------------------------------------
; Menu Items move left
; ---------------------------------------------------------------

MenuItem_Hide_Left:
	move.w	#-$180,acc(a0)
	
MenuItem_Hide_Directional:
	move.b	index(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,timer(a0)
	move.l	#@Hide_WaitTurn,obj(a0)

; ---------------------------------------------------------------
@Hide_WaitTurn:
	subq.b	#1,timer(a0)			; is it time to hide?
	bpl.s	MenuItem_Display2		; if nop, branch
	move.w	xpos(a0),xpos2(a0)
	move.l	#@Hide_Process,obj(a0)

; ---------------------------------------------------------------
@Hide_Process:
	move.w	acc(a0),d1
	bsr.s	MenuItem_MoveXAcc
	move.w	xpos(a0),d0
	lsl.w	#6,d0
	bpl		MenuItem_Display2
	bra.s	MenuItem_Hide_MarkGone

; ---------------------------------------------------------------
; Menu Items move right
; ---------------------------------------------------------------

MenuItem_Hide_Right:
	move.w	#$180,acc(a0)
	bra		MenuItem_Hide_Directional

; ---------------------------------------------------------------
; Menu Items move bottom
; ---------------------------------------------------------------

MenuItem_Hide_Bottom:
	moveq	#$40/$20,d0
	add.b	index(a0),d0
	lsl.w	#5,d0					; d0 *= $20
	move.w	d0,acc(a0)
	move.w	ypos(a0),ypos2(a0)
	clr.w	yvel(a0)
	move.l	#@Hide_Process,obj(a0)
	
@Hide_Process:
	move.w	yvel(a0),d1
	move.w	d1,d0
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,ypos2(a0)

	add.w	acc(a0),d1
	move.w	d1,yvel(a0)

	move.w	ypos2(a0),d0
	move.w	d0,ypos(a0)
	cmpi.w	#$80+240,d0
	bls		MenuItem_Display

MenuItem_Hide_MarkGone:
	addq.b	#1,Logo_MenuStatus		; mark obj as gone
	jmp		DeleteObject

; ---------------------------------------------------------------
; Subroutine to make item move with acceleration
; ---------------------------------------------------------------

MenuItem_MoveXAcc:
	move.w	xvel(a0),d0
	add.w	d1,d0
	move.w	d0,xvel(a0)
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,xpos2(a0)
	move.w	xpos2(a0),xpos(a0)
	rts


; ---------------------------------------------------------------
ObjMap_MenuItems:
@L
	dc.w	@PLAY_EN-@L		; $00
	dc.w	@CHAL_EN-@L		; $01
	dc.w	@OPTS_EN-@L		; $02
	dc.w	@LANG_EN-@L		; $03
	dc.w	@SRAM_EN-@L		; $04
	dc.w	@SNDT_EN-@L		; $05
	dc.w	@BACK_EN-@L		; $06
	dc.w	@LOCKED-@L		; $07
	dc.w	@YES_EN-@L		; $08
	dc.w	@NO_EN-@L		; $09
	
Logo_MenuFrames equ (*-@l)/4		; define number of frames for the menu

; ---------------------------------------------------------------
@LOCKED:
Xdisp = $28/2

	dc.b	3
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $3C, $00-Xdisp ; ?
	dc.b	$F8, %0001, $00, $3C, $10-Xdisp ; ?
	dc.b	$F8, %0001, $00, $3C, $20-Xdisp ; ?

; ---------------------------------------------------------------
@PLAY_EN:
Xdisp = $10

	dc.b	4
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $5E, $00-Xdisp ; P
	dc.b	$F8, %0001, $00, $56, $08-Xdisp ; L
	dc.b	$F8, %0001, $00, $40, $10-Xdisp ; A
	dc.b	$F8, %0001, $00, $70, $18-Xdisp ; Y

@CHAL_EN:
Xdisp = $50/2

	dc.b	10
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $44, $00-Xdisp ; C
	dc.b	$F8, %0001, $00, $4E, $08-Xdisp ; H
	dc.b	$F8, %0001, $00, $40, $10-Xdisp ; A
	dc.b	$F8, %0001, $00, $56, $18-Xdisp ; L
	dc.b	$F8, %0001, $00, $56, $20-Xdisp ; L
	dc.b	$F8, %0001, $00, $48, $28-Xdisp ; E
	dc.b	$F8, %0001, $00, $5A, $30-Xdisp ; N
	dc.b	$F8, %0001, $00, $4C, $38-Xdisp ; G
	dc.b	$F8, %0001, $00, $48, $40-Xdisp ; E
	dc.b	$F8, %0001, $00, $64, $48-Xdisp ; S

@OPTS_EN:
Xdisp = $38/2

	dc.b	6
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0101, $00, $5C, $00-Xdisp ; 0P
	dc.b	$F8, %0001, $00, $66, $10-Xdisp ; T
	dc.b	$F8, %0001, $00, $50, $18-Xdisp ; I
	dc.b	$F8, %0001, $00, $5C, $20-Xdisp ; 0
	dc.b	$F8, %0001, $00, $5A, $28-Xdisp ; N
	dc.b	$F8, %0001, $00, $64, $30-Xdisp ; S
	

@LANG_EN:
Xdisp = $88/2

	dc.b	16
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $56, $00-Xdisp ; L
	dc.b	$F8, %0001, $00, $40, $08-Xdisp ; A
	dc.b	$F8, %0001, $00, $5A, $10-Xdisp ; N
	dc.b	$F8, %0001, $00, $4C, $18-Xdisp ; G
	dc.b	$F8, %0001, $00, $68, $20-Xdisp ; U
	dc.b	$F8, %0001, $00, $40, $28-Xdisp ; A
	dc.b	$F8, %0001, $00, $4C, $30-Xdisp ; G
	dc.b	$F8, %0001, $00, $48, $38-Xdisp ; E
	dc.b	$F8, %0001, $00, $32, $40-Xdisp ; :

	dc.b	$F8, %0001, $00, $48, $50-Xdisp ; E
	dc.b	$F8, %0001, $00, $5A, $58-Xdisp ; N
	dc.b	$F8, %0001, $00, $4C, $60-Xdisp ; G
	dc.b	$F8, %0001, $00, $56, $68-Xdisp ; L
	dc.b	$F8, %0001, $00, $50, $70-Xdisp ; I
	dc.b	$F8, %0001, $00, $64, $78-Xdisp ; S
	dc.b	$F8, %0001, $00, $4E, $80-Xdisp ; H
	
@SRAM_EN:
Xdisp = $80/2

	dc.b	14
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $46, $00-Xdisp ; D
	dc.b	$F8, %0001, $00, $48, $08-Xdisp ; E
	dc.b	$F8, %0001, $00, $56, $10-Xdisp ; L
	dc.b	$F8, %0001, $00, $48, $18-Xdisp ; E
	dc.b	$F8, %0001, $00, $66, $20-Xdisp ; T
	dc.b	$F8, %0001, $00, $48, $28-Xdisp ; E

	dc.b	$F8, %0001, $00, $64, $38-Xdisp ; S
	dc.b	$F8, %0001, $00, $40, $40-Xdisp ; A
	dc.b	$F8, %0001, $00, $6A, $48-Xdisp ; V
	dc.b	$F8, %0001, $00, $48, $50-Xdisp ; E

	dc.b	$F8, %0001, $00, $46, $60-Xdisp ; D
	dc.b	$F8, %0001, $00, $40, $68-Xdisp ; A
	dc.b	$F8, %0001, $00, $66, $70-Xdisp ; T
	dc.b	$F8, %0001, $00, $40, $78-Xdisp ; A
	
@SNDT_EN:
Xdisp = $50/2

	dc.b	8
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $64, $00-Xdisp ; S
	dc.b	$F8, %0001, $00, $5C, $08-Xdisp ; 0
	dc.b	$F8, %0001, $00, $68, $10-Xdisp ; U
	dc.b	$F8, %0001, $00, $5A, $18-Xdisp ; N
	dc.b	$F8, %0001, $00, $46, $20-Xdisp ; D

	dc.b	$F8, %0001, $00, $66, $30-Xdisp ; T
	dc.b	$F8, %0001, $00, $48, $38-Xdisp ; E
	dc.b	$F8, %0101, $00, $64, $40-Xdisp ; ST
	
@BACK_EN:
Xdisp = $20/2

	dc.b	4
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $42, $00-Xdisp ; B
	dc.b	$F8, %0001, $00, $40, $08-Xdisp ; A
	dc.b	$F8, %0001, $00, $44, $10-Xdisp ; C
	dc.b	$F8, %0001, $00, $54, $18-Xdisp ; K
	
@YES_EN:
Xdisp	= $18/2

	dc.b	3
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $70, $00-Xdisp ; Y
	dc.b	$F8, %0001, $00, $48, $08-Xdisp ; E
	dc.b	$F8, %0001, $00, $64, $10-Xdisp ; S

@NO_EN:
Xdisp	= $10/2

	dc.b	2
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $5A, $00-Xdisp ; N
	dc.b	$F8, %0001, $00, $5C, $08-Xdisp ; 0

; ===============================================================












; ===============================================================
; ---------------------------------------------------------------
; Object: Delete Progress title in a specific menu
; ---------------------------------------------------------------

xpos = 8
ypos = $A

Obj_SRAMChoice_Title:

	move.l	#ObjMap_MenuItems,maps(a0)
	move.w	#$8000+_VRAM_MenuFont_Pat,art(a0)
	move.l	#@WaitAppear,obj(a0)

	; Create question mark object
	move.l	#Obj_SRAMChoice_QuestionMark,d1
	jsr	FindNextFreeObj
	move.w	a1,parent(a0)

; ---------------------------------------------------------------
@WaitAppear:
	; Wait until the menu starts appearing
	tst.b	Logo_MenuStatus
	bmi.s	@Display
	
	; Move menu
	subq.w	#1,ypos(a0)
	cmpi.w	#$110,ypos(a0)
	bne.s	@Display
	move.l	#@WaitHide,obj(a0)

; ---------------------------------------------------------------
@WaitHide:
	; Wait until the menu starts disapp
	tst.b	Logo_MenuStatus
	bpl.s	@Display
	move.l	#MenuItem_Hide_Left,d0	; MEGA HACK 
	movea.w parent(a0),a1
	move.l	d0,obj(a0)
	move.l	d0,obj(a1)
	subq.b	#2,Logo_MenuStatus		; simulate extra 2 items

; ---------------------------------------------------------------
@Display:
	jmp	DisplaySprite

; ===============================================================

timer	= $38

Obj_SRAMChoice_QuestionMark:
	move.l	#@Maps,maps(a0)
	move.w	#$8000+_VRAM_MenuFont_Pat,art(a0)	
	moveq	#$80/2-8,d0
	add.w	d0,xpos(a0)
	move.w	#8,timer(a0)
	move.l	#@Move,obj(a0)

; ---------------------------------------------------------------
@Move:
	addq.w	#1,xpos(a0)
	subq.w	#1,timer(a0)
	bne.s	@Display
	move.l	#@Display,obj(a0)

@Display
	movea.w parent(a0),a1
	move.w	ypos(a1),ypos(a0)
	jmp	DisplaySprite

@Maps:
Xdisp = $00

	dc.w	2
	dc.b	1
	;		 YY	  WWHH		  TT   XX
	dc.b	$F8, %0001, $00, $3C, $00-Xdisp ; ?
	even



; ===============================================================
; ---------------------------------------------------------------
; Logo VBlank routine
; ---------------------------------------------------------------

LogoMain_VBlank_Init:
	movem.l d0-a6,-(sp)
	lea	vdp_control_port,a6
	move.w	#$8174,(a6)				; enable display
	move.w	#$8C89,(a6)				; enable SH
	move.l	#LogoMain_VBlank_Intro,VBlank_Sub
	bra.s	LogoMain_VBlank_Common

; ---------------------------------------------------------------
LogoMain_VBlank_Intro:
	movem.l d0-a6,-(sp)
	tst.b	$FFFFF62A
	beq	LogoMain_VBlank_Misc
	writeVRAM Logo_PSBTiles, $2A0, _VRAM_PSB
	bra.s	LogoMain_VBlank_Common

; ---------------------------------------------------------------
LogoMain_VBlank_Menu:
	movem.l d0-a6,-(sp)
	tst.b	$FFFFF62A
	beq	LogoMain_VBlank_Misc
	writeVRAM $FFF800,$280,$F800	; transfer sprites

LogoMain_VBlank_Common:
	sf.b	$FFFFF62A				; reset VBlank pending flag
	lea	vdp_control_port,a6
	move.l	#$40000010,(a6)			; access VSRAM at addess $00
	move.l	($FFFFF616).w,-4(a6)	; send to VSRAM
	jsr	ReadJoypads
	writeCRAM $FFFFFB00, $80, 0		; transfer palette
	writeVRAM HSRAM_Buffer, $380, $FC00 ; transfer HSRAM

LogoMain_VBlank_Misc:
	jsr	Int_SoundDriver
	movem.l (sp)+,d0-a6
	rte

; ===============================================================
; ---------------------------------------------------------------
; Data
; ---------------------------------------------------------------

LogoMain_Palette:

Kos_MenuFont:
	
