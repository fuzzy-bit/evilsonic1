; ---------------------------------------------------------------------------
; Palette pointers
; ---------------------------------------------------------------------------

PalettePointer:	macro paladdress,ramaddress,colours
	dc.l paladdress
	dc.w ramaddress, (colours>>1)-1
	endm

PalPointers:

; palette address, RAM address, colours

ptr_Pal_SegaBG:		PalettePointer	Pal_SegaBG,v_pal_dry,$40		; 0 - Sega logo
ptr_Pal_Title:		PalettePointer	Pal_Title,v_pal_dry,$40		; 1 - title screen
ptr_Pal_LevelSel:	PalettePointer	Pal_LevelSel,v_pal_dry,$40		; 2 - level select
ptr_Pal_Sonic:		PalettePointer	Pal_Sonic,v_pal_dry,$10		; 3 - Sonic
Pal_Levels:
ptr_Pal_GHZ:		PalettePointer	Pal_GHZ,v_pal_dry+$20, $30		; 4 - GHZ
ptr_Pal_LZ:		    PalettePointer	Pal_LZ,v_pal_dry+$20,$30		; 5 - LZ
ptr_Pal_MZ:		    PalettePointer	Pal_MZ,v_pal_dry+$20,$30		; 6 - MZ
ptr_Pal_SLZ:		PalettePointer	Pal_SLZ,v_pal_dry+$20,$30		; 7 - SLZ
ptr_Pal_SYZ:		PalettePointer	Pal_SYZ,v_pal_dry+$20,$30		; 8 - SYZ
ptr_Pal_SBZ1:		PalettePointer	Pal_SBZ1,v_pal_dry+$20,$30		; 9 - SBZ1
ptr_Pal_Zone7:		PalettePointer	Pal_Zone7,v_pal_dry+$20,$30		; 9 - Zone 7
			zonewarning Pal_Levels,8
ptr_Pal_Special:	PalettePointer	Pal_Special,v_pal_dry,$40		; $A (10) - special stage
ptr_Pal_LZWater:	PalettePointer	Pal_LZWater,v_pal_dry,$40		; $B (11) - LZ underwater
ptr_Pal_SBZ3:		PalettePointer	Pal_SBZ3,v_pal_dry+$20,$30		; $C (12) - SBZ3
ptr_Pal_SBZ3Water:	PalettePointer	Pal_SBZ3Water,v_pal_dry,$40		; $D (13) - SBZ3 underwater
ptr_Pal_SBZ2:		PalettePointer	Pal_SBZ2,v_pal_dry+$20,$30		; $E (14) - SBZ2
ptr_Pal_LZSonWater:	PalettePointer	Pal_LZSonWater,v_pal_dry,$10	; $F (15) - LZ Sonic underwater
ptr_Pal_SBZ3SonWat:	PalettePointer	Pal_SBZ3SonWat,v_pal_dry,$10	; $10 (16) - SBZ3 Sonic underwater
ptr_Pal_SSResult:	PalettePointer	Pal_SSResult,v_pal_dry,$40		; $11 (17) - special stage results
ptr_Pal_Continue:	PalettePointer	Pal_Continue,v_pal_dry,$20		; $12 (18) - special stage results continue
ptr_Pal_Ending:		PalettePointer	Pal_Ending,v_pal_dry,$40		; $13 (19) - ending sequence
			even


palid_SegaBG:		equ (ptr_Pal_SegaBG-PalPointers)/8
palid_Title:		equ (ptr_Pal_Title-PalPointers)/8
palid_LevelSel:		equ (ptr_Pal_LevelSel-PalPointers)/8
palid_Sonic:		equ (ptr_Pal_Sonic-PalPointers)/8
palid_GHZ:		equ (ptr_Pal_GHZ-PalPointers)/8
palid_LZ:		equ (ptr_Pal_LZ-PalPointers)/8
palid_MZ:		equ (ptr_Pal_MZ-PalPointers)/8
palid_SLZ:		equ (ptr_Pal_SLZ-PalPointers)/8
palid_SYZ:		equ (ptr_Pal_SYZ-PalPointers)/8
palid_SBZ1:		equ (ptr_Pal_SBZ1-PalPointers)/8
palid_Special:		equ (ptr_Pal_Special-PalPointers)/8
palid_LZWater:		equ (ptr_Pal_LZWater-PalPointers)/8
palid_SBZ3:		equ (ptr_Pal_SBZ3-PalPointers)/8
palid_SBZ3Water:	equ (ptr_Pal_SBZ3Water-PalPointers)/8
palid_SBZ2:		equ (ptr_Pal_SBZ2-PalPointers)/8
palid_LZSonWater:	equ (ptr_Pal_LZSonWater-PalPointers)/8
palid_SBZ3SonWat:	equ (ptr_Pal_SBZ3SonWat-PalPointers)/8
palid_SSResult:		equ (ptr_Pal_SSResult-PalPointers)/8
palid_Continue:		equ (ptr_Pal_Continue-PalPointers)/8
palid_Ending:		equ (ptr_Pal_Ending-PalPointers)/8
palid_Zone7:		equ (ptr_Pal_Zone7-PalPointers)/8
