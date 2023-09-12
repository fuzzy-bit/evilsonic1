
; ===============================================================
; TOTALLY *NOT* SONIC WINTER ADVENTURES MENU
; ---------------------------------------------------------------
; (c) 2012-2013, 2023 totally not vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Constants
; ---------------------------------------------------------------

; VRAM locations

_Nametbl_PlaneA = $C000 ;
_Nametbl_PlaneB = $E000 ;

_VRAM_MenuBG = $20
_VRAM_MenuBG_Pat = (_VRAM_MenuBG/$20)
_VRAM_MenuFont	= $2000
_VRAM_MenuFont_Pat = (_VRAM_MenuFont/$20)


; Menu RAM layout

Menu_RAM:	equ	$FFFFA000

		rsset	Menu_RAM
Menu_ID:		rs.b	1	; Currently selected menu
Menu_ItemID:		rs.b	1	; Currently selected menu item
Menu_NumItems:		rs.b	1	; Number of items in the menu	  
Menu_Status:		rs.b 	1	; Indicates menu status ($80 - working, indicates number of objects remain)
Menu_Anim_In: 		rs.b	1	; Menu appear animation
Menu_Anim_Out:		rs.b	1	; Menu hide animation

; ===============================================================
; ---------------------------------------------------------------
; Init Screen Mode
; ---------------------------------------------------------------

Menu:
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
	move.w	#$8C89,(a6)			; enable S&H
	move.w	#$8134,(a6)			; disable display
	jsr	ClearScreen

	; Clear objects RAM
	lea	v_objspace, a0
	move.w	#$2000/$10-1, d0
	moveq	#0, d1

	@loop1:	
		rept	4	; do $10 bytes
			move.l	d1, (a0)+
		endr
		dbf	d0, @loop1

	; Load palette ($40 bytes)
	lea	v_pal_dry_dup,a0
	lea	Pal_MenuMain,a1
	lea	-$80(a0),a2
	moveq	#6-1,d0

	@loop2:
		rept	4	; do $10 bytes
			move.l	(a1)+, (a0)+
		endr
		dbf	d0, @loop2

	; Load patterns
	lea	Kos_MenuFont,a0			; Menu font
	lea	$FF0000,a1
	jsr	KosDec
	writeVRAM $FF0000, $1D80, _VRAM_MenuFont

	lea	Kos_MenuBg,a0			; Menu background
	lea	$FF0000,a1
	jsr	KosDec
	writeVRAM $FF0000, $100, _VRAM_MenuBG

	music	mus_title

	; Setup screen
	jsr	Menu_GenerateBG
	jsr	Menu_InitScrolling

	; Enable display
	move.w	(v_vdp_buffer1).w, d0
	ori.b	#$40, d0
	move.w	d0, (vdp_control_port).l

	; Prepare screen to show up
	jsr	PaletteFadeIn

	; Load the first menu & rock
	moveq	#0,d1
	move.b	d1, Menu_ID
	moveq	#0,d0
	move.b	d0, Menu_ItemID
	move.b	d0, Menu_Anim_In
	jsr	MainMenu_LoadMenu

; ===============================================================
; ---------------------------------------------------------------
; Menu appearence loop
; ---------------------------------------------------------------

MainMenu_MenuAppearLoop:
	move.b	#2, (v_vbla_routine).w 	; demo time routine
	jsr	WaitForVBla

	; Run menu objects
	jsr	ExecuteObjects
	jsr	BuildSprites
	jsr	Menu_UpdateScrolling

	; Check if menu items appearence animation is done
	tst.b	Menu_Status
	bne	MainMenu_MenuAppearLoop

; ---------------------------------------------------------------
; Menu controls loop
; ---------------------------------------------------------------

MainMenu_MenuControlLoop:
	move.b	#2, (v_vbla_routine).w 	; demo time routine
	jsr	WaitForVBla

	; Run menu objects
	jsr	ExecuteObjects
	jsr	BuildSprites
	jsr	Menu_UpdateScrolling
	jsr	MainMenu_ControlMenu
	beq	MainMenu_MenuControlLoop 	; if nothing was selected, branch

	jmp	MainMenu_MenuExecute

