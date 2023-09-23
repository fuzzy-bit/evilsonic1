;  =========================================================================
; |                         Fuzzy's Sonic 1 Engine                         |
;  =========================================================================

; ===========================================================================

rom:	section	org(0),obj(0)

	include	"Constants.asm"
	include	"Variables.asm"
	include	"Macros.asm"

	include	"Libs/debugger.lib"
	include	"Libs/veps.lib"

	include "ErrorHandler/debugger.asm"

SRAMEnabled:	equ 1	; change to 1 to enable SRAM

; Change to 0 to build the original version of the game, dubbed REV00
; Change to 1 to build the later vesion, dubbed REV01, which includes various bugfixes and enhancements
; Change to 2 to build the version from Sonic Mega Collection, dubbed REVXB, which fixes the infamous "spike bug"
; REVISION CONSTANT IS DEPRECATED AND MAY NOT WORK AS INTENDED
Revision:	equ 1

; Custom engine flags
Respawn: 	equ 0
SpeedCap: 	equ 0

ZoneCount:	equ 7	; discrete zones are: GHZ, MZ, SYZ, LZ, SLZ, and SBZ

; ===========================================================================

StartOfRom:
		include "Engine/Header.asm"

BizhawkCompatibility:
		dc.w 0

HiddenMessage:
		;align 24
		dc.b "RIVET DID 7-11  "
		even

; ===========================================================================
; Crash/Freeze the 68000. Unlike Sonic 2, Sonic 1 uses the 68000 for playing music, so it stops too

;ErrorTrap:
;		nop
;		nop
;		bra.s	ErrorTrap
; ===========================================================================

EntryPoint:
		tst.l	(z80_port_1_control).l ; test port A & B control registers
		bne.s	PortA_Ok
		tst.w	(z80_expansion_control).l ; test port C control register

PortA_Ok:
		bne.w	SkipSetup ; Skip the VDP and Z80 setup code if port A, B or C is ok...?
		lea	SetupValues(pc),a5	; Load setup values array address.
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version (from $A10001)
		andi.b	#$F,d0
		beq.s	SkipSecurity	; If the console has no TMSS, skip the security stuff.
		move.l	MEGADRIVE.w,$2F00(a1) ; move "SEGA" to TMSS register ($A14000)

SkipSecurity:
		move.w	(a4),d0	; clear write-pending flag in VDP to prevent issues if the 68k has been reset in the middle of writing a command long word to the VDP.
		moveq	#0,d0	; clear d0
		movea.l	d0,a6	; clear a6
		move.l	a6,usp	; set usp to $0

		moveq	#$17,d1
VDPInitLoop:
		move.b	(a5)+,d5	; add $8000 to value
		move.w	d5,(a4)		; move value to	VDP register
		add.w	d7,d5		; next register
		dbf	d1,VDPInitLoop

		move.l	(a5)+,(a4)
		move.w	d0,(a3)		; clear	the VRAM
		move.w	d7,(a1)		; stop the Z80
		move.w	d7,(a2)		; reset	the Z80

WaitForZ80:
		btst	d0,(a1)		; has the Z80 stopped?
		bne.s	WaitForZ80	; if not, branch

				moveq   #$25,d2
Z80InitLoop:
		move.b	(a5)+,(a0)+
		dbf	d2,Z80InitLoop

		move.w	d0,(a2)
		move.w	d0,(a1)		; start	the Z80
		move.w	d7,(a2)		; reset	the Z80

ClrRAMLoop:
		move.l	d0,-(a6)	; clear 4 bytes of RAM
		dbf	d6,ClrRAMLoop	; repeat until the entire RAM is clear
		move.l	(a5)+,(a4)	; set VDP display mode and increment mode
		move.l	(a5)+,(a4)	; set VDP to CRAM write

		moveq	#$1F,d3	; set repeat times
ClrCRAMLoop:
		move.l	d0,(a3)	; clear 2 palettes
		dbf	d3,ClrCRAMLoop	; repeat until the entire CRAM is clear
		move.l	(a5)+,(a4)	; set VDP to VSRAM write

		moveq	#$13,d4
ClrVSRAMLoop:
		move.l	d0,(a3)	; clear 4 bytes of VSRAM.
		dbf	d4,ClrVSRAMLoop	; repeat until the entire VSRAM is clear
		moveq	#3,d5

PSGInitLoop:
		move.b	(a5)+,$11(a3)	; reset	the PSG
		dbf	d5,PSGInitLoop	; repeat for other channels
		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear all registers

SkipSetup:
		bra.w	GameProgram	; begin game

; ===========================================================================
SetupValues:	dc.w $8000		; VDP register start number
		dc.w $3FFF		; size of RAM/4
		dc.w $100		; VDP register diff

		dc.l z80_ram		; start	of Z80 RAM
		dc.l z80_bus_request	; Z80 bus request
		dc.l z80_reset		; Z80 reset
		dc.l vdp_data_port	; VDP data
		dc.l vdp_control_port	; VDP control

		dc.b 4			; VDP $80 - 8-colour mode
		dc.b $14		; VDP $81 - Megadrive mode, DMA enable
		dc.b ($C000>>10)	; VDP $82 - foreground nametable address
		dc.b ($F000>>10)	; VDP $83 - window nametable address
		dc.b ($E000>>13)	; VDP $84 - background nametable address
		dc.b ($D800>>9)		; VDP $85 - sprite table address
		dc.b 0			; VDP $86 - unused
		dc.b 0			; VDP $87 - background colour
		dc.b 0			; VDP $88 - unused
		dc.b 0			; VDP $89 - unused
		dc.b 255		; VDP $8A - HBlank register
		dc.b 0			; VDP $8B - full screen scroll
		dc.b $81		; VDP $8C - 40 cell display
		dc.b ($DC00>>10)	; VDP $8D - hscroll table address
		dc.b 0			; VDP $8E - unused
		dc.b 1			; VDP $8F - VDP increment
		dc.b 1			; VDP $90 - 64 cell hscroll size
		dc.b 0			; VDP $91 - window h position
		dc.b 0			; VDP $92 - window v position
		dc.w $FFFF		; VDP $93/94 - DMA length
		dc.w 0			; VDP $95/96 - DMA source
		dc.b $80		; VDP $97 - DMA fill VRAM
		dc.l $40000080		; VRAM address 0

				dc.b $AF, 1, $D9, $1F, $11, $27, 0, $21, $26, 0, $F9, $77 ; Z80 instructions
				dc.b $ED, $B0, $DD, $E1, $FD, $E1, $ED, $47, $ED, $4F
				dc.b $D1, $E1, $F1, 8, $D9, $C1, $D1, $E1, $F1, $F9, $F3
				dc.b $ED, $56, $36, $E9, $E9

		dc.w $8104		; VDP display mode
		dc.w $8F02		; VDP increment
		dc.l $C0000000		; CRAM write mode
		dc.l $40000010		; VSRAM address 0

		dc.b $9F, $BF, $DF, $FF	; values for PSG channel volumes
; ===========================================================================

GameProgram:
		lea		v_systemstack, sp

		tst.w	(vdp_control_port).l
		btst	#6,($A1000D).l
		beq.s	@check
		cmpi.l	#'init',(v_init).w ; has checksum routine already run?
		beq.w	GameInit	; if yes, branch

	@check:
		lea	($FFFFFE00).w,a6
		moveq	#0,d7
		move.w	#$7F,d6
	@clearRAM:
		move.l	d7,(a6)+
		dbf	d6,@clearRAM			; clear RAM ($FE00-$FFFF)

		move.l	#EndOfHeader,v_csum_addr.w	; load end of header to checksum check
		clr.w	v_csum_value.w			; initial value of 0
		move.b	(z80_version).l,d0
		andi.b	#$C0,d0
		move.b	d0,(v_megadrive).w		; get region setting
		move.l	#'init',(v_init).w		; set flag so checksum won't run again

GameInit:
		lea	($FF0000).l,a6
		moveq	#0,d7
		move.w	#$3F7F,d6
	@clearRAM:
		move.l	d7,(a6)+
		dbf	d6,@clearRAM	; clear RAM ($0000-$FDFF)

		bsr.w	VDPSetup
		
		; Initialize sound subsystem
		jsr	VEPS_Init
		lea	SampleTable, a0
		move.w	#(SampleTable_End-SampleTable)/$C-1, d0
		jsr	VEPS_LoadSampleTable

		jsr		InitSRAM

		bsr.w	JoypadInit
		jsr	VDPDraw_Init
		move.b	#id_Sega,(v_gamemode).w ; set Game Mode to Sega Screen

MainGameLoop:
		move.b	(v_gamemode).w,d0 ; load Game Mode
		andi.w	#$7C,d0	; limit Game Mode value to $1C max (change to a maximum of 7C to add more game modes)
		jsr	GameModeArray(pc,d0.w) ; jump to apt location in ROM
		bra.s	MainGameLoop	; loop indefinitely
		dc.b	"HEY GUYS IM ARIF TODAY IM GOING TO KILL MYSELF"
		
; ===========================================================================
; ---------------------------------------------------------------------------
; Main game mode array
; ---------------------------------------------------------------------------

GameModeArray:
		ptr_GM_Sega:	bra.w	SegaScreen	; Sega Screen ($00)
		ptr_GM_Title:	bra.w	TitleScreen	; Title	Screen ($04)
		ptr_GM_Menu:	bra.w 	Menu 	; Menu ($08)
		ptr_GM_Demo:	bra.w	Level	; Demo Mode ($0C)
		ptr_GM_Level:	bra.w	Level	; Normal Level ($10)
		ptr_GM_Special:	bra.w	SpecialStage	; Special Stage	($14)
		ptr_GM_Cont:	bra.w	Continue	; Continue Screen ($18)
		ptr_GM_Ending:	bra.w	Ending	; End of game sequence ($1C)
		ptr_GM_Credits:	bra.w	Credits	; Credits ($20)
		rts
		
; ===========================================================================

CheckSumError:
		bsr.w	VDPSetup
		move.l	#$C0000000,(vdp_control_port).l ; set VDP to CRAM write
		moveq	#$3F,d7

	@fillred:
		move.w	#cRed,(vdp_data_port).l ; fill palette with red
		dbf	d7,@fillred	; repeat $3F more times
		
		moveq  	#$FFFFFFA6,d0
		jsr    	PlaySample

	@endlessloop:
		bra.s	@endlessloop
; ===========================================================================

Art_Text:	incbin	"Data\Art\Uncompressed\menutext.bin" ; text used in level select and debug mode
		even



; ===========================================================================
; ---------------------------------------------------------------------------
; Interrupts
; ---------------------------------------------------------------------------
		include "Engine/VBlank.asm"
		include "Engine/HBlank.asm"

; ---------------------------------------------------------------------------
; SRAM
; ---------------------------------------------------------------------------
		include "Engine/SRAM.asm"
		
; ---------------------------------------------------------------------------
; Input
; ---------------------------------------------------------------------------
		include	"Engine\Input\JoypadInit.asm"
		include	"Engine\Input\ReadJoypads.asm"

; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Rendering
; ---------------------------------------------------------------------------
		include	"Engine\Rendering\VDPSetup.asm"
		include	"Engine\Rendering\ClearScreen.asm"
		include	"Engine\Rendering\TilemapToVRAM.asm"
		include	"Engine\Rendering\Fading.asm"
		include	"Engine\Rendering\Palette.asm"
		include	"Engine\Rendering\VDPDrawBuffer.asm"

; ---------------------------------------------------------------------------
; Compression
; ---------------------------------------------------------------------------
		include	"Engine\Compression\Nemesis.asm"
		include	"Engine\Compression\Enigma.asm"
		include	"Engine\Compression\Kosinski.asm"
		include	"Engine\Compression\Comper.asm"

		include	"Engine\PLC\PatternLoadCues.asm"

		include	"Includes\PaletteCycle.asm"
		include	"Includes\PauseGame.asm"



; ---------------------------------------------------------------------------
; Palette Cycling
; ---------------------------------------------------------------------------
Pal_TitleCyc:	incbin	"Data\Palette\Cycle - Title Screen Water.bin"
Pal_GHZCyc:	incbin	"Data\Palette\Cycle - GHZ.bin"
Pal_LZCyc1:	incbin	"Data\Palette\Cycle - LZ Waterfall.bin"
Pal_LZCyc2:	incbin	"Data\Palette\Cycle - LZ Conveyor Belt.bin"
Pal_LZCyc3:	incbin	"Data\Palette\Cycle - LZ Conveyor Belt Underwater.bin"
Pal_SBZ3Cyc1:	incbin	"Data\Palette\Cycle - SBZ3 Waterfall.bin"
Pal_SLZCyc:	incbin	"Data\Palette\Cycle - SLZ.bin"
Pal_SYZCyc1:	incbin	"Data\Palette\Cycle - SYZ1.bin"
Pal_SYZCyc2:	incbin	"Data\Palette\Cycle - SYZ2.bin"

		include	"Includes\SBZ Palette Scripts.asm"

