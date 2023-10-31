
; ===============================================================
; ---------------------------------------------------------------
; Error handling and debugging modules
;
; (c) 2016-2023, Vladikcomper
; ---------------------------------------------------------------
; Error handler functions and calls
; ---------------------------------------------------------------

; ---------------------------------------------------------------
; Error handler control flags
; ---------------------------------------------------------------

; Screen appearence flags
_eh_address_error	equ	$01		; use for address and bus errors only (tells error handler to display additional "Address" field)
_eh_show_sr_usp		equ	$02		; displays SR and USP registers content on error screen

; Advanced execution flags
; WARNING! For experts only, DO NOT USES them unless you know what you're doing
_eh_return			equ	$20
_eh_enter_console	equ	$40
_eh_align_offset	equ	$80

; ---------------------------------------------------------------
; Errors vector table
; ---------------------------------------------------------------

; Default screen configuration
_eh_default			equ	0 ;_eh_show_sr_usp

; ---------------------------------------------------------------

BusError:
	__ErrorMessage "BUS ERROR", _eh_default|_eh_address_error

AddressError:
	__ErrorMessage "ADDRESS ERROR", _eh_default|_eh_address_error

IllegalInstr:
	__ErrorMessage "ILLEGAL INSTRUCTION", _eh_default

ZeroDivide:
	__ErrorMessage "ZERO DIVIDE", _eh_default

ChkInstr:
	__ErrorMessage "CHK INSTRUCTION", _eh_default

TrapvInstr:
	__ErrorMessage "TRAPV INSTRUCTION", _eh_default

PrivilegeViol:
	__ErrorMessage "PRIVILEGE VIOLATION", _eh_default

Trace:
	__ErrorMessage "TRACE", _eh_default

Line1010Emu:
	__ErrorMessage "LINE 1010 EMULATOR", _eh_default

Line1111Emu:
	__ErrorMessage "LINE 1111 EMULATOR", _eh_default

ErrorExcept:
	__ErrorMessage "ERROR EXCEPTION", _eh_default

ErrorTrap:
	__ErrorMessage "ERROR TRAP", _eh_default


; ---------------------------------------------------------------
; Import error handler global functions
; ---------------------------------------------------------------

; Debugger extension functions
__global__ErrorHandler_ConsoleOnly: equ DebuggerExtensions+$0
__global__ErrorHandler_ClearConsole: equ DebuggerExtensions+$26
__global__KDebug_WriteLine_Formatted: equ DebuggerExtensions+$50
__global__KDebug_Write_Formatted: equ DebuggerExtensions+$54
__global__KDebug_FlushLine: equ DebuggerExtensions+$AA
__global__ErrorHandler_PauseConsole: equ DebuggerExtensions+$C2
__global__ErrorHandler_PagesController: equ DebuggerExtensions+$F8
__global__VSync: equ DebuggerExtensions+$158

; Error handler & core functions
__global__ErrorHandler: equ ErrorHandler+$0
__global__Error_IdleLoop: equ ErrorHandler+$122
__global__Error_InitConsole: equ ErrorHandler+$13C
__global__Error_MaskStackBoundaries: equ ErrorHandler+$148
__global__Error_DrawOffsetLocation: equ ErrorHandler+$1B2
__global__Error_DrawOffsetLocation2: equ ErrorHandler+$1B6
__global__ErrorHandler_SetupVDP: equ ErrorHandler+$23C
__global__ErrorHandler_VDPConfig: equ ErrorHandler+$274
__global__ErrorHandler_VDPConfig_Nametables: equ ErrorHandler+$28A
__global__ErrorHandler_ConsoleConfig_Initial: equ ErrorHandler+$2C6
__global__ErrorHandler_ConsoleConfig_Shared: equ ErrorHandler+$2CA
__global__Art1bpp_Font: equ ErrorHandler+$334
__global__FormatString: equ ErrorHandler+$8FC
__global__Console_Init: equ ErrorHandler+$9D2
__global__Console_Reset: equ ErrorHandler+$A14
__global__Console_InitShared: equ ErrorHandler+$A16
__global__Console_SetPosAsXY_Stack: equ ErrorHandler+$A52
__global__Console_SetPosAsXY: equ ErrorHandler+$A58
__global__Console_GetPosAsXY: equ ErrorHandler+$A86
__global__Console_StartNewLine: equ ErrorHandler+$AA8
__global__Console_SetBasePattern: equ ErrorHandler+$AD0
__global__Console_SetWidth: equ ErrorHandler+$AE4
__global__Console_WriteLine_WithPattern: equ ErrorHandler+$AFA
__global__Console_WriteLine: equ ErrorHandler+$AFC
__global__Console_Write: equ ErrorHandler+$B00
__global__Console_WriteLine_Formatted: equ ErrorHandler+$BAC
__global__Console_Write_Formatted: equ ErrorHandler+$BB0
__global__Decomp1bpp: equ ErrorHandler+$BE0