; ---------------------------------------------------------------
; Menu hide loop
; ---------------------------------------------------------------

MainMenu_MenuHide:
	sfx	sfx_lamppost

	move.b	Menu_NumItems, d0
	neg.b	d0
	move.b	d0, Menu_Status

MainMenu_MenuHideLoop:
	move.b	#2, (v_vbla_routine).w
	jsr	WaitForVBla

	jsr	ExecuteObjects
	jsr	BuildSprites
	jsr	Menu_UpdateScrolling
	tst.b	Menu_Status			; has all items been done?
	bne.s	MainMenu_MenuHideLoop		; if not, branch

	; Transition to the next menu
	jsr	MainMenu_LoadMenu		; load new menu
	bra	MainMenu_MenuAppearLoop

; ---------------------------------------------------------------
; Menu hide loop 2
; ---------------------------------------------------------------

MainMenu_MenuHide2:
	sfx	sfx_lamppost

	move.b	Menu_NumItems, d0
	neg.b	d0
	move.b	d0, Menu_Status

	command	mus_fadeout

MainMenu_MenuHideLoop2:
	move.b	#2, (v_vbla_routine).w
	jsr	WaitForVBla

	jsr	ExecuteObjects
	jsr	BuildSprites
	jsr	Menu_UpdateScrolling

	tst.b	Menu_Status			; has all items been done?
	bne.s	MainMenu_MenuHideLoop2		; if not, branch

@Quit:	jsr	PaletteFadeOut
	move.w	#$8C81, vdp_control_port	; turn off S&H
	rts

; ===============================================================








; ===============================================================
; ---------------------------------------------------------------
; Subroutine to load a menu
; ---------------------------------------------------------------

Menu_GenerateBG:
	lea	vdp_control_port,a6
	lea	-4(a6),a5		; vdp_data_port

	lea	@BG_Data,a0
	move.l	(a0)+,(a6)		; d0 = VRAM addr
	move.l	(a0)+,d1		; d1 = pattern base (doubled)
	move.l	(a0)+,d2		; d2 = row factor
	moveq	#4,d7			; d7 = blocks row switcher

	move.w	#7,d6			; d6 = number of 64px block rows

@DrawRowOfBlocks:
	moveq	#3,d5			; d5 = number rows in block

@DrawRow:
	moveq	#7,d4			; d4 = number of block pairs in row

@DrawBlocksInRow:
	jsr	@BlocksTbl(pc,d7.w)
	jsr	@BlocksTbl+2(pc,d7.w)
	dbf	d4,@DrawBlocksInRow

	dbf	d5,@DrawRow

	swap	d7			; swap blocks
	dbf	d6,@DrawRowOfBlocks
	rts

; ---------------------------------------------------------------
@BlocksTbl:
	bra.s	@Block1_Flip	; $00
	bra.s	@Block0		; $02
	bra.s	@Block0		; $04
	bra.s	@Block1_Normal	; $06

; ---------------------------------------------------------------
@Block0:
	move.l	d1,(a5)
	move.l	d1,(a5)
	rts

; ---------------------------------------------------------------
@Block1_Flip:
	move.w	d5,d3
	addq.w	#4,d3
	bra.s	@B1_0

@Block1_Normal:
	move.w	d5,d3
@B1_0	lsl.w	#3,d3
	lea	(a0,d3.w),a1
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	rts

; ---------------------------------------------------------------
@BG_Data:
	dcvram	_Nametbl_PlaneB			; VRAM base addr
	dc.l	(_VRAM_MenuBG_Pat)<<16|(_VRAM_MenuBG_Pat)	; pattern base (dobled)
	dc.l	$80<<16				; row factor

	dc.w	_VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+1	; Block 1 map (normal)
	dc.w	_VRAM_MenuBG_Pat+5, _VRAM_MenuBG_Pat+6, _VRAM_MenuBG_Pat+7, _VRAM_MenuBG_Pat+1
	dc.w	_VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+3, _VRAM_MenuBG_Pat+4, _VRAM_MenuBG_Pat+1
	dc.w    _VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+1, _VRAM_MenuBG_Pat+2, _VRAM_MenuBG_Pat+1

	dc.w	(_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11)	; Block 1 map (flip)
	dc.w	(_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+7)|(1<<11), (_VRAM_MenuBG_Pat+6)|(1<<11), (_VRAM_MenuBG_Pat+5)|(1<<11)
	dc.w	(_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+4)|(1<<11), (_VRAM_MenuBG_Pat+3)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11)
	dc.w    (_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+2)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11), (_VRAM_MenuBG_Pat+1)|(1<<11)