Pal_SBZCyc1:	incbin	"Data\Palette\Cycle - SBZ 1.bin"
Pal_SBZCyc2:	incbin	"Data\Palette\Cycle - SBZ 2.bin"
Pal_SBZCyc3:	incbin	"Data\Palette\Cycle - SBZ 3.bin"
Pal_SBZCyc4:	incbin	"Data\Palette\Cycle - SBZ 4.bin"
Pal_SBZCyc5:	incbin	"Data\Palette\Cycle - SBZ 5.bin"
Pal_SBZCyc6:	incbin	"Data\Palette\Cycle - SBZ 6.bin"
Pal_SBZCyc7:	incbin	"Data\Palette\Cycle - SBZ 7.bin"
Pal_SBZCyc8:	incbin	"Data\Palette\Cycle - SBZ 8.bin"
Pal_SBZCyc9:	incbin	"Data\Palette\Cycle - SBZ 9.bin"
Pal_SBZCyc10:	incbin	"Data\Palette\Cycle - SBZ 10.bin"


; ===========================================================================

Pal_Sega1:	incbin	"Data\Palette\Sega1.bin"
Pal_Sega2:	incbin	"Data\Palette\Sega2.bin"

; ===========================================================================

		include	"Includes\Palette Pointers.asm"

; ---------------------------------------------------------------------------
; Palette data
; ---------------------------------------------------------------------------
Pal_SegaBG:	incbin	"Data\Palette\Sega.bin"
Pal_Title:	incbin	"Data\Palette\Title Screen.bin"
Pal_LevelSel:	incbin	"Data\Palette\Level Select.bin"
Pal_Sonic:	incbin	"Data\Palette\Sonic.bin"
Pal_GHZ:	incbin	"Data\Palette\Green Hill Zone.bin"
Pal_LZ:		incbin	"Data\Palette\Labyrinth Zone.bin"
Pal_LZWater:	incbin	"Data\Palette\Labyrinth Zone Underwater.bin"
Pal_MZ:		incbin	"Data\Palette\Marble Zone.bin"
Pal_SLZ:	incbin	"Data\Palette\Star Light Zone.bin"
Pal_SYZ:	incbin	"Data\Palette\Spring Yard Zone.bin"
Pal_SBZ1:	incbin	"Data\Palette\SBZ Act 1.bin"
Pal_SBZ2:	incbin	"Data\Palette\SBZ Act 2.bin"
Pal_Special:	incbin	"Data\Palette\Special Stage.bin"
Pal_SBZ3:	incbin	"Data\Palette\SBZ Act 3.bin"
Pal_SBZ3Water:	incbin	"Data\Palette\SBZ Act 3 Underwater.bin"
Pal_LZSonWater:	incbin	"Data\Palette\Sonic - LZ Underwater.bin"
Pal_SBZ3SonWat:	incbin	"Data\Palette\Sonic - SBZ3 Underwater.bin"
Pal_SSResult:	incbin	"Data\Palette\Special Stage Results.bin"
Pal_Continue:	incbin	"Data\Palette\Special Stage Continue Bonus.bin"
Pal_Ending:	incbin	"Data\Palette\Ending.bin"
Pal_Zone7:	incbin	"Data\Palette\Zone 7.bin"

; ---------------------------------------------------------------------------
; Subroutine to	wait for VBlank routines to complete
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WaitForVBla:
		enable_ints

	@wait:
		tst.b	(v_vbla_routine).w ; has VBlank routine finished?
		bne.s	@wait		; if not, branch
		rts
; End of function WaitForVBla

; ---------------------------------------------------------------------------
; Math
; ---------------------------------------------------------------------------
		include	"Engine\Math\RandomNumber.asm"
		include	"Engine\Math\CalcSine.asm"
		include	"Engine\Math\CalcAngle.asm"

; ---------------------------------------------------------------------------
; Modes
; ---------------------------------------------------------------------------
		include	"Modes\SegaScreen.asm"
		include	"Modes\TitleScreen.asm"
		include	"Modes\Menu.asm"
		include	"Modes\Level.asm"
		include	"Modes\SpecialStage.asm"		
		include	"Modes\Continue.asm"
		include	"Modes\Ending.asm"
		include	"Modes\Credits.asm"

; ---------------------------------------------------------------------------
; Level System
; ---------------------------------------------------------------------------
		include	"Engine\Level\LoadTilesAsYouMove.asm"
		include	"Engine\Level\LoadBGScrollBlocks.asm"
		include	"Engine\Level\DrawBlocks.asm"
		include	"Engine\Level\GetBlockData.asm"
		include	"Engine\Level\CalculateVRAMPosition.asm"
		include	"Engine\Level\LoadTilesFromStart.asm"
		include	"Engine\Level\DrawChunks.asm"
		include	"Engine\Level\LevelDataLoad.asm"
		include	"Engine\Level\LevelLayoutLoad.asm"

		include	"Includes\DynamicLevelEvents.asm"
		include	"Engine\Level\Randomizers.asm"

		include	"Objects\Level\Bridge (part 1).asm"

; ---------------------------------------------------------------------------
; Platform subroutine
; ---------------------------------------------------------------------------
PlatformObject:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)	; is Sonic moving up/jumping?
		bmi.w	Plat_Exit	; if yes, branch

;		perform x-axis range check
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.w	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	Plat_Exit

	Plat_NoXCheck:
		move.w	obY(a0),d0
		subq.w	#8,d0

Platform3:
;		perform y-axis range check
		move.w	obY(a1),d2
		move.b	obHeight(a1),d1
		ext.w	d1
		add.w	d2,d1
		addq.w	#4,d1
		sub.w	d1,d0
		bhi.w	Plat_Exit
		cmpi.w	#-$10,d0
		blo.w	Plat_Exit

		tst.b	(f_lockmulti).w
		bmi.w	Plat_Exit
		cmpi.b	#6,obRoutine(a1)
		bhs.w	Plat_Exit
		add.w	d0,d2
		addq.w	#3,d2
		move.w	d2,obY(a1)
		addq.b	#2,obRoutine(a0)

loc_74AE:
		btst	#3,obStatus(a1)
		beq.s	loc_74DC
		moveq	#0,d0
		move.b	$3D(a1),d0
		lsl.w	#6,d0
		addi.l	#v_objspace&$FFFFFF,d0
		movea.l	d0,a2
		bclr	#3,obStatus(a2)
		clr.b	ob2ndRout(a2)
		cmpi.b	#4,obRoutine(a2)
		bne.s	loc_74DC
		subq.b	#2,obRoutine(a2)

loc_74DC:
		move.w	a0,d0
		subi.w	#-$3000,d0
		lsr.w	#6,d0
		andi.w	#$7F,d0
		move.b	d0,$3D(a1)
		move.b	#0,obAngle(a1)
		move.w	#0,obVelY(a1)
		move.w	obVelX(a1),obInertia(a1)
		btst	#1,obStatus(a1)
		beq.s	loc_7512
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Sonic_ResetOnFloor).l
		movea.l	(sp)+,a0

loc_7512:
		bset	#3,obStatus(a1)
		bset	#3,obStatus(a0)

Plat_Exit:
		rts
; End of function PlatformObject

; ---------------------------------------------------------------------------
; Sloped platform subroutine (GHZ collapsing ledges and	SLZ seesaws)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SlopeObject:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)
		bmi.w	Plat_Exit
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.s	Plat_Exit
		btst	#0,obRender(a0)
		beq.s	loc_754A
		not.w	d0
		add.w	d1,d0

loc_754A:
		lsr.w	#1,d0
		moveq	#0,d3
		move.b	(a2,d0.w),d3
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.w	Platform3
; End of function SlopeObject


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Swing_Solid:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)
		bmi.w	Plat_Exit
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.w	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	Plat_Exit
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.w	Platform3
; End of function Obj15_Solid

; ===========================================================================

		include	"Objects\Level\Bridge (part 2).asm"

; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to walk or jump off	a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ExitPlatform:
		move.w	d1,d2

ExitPlatform2:
		add.w	d2,d2
		lea	(v_player).w,a1
		btst	#1,obStatus(a1)
		bne.s	loc_75E0
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	loc_75E0
		cmp.w	d2,d0
		blo.s	locret_75F2

loc_75E0:
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a0)
		bclr	#3,obStatus(a0)

locret_75F2:
		rts
; End of function ExitPlatform

		include	"Objects\Level\Bridge (part 3).asm" ; TODO: Merge the entire bridge into this file
Map_Bri:	include	"Data\Mappings\Objects\Bridge.asm"

		include	"Objects\Level\Swinging Platforms (part 1).asm"

; ---------------------------------------------------------------------------
; Subroutine to	change Sonic's position with a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MvSonicOnPtfm:
		lea	(v_player).w,a1
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.s	MvSonic2
; End of function MvSonicOnPtfm

; ---------------------------------------------------------------------------
; Subroutine to	change Sonic's position with a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MvSonicOnPtfm2:
		lea	(v_player).w,a1
		move.w	obY(a0),d0
		subi.w	#9,d0

MvSonic2:
		tst.b	(f_lockmulti).w
		bmi.s	locret_7B62
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.s	locret_7B62
		tst.w	(v_debuguse).w
		bne.s	locret_7B62
		moveq	#0,d1
		move.b	obHeight(a1),d1
		sub.w	d1,d0
		move.w	d0,obY(a1)
		sub.w	obX(a0),d2
		sub.w	d2,obX(a1)

locret_7B62:
		rts
; End of function MvSonicOnPtfm2

		include	"Objects\Level\Swinging Platforms (part 2).asm" ; TODO: Merge Part 1 -> Part 2
Map_Swing_GHZ:	include	"Data\Mappings\Objects\Swinging Platforms (GHZ).asm"
Map_Swing_SLZ:	include	"Data\Mappings\Objects\Swinging Platforms (SLZ).asm"
		include	"Objects\Hazards\Spiked Pole Helix.asm"
Map_Hel:	include	"Data\Mappings\Objects\Spiked Pole Helix.asm"
		include	"Objects\Level\Platforms.asm"
Map_Plat_Unused:include	"Data\Mappings\Objects\Platforms (unused).asm"
Map_Plat_GHZ:	include	"Data\Mappings\Objects\Platforms (GHZ).asm"
Map_Plat_SYZ:	include	"Data\Mappings\Objects\Platforms (SYZ).asm"
Map_Plat_SLZ:	include	"Data\Mappings\Objects\Platforms (SLZ).asm"
Map_GBall:	include	"Data\Mappings\Objects\GHZ Ball.asm"
		include	"Objects\Level\Collapsing Ledge.asm"
		include	"Objects\Level\Collapsing Floors.asm"

; ===========================================================================

Ledge_Fragment:
		move.b	#0,ledge_collapse_flag(a0)

loc_847A:
		lea	(CFlo_Data1).l,a4
		moveq	#$18,d1
		addq.b	#2,obFrame(a0)

loc_8486:
		moveq	#0,d0
		move.b	obFrame(a0),d0
		add.w	d0,d0
		movea.l	obMap(a0),a3
		adda.w	(a3,d0.w),a3
		addq.w	#2,a3
		bset	#5,obRender(a0)
		move.b	0(a0),d4
		move.b	obRender(a0),d5
		movea.l	a0,a1
		bra.s	loc_84B2
; ===========================================================================

loc_84AA:
		bsr.w	FindFreeObj
		bne.s	loc_84F2
		addq.w	#6,a3

loc_84B2:
		move.b	#6,obRoutine(a1)
		move.b	d4,0(a1)
		move.l	a3,obMap(a1)
		move.b	d5,obRender(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	obGfx(a0),obGfx(a1)
		move.b	obPriority(a0),obPriority(a1)
		move.b	obActWid(a0),obActWid(a1)
		move.b	(a4)+,ledge_timedelay(a1)
		cmpa.l	a0,a1
		bhs.s	loc_84EE
		bsr.w	DisplaySprite1

loc_84EE:
		dbf	d1,loc_84AA

loc_84F2:
		bsr.w	DisplaySprite
		sfx	sfx_Collapse	; play collapsing sound
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Disintegration data for collapsing ledges (MZ, SLZ, SBZ)
; ---------------------------------------------------------------------------
CFlo_Data1:	dc.b $1C, $18, $14, $10, $1A, $16, $12,	$E, $A,	6, $18,	$14, $10, $C, 8, 4
		dc.b $16, $12, $E, $A, 6, 2, $14, $10, $C, 0
CFlo_Data2:	dc.b $1E, $16, $E, 6, $1A, $12,	$A, 2
CFlo_Data3:	dc.b $16, $1E, $1A, $12, 6, $E,	$A, 2

; ---------------------------------------------------------------------------
; Sloped platform subroutine (GHZ collapsing ledges and	MZ platforms)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SlopeObject2:
		lea	(v_player).w,a1
		btst	#3,obStatus(a1)
		beq.s	locret_856E
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		lsr.w	#1,d0
		btst	#0,obRender(a0)
		beq.s	loc_854E
		not.w	d0
		add.w	d1,d0

loc_854E:
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		move.w	obY(a0),d0
		sub.w	d1,d0
		moveq	#0,d1
		move.b	obHeight(a1),d1
		sub.w	d1,d0
		move.w	d0,obY(a1)
		sub.w	obX(a0),d2
		sub.w	d2,obX(a1)

locret_856E:
		rts
; End of function SlopeObject2

; ===========================================================================
; ---------------------------------------------------------------------------
; Collision data for GHZ collapsing ledge
; ---------------------------------------------------------------------------
Ledge_SlopeData:
		incbin	"Data\Miscellaneous\GHZ Collapsing Ledge Heightmap.bin"
		even

Map_Ledge:	include	"Data\Mappings\Objects\Collapsing Ledge.asm"
Map_CFlo:	include	"Data\Mappings\Objects\Collapsing Floors.asm"

		include	"Objects\Level\Scenery.asm"
Map_Scen:	include	"Data\Mappings\Objects\Scenery.asm"

		include	"Objects\Unused\Unused Switch.asm"
Map_Swi:	include	"Data\Mappings\Objects\Unused Switch.asm"

		include	"Objects\Level\SBZ Small Door.asm"
		include	"Data\Animations\SBZ Small Door.asm"
Map_ADoor:	include	"Data\Mappings\Objects\SBZ Small Door.asm"

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj44_SolidWall:
		bsr.w	Obj44_SolidWall2
		beq.s	loc_8AA8
		bmi.w	loc_8AC4
		tst.w	d0
		beq.w	loc_8A92
		bmi.s	loc_8A7C
		tst.w	obVelX(a1)
		bmi.s	loc_8A92
		bra.s	loc_8A82
; ===========================================================================

loc_8A7C:
		tst.w	obVelX(a1)
		bpl.s	loc_8A92

loc_8A82:
		sub.w	d0,obX(a1)
		move.w	#0,obInertia(a1)
		move.w	#0,obVelX(a1)

loc_8A92:
		btst	#1,obStatus(a1)
		bne.s	loc_8AB6
		bset	#5,obStatus(a1)
		bset	#5,obStatus(a0)
		rts
; ===========================================================================

loc_8AA8:
		btst	#5,obStatus(a0)
		beq.s	locret_8AC2
		move.w	#id_Run,obAnim(a1)

loc_8AB6:
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)