; Aliases for linker
KDebug_WriteLine_Formatted:	equ	__global__KDebug_WriteLine_Formatted
KDebug_Write_Formatted:		equ	__global__KDebug_Write_Formatted
KDebug_FlushLine:		equ	__global__KDebug_FlushLine



; ---------------------------------------------------------------
; Built-in debuggers
; ---------------------------------------------------------------

Debugger_AddressRegisters:

	dc.l	$48E700FE, $41FA002A
	jsr		__global__Console_Write(pc)
	dc.l	$49D77C06, $3F3C2000, $2F3CE861, $303A41D7
	dc.w	$221C
	jsr		__global__Error_DrawOffsetLocation(pc)
	dc.l	$522F0002, $51CEFFF2, $4FEF0022, $4E75E0FA, $01F026EA, $41646472, $65737320, $52656769
	dc.l	$73746572, $733AE0E0
	dc.w	$0000

Debugger_Backtrace:

	dc.l	$41FA0088
	jsr		__global__Console_Write(pc)
	dc.l	$22780000, $598945D7
	jsr		__global__Error_MaskStackBoundaries(pc)
	dc.l	$B3CA6570, $0C520040, $64642012, $67602040, $02400001, $66581220, $10200C00, $00616604
	dc.l	$4A01663A, $0C00004E, $660A0201, $00F80C01, $0090672A, $30200C40, $61006722, $12004200
	dc.l	$0C404E00, $66120C01, $00A8650C, $0C0100BB, $62060C01, $00B96606, $0C604EB9, $66102F0A
	dc.l	$2F092208
	jsr		__global__Error_DrawOffsetLocation2(pc)
	dc.l	$225F245F, $548A548A, $B3CA6490, $4E75E0FA, $01F026EA, $4261636B, $74726163, $653AE0E0
	dc.w	$0000

; ---------------------------------------------------------------
; Debugger extensions
; ---------------------------------------------------------------

DebuggerExtensions:

	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $47EF003C
	jsr		__global__ErrorHandler_SetupVDP(pc)
	jsr		__global__Error_InitConsole(pc)
	dc.l	$4CDF7FFF
	pea		__global__Error_IdleLoop(pc)
	dc.l	$2F2F0012, $4E752F0B, $4E6B0C2B, $005D000C, $661A48E7, $C4464BF9, $00C00004, $4DEDFFFC
	lea		__global__ErrorHandler_ConsoleConfig_Initial(pc), a1
	jsr		__global__Console_Reset(pc)
	dc.l	$4CDF6223, $265F4E75, $487A0058, $4E680C28, $005D000C, $67182F0C, $49FA0016, $4FEFFFF0
	dc.l	$41D77E0E
	jsr		__global__FormatString(pc)
	dc.l	$4FEF0010, $285F4E75, $42184447, $0647000F, $90C72F08, $2F0D4BF9, $00C00004, $3E3C9E00
	dc.l	$60023A87, $1E186EFA, $67080407, $00E067F2, $60F22A5F, $205F7E0E, $4E752F08, $4E680C28
	dc.l	$005D000C, $670833FC, $9E0000C0, $0004205F, $4E7548E7, $C0D04E6B, $0C2B005D, $000C660C
	dc.l	$3F3C0000, $610C610A, $67FC544F, $4CDF0B03, $4E756174, $41EF0004, $43F900A1, $00036178
	dc.l	$70F0C02F, $00054E75, $48E7FFFE, $3F3C0000, $61E04BF9, $00C00004, $4DEDFFFC, $61D467F2
	dc.l	$6B4041FA, $00765888, $D00064FA, $20106F32, $20404FEF
	dc.w	$FFF2
	lea		__global__ErrorHandler_ConsoleConfig_Shared(pc), a1
	dc.l	$47D72A3C, $40000003
	jsr		__global__Console_InitShared(pc)
	dc.l	$2ABC8230, $84062A85, $487A000C, $48504CEF, $7FFF0014, $4E754FEF, $000E60B0
	move.l	__global__ErrorHandler_VDPConfig_Nametables(pc), (a5)
	dc.l	$60AA41F9, $00C00004, $44D06BFC, $44D06AFC, $4E7512BC, $00004E71, $72C01011, $E50812BC
	dc.l	$00404E71, $C0011211, $0201003F, $80014600, $1210B101, $10C0C200, $10C14E75