; ===============================================================
; ---------------------------------------------------------------
; Subroutine to load a menu
; ---------------------------------------------------------------

obMenuItemIndex = $1F

MainMenu_LoadMenu:
	moveq	#0,d0
	moveq	#0,d3				; d3 = Frame Bank
	move.b	Menu_ID,d0			; d0 = Menu ID
	add.w	d0,d0
	lea	MainMenu_MenuElements,a1
	add.w	(a1,d0),a1			; get data pointer for this menu
	move.b	(a1)+,Menu_ItemID		; set default item
	moveq	#0,d0
	move.b	(a1)+,d0
	move.b	d0,Menu_Status		; set menu status for processing shit
	move.b	d0,Menu_NumItems
	subq.w	#1,d0				; d0 = Number of elements

	lea	v_player,a0
	moveq	#id_ObjDynamic, d1
	move.l	#Obj_MenuItem, d2

	@CreateItem:
		move.b	d1, (a0)
		move.l	d2, obCodePtr(a0)		; code pointer
		move.b	(a1)+, obMenuItemIndex(a0)
		move.b	(a1)+, obFrame(a0)
		add.b	d3, obFrame(a0)
		move.w	(a1)+, obScreenY(a0)
		lea	$40(a0), a0			; next object
		dbf	d0,@CreateItem

	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to control menu 'n' shit
; ---------------------------------------------------------------

MainMenu_ControlMenu:
	move.b	v_jpadpress1, d3
	move.b	Menu_ItemID, d1
	move.b	Menu_NumItems, d2

	btst	#bitDn, d3			; Down pressed?
	beq.s	@ChkUp				; if not, branch
	addq.b	#1,d1
	cmp.b	d2,d1
	bne.s	@SetNewItem
	moveq	#0,d1
	bra.s	@SetNewItem

@ChkUp	btst	#bitUp, d3			; Up pressed?
	beq.s	@ChkSelect			; if not, branch
	subq.b	#1,d1
	bpl.s	@SetNewItem		 
	subq.b	#1,d2				; d2 = max item obMenuItemIndex
	move.b	d2,d1

@SetNewItem:
	move.b	d1, Menu_ItemID

	sfx	sfx_switch	

@ChkSelect:
	andi.b	#btnABC+btnStart, d3		; A/B/C/Start pressed?
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to exeCUTE menu commanda
; ---------------------------------------------------------------

MainMenu_MenuExecute:
	moveq	#0, d0
	move.b	Menu_ID, d0
	add.w	d0, d0
	lea	MainMenu_MenuCommands, a1
	add.w	(a1,d0), a1				; get array
	move.b	Menu_ItemID, d0
	add.w	d0,d0					; d0 = 2x
	move.w	d0,d1
	add.w	d0,d0					; d0 = 4x
	add.w	d0,d0					; d0 = 8x
	add.w	d1,d0					; d0 = 10x
	adda.w	d0,a1					; get commanda
	move.w	(a1)+, Menu_Anim_In
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

MainMenu_MenuCommands:
@L	dc.w	MainMenu_Full_Cmd-@L	; $00
	dc.w	OptionsMenu_Cmd-@L		; $01
	dc.w	SRAMChoice_Cmd-@L		; $02
	dc.w	SRAMChoice_Cmd-@L		; $03

MainMenu_MenuElements:
@L	dc.w	MainMenu_Full-@L		; $00
	dc.w	OptionsMenu-@L			; $01
	dc.w	SRAMChoice-@L			; $02
	dc.w	SRAMChoice-@L			; $03