locret_8AC2:
		rts
; ===========================================================================

loc_8AC4:
		tst.w	obVelY(a1)
		bpl.s	locret_8AD8
		tst.w	d3
		bpl.s	locret_8AD8
		sub.w	d3,obY(a1)
		move.w	#0,obVelY(a1)

locret_8AD8:
		rts
; End of function Obj44_SolidWall


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj44_SolidWall2:
		lea	(v_player).w,a1
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	loc_8B48
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.s	loc_8B48
		move.b	obHeight(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	obY(a1),d3
		sub.w	obY(a0),d3
		add.w	d2,d3
		bmi.s	loc_8B48
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.s	loc_8B48
		tst.b	(f_lockmulti).w
		bmi.s	loc_8B48
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.s	loc_8B48
		tst.w	(v_debuguse).w
		bne.s	loc_8B48
		move.w	d0,d5
		cmp.w	d0,d1
		bhs.s	loc_8B30
		add.w	d1,d1
		sub.w	d1,d0
		move.w	d0,d5
		neg.w	d5

loc_8B30:
		move.w	d3,d1
		cmp.w	d3,d2
		bhs.s	loc_8B3C
		sub.w	d4,d3
		move.w	d3,d1
		neg.w	d1

loc_8B3C:
		cmp.w	d1,d5
		bhi.s	loc_8B44
		moveq	#1,d4
		rts
; ===========================================================================

loc_8B44:
		moveq	#-1,d4
		rts
; ===========================================================================

loc_8B48:
		moveq	#0,d4
		rts
; End of function Obj44_SolidWall2

; ===========================================================================
		include	"Objects\Badniks\Ball Hog.asm"
		include	"Objects\Badniks\Cannonball.asm"
		include	"Objects\Effects\Explosions.asm"
		include	"Data\Animations\Ball Hog.asm"
Map_Hog:	include	"Data\Mappings\Objects\Ball Hog.asm"
Map_MisDissolve:include	"Data\Mappings\Objects\Buzz Bomber Missile Dissolve.asm"
		include	"Data\Mappings\Objects\Explosions.asm"

		include	"Objects\Effects\Animals.asm"
		include	"Objects\Effects\MK Blood.asm"
		include	"Objects\Gameplay\Points.asm"
Map_Animal1:	include	"Data\Mappings\Objects\Animals 1.asm"
Map_Animal2:	include	"Data\Mappings\Objects\Animals 2.asm"
Map_Animal3:	include	"Data\Mappings\Objects\Animals 3.asm"
Map_Poi:	include	"Data\Mappings\Objects\Points.asm"

		include	"Objects\Badniks\Crabmeat.asm"
		include	"Data\Animations\Crabmeat.asm"
Map_Crab:	include	"Data\Mappings\Objects\Crabmeat.asm"
		include	"Objects\Badniks\Buzz Bomber.asm"
		include	"Objects\Badniks\Buzz Bomber Missile.asm"
		include	"Data\Animations\Buzz Bomber.asm"
		include	"Data\Animations\Buzz Bomber Missile.asm"
Map_Buzz:	include	"Data\Mappings\Objects\Buzz Bomber.asm"
Map_Missile:	include	"Data\Mappings\Objects\Buzz Bomber Missile.asm"

		include	"Objects\Gameplay\Rings.asm"
		include	"Objects\Gameplay\Giant Ring.asm"
		include	"Objects\Effects\Ring Flash.asm"

		include	"Data\Animations\Rings.asm"
		if Revision=0
Map_Ring:	include	"Data\Mappings\Objects\Rings.asm"
		else
Map_Ring:		include	"Data\Mappings\Objects\Rings (JP1).asm"
		endc
Map_GRing:	include	"Data\Mappings\Objects\Giant Ring.asm"
Map_Flash:	include	"Data\Mappings\Objects\Ring Flash.asm"
		include	"Objects\Gameplay\Monitor.asm"
		include	"Objects\Gameplay\Monitor Content Power-Up.asm"
		include	"Engine\Collision\SolidSides.asm"
		include	"Data\Animations\Monitor.asm"
Map_Monitor:	include	"Data\Mappings\Objects\Monitor.asm"

		include	"Objects\Screen-Space\Title Screen Sonic.asm"
		include	"Objects\Screen-Space\Press Start and TM.asm"

		include	"Data\Animations\Title Screen Sonic.asm"
		include	"Data\Animations\Press Start and TM.asm"

Map_PSB:	include	"Data\Mappings\Objects\Press Start and TM.asm"
Map_TSon:	include	"Data\Mappings\Objects\Title Screen Sonic.asm"

		include	"Objects\Badniks\Chopper.asm"
		include	"Data\Animations\Chopper.asm"
Map_Chop:	include	"Data\Mappings\Objects\Chopper.asm"
		include	"Objects\Badniks\Jaws.asm"
		include	"Data\Animations\Jaws.asm"
Map_Jaws:	include	"Data\Mappings\Objects\Jaws.asm"
		include	"Objects\Badniks\Burrobot.asm"
		include	"Data\Animations\Burrobot.asm"
Map_Burro:	include	"Data\Mappings\Objects\Burrobot.asm"

		include	"Objects\Hazards\MZ Large Grassy Platforms.asm"
		include	"Objects\Hazards\Burning Grass.asm"
		include	"Data\Animations\Burning Grass.asm"
Map_LGrass:	include	"Data\Mappings\Objects\MZ Large Grassy Platforms.asm"
Map_Fire:	include	"Data\Mappings\Objects\Fireballs.asm"
		include	"Objects\Level\MZ Large Green Glass Blocks.asm"
Map_Glass:	include	"Data\Mappings\Objects\MZ Large Green Glass Blocks.asm"
		include	"Objects\Hazards\Chained Stompers.asm"
		include	"Objects\Hazards\Sideways Stomper.asm"
Map_CStom:	include	"Data\Mappings\Objects\Chained Stompers.asm"
Map_SStom:	include	"Data\Mappings\Objects\Sideways Stomper.asm"

		include	"Objects\Level\Button.asm"
Map_But:	include	"Data\Mappings\Objects\Button.asm"

		include	"Objects\Level\Pushable Blocks.asm"
Map_Push:	include	"Data\Mappings\Objects\Pushable Blocks.asm"

		include	"Objects\Screen-Space\Title Cards.asm"
		include	"Objects\Screen-Space\Game Over.asm"
		include	"Objects\Screen-Space\Got Through Card.asm"
		include	"Objects\Screen-Space\Special Stage Results.asm"
		include	"Objects\Screen-Space\SS Result Chaos Emeralds.asm"

		include "Data\Mappings\Sprites\TitleCards.asm"

Map_SSRC:	include	"Data\Mappings\Objects\SS Result Chaos Emeralds.asm"

		include	"Objects\Hazards\Spikes.asm"
Map_Spike:	include	"Data\Mappings\Objects\Spikes.asm"
		include	"Objects\Level\Purple Rock.asm"
		include	"Objects\Effects\Waterfall Sound.asm"
Map_PRock:	include	"Data\Mappings\Objects\Purple Rock.asm"
		include	"Objects\Level\Smashable Wall.asm"

		include	"Engine\ObjectSystem\SmashObject.asm"

; ===========================================================================
; Smashed block	fragment speeds
;
Smash_FragSpd1:	dc.w $400, -$500	; x-move speed,	y-move speed
		dc.w $600, -$100
		dc.w $600, $100
		dc.w $400, $500
		dc.w $600, -$600
		dc.w $800, -$200
		dc.w $800, $200
		dc.w $600, $600

Smash_FragSpd2:	dc.w -$600, -$600
		dc.w -$800, -$200
		dc.w -$800, $200
		dc.w -$600, $600
		dc.w -$400, -$500
		dc.w -$600, -$100
		dc.w -$600, $100
		dc.w -$400, $500

Map_Smash:	include	"Data\Mappings\Objects\Smashable Walls.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Object System
; ---------------------------------------------------------------------------
		include	"Engine\ObjectSystem\ChaseObject.asm"
		include	"Engine\ObjectSystem\FindOtherObject.asm"
		include	"Engine\ObjectSystem\ExecuteObjects.asm"
		
Obj_Index:
		include	"Objects\Pointers.asm"
		
		include	"Engine\ObjectSystem\ObjectFall.asm"
		include	"Engine\ObjectSystem\SpeedToPos.asm"
		include	"Engine\ObjectSystem\DisplaySprite.asm"
		include	"Engine\ObjectSystem\DeleteObject.asm"
		
		include	"Engine\ObjectSystem\GetOrientationToPlayer.asm"
		include	"Engine\ObjectSystem\BuildSprites.asm"
		include	"Engine\ObjectSystem\ChkObjectVisible.asm"
		include	"Engine\ObjectSystem\ObjPosLoad.asm"
		include	"Engine\ObjectSystem\FindFreeObj.asm"
		
		include	"Engine\ObjectSystem\AnimateSprite.asm"
				
; ===========================================================================

		include	"Objects\Level\Springs.asm"
		include	"Data\Animations\Springs.asm"
Map_Spring:	include	"Data\Mappings\Objects\Springs.asm"

		include	"Objects\Badniks\Newtron.asm"
		include	"Data\Animations\Newtron.asm"
Map_Newt:	include	"Data\Mappings\Objects\Newtron.asm"
		include	"Objects\Badniks\Roller.asm"
		include	"Data\Animations\Roller.asm"
Map_Roll:	include	"Data\Mappings\Objects\Roller.asm"

		include	"Objects\Level\GHZ Edge Walls.asm"
Map_Edge:	include	"Data\Mappings\Objects\GHZ Edge Walls.asm"

		include	"Objects\Hazards\Lava Ball Maker.asm"
		include	"Objects\Hazards\Lava Ball.asm"
		include	"Data\Animations\Fireballs.asm"

		include	"Objects\Hazards\Flamethrower.asm"
		include	"Data\Animations\Flamethrower.asm"
Map_Flame:	include	"Data\Mappings\Objects\Flamethrower.asm"

		include	"Objects\Level\MZ Bricks.asm"
Map_Brick:	include	"Data\Mappings\Objects\MZ Bricks.asm"

		include	"Objects\Level\Light.asm"
Map_Light	include	"Data\Mappings\Objects\Light.asm"
		include	"Objects\Level\Bumper.asm"
		include	"Data\Animations\Bumper.asm"
Map_Bump:	include	"Data\Mappings\Objects\Bumper.asm"

		include	"Objects\Gameplay\Signpost.asm" ; includes "GotThroughAct" subroutine
		include	"Data\Animations\Signpost.asm"
Map_Sign:	include	"Data\Mappings\Objects\Signpost.asm"

		include	"Objects\Hazards\Lava Geyser Maker.asm"
		include	"Objects\Hazards\Wall of Lava.asm"
		include	"Objects\Invisible\Lava Tag.asm"
Map_LTag:	include	"Data\Mappings\Objects\Lava Tag.asm"
		include	"Data\Animations\Lava Geyser.asm"
		include	"Data\Animations\Wall of Lava.asm"
Map_Geyser:	include	"Data\Mappings\Objects\Lava Geyser.asm"
Map_LWall:	include	"Data\Mappings\Objects\Wall of Lava.asm"

		include	"Objects\Badniks\Moto Bug.asm" ; includes "Objects\sub RememberState.asm"
		include	"Data\Animations\Moto Bug.asm"
Map_Moto:	include	"Data\Mappings\Objects\Moto Bug.asm"
		include	"Objects\Unused\4F.asm"

		include "Data/Mappings/Objects/Mogeko.asm"
		include "Data/Animations/Mogeko.asm"
		include "Objects/Badniks/Mogeko.asm"

		include	"Objects\Badniks\Yadrin.asm"
		include	"Data\Animations\Yadrin.asm"
Map_Yad:	include	"Data\Mappings\Objects\Yadrin.asm"

		include	"Engine\ObjectSystem\SolidObject.asm"

		include	"Objects\Level\Smashable Green Block.asm"
Map_Smab:	include	"Data\Mappings\Objects\Smashable Green Block.asm"

		include	"Objects\Level\Moving Blocks.asm"
Map_MBlock:	include	"Data\Mappings\Objects\Moving Blocks (MZ and SBZ).asm"
Map_MBlockLZ:	include	"Data\Mappings\Objects\Moving Blocks (LZ).asm"

		include	"Objects\Badniks\Basaran.asm"
		include	"Data\Animations\Basaran.asm"
Map_Bas:	include	"Data\Mappings\Objects\Basaran.asm"

		include	"Objects\Level\Floating Blocks and Doors.asm"
Map_FBlock:	include	"Data\Mappings\Objects\Floating Blocks and Doors.asm"

		include	"Objects\Hazards\Spiked Ball and Chain.asm"
Map_SBall:	include	"Data\Mappings\Objects\Spiked Ball and Chain (SYZ).asm"
Map_SBall2:	include	"Data\Mappings\Objects\Spiked Ball and Chain (LZ).asm"
		include	"Objects\Hazards\Big Spiked Ball.asm"
Map_BBall:	include	"Data\Mappings\Objects\Big Spiked Ball.asm"
		include	"Objects\Level\SLZ Elevators.asm"
Map_Elev:	include	"Data\Mappings\Objects\SLZ Elevators.asm"
		include	"Objects\Level\SLZ Circling Platform.asm"
Map_Circ:	include	"Data\Mappings\Objects\SLZ Circling Platform.asm"
		include	"Objects\Level\Staircase.asm"
Map_Stair:	include	"Data\Mappings\Objects\Staircase.asm"
		include	"Objects\Screen-Space\Pylon.asm"
Map_Pylon:	include	"Data\Mappings\Objects\Pylon.asm"

		include	"Objects\Effects\Water Surface.asm"
Map_Surf:	include	"Data\Mappings\Objects\Water Surface.asm"
		include	"Objects\Level\Pole that Breaks.asm"
Map_Pole:	include	"Data\Mappings\Objects\Pole that Breaks.asm"
		include	"Objects\Level\Flapping Door.asm"
		include	"Data\Animations\Flapping Door.asm"
Map_Flap:	include	"Data\Mappings\Objects\Flapping Door.asm"

		include	"Objects\Invisible\Invisible Barriers.asm"
Map_Invis:	include	"Data\Mappings\Objects\Invisible Barriers.asm"

		include	"Objects\Level\Fan.asm"
Map_Fan:	include	"Data\Mappings\Objects\Fan.asm"
		include	"Objects\Level\Seesaw.asm"
Map_Seesaw:	include	"Data\Mappings\Objects\Seesaw.asm"
Map_SSawBall:	include	"Data\Mappings\Objects\Seesaw Ball.asm"
		include	"Objects\Badniks\Bomb Enemy.asm"
		include	"Data\Animations\Bomb Enemy.asm"
Map_Bomb:	include	"Data\Mappings\Objects\Bomb Enemy.asm"

		include	"Objects\Badniks\Orbinaut.asm"
		include	"Data\Animations\Orbinaut.asm"
Map_Orb:	include	"Data\Mappings\Objects\Orbinaut.asm"

		include	"Objects\Hazards\Harpoon.asm"
		include	"Data\Animations\Harpoon.asm"
Map_Harp:	include	"Data\Mappings\Objects\Harpoon.asm"
		include	"Objects\Level\LZ Blocks.asm"
Map_LBlock:	include	"Data\Mappings\Objects\LZ Blocks.asm"
		include	"Objects\Hazards\Gargoyle.asm"
Map_Gar:	include	"Data\Mappings\Objects\Gargoyle.asm"
		include	"Objects\Level\LZ Conveyor.asm"
Map_LConv:	include	"Data\Mappings\Objects\LZ Conveyor.asm"
		include	"Objects\Gameplay\Bubbles.asm"
		include	"Data\Animations\Bubbles.asm"
Map_Bub:	include	"Data\Mappings\Objects\Bubbles.asm"
		include	"Objects\Level\Waterfalls.asm"
		include	"Data\Animations\Waterfalls.asm"
Map_WFall	include	"Data\Mappings\Objects\Waterfalls.asm"
		include	"Objects\Effects\S2 Sonic Particles.asm"
		include "Objects\Sonic\Main.asm"
		include	"Objects\Gameplay\Drowning Countdown.asm"


; ---------------------------------------------------------------------------
; Subroutine to	play music for LZ/SBZ3 after a countdown
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ResumeMusic:
		cmpi.w	#12,(v_air).w	; more than 12 seconds of air left?
		bhi.s	@over12		; if yes, branch
		move.b	#mus_LZ,d0	; play LZ music
		cmpi.w	#(id_LZ<<8)+3,(v_zone).w ; check if level is 0103 (SBZ3)
		bne.s	@notsbz
		move.b	#mus_SBZ,d0	; play SBZ music

	@notsbz:
		if Revision=0
		else
			tst.b	(v_invinc).w ; is Sonic invincible?
			beq.s	@notinvinc ; if not, branch
			move.b	#mus_Invincibility,d0
	@notinvinc:
			tst.b	(f_lockscreen).w ; is Sonic at a boss?
			beq.s	@playselected ; if not, branch
			move.b	#mus_Boss,d0
	@playselected:
		endc

		jsr	PlaySound

	@over12:
		move.w	#30,(v_air).w	; reset air to 30 seconds
		clr.b	(v_objspace+$340+$32).w
		rts
; End of function ResumeMusic

; ===========================================================================

		include	"Data\Animations\Drowning Countdown.asm"
Map_Drown:	include	"Data\Mappings\Objects\Drowning Countdown.asm"

		include	"Objects\Gameplay\Shield and Invincibility.asm"
		include	"Objects\Unused\Special Stage Entry (Unused).asm"
		include	"Objects\Effects\Water Splash.asm"
		include	"Data\Animations\Shield and Invincibility.asm"
Map_Shield:	include	"Data\Mappings\Objects\Shield and Invincibility.asm"
		include	"Data\Animations\Special Stage Entry (Unused).asm"
Map_Vanish:	include	"Data\Mappings\Objects\Special Stage Entry (Unused).asm"
		include	"Data\Animations\Water Splash.asm"
Map_Splash:	include	"Data\Mappings\Objects\Water Splash.asm"

		include	"Objects\Sonic\AnglePos.asm"

; ---------------------------------------------------------------------------
; Collision
; ---------------------------------------------------------------------------
		include	"Engine\Collision\FindNearestTile.asm"
		include	"Engine\Collision\FindFloor.asm"
		include	"Engine\Collision\FindWall.asm"

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_WalkSpeed:
		move.l	obX(a0),d3
		move.l	obY(a0),d2
		move.w	obVelX(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	obVelY(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3
		move.b	d0,(v_anglebuffer).w
		move.b	d0,($FFFFF76A).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	loc_14D1A
		move.b	d1,d0
		bpl.s	loc_14D14
		subq.b	#1,d0

loc_14D14:
		addi.b	#$20,d0
		bra.s	loc_14D24
; ===========================================================================

loc_14D1A:
		move.b	d1,d0
		bpl.s	loc_14D20
		addq.b	#1,d0

loc_14D20:
		addi.b	#$1F,d0

loc_14D24:
		andi.b	#$C0,d0
		beq.w	loc_14DF0
		cmpi.b	#$80,d0
		beq.w	loc_14F7C
		andi.b	#$38,d1
		bne.s	loc_14D3C
		addq.w	#8,d2

loc_14D3C:
		cmpi.b	#$40,d0
		beq.w	loc_1504A
		bra.w	loc_14EBC

; End of function Sonic_WalkSpeed


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14D48:
		move.b	d0,(v_anglebuffer).w
		move.b	d0,($FFFFF76A).w
		addi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_14FD6
		cmpi.b	#$80,d0
		beq.w	Sonic_DontRunOnWalls
		cmpi.b	#$C0,d0
		beq.w	sub_14E50

; End of function sub_14D48

; ---------------------------------------------------------------------------
; Subroutine to	make Sonic land	on the floor after jumping
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HitFloor:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$D,d5
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$D,d5
		bsr.w	FindFloor
		move.w	(sp)+,d0
		move.b	#0,d2

loc_14DD0:
		move.b	($FFFFF76A).w,d3
		cmp.w	d0,d1
		ble.s	loc_14DDE
		move.b	(v_anglebuffer).w,d3
		exg	d0,d1

loc_14DDE:
		btst	#0,d3
		beq.s	locret_14DE6
		move.b	d2,d3

locret_14DE6:
		rts

; End of function Sonic_HitFloor

; ===========================================================================
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14DF0:
		addi.w	#$A,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	#0,d2

loc_14E0A:
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14E16
		move.b	d2,d3

locret_14E16:
		rts

		include	"Engine\ObjectSystem\ObjFloorDist.asm"


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14E50:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#-$40,d2
		bra.w	loc_14DD0

; End of function sub_14E50


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14EB4:
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14EBC:
		addi.w	#$A,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	#-$40,d2
		bra.w	loc_14E0A

; End of function sub_14EB4

; ---------------------------------------------------------------------------
; Subroutine to	detect when an object hits a wall to its right
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitWallRight:
		add.w	obX(a0),d3
		move.w	obY(a0),d2
		lea	(v_anglebuffer).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14F06
		move.b	#-$40,d3

locret_14F06:
		rts

; End of function ObjHitWallRight

; ---------------------------------------------------------------------------
; Subroutine preventing	Sonic from running on walls and	ceilings when he
; touches them
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_DontRunOnWalls:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.w	(sp)+,d0
		move.b	#-$80,d2
		bra.w	loc_14DD0
; End of function Sonic_DontRunOnWalls

; ===========================================================================
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14F7C:
		subi.w	#$A,d2
		eori.w	#$F,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	#-$80,d2
		bra.w	loc_14E0A

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitCeiling:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14FD4
		move.b	#-$80,d3

locret_14FD4:
		rts
; End of function ObjHitCeiling

; ===========================================================================

loc_14FD6:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	($FFFFF76A).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#$40,d2
		bra.w	loc_14DD0

; ---------------------------------------------------------------------------
; Subroutine to	stop Sonic when	he jumps at a wall
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HitWall:
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_1504A:
		subi.w	#$A,d3
		eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	#$40,d2
		bra.w	loc_14E0A
; End of function Sonic_HitWall

; ---------------------------------------------------------------------------
; Subroutine to	detect when an object hits a wall to its left
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitWallLeft:
		add.w	obX(a0),d3
		move.w	obY(a0),d2
		; Engine bug: colliding with left walls is erratic with this function.
		; The cause is this: a missing instruction to flip collision on the found
		; 16x16 block; this one:
		;eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_15098
		move.b	#$40,d3

locret_15098:
		rts
; End of function ObjHitWallLeft

; ===========================================================================

		include	"Objects\Level\Rotating Junction.asm"
Map_Jun:	include	"Data\Mappings\Objects\Rotating Junction.asm"
		include	"Objects\Level\Running Disc.asm"
Map_Disc:	include	"Data\Mappings\Objects\Running Disc.asm"
		include	"Objects\Level\Conveyor Belt.asm"
		include	"Objects\Level\SBZ Spinning Platforms.asm"
		include	"Data\Animations\SBZ Spinning Platforms.asm"
Map_Trap:	include	"Data\Mappings\Objects\Trapdoor.asm"
Map_Spin:	include	"Data\Mappings\Objects\SBZ Spinning Platforms.asm"
		include	"Objects\Hazards\Saws and Pizza Cutters.asm"
Map_Saw:	include	"Data\Mappings\Objects\Saws and Pizza Cutters.asm"
		include	"Objects\Hazards\SBZ Stomper and Door.asm"
Map_Stomp:	include	"Data\Mappings\Objects\SBZ Stomper and Door.asm"
		include	"Objects\Level\SBZ Vanishing Platforms.asm"
		include	"Data\Animations\SBZ Vanishing Platforms.asm"
Map_VanP:	include	"Data\Mappings\Objects\SBZ Vanishing Platforms.asm"
		include	"Objects\Hazards\Electrocuter.asm"
		include	"Data\Animations\Electrocuter.asm"
Map_Elec:	include	"Data\Mappings\Objects\Electrocuter.asm"
		include	"Objects\Level\SBZ Spin Platform Conveyor.asm"
		include	"Data\Animations\SBZ Spin Platform Conveyor.asm"

off_164A6:	dc.w word_164B2-off_164A6, word_164C6-off_164A6, word_164DA-off_164A6
		dc.w word_164EE-off_164A6, word_16502-off_164A6, word_16516-off_164A6
word_164B2:	dc.w $10, $E80,	$E14, $370, $EEF, $302,	$EEF, $340, $E14, $3AE
word_164C6:	dc.w $10, $F80,	$F14, $2E0, $FEF, $272,	$FEF, $2B0, $F14, $31E
word_164DA:	dc.w $10, $1080, $1014,	$270, $10EF, $202, $10EF, $240,	$1014, $2AE
word_164EE:	dc.w $10, $F80,	$F14, $570, $FEF, $502,	$FEF, $540, $F14, $5AE
word_16502:	dc.w $10, $1B80, $1B14,	$670, $1BEF, $602, $1BEF, $640,	$1B14, $6AE
word_16516:	dc.w $10, $1C80, $1C14,	$5E0, $1CEF, $572, $1CEF, $5B0,	$1C14, $61E
; ===========================================================================

		include	"Objects\Level\Girder Block.asm"
Map_Gird:	include	"Data\Mappings\Objects\Girder Block.asm"
		include	"Objects\Invisible\Teleporter.asm"

		include	"Objects\Badniks\Caterkiller.asm"
		include	"Data\Animations\Caterkiller.asm"
Map_Cat:	include	"Data\Mappings\Objects\Caterkiller.asm"

		include	"Objects\Gameplay\Lamppost.asm"
Map_Lamp:	include	"Data\Mappings\Objects\Lamppost.asm"
		include	"Objects\Gameplay\Hidden Bonuses.asm"
Map_Bonus:	include	"Data\Mappings\Objects\Hidden Bonuses.asm"

		include	"Objects\Screen-Space\Credits.asm"
Map_Cred:	include	"Data\Mappings\Objects\Credits.asm"

; ---------------------------------------------------------------------------
; Defeated boss	subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossDefeated:
		move.b	(v_vbla_byte).w,d0
		andi.b	#7,d0
		bne.s	locret_178A2
		jsr	(FindFreeObj).l
		bne.s	locret_178A2
		
		Instance.new ExplosionBomb, a1
		
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		
		jsr	(RandomNumber).l
		move.w	d0,d1
		moveq	#0,d1
		move.b	d0,d1
		lsr.b	#2,d1
		subi.w	#$20,d1
		add.w	d1,obX(a1)
		lsr.w	#8,d0
		lsr.b	#3,d0
		add.w	d0,obY(a1)

locret_178A2:
		rts
; End of function BossDefeated

		dc.b 	"MY BUNNI WEIGHS 2 KILOS "

; ---------------------------------------------------------------------------
; Subroutine to	move a boss
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossMove:
		move.l	$30(a0),d2
		move.l	$38(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	obVelY(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,$30(a0)
		move.l	d3,$38(a0)
		rts
; End of function BossMove

; ---------------------------------------------------------------------------
; Subroutine to	move a boss (optimized)
; ---------------------------------------------------------------------------

BossMove2:
		; use Blast processing(tm) to calculate position
		movem.w	obVelX(a0), d0-d1
		asl.l	#8, d0
		add.l	d0, obX(a0)
		asl.l	#8, d1
		add.l	d1, $38(a0)
		rts
; End of function BossMove

; ===========================================================================

		include	"Objects\Bosses\Green Hill\Main.asm"
		include	"Objects\Bosses\Green Hill\EggmanShip.asm"	; WARNING! Auto-generated
		include	"Objects\Bosses\Green Hill\EggmanMonitor.asm"	; WARNING! Auto-generated
		include	"Objects\Bosses\Green Hill\SpikedBall.asm"	; WARNING! Auto-generated
		
		include	"Data\Animations\Eggman.asm"
Map_Eggman:	include	"Data\Mappings\Objects\Eggman.asm"
Map_BossItems:	include	"Data\Mappings\Objects\Boss Items.asm"
		
		include	"Data\Mappings\Sprites\Menu Items.asm"

		include	"Objects\Bosses\Labyrinth\Main.asm"
		
		include	"Objects\Bosses\Star Light\Main.asm"
		include	"Objects\Bosses\Star Light\Missile.asm"

	Obj7A_Delete:
		jmp	(DeleteObject).l

		include	"Objects\Bosses\Marble\Main.asm"
		include	"Objects\Bosses\Marble\LavaBall.asm"
Map_BSBall:	include	"Data\Mappings\Objects\SLZ Boss Spikeball.asm"
		include	"Objects\Bosses\Spring Yard\Main.asm"
		include	"Objects\Bosses\Spring Yard\SYZ Boss Bumper.asm"
Map_BossBlock:	include	"Data\Mappings\Objects\SYZ Boss Blocks.asm"

loc_1982C:
		jmp	(DeleteObject).l

		include	"Objects\Bosses\Eggman - Scrap Brain 2.asm"
		include	"Data\Animations\Eggman - Scrap Brain 2 & Final.asm"
Map_SEgg:	include	"Data\Mappings\Objects\Eggman - Scrap Brain 2.asm"
		include	"Objects\Bosses\SBZ Eggman's Crumbling Floor.asm"
Map_FFloor:	include	"Data\Mappings\Objects\SBZ Eggman's Crumbling Floor.asm"
		include	"Objects\Bosses\Final\Main.asm"
		include	"Data\Animations\FZ Eggman in Ship.asm"
Map_FZDamaged:	include	"Data\Mappings\Objects\FZ Damaged Eggmobile.asm"
Map_FZLegs:	include	"Data\Mappings\Objects\FZ Eggmobile Legs.asm"
		include	"Objects\Bosses\Final\FZ Eggman's Cylinders.asm"
Map_EggCyl:	include	"Data\Mappings\Objects\FZ Eggman's Cylinders.asm"
		include	"Objects\Bosses\Final\FZ Plasma Ball Launcher.asm"
		include	"Data\Animations\Plasma Ball Launcher.asm"
Map_PLaunch:	include	"Data\Mappings\Objects\Plasma Ball Launcher.asm"
		include	"Data\Animations\Plasma Balls.asm"
Map_Plasma:	include	"Data\Mappings\Objects\Plasma Balls.asm"

		include	"Objects\Gameplay\Prison Capsule.asm"
		include	"Data\Animations\Prison Capsule.asm"
Map_Pri:	include	"Data\Mappings\Objects\Prison Capsule.asm"

		include	"Engine\ObjectSystem\ReactToItem.asm"
		include	"Engine\ObjectSystem\RandomDirection.asm"

		include	"Engine\ObjectSystem\UpdateDPLC.asm"

SS_MapIndex:
		include	"Includes\Special Stage Mappings & VRAM Pointers.asm"

Map_SS_R:	include	"Data\Mappings\Objects\SS R Block.asm"
Map_SS_Glass:	include	"Data\Mappings\Objects\SS Glass Block.asm"
Map_SS_Up:	include	"Data\Mappings\Objects\SS UP Block.asm"
Map_SS_Down:	include	"Data\Mappings\Objects\SS DOWN Block.asm"
		include	"Data\Mappings\Objects\SS Chaos Emeralds.asm"

		include	"Objects\Unused\10.asm"

		include	"Includes\AnimateLevelGfx.asm"

		include	"Objects\Screen-Space\HUD.asm"
Map_HUD:	include	"Data\Mappings\Objects\HUD.asm"

		include	"Objects\Effects\Splatter.asm"
		include	"Objects\Screen-Space\Sega Logo Letters.asm"

; ---------------------------------------------------------------------------
; Special game over
; ---------------------------------------------------------------------------
BasicallyYoureFucked:
		music 	mus_stop
		jsr 	ClearScreen
		move.w  #$24, (v_demolength).w

		move.l 	#$FFFFFFA3, d0
		jsr 	PlaySample

@WaitSample1:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		beq.s 	@Sample2

		bra.s 	@WaitSample1

@Sample2:
		move.l 	#$FFFFFFA4, d0
		jsr 	PlaySample

		move.l  #$68000000, ($FFC00004).l
		lea     @Art, a0
		jsr     NemDec 		; preload art

		move.w  #$40, (v_demolength).w

@WaitSample2:
		move.b	#$4, (v_vbla_routine).w
		jsr		WaitForVBla

		tst.w 	(v_demolength).w
		bne.s 	@WaitSample2

		lea    	($FF0000), a1 ; load background here
		lea    	@Mappings, a0
		move.w 	#320, d0
		jsr    	EniDec.w

		lea     ($FF0000), a1
		move.l  #$60000003, d0
		moveq   #39, d1
		moveq   #30, d2
		jsr	   	TilemapToVRAM 	; mappings -> vram

		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$9, d0
 
@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop
		jsr 	PaletteFadeIn

@Die:
		bra.s 	@Die

@Mappings: incbin "Data/Mappings/TileMaps/Special Game Over.bin"
	even
@Art: incbin "Data/Art/Nemesis/Special Game Over.bin"
	even
@Palette: incbin "Data/Palette/Special Game Over.bin"
	even

; ---------------------------------------------------------------------------
; Add points subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


AddPoints:
		move.b	#1,(f_scorecount).w ; set score counter to update

		if Revision=0
		lea	(v_scorecopy).w,a2
		lea	(v_score).w,a3
		add.l	d0,(a3)		; add d0*10 to the score
		move.l	#999999,d1
		cmp.l	(a3),d1		; is score below 999999?
		bhi.w	@belowmax	; if yes, branch
		move.l	d1,(a3)		; reset	score to 999999
		move.l	d1,(a2)

	@belowmax:
		move.l	(a3),d0
		cmp.l	(a2),d0
		blo.w	@locret_1C6B6
		move.l	d0,(a2)

		else

			lea     (v_score).w,a3
			add.l   d0,(a3)
			move.l  #999999,d1
			cmp.l   (a3),d1 ; is score below 999999?
			bhi.s   @belowmax ; if yes, branch
			move.l  d1,(a3) ; reset score to 999999
		@belowmax:
			move.l  (a3),d0
			cmp.l   (v_scorelife).w,d0 ; has Sonic got 50000+ points?
			blo.s   @noextralife ; if not, branch

			addi.l  #5000,(v_scorelife).w ; increase requirement by 50000
			tst.b   (v_megadrive).w
			bmi.s   @noextralife ; branch if Mega Drive is Japanese
			addq.b  #1,(v_lives).w ; give extra life
			addq.b  #1,(f_lifecount).w
			sfx		sfx_register	; play extra life music
		endc

@locret_1C6B6:
@noextralife:
		rts
; End of function AddPoints

		include	"Includes\HUD_Update.asm"
		include "Objects\Effects\SonicDeath.asm"
		include	"Objects\CppObject.asm"
		include	"Objects\DynamicObject.asm"

; ---------------------------------------------------------------------------
; Subroutine to	load countdown numbers on the continue screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ContScrCounter:
		locVRAM	$DF80
		lea	(vdp_data_port).l,a6
		lea	(Hud_10).l,a2
		moveq	#1,d6
		moveq	#0,d4
		lea	Art_Hud(pc),a1 ; load numbers patterns

ContScr_Loop:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_1C95A:
		sub.l	d3,d1
		blo.s	loc_1C962
		addq.w	#1,d2
		bra.s	loc_1C95A
; ===========================================================================

loc_1C962:
		add.l	d3,d1
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		dbf	d6,ContScr_Loop	; repeat 1 more	time

		rts
; End of function ContScrCounter

; ===========================================================================

		include	"Includes\HUD (part 2).asm"

Art_Hud:	incbin	"Data\Art\Uncompressed\HUD Numbers.bin" ; 8x16 pixel numbers on HUD
		even
Art_LivesNums:	incbin	"Data\Art\Uncompressed\Lives Counter Numbers.bin" ; 8x8 pixel numbers on lives counter
		even

		include	"Objects\Bosses\Final\PlasmaBoss.asm"
		include	"Objects\Bosses\Final\PlasmaBall.asm"

		include	"Objects\DebugMode.asm"
		include	"Includes\DebugList.asm"
		include	"Includes\LevelHeaders.asm"
		include	"Includes\Pattern Load Cues.asm"

		if Revision=0
Nem_SegaLogo:	incbin	"Data\Art\Nemesis\Sega Logo.bin"	; large Sega logo
		even
Eni_SegaLogo:	incbin	"Data\Mappings\TileMaps\Sega Logo.bin" ; large Sega logo (mappings)
		even
		else
	Nem_SegaLogo:	incbin	"Data\Art\Nemesis\Sega Logo (JP1).bin" ; large Sega logo
			even
	Eni_SegaLogo:	incbin	"Data\Mappings\TileMaps\Sega Logo (JP1).bin" ; large Sega logo (mappings)
			even
		endc
Nem_TitleSonic:	incbin	"Data\Art\Nemesis\Title Screen Sonic.bin"
		even
Nem_TitleTM:	incbin	"Data\Art\Nemesis\Title Screen TM.bin"
		even
Eni_JapNames:	incbin	"Data\Mappings\TileMaps\Hidden Japanese Credits.bin" ; Japanese credits (mappings)
		even
Nem_JapNames:	incbin	"Data\Art\Nemesis\Hidden Japanese Credits.bin"
		even

Map_Sonic:	include	"Data\Mappings\Objects\Sonic.asm"
		include	"Data\DPLCs\Sonic.asm"

; ---------------------------------------------------------------------------
; Uncompressed graphics	- Sonic
; ---------------------------------------------------------------------------

Art_Sonic:	incbin	"Data\Art\Uncompressed\Sonic.bin"	; Sonic
		even

; ---------------------------------------------------------------------------
; Uncompressed graphics	- Sonic 2's dust/splash particles
; ---------------------------------------------------------------------------
Art_Dust:	incbin	"Data\Art\Uncompressed\S2 Sonic Particles.bin"	; Sonic
		even
; ---------------------------------------------------------------------------
; Compressed graphics - various
; ---------------------------------------------------------------------------
		if Revision=0
Nem_Smoke:	incbin	"Data\Art\Nemesis\Unused - Smoke.bin"
		even
Nem_SyzSparkle:	incbin	"Data\Art\Nemesis\Unused - SYZ Sparkles.bin"
		even
		else
		endc
Nem_Shield:	incbin	"Data\Art\Nemesis\Shield.bin"
		even
Nem_Stars:	incbin	"Data\Art\Nemesis\Invincibility Stars.bin"
		even
		if Revision=0
Nem_LzSonic:	incbin	"Data\Art\Nemesis\Unused - LZ Sonic.bin" ; Sonic holding his breath
		even
Nem_UnkFire:	incbin	"Data\Art\Nemesis\Unused - Fireball.bin" ; unused fireball
		even
Nem_Warp:	incbin	"Data\Art\Nemesis\Unused - SStage Flash.bin" ; entry to special stage flash
		even
Nem_Goggle:	incbin	"Data\Art\Nemesis\Unused - Goggles.bin" ; unused goggles
		even
		else
		endc

Map_SSWalls:	include	"Data\Mappings\Objects\SS Walls.asm"

; ---------------------------------------------------------------------------
; Compressed graphics - special stage
; ---------------------------------------------------------------------------
Nem_SSWalls:	incbin	"Data\Art\Nemesis\Special Walls.bin" ; special stage walls
		even
Eni_SSBg1:	incbin	"Data\Mappings\TileMaps\SS Background 1.bin" ; special stage background (mappings)
		even
Nem_SSBgFish:	incbin	"Data\Art\Nemesis\Special Birds & Fish.bin" ; special stage birds and fish background
		even
Eni_SSBg2:	incbin	"Data\Mappings\TileMaps\SS Background 2.bin" ; special stage background (mappings)
		even
Nem_SSBgCloud:	incbin	"Data\Art\Nemesis\Special Clouds.bin" ; special stage clouds background
		even
Nem_SSGOAL:	incbin	"Data\Art\Nemesis\Special GOAL.bin" ; special stage GOAL block
		even
Nem_SSRBlock:	incbin	"Data\Art\Nemesis\Special R.bin"	; special stage R block
		even
Nem_SS1UpBlock:	incbin	"Data\Art\Nemesis\Special 1UP.bin" ; special stage 1UP block
		even
Nem_SSEmStars:	incbin	"Data\Art\Nemesis\Special Emerald Twinkle.bin" ; special stage stars from a collected emerald
		even
Nem_SSRedWhite:	incbin	"Data\Art\Nemesis\Special Red-White.bin" ; special stage red/white block
		even
Nem_SSZone1:	incbin	"Data\Art\Nemesis\Special ZONE1.bin" ; special stage ZONE1 block
		even
Nem_SSZone2:	incbin	"Data\Art\Nemesis\Special ZONE2.bin" ; ZONE2 block
		even
Nem_SSZone3:	incbin	"Data\Art\Nemesis\Special ZONE3.bin" ; ZONE3 block
		even
Nem_SSZone4:	incbin	"Data\Art\Nemesis\Special ZONE4.bin" ; ZONE4 block
		even
Nem_SSZone5:	incbin	"Data\Art\Nemesis\Special ZONE5.bin" ; ZONE5 block
		even
Nem_SSZone6:	incbin	"Data\Art\Nemesis\Special ZONE6.bin" ; ZONE6 block
		even
Nem_SSUpDown:	incbin	"Data\Art\Nemesis\Special UP-DOWN.bin" ; special stage UP/DOWN block
		even
Nem_SSEmerald:	incbin	"Data\Art\Nemesis\Special Emeralds.bin" ; special stage chaos emeralds
		even
Nem_SSGhost:	incbin	"Data\Art\Nemesis\Special Ghost.bin" ; special stage ghost block
		even
Nem_SSWBlock:	incbin	"Data\Art\Nemesis\Special W.bin"	; special stage W block
		even
Nem_SSGlass:	incbin	"Data\Art\Nemesis\Special Glass.bin" ; special stage destroyable glass block
		even
Nem_ResultEm:	incbin	"Data\Art\Nemesis\Special Result Emeralds.bin" ; chaos emeralds on special stage results screen
		even
; ---------------------------------------------------------------------------
; Compressed graphics - GHZ stuff
; ---------------------------------------------------------------------------
Nem_Stalk:	incbin	"Data\Art\Nemesis\GHZ Flower Stalk.bin"
		even
Nem_Swing:	incbin	"Data\Art\Nemesis\GHZ Swinging Platform.bin"
		even
Nem_Bridge:	incbin	"Data\Art\Nemesis\GHZ Bridge.bin"
		even
Nem_GhzUnkBlock:incbin	"Data\Art\Nemesis\Unused - GHZ Block.bin"
		even
Nem_Ball:	incbin	"Data\Art\Nemesis\GHZ Giant Ball.bin"
		even
Nem_Spikes:	incbin	"Data\Art\Nemesis\Spikes.bin"
		even
Nem_GhzLog:	incbin	"Data\Art\Nemesis\Unused - GHZ Log.bin"
		even
Nem_SpikePole:	incbin	"Data\Art\Nemesis\GHZ Spiked Log.bin"
		even
Nem_PplRock:	incbin	"Data\Art\Nemesis\GHZ Purple Rock.bin"
		even
Nem_GhzWall1:	incbin	"Data\Art\Nemesis\GHZ Breakable Wall.bin"
		even
Nem_GhzWall2:	incbin	"Data\Art\Nemesis\GHZ Edge Wall.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - LZ stuff
; ---------------------------------------------------------------------------
Nem_Water:	incbin	"Data\Art\Nemesis\LZ Water Surface.bin"
		even
Nem_Splash:	incbin	"Data\Art\Nemesis\LZ Water & Splashes.bin"
		even
Nem_LzSpikeBall:incbin	"Data\Art\Nemesis\LZ Spiked Ball & Chain.bin"
		even
Nem_FlapDoor:	incbin	"Data\Art\Nemesis\LZ Flapping Door.bin"
		even
Nem_Bubbles:	incbin	"Data\Art\Nemesis\LZ Bubbles & Countdown.bin"
		even
Nem_LzBlock3:	incbin	"Data\Art\Nemesis\LZ 32x16 Block.bin"
		even
Nem_LzDoor1:	incbin	"Data\Art\Nemesis\LZ Vertical Door.bin"
		even
Nem_Harpoon:	incbin	"Data\Art\Nemesis\LZ Harpoon.bin"
		even
Nem_LzPole:	incbin	"Data\Art\Nemesis\LZ Breakable Pole.bin"
		even
Nem_LzDoor2:	incbin	"Data\Art\Nemesis\LZ Horizontal Door.bin"
		even
Nem_LzWheel:	incbin	"Data\Art\Nemesis\LZ Wheel.bin"
		even
Nem_Gargoyle:	incbin	"Data\Art\Nemesis\LZ Gargoyle & Fireball.bin"
		even
Nem_LzBlock2:	incbin	"Data\Art\Nemesis\LZ Blocks.bin"
		even
Nem_LzPlatfm:	incbin	"Data\Art\Nemesis\LZ Rising Platform.bin"
		even
Nem_Cork:	incbin	"Data\Art\Nemesis\LZ Cork.bin"
		even
Nem_LzBlock1:	incbin	"Data\Art\Nemesis\LZ 32x32 Block.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - MZ stuff
; ---------------------------------------------------------------------------
Nem_MzMetal:	incbin	"Data\Art\Nemesis\MZ Metal Blocks.bin"
		even
Nem_MzSwitch:	incbin	"Data\Art\Nemesis\MZ Switch.bin"
		even
Nem_MzGlass:	incbin	"Data\Art\Nemesis\MZ Green Glass Block.bin"
		even
Nem_UnkGrass:	incbin	"Data\Art\Nemesis\Unused - Grass.bin"
		even
Nem_MzFire:	incbin	"Data\Art\Nemesis\Fireballs.bin"
		even
Nem_Lava:	incbin	"Data\Art\Nemesis\MZ Lava.bin"
		even
Nem_MzBlock:	incbin	"Data\Art\Nemesis\MZ Green Pushable Block.bin"
		even
Nem_MzUnkBlock:	incbin	"Data\Art\Nemesis\Unused - MZ Background.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - SLZ stuff
; ---------------------------------------------------------------------------
Nem_Seesaw:	incbin	"Data\Art\Nemesis\SLZ Seesaw.bin"
		even
Nem_SlzSpike:	incbin	"Data\Art\Nemesis\SLZ Little Spikeball.bin"
		even
Nem_Fan:	incbin	"Data\Art\Nemesis\SLZ Fan.bin"
		even
Nem_SlzWall:	incbin	"Data\Art\Nemesis\SLZ Breakable Wall.bin"
		even
Nem_Pylon:	incbin	"Data\Art\Nemesis\SLZ Pylon.bin"
		even
Nem_SlzSwing:	incbin	"Data\Art\Nemesis\SLZ Swinging Platform.bin"
		even
Nem_SlzBlock:	incbin	"Data\Art\Nemesis\SLZ 32x32 Block.bin"
		even
Nem_SlzCannon:	incbin	"Data\Art\Nemesis\SLZ Cannon.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - SYZ stuff
; ---------------------------------------------------------------------------
Nem_Bumper:	incbin	"Data\Art\Nemesis\SYZ Bumper.bin"
		even
Nem_SyzSpike2:	incbin	"Data\Art\Nemesis\SYZ Small Spikeball.bin"
		even
Nem_LzSwitch:	incbin	"Data\Art\Nemesis\Switch.bin"
		even
Nem_SyzSpike1:	incbin	"Data\Art\Nemesis\SYZ Large Spikeball.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - SBZ stuff
; ---------------------------------------------------------------------------
Nem_SbzWheel1:	incbin	"Data\Art\Nemesis\SBZ Running Disc.bin"
		even
Nem_SbzWheel2:	incbin	"Data\Art\Nemesis\SBZ Junction Wheel.bin"
		even
Nem_Cutter:	incbin	"Data\Art\Nemesis\SBZ Pizza Cutter.bin"
		even
Nem_Stomper:	incbin	"Data\Art\Nemesis\SBZ Stomper.bin"
		even
Nem_SpinPform:	incbin	"Data\Art\Nemesis\SBZ Spinning Platform.bin"
		even
Nem_TrapDoor:	incbin	"Data\Art\Nemesis\SBZ Trapdoor.bin"
		even
Nem_SbzFloor:	incbin	"Data\Art\Nemesis\SBZ Collapsing Floor.bin"
		even
Nem_Electric:	incbin	"Data\Art\Nemesis\SBZ Electrocuter.bin"
		even
Nem_SbzBlock:	incbin	"Data\Art\Nemesis\SBZ Vanishing Block.bin"
		even
Nem_FlamePipe:	incbin	"Data\Art\Nemesis\SBZ Flaming Pipe.bin"
		even
Nem_SbzDoor1:	incbin	"Data\Art\Nemesis\SBZ Small Vertical Door.bin"
		even
Nem_SlideFloor:	incbin	"Data\Art\Nemesis\SBZ Sliding Floor Trap.bin"
		even
Nem_SbzDoor2:	incbin	"Data\Art\Nemesis\SBZ Large Horizontal Door.bin"
		even
Nem_Girder:	incbin	"Data\Art\Nemesis\SBZ Crushing Girder.bin"
		even

; ---------------------------------------------------------------------------
; Compressed graphics - mogege
; ---------------------------------------------------------------------------
Nem_Mogeko: 	incbin "Data\Art\Nemesis\Mogeko.bin"
		even
		
; ---------------------------------------------------------------------------
; Compressed graphics - enemies
; ---------------------------------------------------------------------------
Nem_BallHog:	incbin	"Data\Art\Nemesis\Enemy Ball Hog.bin"
		even
Nem_Crabmeat:	incbin	"Data\Art\Nemesis\Enemy Crabmeat.bin"
		even
Nem_Buzz:	incbin	"Data\Art\Nemesis\Enemy Buzz Bomber.bin"
		even
Nem_UnkExplode:	incbin	"Data\Art\Nemesis\Unused - Explosion.bin"
		even
Nem_Burrobot:	incbin	"Data\Art\Nemesis\Enemy Burrobot.bin"
		even
Nem_Chopper:	incbin	"Data\Art\Nemesis\Enemy Chopper.bin"
		even
Nem_Jaws:	incbin	"Data\Art\Nemesis\Enemy Jaws.bin"
		even
Nem_Roller:	incbin	"Data\Art\Nemesis\Enemy Roller.bin"
		even
Nem_Motobug:	incbin	"Data\Art\Nemesis\Enemy Motobug.bin"
		even
Nem_Newtron:	incbin	"Data\Art\Nemesis\Enemy Newtron.bin"
		even
Nem_Yadrin:	incbin	"Data\Art\Nemesis\Enemy Yadrin.bin"
		even
Nem_Basaran:	incbin	"Data\Art\Nemesis\Enemy Basaran.bin"
		even
Nem_Splats:	incbin	"Data\Art\Nemesis\Enemy Splats.bin"
		even
Nem_Bomb:	incbin	"Data\Art\Nemesis\Enemy Bomb.bin"
		even
Nem_Orbinaut:	incbin	"Data\Art\Nemesis\Enemy Orbinaut.bin"
		even
Nem_Cater:	incbin	"Data\Art\Nemesis\Enemy Caterkiller.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - various
; ---------------------------------------------------------------------------
Nem_TitleCard:	incbin	"Data\Art\Nemesis\Title Cards V2.bin"
		even
Nem_Hud:	incbin	"Data\Art\Nemesis\HUD.bin"	; HUD (rings, time, score)
		even
Nem_Lives:	incbin	"Data\Art\Nemesis\HUD - Life Counter Icon.bin"
		even
Nem_Ring:	incbin	"Data\Art\Nemesis\Rings.bin"
		even
Nem_Monitors:	incbin	"Data\Art\Nemesis\Monitors.bin"
		even
Nem_Explode:	incbin	"Data\Art\Nemesis\Explosion.bin"
		even
Nem_Points:	incbin	"Data\Art\Nemesis\Points.bin"	; points from destroyed enemy or object
		even
Nem_GameOver:	incbin	"Data\Art\Nemesis\Game Over.bin"	; game over / time over
		even
Nem_HSpring:	incbin	"Data\Art\Nemesis\Spring Horizontal.bin"
		even
Nem_VSpring:	incbin	"Data\Art\Nemesis\Spring Vertical.bin"
		even
Nem_SignPost:	incbin	"Data\Art\Nemesis\Signpost.bin"	; end of level signpost
		even
Nem_Lamp:	incbin	"Data\Art\Nemesis\Lamppost.bin"
		even
Nem_BigFlash:	incbin	"Data\Art\Nemesis\Giant Ring Flash.bin"
		even
Nem_Bonus:	incbin	"Data\Art\Nemesis\Hidden Bonuses.bin" ; hidden bonuses at end of a level
		even
Kos_MenuFont:	incbin	"Data\Art\Kosinski\Menu Font.bin"	; SWA menu font
		even
Kos_MenuBG:	incbin	"Data\Art\Kosinski\Menu Background.bin"	; manu background
		even
; ---------------------------------------------------------------------------
; Compressed graphics - continue screen
; ---------------------------------------------------------------------------
Nem_ContSonic:	incbin	"Data\Art\Nemesis\Continue Screen Sonic.bin"
		even
Nem_MiniSonic:	incbin	"Data\Art\Nemesis\Continue Screen Stuff.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - animals
; ---------------------------------------------------------------------------
Nem_Rabbit:	incbin	"Data\Art\Nemesis\Animal Rabbit.bin"
		even
Nem_Chicken:	incbin	"Data\Art\Nemesis\Animal Chicken.bin"
		even
Nem_BlackBird:	incbin	"Data\Art\Nemesis\Animal Blackbird.bin"
		even
Nem_Seal:	incbin	"Data\Art\Nemesis\Animal Seal.bin"
		even
Nem_Pig:	incbin	"Data\Art\Nemesis\Animal Pig.bin"
		even
Nem_Flicky:	incbin	"Data\Art\Nemesis\Animal Flicky.bin"
		even
Nem_Squirrel:	incbin	"Data\Art\Nemesis\Animal Squirrel.bin"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - primary patterns and block mappings
; ---------------------------------------------------------------------------
Blk16_GHZ:	incbin	"Data\Mappings\Levels\16\GHZ.bin"
		even
Nem_GHZ_1st:	incbin	"Data\Art\Nemesis\8x8 - GHZ1.bin"	; GHZ primary patterns
		even
Nem_GHZ_2nd:	incbin	"Data\Art\Nemesis\8x8 - GHZ2.bin"	; GHZ secondary patterns
		even
Blk256_GHZ:	incbin	"Data\Mappings\Levels\256\GHZ.bin"
		even
Blk16_LZ:	
		even
Nem_LZ:		
		even
Blk256_LZ:	
		even
Blk16_MZ:	incbin	"Data\Mappings\Levels\16\MZ.bin"
		even
Nem_MZ:		incbin	"Data\Art\Nemesis\8x8 - MZ.bin"	; MZ primary patterns
		even
Blk256_MZ:	if Revision=0
		incbin	"Data\Mappings\Levels\256\MZ.bin"
		else
		incbin	"Data\Mappings\Levels\256\MZ (JP1).bin"
		endc
		even
Blk16_SLZ:	incbin	"Data\Mappings\Levels\16\SLZ.bin"
		even
Nem_SLZ:	incbin	"Data\Art\Nemesis\8x8 - SLZ.bin"	; SLZ primary patterns
		even
Blk256_SLZ:	incbin	"Data\Mappings\Levels\256\SLZ.bin"
		even
Blk16_SYZ:	incbin	"Data\Mappings\Levels\16\SYZ.bin"
		even
Nem_SYZ:	incbin	"Data\Art\Nemesis\8x8 - SYZ.bin"	; SYZ primary patterns
		even
Blk256_SYZ:	incbin	"Data\Mappings\Levels\256\SYZ.bin"
		even
Blk16_SBZ:	incbin	"Data\Mappings\Levels\16\SBZ.bin"
		even
Nem_SBZ:	incbin	"Data\Art\Nemesis\8x8 - SBZ.bin"	; SBZ primary patterns
		even
Blk256_SBZ:	if Revision=0
		incbin	"Data\Mappings\Levels\256\SBZ.bin"
		else
		incbin	"Data\Mappings\Levels\256\SBZ (JP1).bin"
		endc
		even
Nem_Zone7:		incbin	"Data\Art\Nemesis\8x8 - Zone 7.bin"	; Zone 7 primary patterns
		even	
Blk256_Zone7:
				incbin	"Data\Mappings\Levels\256\Zone 7.bin"	
		even
Blk16_Zone7:
				incbin	"Data\Mappings\Levels\16\Zone 7.bin"	
		even		
; ---------------------------------------------------------------------------
; Compressed graphics - bosses and ending sequence
; ---------------------------------------------------------------------------
Nem_Eggman:	incbin	"Data\Art\Nemesis\Boss - Main.bin"
		even
Nem_Weapons:	incbin	"Data\Art\Nemesis\Boss - Weapons.bin"
		even
Nem_Prison:	incbin	"Data\Art\Nemesis\Prison Capsule.bin"
		even
Nem_Sbz2Eggman:	incbin	"Data\Art\Nemesis\Boss - Eggman in SBZ2 & FZ.bin"
		even
Nem_FzBoss:	incbin	"Data\Art\Nemesis\Boss - Final Zone.bin"
		even
Nem_FzEggman:	incbin	"Data\Art\Nemesis\Boss - Eggman after FZ Fight.bin"
		even
Nem_Exhaust:	incbin	"Data\Art\Nemesis\Boss - Exhaust Flame.bin"
		even
Nem_EndEm:	incbin	"Data\Art\Nemesis\Ending - Emeralds.bin"
		even
Nem_EndSonic:	incbin	"Data\Art\Nemesis\Ending - Sonic.bin"
		even
Nem_TryAgain:	incbin	"Data\Art\Nemesis\Ending - Try Again.bin"
		even
Nem_EndEggman:
		even
Kos_EndFlowers:	incbin	"Data\Art\Kosinski\Flowers at Ending.bin" ; ending sequence animated flowers
		even
Nem_EndFlower:	incbin	"Data\Art\Nemesis\Ending - Flowers.bin"
		even
Nem_CreditText:	incbin	"Data\Art\Nemesis\Ending - Credits.bin"
		even
Nem_EndStH:	incbin	"Data\Art\Nemesis\Ending - StH Logo.bin"
		even
; ---------------------------------------------------------------------------
; Collision data
; ---------------------------------------------------------------------------
AngleMap:	incbin	"Data\Levels\Collision\Angle Map.bin"
		even
CollArray1:	incbin	"Data\Levels\Collision\Collision Array (Normal).bin"
		even
CollArray2:	incbin	"Data\Levels\Collision\Collision Array (Rotated).bin"
		even
Col_GHZ:	incbin	"Data\Levels\Collision\GHZ.bin"	; GHZ index
		even
Col_LZ:		
		even
Col_MZ:		incbin	"Data\Levels\Collision\MZ.bin"	; MZ index
		even
Col_SLZ:	incbin	"Data\Levels\Collision\SLZ.bin"	; SLZ index
		even
Col_SYZ:	incbin	"Data\Levels\Collision\SYZ.bin"	; SYZ index
		even
Col_SBZ:	incbin	"Data\Levels\Collision\SBZ.bin"	; SBZ index
		even
Col_Zone7:		incbin	"Data\Levels\Collision\Zone 7.bin"	; Zone 7 index
		even		
; ---------------------------------------------------------------------------
; Special Stage layouts
; ---------------------------------------------------------------------------
SS_1:		incbin	"Data\Levels\SpecialStages\1.bin"
		even
SS_2:		incbin	"Data\Levels\SpecialStages\2.bin"
		even
SS_3:		incbin	"Data\Levels\SpecialStages\3.bin"
		even
SS_4:		incbin	"Data\Levels\SpecialStages\4.bin"
		even
SS_5:		incbin	"Data\Levels\SpecialStages\5 (JP1).bin"
			even
SS_6:		incbin	"Data\Levels\SpecialStages\6 (JP1).bin"
		even
; ---------------------------------------------------------------------------
; Animated uncompressed graphics
; ---------------------------------------------------------------------------
Art_GhzWater:	incbin	"Data\Art\Uncompressed\GHZ Waterfall.bin"
		even
Art_GhzFlower1:	incbin	"Data\Art\Uncompressed\GHZ Flower Large.bin"
		even
Art_GhzFlower2:	incbin	"Data\Art\Uncompressed\GHZ Flower Small.bin"
		even
Art_MzLava1:	incbin	"Data\Art\Uncompressed\MZ Lava Surface.bin"
		even
Art_MzLava2:	incbin	"Data\Art\Uncompressed\MZ Lava.bin"
		even
Art_MzTorch:	incbin	"Data\Art\Uncompressed\MZ Background Torch.bin"
		even
Art_SbzSmoke:	incbin	"Data\Art\Uncompressed\SBZ Background Smoke.bin"
		even

; ---------------------------------------------------------------------------
; Level	layout index
; ---------------------------------------------------------------------------
Level_Index:
		; GHZ
		dc.w Level_GHZ1-Level_Index, Level_GHZbg-Level_Index, byte_68D70-Level_Index
		dc.w Level_GHZ2-Level_Index, Level_GHZbg-Level_Index, byte_68E3C-Level_Index
		dc.w Level_GHZ3-Level_Index, Level_GHZbg-Level_Index, byte_68F84-Level_Index
		dc.w byte_68F88-Level_Index, byte_68F88-Level_Index, byte_68F88-Level_Index
		; LZ
		dc.w Level_LZ1-Level_Index, Level_LZbg-Level_Index, byte_69190-Level_Index
		dc.w Level_LZ2-Level_Index, Level_LZbg-Level_Index, byte_6922E-Level_Index
		dc.w Level_LZ3-Level_Index, Level_LZbg-Level_Index, byte_6934C-Level_Index
		dc.w Level_SBZ3-Level_Index, Level_LZbg-Level_Index, byte_6940A-Level_Index
		; MZ
		dc.w Level_MZ1-Level_Index, Level_MZ1bg-Level_Index, Level_MZ1-Level_Index
		dc.w Level_MZ2-Level_Index, Level_MZ2bg-Level_Index, byte_6965C-Level_Index
		dc.w Level_MZ3-Level_Index, Level_MZ3bg-Level_Index, byte_697E6-Level_Index
		dc.w byte_697EA-Level_Index, byte_697EA-Level_Index, byte_697EA-Level_Index
		; SLZ
		dc.w Level_SLZ1-Level_Index, Level_SLZbg-Level_Index, byte_69B84-Level_Index
		dc.w Level_SLZ2-Level_Index, Level_SLZbg-Level_Index, byte_69B84-Level_Index
		dc.w Level_SLZ3-Level_Index, Level_SLZbg-Level_Index, byte_69B84-Level_Index
		dc.w byte_69B84-Level_Index, byte_69B84-Level_Index, byte_69B84-Level_Index
		; SYZ
		dc.w Level_SYZ1-Level_Index, Level_SYZbg-Level_Index, byte_69C7E-Level_Index
		dc.w Level_SYZ2-Level_Index, Level_SYZbg-Level_Index, byte_69D86-Level_Index
		dc.w Level_SYZ3-Level_Index, Level_SYZbg-Level_Index, byte_69EE4-Level_Index
		dc.w byte_69EE8-Level_Index, byte_69EE8-Level_Index, byte_69EE8-Level_Index
		; SBZ
		dc.w Level_SBZ1-Level_Index, Level_SBZ1bg-Level_Index, Level_SBZ1bg-Level_Index
		dc.w Level_SBZ2-Level_Index, Level_SBZ2bg-Level_Index, Level_SBZ2bg-Level_Index
		dc.w Level_SBZ2-Level_Index, Level_SBZ2bg-Level_Index, byte_6A2F8-Level_Index
		dc.w byte_6A2FC-Level_Index, byte_6A2FC-Level_Index, byte_6A2FC-Level_Index
		; Ending
		dc.w Level_End-Level_Index, Level_GHZbg-Level_Index, byte_6A320-Level_Index
		dc.w Level_End-Level_Index, Level_GHZbg-Level_Index, byte_6A320-Level_Index
		dc.w byte_6A320-Level_Index, byte_6A320-Level_Index, byte_6A320-Level_Index
		dc.w byte_6A320-Level_Index, byte_6A320-Level_Index, byte_6A320-Level_Index
		zonewarning Level_Index,24		
		; Zone 7
		dc.w Level_Zone7-Level_Index, Level_Zone7bg-Level_Index, Level_Zone7-Level_Index
		dc.w byte_68F88-Level_Index, byte_68F88-Level_Index, byte_68F88-Level_Index
		dc.w byte_68F88-Level_Index, byte_68F88-Level_Index, byte_68F88-Level_Index
		dc.w byte_68F88-Level_Index, byte_68F88-Level_Index, byte_68F88-Level_Index
		

Level_GHZ1:	incbin	"Data\Levels\LevelData\ghz1.bin"
		even
byte_68D70:	dc.b 0,	0, 0, 0
Level_GHZ2:	incbin	"Data\Levels\LevelData\ghz2.bin"
		even
byte_68E3C:	dc.b 0,	0, 0, 0
Level_GHZ3:	incbin	"Data\Levels\LevelData\ghz3.bin"
		even
Level_GHZbg:	incbin	"Data\Levels\LevelData\ghzbg.bin"
		even
byte_68F84:	dc.b 0,	0, 0, 0
byte_68F88:	dc.b 0,	0, 0, 0

Level_LZ1:	incbin	"Data\Levels\LevelData\lz1.bin"
		even
Level_LZbg:	incbin	"Data\Levels\LevelData\lzbg.bin"
		even
byte_69190:	dc.b 0,	0, 0, 0
Level_LZ2:	incbin	"Data\Levels\LevelData\lz2.bin"
		even
byte_6922E:	dc.b 0,	0, 0, 0
Level_LZ3:	incbin	"Data\Levels\LevelData\lz3.bin"
		even
byte_6934C:	dc.b 0,	0, 0, 0
Level_SBZ3:	incbin	"Data\Levels\LevelData\sbz3.bin"
		even
byte_6940A:	dc.b 0,	0, 0, 0

Level_MZ1:	incbin	"Data\Levels\LevelData\mz1.bin"
		even
Level_MZ1bg:	incbin	"Data\Levels\LevelData\mz1bg.bin"
		even
Level_MZ2:	incbin	"Data\Levels\LevelData\mz2.bin"
		even
Level_MZ2bg:	incbin	"Data\Levels\LevelData\mz2bg.bin"
		even
byte_6965C:	dc.b 0,	0, 0, 0
Level_MZ3:	incbin	"Data\Levels\LevelData\mz3.bin"
		even
Level_MZ3bg:	incbin	"Data\Levels\LevelData\mz3bg.bin"
		even
byte_697E6:	dc.b 0,	0, 0, 0
byte_697EA:	dc.b 0,	0, 0, 0

Level_SLZ1:	incbin	"Data\Levels\LevelData\slz1.bin"
		even
Level_SLZbg:	incbin	"Data\Levels\LevelData\slzbg.bin"
		even
Level_SLZ2:	incbin	"Data\Levels\LevelData\slz2.bin"
		even
Level_SLZ3:	incbin	"Data\Levels\LevelData\slz3.bin"
		even
byte_69B84:	dc.b 0,	0, 0, 0

Level_SYZ1:	incbin	"Data\Levels\LevelData\syz1.bin"
		even
Level_SYZbg:	if Revision=0
		incbin	"Data\Levels\LevelData\syzbg.bin"
		else
		incbin	"Data\Levels\LevelData\syzbg (JP1).bin"
		endc
		even
byte_69C7E:	dc.b 0,	0, 0, 0
Level_SYZ2:	incbin	"Data\Levels\LevelData\syz2.bin"
		even
byte_69D86:	dc.b 0,	0, 0, 0
Level_SYZ3:	incbin	"Data\Levels\LevelData\syz3.bin"
		even
byte_69EE4:	dc.b 0,	0, 0, 0
byte_69EE8:	dc.b 0,	0, 0, 0

Level_SBZ1:	incbin	"Data\Levels\LevelData\sbz1.bin"
		even
Level_SBZ1bg:	incbin	"Data\Levels\LevelData\sbz1bg.bin"
		even
Level_SBZ2:	incbin	"Data\Levels\LevelData\sbz2.bin"
		even
Level_SBZ2bg:	incbin	"Data\Levels\LevelData\sbz2bg.bin"
		even
byte_6A2F8:	dc.b 0,	0, 0, 0
byte_6A2FC:	dc.b 0,	0, 0, 0
Level_End:	incbin	"Data\Levels\LevelData\ending.bin"
		even
byte_6A320:	dc.b 0,	0, 0, 0

Level_Zone7:	incbin	"Data\Levels\LevelData\zone7.bin"
		even
Level_Zone7bg:	incbin	"Data\Levels\LevelData\zone7bg.bin"
		even
		
Art_BigRing:	incbin	"Data\Art\Uncompressed\Giant Ring.bin"
		even

; ---------------------------------------------------------------------------
; Sprite locations index
; ---------------------------------------------------------------------------
ObjPos_Index:
		; GHZ
		dc.w ObjPos_GHZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; LZ
		dc.w ObjPos_LZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_LZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_LZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SBZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; MZ
		dc.w ObjPos_MZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_MZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_MZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_MZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; SLZ
		dc.w ObjPos_SLZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SLZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SLZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SLZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; SYZ
		dc.w ObjPos_SYZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SYZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SYZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SYZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; SBZ
		dc.w ObjPos_SBZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SBZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_FZ-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_SBZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		; Ending
		dc.w ObjPos_End-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_End-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_End-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_End-ObjPos_Index, ObjPos_Null-ObjPos_Index
		zonewarning ObjPos_Index,$10		
		; --- Put extra object data here. ---
		dc.w ObjPos_Zone7-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_Zone7-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_Zone7-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_Zone7-ObjPos_Index, ObjPos_Null-ObjPos_Index	
		
ObjPosLZPlatform_Index:
		dc.w ObjPos_LZ1pf1-ObjPos_Index, ObjPos_LZ1pf2-ObjPos_Index
		dc.w ObjPos_LZ2pf1-ObjPos_Index, ObjPos_LZ2pf2-ObjPos_Index
		dc.w ObjPos_LZ3pf1-ObjPos_Index, ObjPos_LZ3pf2-ObjPos_Index
		dc.w ObjPos_LZ1pf1-ObjPos_Index, ObjPos_LZ1pf2-ObjPos_Index
ObjPosSBZPlatform_Index:
		dc.w ObjPos_SBZ1pf1-ObjPos_Index, ObjPos_SBZ1pf2-ObjPos_Index
		dc.w ObjPos_SBZ1pf3-ObjPos_Index, ObjPos_SBZ1pf4-ObjPos_Index
		dc.w ObjPos_SBZ1pf5-ObjPos_Index, ObjPos_SBZ1pf6-ObjPos_Index
		dc.w ObjPos_SBZ1pf1-ObjPos_Index, ObjPos_SBZ1pf2-ObjPos_Index
		dc.b $FF, $FF, 0, 0, 0,	0
ObjPos_GHZ1:	incbin	"Data\Levels\Objects\ghz1.bin"
		even
ObjPos_GHZ2:	incbin	"Data\Levels\Objects\ghz2.bin"
		even
ObjPos_GHZ3:	if Revision=0
		incbin	"Data\Levels\Objects\ghz3.bin"
		else
		incbin	"Data\Levels\Objects\ghz3 (JP1).bin"
		endc
		even
ObjPos_LZ1:	if Revision=0
		incbin	"Data\Levels\Objects\lz1.bin"
		else
		incbin	"Data\Levels\Objects\lz1 (JP1).bin"
		endc
		even
ObjPos_LZ2:	incbin	"Data\Levels\Objects\lz2.bin"
		even
ObjPos_LZ3:	if Revision=0
		incbin	"Data\Levels\Objects\lz3.bin"
		else
		incbin	"Data\Levels\Objects\lz3 (JP1).bin"
		endc
		even
ObjPos_SBZ3:	incbin	"Data\Levels\Objects\sbz3.bin"
		even
ObjPos_LZ1pf1:	incbin	"Data\Levels\Objects\lz1pf1.bin"
		even
ObjPos_LZ1pf2:	incbin	"Data\Levels\Objects\lz1pf2.bin"
		even
ObjPos_LZ2pf1:	incbin	"Data\Levels\Objects\lz2pf1.bin"
		even
ObjPos_LZ2pf2:	incbin	"Data\Levels\Objects\lz2pf2.bin"
		even
ObjPos_LZ3pf1:	incbin	"Data\Levels\Objects\lz3pf1.bin"
		even
ObjPos_LZ3pf2:	incbin	"Data\Levels\Objects\lz3pf2.bin"
		even
ObjPos_MZ1:	if Revision=0
		incbin	"Data\Levels\Objects\mz1.bin"
		else
		incbin	"Data\Levels\Objects\mz1 (JP1).bin"
		endc
		even
ObjPos_MZ2:	incbin	"Data\Levels\Objects\mz2.bin"
		even
ObjPos_MZ3:	incbin	"Data\Levels\Objects\mz3.bin"
		even
ObjPos_SLZ1:	incbin	"Data\Levels\Objects\slz1.bin"
		even
ObjPos_SLZ2:	incbin	"Data\Levels\Objects\slz2.bin"
		even
ObjPos_SLZ3:	incbin	"Data\Levels\Objects\slz3.bin"
		even
ObjPos_SYZ1:	incbin	"Data\Levels\Objects\syz1.bin"
		even
ObjPos_SYZ2:	incbin	"Data\Levels\Objects\syz2.bin"
		even
ObjPos_SYZ3:	if Revision=0
		incbin	"Data\Levels\Objects\syz3.bin"
		else
		incbin	"Data\Levels\Objects\syz3 (JP1).bin"
		endc
		even
ObjPos_SBZ1:	if Revision=0
		incbin	"Data\Levels\Objects\sbz1.bin"
		else
		incbin	"Data\Levels\Objects\sbz1 (JP1).bin"
		endc
		even
ObjPos_SBZ2:	incbin	"Data\Levels\Objects\sbz2.bin"
		even
ObjPos_FZ:	incbin	"Data\Levels\Objects\fz.bin"
		even
ObjPos_SBZ1pf1:	incbin	"Data\Levels\Objects\sbz1pf1.bin"
		even
ObjPos_SBZ1pf2:	incbin	"Data\Levels\Objects\sbz1pf2.bin"
		even
ObjPos_SBZ1pf3:	incbin	"Data\Levels\Objects\sbz1pf3.bin"
		even
ObjPos_SBZ1pf4:	incbin	"Data\Levels\Objects\sbz1pf4.bin"
		even
ObjPos_SBZ1pf5:	incbin	"Data\Levels\Objects\sbz1pf5.bin"
		even
ObjPos_SBZ1pf6:	incbin	"Data\Levels\Objects\sbz1pf6.bin"
		even
ObjPos_End:	incbin	"Data\Levels\Objects\ending.bin"
		even
ObjPos_Zone7:	incbin	"Data\Levels\Objects\zone7.bin"
		even		
ObjPos_Null:	dc.b $FF, $FF, 0, 0, 0,	0

; ===========================================================================
; ---------------------------------------------------------------------------
; VEPS Sound Driver
; ---------------------------------------------------------------------------
		include	"Engine\Audio\VEPS\VEPS.asm"
		include	"Engine\Audio\MegaPCM\Main.asm"
		include	"Engine\Audio\Utils.asm"

TitleBGArt: 	incbin "Data/Art/Nemesis/Title Screen Background.bin"
TitleBGMap: 	incbin "Data/Mappings/TileMaps/Title Screen Background.bin"
TitleFGArt: 	incbin "Data/Art/Nemesis/Title Screen Foreground.bin"
TitleFGMap: 	incbin "Data/Mappings/TileMaps/Title Screen.bin"

; ---------------------------------------------------------------------------
; Error Handler
; ---------------------------------------------------------------------------
		include	"ErrorHandler/Extras.asm"
		include	"ErrorHandler/ErrorHandler.asm"
EndOfRom:	END