; WARNING! Don't move! This must be placed directly below "DebuggerExtensions"
DebuggerExtensions_ExtraDebuggerList:
	dc.l	DEBUGGER__EXTENSIONS__BTN_A_DEBUGGER	; for button A
	dc.l	DEBUGGER__EXTENSIONS__BTN_C_DEBUGGER	; for button C (not B)
	dc.l	DEBUGGER__EXTENSIONS__BTN_B_DEBUGGER	; for button B (not C)

; ---------------------------------------------------------------
; Error handler blob
; ---------------------------------------------------------------

ErrorHandler:

	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $4EBA022E, $49EF004A, $4E682F08, $47EF0040, $4EBA011E
	dc.l	$41FA02B2, $4EBA0ADA, $225C45D4, $4EBA0B7E, $4EBA0A76, $49D21C19, $6A025249, $47D10806
	dc.l	$0000670E, $41FA0295, $222C0002, $4EBA0164, $504C41FA, $0292222C, $00024EBA, $01562278
	dc.l	$000045EC, $00064EBA, $01AE41FA, $02844EBA, $01424EBA, $0A340806, $00066600, $00AA45EF
	dc.l	$00044EBA, $0A023F01, $70034EBA, $09CC303C, $64307A07, $4EBA0132, $321F7011, $4EBA09BA
	dc.l	$303C6130, $7A064EBA, $0120303C, $73707A00, $2F0C45D7, $4EBA0112, $584F0806, $00016714
	dc.l	$43FA0240, $45D74EBA, $0AE843FA, $024145D4, $4EBA0ADA, $584F4EBA, $09AE5241, $70014EBA
	dc.l	$09782038, $007841FA, $022F4EBA, $010A2038, $007041FA, $022B4EBA, $00FE4EBA, $09AC2278
	dc.l	$000045D4, $53896140, $4EBA097C, $7A199A41, $6B0A6148, $4EBA005A, $51CDFFFA, $08060005
	dc.l	$660A4E71, $60FC7200, $4EBA09A6, $2ECB4CDF, $7FFF487A, $FFEE2F2F, $FFC44E75, $43FA0152
	dc.l	$45FA01F2, $4EFA088C, $223C00FF, $FFFF2409, $C4812242, $240AC481, $24424E75, $4FEFFFD0
	dc.l	$41D77EFF, $20FC2853, $502930FC, $3A206018, $4FEFFFD0, $41D77EFF, $30FC202B, $320A924C
	dc.l	$4EBA05A8, $30FC3A20, $700572EC, $B5C96502, $72EE10C1, $321A4EBA, $05B010FC, $002051C8
	dc.l	$FFEA4218, $41D77200, $4EBA0950, $4FEF0030, $4E754EBA, $094C2F01, $2F0145D7, $43FA013C
	dc.l	$4EBA09EA, $504F4E75, $4FEFFFF0, $7EFF41D7, $30C030FC, $3A2010FC, $00EC221A, $4EBA0562
	dc.l	$421841D7, $72004EBA, $09125240, $51CDFFE0, $4FEF0010, $4E752200, $48414601, $66F62440
	dc.l	$0C5A4EF9, $66042212, $60A84EBA, $08F441FA, $01174EFA, $08E85989, $4EBAFF2E, $B3CA650C
	dc.l	$0C520040, $650A548A, $B3CA64F4, $72004E75, $221267F2, $08010000, $66EC4E75, $4BF900C0
	dc.l	$00044DED, $FFFC4A55, $44D569FC, $41FA0026, $30186A04, $3A8060F8, $70002ABC, $40000000
	dc.l	$2C802ABC, $40000010, $2C802ABC, $C0000000, $3C804E75, $80048134, $85008700, $8B008C81
	dc.l	$8D008F02, $90119100, $92008220, $84040000, $44000000, $00000001, $00100011, $01000101
	dc.l	$01100111, $10001001, $10101011, $11001101, $11101111, $FFFF0EEE, $FFF200CE, $FFF20EEA
	dc.l	$FFF20E86, $FFF24000, $00020028, $00280000, $008000FF, $EAE0FA01, $F02600EA, $41646472
	dc.l	$6573733A, $2000EA4F, $66667365, $743A2000, $EA43616C, $6C65723A, $2000EC83, $20E8BFEC
	dc.l	$C800FA10, $E8757370, $3A20EC83, $00FA03E8, $73723A20, $EC8100EA, $56496E74, $3A2000EA
	dc.l	$48496E74, $3A2000E8, $3C756E64, $6566696E, $65643E00, $02F70000, $00000000, $0000183C
	dc.l	$3C181800, $18006C6C, $6C000000, $00006C6C, $FE6CFE6C, $6C00187E, $C07C06FC, $180000C6
	dc.l	$0C183060, $C600386C, $3876CCCC, $76001818, $30000000, $00001830, $60606030, $18006030
	dc.l	$18181830, $600000EE, $7CFE7CEE, $00000018, $187E1818, $00000000, $00001818, $30000000
	dc.l	$00FE0000, $00000000, $00000038, $3800060C, $183060C0, $80007CC6, $CEDEF6E6, $7C001878
	dc.l	$18181818, $7E007CC6, $0C183066, $FE007CC6, $063C06C6, $7C000C1C, $3C6CFE0C, $0C00FEC0
	dc.l	$FC0606C6, $7C007CC6, $C0FCC6C6, $7C00FEC6, $060C1818, $18007CC6, $C67CC6C6, $7C007CC6
	dc.l	$C67E06C6, $7C00001C, $1C00001C, $1C000018, $18000018, $18300C18, $30603018, $0C000000
	dc.l	$FE0000FE, $00006030, $180C1830, $60007CC6, $060C1800, $18007CC6, $C6DEDCC0, $7E00386C
	dc.l	$C6C6FEC6, $C600FC66, $667C6666, $FC003C66, $C0C0C066, $3C00F86C, $6666666C, $F800FEC2
	dc.l	$C0F8C0C2, $FE00FE62, $607C6060, $F0007CC6, $C0C0DEC6, $7C00C6C6, $C6FEC6C6, $C6003C18
	dc.l	$18181818, $3C003C18, $1818D8D8, $7000C6CC, $D8F0D8CC, $C600F060, $60606062, $FE00C6EE
	dc.l	$FED6D6C6, $C600C6E6, $E6F6DECE, $C6007CC6, $C6C6C6C6, $7C00FC66, $667C6060, $F0007CC6
	dc.l	$C6C6C6D6, $7C06FCC6, $C6FCD8CC, $C6007CC6, $C07C06C6, $7C007E5A, $18181818, $3C00C6C6
	dc.l	$C6C6C6C6, $7C00C6C6, $C6C66C38, $1000C6C6, $D6D6FEEE, $C600C66C, $3838386C, $C6006666
	dc.l	$663C1818, $3C00FE86, $0C183062, $FE007C60, $60606060, $7C00C060, $30180C06, $02007C0C
	dc.l	$0C0C0C0C, $7C001038, $6CC60000, $00000000, $00000000, $00FF3030, $18000000, $00000000
	dc.l	$780C7CCC, $7E00E060, $7C666666, $FC000000, $7CC6C0C6, $7C001C0C, $7CCCCCCC, $7E000000
	dc.l	$7CC6FEC0, $7C001C36, $30FC3030, $78000000, $76CEC67E, $067CE060, $7C666666, $E6001800
	dc.l	$38181818, $3C000C00, $1C0C0C0C, $CC78E060, $666C786C, $E6001818, $18181818, $1C000000
	dc.l	$6CFED6D6, $C6000000, $DC666666, $66000000, $7CC6C6C6, $7C000000, $DC66667C, $60F00000
	dc.l	$76CCCC7C, $0C1E0000, $DC666060, $F0000000, $7CC07C06, $7C003030, $FC303036, $1C000000
	dc.l	$CCCCCCCC, $76000000, $C6C66C38, $10000000, $C6C6D6FE, $6C000000, $C66C386C, $C6000000
	dc.l	$C6C6CE76, $067C0000, $FC983064, $FC000E18, $18701818, $0E001818, $18001818, $18007018
	dc.l	$180E1818, $700076DC, $00000000, $00002279, SymbolData_Ptr, $0C59DEB2, $667270FE, $D05974FC
	dc.l	$76004841, $024100FF, $D241D241, $B240625C, $675E2031, $10006758, $47F10800, $48417000
	dc.l	$301BB253, $654C43F3, $08FE45E9, $FFFCE248, $C042B273, $00006514, $6204D6C0, $601A47F3
	dc.l	$0004200A, $908B6AE6, $594B600C, $45F300FC, $200A908B, $6AD847D2, $925B7400, $341BD3C2
	dc.l	$48414241, $4841D283, $70004E75, $70FF4E75, $48417000, $3001D680, $5283323C, $FFFF4841
	dc.l	$59416A8E, $70FF4E75
	dc.w	$2679
	dc.l	SymbolData_Ptr, $0C5BDEB2, $664AD6D3, $78007200, $740045D3, $51CC0006, $16197807, $D603D341
	dc.l	$5242B252, $620A65EC, $B42A0002, $671265E4, $584AB252, $62FA65DC, $B42A0002, $65D666F0
	dc.l	$10EA0003, $670A51CF, $FFC64E94, $64C04E75, $53484E75, $70004E75, $4EFA0024, $4EFA0018
	dc.l	$760F3401, $E84AC443, $10FB205E, $51CF004C, $4E946446, $4E754841, $6104654A, $48417404
	dc.l	$760FE579, $1801C843, $10FB403E, $51CF0004, $4E946532, $E5791801, $C84310FB, $402C51CF
	dc.l	$00044E94, $6520E579, $1801C843, $10FB401A, $51CF0004, $4E94650E, $E579C243, $10FB100A
	dc.l	$51CF0004, $4ED44E75, $30313233, $34353637, $38394142, $43444546, $4EFA0026, $4EFA001A
	dc.l	$74077018, $D201D100, $10C051CF, $00064E94, $650451CA, $FFEE4E75, $48416104, $65184841
	dc.l	$740F7018, $D241D100, $10C051CF, $00064E94, $650451CA, $FFEE4E75, $4EFA0010, $4EFA0048
	dc.l	$47FA009A, $024100FF, $600447FA, $008C4200, $7609381B, $34039244, $55CAFFFC, $D2449443
	dc.l	$44428002, $670E0602, $003010C2, $51CF0006, $4E946510, $381B6ADC, $06010030, $10C151CF
	dc.l	$00044ED4, $4E7547FA, $002E4200, $7609281B, $34039284, $55CAFFFC, $D2849443, $44428002
	dc.l	$670E0602, $003010C2, $51CF0006, $4E9465D4, $281B6ADC, $609E3B9A, $CA0005F5, $E1000098
	dc.l	$9680000F, $42400001, $86A00000, $2710FFFF, $03E80064, $000AFFFF, $271003E8, $0064000A
	dc.l	$FFFF48C1, $60084EFA, $00064881, $48C148E7, $50604EBA, $FD906618, $2E814EBA, $FE224CDF
	dc.l	$060A650A, $08030003, $66044EFA, $00B64E75, $4CDF060A, $08030002, $670847FA, $000A4EFA
	dc.l	$00B470FF, $60DE3C75, $6E6B6E6F, $776E3E00, $10FC002B, $51CF0006, $4E9465D2, $48414A41
	dc.l	$6700FE5A, $6000FE52, $08030003, $66C04EFA, $FE4648E7, $F81010D9, $5FCFFFFC, $6E146718
	dc.l	$16207470, $C4034EBB, $201A64EA, $4CDF081F, $4E754E94, $64E060F4, $53484E94, $4CDF081F
	dc.l	$4E7547FA, $FDF4B702, $D4024EFB, $205A4E71, $4E7147FA, $FEA4B702, $D4024EFB, $204A4E71
	dc.l	$4E7147FA, $FE54B702, $D4024EFB, $203A5348, $4E7547FA, $FF2E1403, $02420003, $D4424EFB
	dc.l	$20264A40, $6B084A81, $67164EFA, $FF644EFA, $FF78265A, $10DB57CF, $FFFC67D2, $4E9464F4
	dc.l	$4E755248, $603C504B, $321A4ED3, $584B221A, $4ED35248, $6022504B, $321A6004, $584B221A
	dc.l	$6A084481, $10FC002D, $600410FC, $002B51CF, $00064E94, $65CA4ED3, $51CF0006, $4E9465C0
	dc.l	$10D951CF, $FFBC4ED4, $4BF900C0, $00044DED, $FFFC4A51, $6B102A99, $41D23818, $4EBA01F8
	dc.l	$43E90020, $60EC5449, $41FA0048, $2ABCC000, $00007000, $76033C80, $34193C82, $34196AFA
	dc.l	$72004EB0, $201051CB, $FFEE2A19, $4E6326C5, $26D926D9, $36FC5D00, $2A857000, $32196112
	dc.l	$2ABC4000, $00007200, $61083ABC, $81742A85, $4E752C80, $2C802C80, $2C802C80, $2C802C80
	dc.l	$2C8051C9, $FFEE4E75, $4CAF0003, $000448E7, $60104E6B, $0C2B005D, $000C661A, $34130242
	dc.l	$E000C2EB, $000AD441, $D440D440, $368223DB, $00C00004, $36DB4CDF, $08064E75, $2F0B4E6B
	dc.l	$0C2B005D, $000C6612, $72003213, $02411FFF, $82EB000A, $20014840, $E248265F, $4E752F0B
	dc.l	$4E6B0C2B, $005D000C, $66183F00, $3013D06B, $000A0240, $5FFF3680, $23DB00C0, $000436DB
	dc.l	$301F265F, $4E752F0B, $4E6B0C2B, $005D000C, $66043741, $0008265F, $4E752F0B, $4E6B0C2B
	dc.l	$005D000C, $6606584B, $36C136C1, $265F4E75, $61D4487A, $FFAA48E7, $7E124E6B, $0C2B005D
	dc.l	$000C661C, $2A1B4C93, $005C4846, $4DF900C0, $00007200, $12186E0E, $6B284893, $001C2705
	dc.l	$4CDF487E, $4E7551CB, $000ED642, $DA860885, $001D2D45, $0004D244, $3C817200, $12186EE6
	dc.l	$67D80241, $001E4EFB, $1002DA86, $721D0385, $60206026, $602A6032, $603A1418, $60141818
	dc.l	$60D86036, $1218D241, $76804843, $CA834841, $8A813602, $2D450004, $60C00244, $07FF60BA
	dc.l	$024407FF, $00442000, $60B00244, $07FF0044, $400060A6, $00446000, $60A03F04, $1E98381F
	dc.l	$6098487A, $FEFA2F0C, $49FA0016, $4FEFFFF0, $41D77E0E, $4EBAFD3C, $4FEF0010, $285F4E75
	dc.l	$42184447, $0647000F, $90C72F08, $4EBAFF28, $205F7E0E, $4E75741E, $10181200, $E609C242
	dc.l	$3CB11000, $D000C042, $3CB10000, $51CCFFEA
	dc.w	$4E75

; ---------------------------------------------------------------
; WARNING!
;	DO NOT put any data from now on! DO NOT use ROM padding!
;	Symbol data should be appended here after ROM is compiled
;	by ConvSym utility, otherwise debugger modules won't be able
;	to resolve symbol names.
; ---------------------------------------------------------------