; ---------------------------------------------------------------

MainMenu_Full:
	dc.b	0				; Default Item
	dc.b	3				; Size
	dc.w	$0000, $E0			; Index/Frame, Y-pos
	dc.w	$0101, $100			;
	dc.w	$0202, $120			;
		
MainMenu_Full_Cmd:
	; PLAY
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	MainMenu_MenuHide2		; Loop handler
	dc.l	Hwnd_MainMenu_Play		; Code handler

	; CHALLENGES
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	MainMenu_MenuHide2		; Loop handler
	dc.l	Hwnd_MainMenu_Challenges	; Code handler

	; OPTIONS
	dc.b	_FromRight,_ToLeft		; In/Out anim
	dc.l	MainMenu_MenuHide		; Loop handler
	dc.l	Hwnd_MainMenu_Options		; Code handler

; ---------------------------------------------------------------
OptionsMenu:
	dc.b	0				; Default Item
	dc.b	4				; Size
	dc.w	$0003, $D0			; Index/Frame, Y-pos
	dc.w	$0104, $D0+$18			;
	dc.w	$0205, $D0+$18*2		;
	dc.w	$0306, $D0+$18*3+$10		;
	
OptionsMenu_Cmd:
	; DIFFICULTY
	dc.b	_FromRight,_ToRight		; In/Out anim
	dc.l	MainMenu_MenuHide		; Loop handler
	dc.l	Hwnd_Options_Difficulty		; Code handler

	; CLEAR SRAM
	dc.b	_FromRight,_ToLeft		; In/Out anim
	dc.l	MainMenu_MenuHide		; Loop handler
	dc.l	Hwnd_Options_ClearSRAM		; Code handler

	; SOUND TEST
	dc.b	0,_ToLeft			; In/Out anim
	dc.l	MainMenu_MenuHide2		; Loop handler
	dc.l	Hwnd_Options_SoundTest		; Code handler

	; BACK
	dc.b	_FromLeft,_ToRight		; In/Out anim
	dc.l	MainMenu_MenuHide		; Loop handler
	dc.l	Hwnd_Options_Back		; Code handler

; ---------------------------------------------------------------
SRAMChoice:
	dc.b	1				; Default Item
	dc.b	2				; Size
	dc.w	$0008, $100			; Index/Frame, Y-pos
	dc.w	$0109, $118			;

SRAMChoice_Cmd:
	; YES
	dc.b	0,_ToBottom			; In/Out anim
	dc.l	MainMenu_MenuHide2		; Loop handler
	dc.l	Hwnd_SRAMChoice_Yes		; Code handler

	; NO
	dc.b	_FromLeft,_ToRight		; In/Out anim
	dc.l	MainMenu_MenuHide		; Loop handler
	dc.l	Hwnd_SRAMChoice_No		; Code handler


; ---------------------------------------------------------------
; Menu Handlers
; ---------------------------------------------------------------

Hwnd_MainMenu_Play:
	jmp	PlayLevel

; ---------------------------------------------------------------
Hwnd_MainMenu_Challenges:
	illegal

; ---------------------------------------------------------------
Hwnd_MainMenu_Options:
	move.b	#$01,Menu_ID
	rts

; ---------------------------------------------------------------
Hwnd_Locked:
	illegal

; ---------------------------------------------------------------
Hwnd_Options_Difficulty:
	illegal

; ---------------------------------------------------------------
Hwnd_Options_ClearSRAM:
	lea	v_player+$40, a0			; get DeleteProgress object
	move.l	#MenuItem_Hide_MarkGone, obCodePtr(a0) ; delete it...

	jsr	FindNextFreeObj
	move.b	#id_ObjDynamic, (a1)
	move.l	#Obj_SRAMChoice_Title, obCodePtr(a1)
	move.w	obX(a0), obX(a1)
	move.w	obScreenY(a0), obScreenY(a1)
	move.b	obFrame(a0), obFrame(a1)

	move.b	#$03, Menu_ID			; change menus
	rts

Hwnd_SRAMChoice_Yes:
	illegal
	
Hwnd_SRAMChoice_No:
	move.b	#$01, Menu_ID
	rts

; ---------------------------------------------------------------
Hwnd_Options_SoundTest:
	illegal

; ---------------------------------------------------------------
Hwnd_Options_Back:
	move.b	#$00, Menu_ID
	rts


; ===============================================================





; ===============================================================
; ---------------------------------------------------------------
; Scrolling routines
; ---------------------------------------------------------------

Menu_InitScrolling:
	moveq	#0, d0
	move.w	d0, v_scrposy_dup
	move.w	d0, v_screenposx
	rts

; ---------------------------------------------------------------
Menu_UpdateScrolling:
	addq.w	#1, v_bgscreenposx
	addq.w	#1, v_bgscreenposy

	; Update VScroll
	move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w

	; Update HScroll
	lea	v_hscrolltablebuffer, a0
	move.w	#224-1, d1
	moveq	#0, d0
	move.w	v_bgscreenposx, d0
	neg.w	d0

	@loop:
		move.l	d0, (a0)+
		dbf	d1, @loop

	rts

; ===============================================================









; ===============================================================
; ---------------------------------------------------------------
; Object: Menu Items
; ---------------------------------------------------------------

; Custom variables
obMenuItemIndex = $1F
obX2 = $30
obScreenY2 = $34
obAcc = $38
obTimer = $3A

Obj_MenuItem:
	move.w	#$2000, obGfx(a0)
	move.l	#ObjMap_MenuItems,obMap(a0)

	; Select appear routine according to menu animation
	moveq	#0,d0
	move.b	Menu_Anim_In,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	@AppearRoutines(pc,d0),obCodePtr(a0)
	rts
	
@AppearRoutines:
	dc.l	MenuItem_Appear_Bottom
	dc.l	MenuItem_Appear_Right
	dc.l	MenuItem_Appear_Left

; ---------------------------------------------------------------
; Menu appears from bottom
; ---------------------------------------------------------------

MenuItem_Appear_Bottom:
	move.l	#@Appear_Process,obCodePtr(a0)
	move.w	#$80+160,obX(a0)

	; Setup entry position and speeds
	moveq	#0,d0
	move.b	obMenuItemIndex(a0),d0
	add.w	d0,d0			; d0 = obMenuItemIndex*2
	move.w	d0,d1
	add.w	d0,d0			; d0 = obMenuItemIndex*4
	add.w	d1,d0			; d0 = obMenuItemIndex*6
	lea	@Appear_Data(pc,d0),a1
	move.w	obScreenY(a0),d0
	add.w	(a1)+,d0
	move.w	d0,obScreenY2(a0)
	move.w	(a1)+,obVelY(a0)
	move.w	(a1)+,obAcc(a0)
	rts

; ---------------------------------------------------------------
@Appear_Process:
	move.w	obVelY(a0),d1
	bmi	MenuItem_Goto_ProcessNormal
	move.w	d1,d0
	ext.l	d0
	lsl.l	#8,d0
	sub.l	d0,obScreenY2(a0)

	sub.w	obAcc(a0),d1
	move.w	d1,obVelY(a0)

	move.w	obScreenY2(a0),d0
	move.w	d0,obScreenY(a0)
	cmpi.w	#$80+240,d0
	bls	MenuItem_Display
	rts	   

; ---------------------------------------------------------------
@Appear_Data:
	;	Position	Start Speed	Acceleration
	dc.w	$80+4,		$800,		$40
	dc.w	$100+$8,	$1000,		$80
	dc.w	$180+$C,	$1800,		$C0

; ---------------------------------------------------------------
; Menu appears from right
; ---------------------------------------------------------------

MenuItem_Appear_Right:
	move.w	#-$2000,obVelX(a0)
	move.w	#$80+160+$100,obX2(a0)
	move.b	obMenuItemIndex(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,obTimer(a0)
	move.l	#@Appear_Wait,obCodePtr(a0)

@Appear_Wait:
	subq.b	#1,obTimer(a0)
	bmi.s	@Appear_Process
	rts

@Appear_Process:
	move.w	#$1E8,d1
	bsr	MenuItem_MoveXAcc
	tst.w	obVelX(a0)
	bmi.s	MenuItem_Display
	move.l	#MenuItem_Appear_ChkPos,obCodePtr(a0)
	bra.s	MenuItem_Appear_ChkPos

; ---------------------------------------------------------------
; Menu appears from left
; ---------------------------------------------------------------

MenuItem_Appear_Left:
	move.w	#$2000,obVelX(a0)
	move.w	#$80+160-$100,obX2(a0)
	move.b	obMenuItemIndex(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,obTimer(a0)
	move.l	#@Appear_Wait,obCodePtr(a0)

@Appear_Wait:
	subq.b	#1,obTimer(a0)
	bmi.s	@Appear_Process
	rts

@Appear_Process:
	move.w	#-$1E8,d1
	bsr	MenuItem_MoveXAcc
	tst.w	obVelX(a0)
	bpl.s	MenuItem_Display
	move.l	#MenuItem_Appear_ChkPos,obCodePtr(a0)

MenuItem_Appear_ChkPos:
	moveq	#1,d0
	cmpi.w	#$80+160,obX(a0)
	beq.s	MenuItem_Goto_ProcessNormal
	bcs.s	@Move
	moveq	#-1,d0
@Move:	add.w	d0,obX(a0)
	bra.s	MenuItem_Display

; ---------------------------------------------------------------
MenuItem_Goto_ProcessNormal:
	move.l	#MenuItem_ProcessNormal,obCodePtr(a0)
	subq.b	#1,Menu_Status

; ---------------------------------------------------------------
; Menu item works in menu
; ---------------------------------------------------------------

MenuItem_ProcessNormal:
	tst.b	Menu_Status
	bmi.s	MenuItem_Hide

; ---------------------------------------------------------------
MenuItem_Display:
	move.w	#$8000+$2000+_VRAM_MenuFont_Pat,d1
	move.b	Menu_ItemID,d0
	cmp.b	obMenuItemIndex(a0),d0			; is this item selected?
	beq.s	@skip					; if yes, branch
	addi.w	#$2000,d1
@skip	move.w	d1,obGfx(a0)

MenuItem_Display2:
	jmp	DisplaySprite

; ---------------------------------------------------------------

MenuItem_Hide:

	; Select hide routine according to menu animation
	moveq	#0,d0
	move.b	Menu_Anim_Out,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	@HideRoutines(pc,d0),obCodePtr(a0)
	bra.s	MenuItem_Display2
	
@HideRoutines:
	dc.l	MenuItem_Hide_Left
	dc.l	MenuItem_Hide_Right
	dc.l	MenuItem_Hide_Bottom

; ---------------------------------------------------------------
; Menu Items move left
; ---------------------------------------------------------------

MenuItem_Hide_Left:
	move.w	#-$180,obAcc(a0)
	
MenuItem_Hide_Directional:
	move.b	obMenuItemIndex(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.b	d0,obTimer(a0)
	move.l	#@Hide_WaitTurn,obCodePtr(a0)

; ---------------------------------------------------------------
@Hide_WaitTurn:
	subq.b	#1,obTimer(a0)			; is it time to hide?
	bpl.s	MenuItem_Display2		; if nop, branch
	move.w	obX(a0),obX2(a0)
	move.l	#@Hide_Process,obCodePtr(a0)

; ---------------------------------------------------------------
@Hide_Process:
	move.w	obAcc(a0),d1
	bsr.s	MenuItem_MoveXAcc
	move.w	obX(a0),d0
	lsl.w	#6,d0
	bpl	MenuItem_Display2
	bra.s	MenuItem_Hide_MarkGone

; ---------------------------------------------------------------
; Menu Items move right
; ---------------------------------------------------------------

MenuItem_Hide_Right:
	move.w	#$180,obAcc(a0)
	bra		MenuItem_Hide_Directional

; ---------------------------------------------------------------
; Menu Items move bottom
; ---------------------------------------------------------------

MenuItem_Hide_Bottom:
	moveq	#$40/$20,d0
	add.b	obMenuItemIndex(a0),d0
	lsl.w	#5,d0					; d0 *= $20
	move.w	d0,obAcc(a0)
	move.w	obScreenY(a0),obScreenY2(a0)
	clr.w	obVelY(a0)
	move.l	#@Hide_Process,obCodePtr(a0)
	
@Hide_Process:
	move.w	obVelY(a0),d1
	move.w	d1,d0
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,obScreenY2(a0)

	add.w	obAcc(a0),d1
	move.w	d1,obVelY(a0)

	move.w	obScreenY2(a0),d0
	move.w	d0,obScreenY(a0)
	cmpi.w	#$80+240,d0
	bls	MenuItem_Display

MenuItem_Hide_MarkGone:
	addq.b	#1,Menu_Status		; mark obj as gone
	jmp	DeleteObject

; ---------------------------------------------------------------
; Subroutine to make item move with acceleration
; ---------------------------------------------------------------

MenuItem_MoveXAcc:
	move.w	obVelX(a0),d0
	add.w	d1,d0
	move.w	d0,obVelX(a0)
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,obX2(a0)
	move.w	obX2(a0),obX(a0)
	rts

; ===============================================================












; ===============================================================
; ---------------------------------------------------------------
; Object: Delete Progress title in a specific menu
; ---------------------------------------------------------------

obParent = $34

Obj_SRAMChoice_Title:
	move.l	#ObjMap_MenuItems,obMap(a0)
	move.w	#$8000+_VRAM_MenuFont_Pat,obGfx(a0)
	move.l	#@WaitAppear,obCodePtr(a0)

	; Create question mark object
	jsr	FindNextFreeObj
	move.b	#id_ObjDynamic, (a1)
	move.l	#Obj_SRAMChoice_QuestionMark, obCodePtr(a1)
	move.w	obX(a0), obX(a1)
	move.w	obScreenY(a0), obScreenY(a1)
	move.w	a0, obParent(a1)

	move.w	a1, obParent(a0)

; ---------------------------------------------------------------
@WaitAppear:
	; Wait until the menu starts appearing
	tst.b	Menu_Status
	bmi.s	@Display
	
	; Move menu
	subq.w	#1,obScreenY(a0)
	cmpi.w	#$D0+8,obScreenY(a0)
	bne.s	@Display
	move.l	#@WaitHide,obCodePtr(a0)

; ---------------------------------------------------------------
@WaitHide:
	; Wait until the menu starts disapp
	tst.b	Menu_Status
	bpl.s	@Display
	move.l	#MenuItem_Hide_Left,d0	; MEGA HACK 
	movea.w obParent(a0),a1
	move.l	d0,obCodePtr(a0)
	move.l	d0,obCodePtr(a1)
	subq.b	#2,Menu_Status		; simulate extra 2 items

; ---------------------------------------------------------------
@Display:
	jmp	DisplaySprite

; ===============================================================

timer	= $38

Obj_SRAMChoice_QuestionMark:
	move.l	#@Maps, obMap(a0)
	move.w	#$8000+_VRAM_MenuFont_Pat, obGfx(a0)	
	moveq	#$80-28,d0
	add.w	d0, obX(a0)
	move.w	#16, obTimer(a0)
	move.l	#@Move, obCodePtr(a0)

; ---------------------------------------------------------------
@Move:
	addq.w	#1,obX(a0)
	subq.w	#1,obTimer(a0)
	bne.s	@Display
	move.l	#@Display,obCodePtr(a0)

@Display
	movea.w obParent(a0),a1
	move.w	obScreenY(a1),obScreenY(a0)
	jmp	DisplaySprite

; ---------------------------------------------------------------
@Maps:
	dc.w	2
	dc.w	1
	;	YY   WWHH	 TT   XX
	dc.b	$F8, %0101, $00, 124, $00, $00 ; ?
	even


; ===============================================================
; ---------------------------------------------------------------
; Data
; ---------------------------------------------------------------

Pal_MenuMain:
	; Line 0
	incbin	'Data/Palette/Menu Font Alt.bin'

	; Line 1
	incbin	'Data/Palette/Menu Font Highlighted.bin'

	; Line 2
	incbin	'Data/Palette/Menu Font.bin'

