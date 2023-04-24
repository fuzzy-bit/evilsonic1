
; ===============================================================
; ---------------------------------------------------------------
; Error handling and debugging modules
; 2016-2017, Vladikcomper
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

ErrorHandler.__global__Error_InitConsole: equ ErrorHandler+$150
ErrorHandler.__global__ErrorHandler_SetupVDP: equ ErrorHandler+$256
ErrorHandler.__global__Art1bpp_Font: equ ErrorHandler+$354
ErrorHandler.__global__FormatString: equ ErrorHandler+$918
ErrorHandler.__global__Console_LoadPalette: equ ErrorHandler+$A32
ErrorHandler.__global__Console_SetPosAsXY_Stack: equ ErrorHandler+$A6E
ErrorHandler.__global__Console_SetPosAsXY: equ ErrorHandler+$A74
ErrorHandler.__global__Console_GetPosAsXY: equ ErrorHandler+$AA2
ErrorHandler.__global__Console_StartNewLine: equ ErrorHandler+$AC4
ErrorHandler.__global__Console_SetBasePattern: equ ErrorHandler+$AEC
ErrorHandler.__global__Console_SetWidth: equ ErrorHandler+$B00
ErrorHandler.__global__Console_WriteLine_WithPattern: equ ErrorHandler+$B16
ErrorHandler.__global__Console_WriteLine: equ ErrorHandler+$B18
ErrorHandler.__global__Console_Write: equ ErrorHandler+$B1C
ErrorHandler.__global__Console_WriteLine_Formatted: equ ErrorHandler+$BC8
ErrorHandler.__global__Console_Write_Formatted: equ ErrorHandler+$BCC
ErrorHandler.__global__Decomp1bpp: equ ErrorHandler+$BFC


; ---------------------------------------------------------------
; Error handler external functions (compiled only when used)
; ---------------------------------------------------------------


	if ref(ErrorHandler.__extern__ScrollConsole)
ErrorHandler.__extern__ScrollConsole:

	endc

	if ref(ErrorHandler.__extern__Console_Only)
ErrorHandler.__extern__Console_Only:
	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $47EF003C
	jsr		ErrorHandler.__global__ErrorHandler_SetupVDP(pc)
	jsr		ErrorHandler.__global__Error_InitConsole(pc)
	dc.l	$4CDF7FFF, $487A0008, $2F2F0012, $4E7560FE
	endc

	if ref(ErrorHandler.__extern__VSync)
ErrorHandler.__extern__VSync:
	dc.l	$41F900C0, $000444D0, $6BFC44D0, $6AFC4E75
	endc

; ---------------------------------------------------------------
; Error handler blob
; ---------------------------------------------------------------

ErrorHandler:

	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $4EBA0248, $49EF004A, $4E682F08, $47EF0040, $4EBA0132
	dc.l	$41FA02CC, $4EBA0AF6, $225C45D4, $4EBA0B9A, $4EBA0A92, $49D21C19, $6A025249, $47D10806
	dc.l	$0000670E, $43FA02AF, $45EC0002, $4EBA0B7A, $504C43FA, $02B045EC, $00024EBA, $0B6C43FA
	dc.l	$02B245EC, $00024EBA, $0B602278, $000045EC, $00064EBA, $00E84EBA, $01BC43FA, $02A42F01
	dc.l	$45D74EBA, $0B444EBA, $0A3C584F, $08060006, $660000A8, $45EF0004, $4EBA0A08, $3F017003
	dc.l	$4EBA09D2, $303C6430, $7A074EBA, $011A321F, $70114EBA, $09C0303C, $61307A06, $4EBA0108
	dc.l	$303C7370, $7A002F0C, $45D74EBA, $00FA584F, $08060001, $671443FA, $025645D7, $4EBA0AEE
	dc.l	$43FA0257, $45D44EBA, $0AE0584F, $4EBA09B4, $52417001, $4EBA097E, $20380078, $41FA0245
	dc.l	$4EBA00F2, $20380070, $41FA0241, $4EBA00E6, $4EBA09B2, $22780000, $45D45389, $613E4EBA
	dc.l	$09827A19, $9A416B0A, $61464EBA, $005851CD, $FFFA0806, $00056608, $60FE7200, $4EBA09AE
	dc.l	$2ECB4CDF, $7FFF487A, $FFF02F2F, $FFC44E75, $43FA0158, $45FA01FE, $4EFA0894, $223C00FF
	dc.l	$FFFF2409, $C4812242, $240AC481, $24424E75, $4FEFFFD0, $41D77EFF, $20FC2853, $502930FC
	dc.l	$3A206018, $4FEFFFD0, $41D77EFF, $30FC202B, $320A924C, $4EBA05B0, $30FC3A20, $700572EC
	dc.l	$B5C96502, $72EE10C1, $321A4EBA, $05B810FC, $002051C8, $FFEA4218, $41D77200, $4EBA0958
	dc.l	$4FEF0030, $4E754FEF, $FFF07EFF, $41D730C0, $30FC3A20, $10FC00EC, $221A4EBA, $05804218
	dc.l	$41D77200, $4EBA0930, $524051CD, $FFE04FEF, $00104E75, $22004841, $46016620, $514F2E88
	dc.l	$244043FA, $00210C5A, $4EF96608, $43FA0010, $2F520004, $45D74EBA, $09B4504F, $4E75D0E8
	dc.l	$BFECC8E0, $00D0E83C, $756E6465, $66696E65, $643EE000, $5989B3CA, $650C0C52, $0040650A
	dc.l	$548AB3CA, $64F47200, $4E752212, $67F20801, $000066EC, $4E754BF9, $00C00004, $4DEDFFFC
	dc.l	$4A5544D5, $69FC41FA, $00263018, $6A043A80, $60F87000, $2ABC4000, $00002C80, $2ABC4000
	dc.l	$00102C80, $2ABCC000, $00003C80, $4E758004, $81348220, $84048500, $87008B00, $8C818D00
	dc.l	$8F029011, $91009200, $00004400, $00000000, $00010010, $00110100, $01010110, $01111000
	dc.l	$10011010, $10111100, $11011110, $1111FFFF, $40000002, $00280028, $00000080, $00FF0EEE
	dc.l	$FFF200CE, $FFF20EEA, $FFF20E86, $FFF2EAE0, $FA01F026, $00EA4164, $64726573, $733A20E8
	dc.l	$BBECC000, $EA4C6F63, $6174696F, $6E3A20EC, $8300EA4D, $6F64756C, $653A20E8, $BFECC800
	dc.l	$EA43616C, $6C65723A, $20E8BBEC, $C000FA10, $E8757370, $3A20EC83, $00FA03E8, $73723A20
	dc.l	$EC8100EA, $56496E74, $3A2000EA, $48496E74, $3A200000, $02F70000, $00000000, $0000183C
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
	dc.l	$180E1818, $700076DC, $00000000, $000043FA, $05C80C59, $DEB26672, $70FED059, $74FC7600
	dc.l	$48410241, $00FFD241, $D241B240, $625C675E, $20311000, $675847F1, $08004841, $7000301B
	dc.l	$B253654C, $43F308FE, $45E9FFFC, $E248C042, $B2730000, $65146204, $D6C0601A, $47F30004
	dc.l	$200A908B, $6AE6594B, $600C45F3, $00FC200A, $908B6AD8, $47D2925B, $7400341B, $D3C24841
	dc.l	$42414841, $D2837000, $4E7570FF, $4E754841, $70003001, $D6805283, $323CFFFF, $48415941
	dc.l	$6A8E70FF, $4E7547FA, $05300C5B, $DEB2664A, $D6D37800, $72007400, $45D351CC, $00061619
	dc.l	$7807D603, $D3415242, $B252620A, $65ECB42A, $00026712, $65E4584A, $B25262FA, $65DCB42A
	dc.l	$000265D6, $66F010EA, $0003670A, $51CFFFC6, $4E9464C0, $4E755348, $4E757000, $4E754EFA
	dc.l	$00244EFA, $0018760F, $3401E84A, $C44310FB, $205E51CF, $004C4E94, $64464E75, $48416104
	dc.l	$654A4841, $7404760F, $E5791801, $C84310FB, $403E51CF, $00044E94, $6532E579, $1801C843
	dc.l	$10FB402C, $51CF0004, $4E946520, $E5791801, $C84310FB, $401A51CF, $00044E94, $650EE579
	dc.l	$C24310FB, $100A51CF, $00044ED4, $4E753031, $32333435, $36373839, $41424344, $45464EFA
	dc.l	$00264EFA, $001A7407, $7018D201, $D10010C0, $51CF0006, $4E946504, $51CAFFEE, $4E754841
	dc.l	$61046518, $4841740F, $7018D241, $D10010C0, $51CF0006, $4E946504, $51CAFFEE, $4E754EFA
	dc.l	$00104EFA, $004847FA, $009A0241, $00FF6004, $47FA008C, $42007609, $381B3403, $924455CA
	dc.l	$FFFCD244, $94434442, $8002670E, $06020030, $10C251CF, $00064E94, $6510381B, $6ADC0601
	dc.l	$003010C1, $51CF0004, $4ED44E75, $47FA002E, $42007609, $281B3403, $928455CA, $FFFCD284
	dc.l	$94434442, $8002670E, $06020030, $10C251CF, $00064E94, $65D4281B, $6ADC609E, $3B9ACA00
	dc.l	$05F5E100, $00989680, $000F4240, $000186A0, $00002710, $FFFF03E8, $0064000A, $FFFF2710
	dc.l	$03E80064, $000AFFFF, $48C16008, $4EFA0006, $488148C1, $48E75060, $4EBAFD94, $66182E81
	dc.l	$4EBAFE24, $4CDF060A, $650A0803, $00036604, $4EFA00B6, $4E754CDF, $060A0803, $00026708
	dc.l	$47FA000A, $4EFA00B4, $70FF60DE, $3C756E6B, $6E6F776E, $3E0010FC, $002B51CF, $00064E94
	dc.l	$65D24841, $4A416700, $FE5A6000, $FE520803, $000366C0, $4EFAFE46, $48E7F810, $10D95FCF
	dc.l	$FFFC6E14, $67181620, $7470C403, $4EBB201A, $64EA4CDF, $081F4E75, $4E9464E0, $60F45348
	dc.l	$4E944CDF, $081F4E75, $47FAFDF4, $B702D402, $4EFB205A, $4E714E71, $47FAFEA4, $B702D402
	dc.l	$4EFB204A, $4E714E71, $47FAFE54, $B702D402, $4EFB203A, $53484E75, $47FAFF2E, $14030242
	dc.l	$0003D442, $4EFB2026, $4A406B08, $4A816716, $4EFAFF64, $4EFAFF78, $265A10DB, $57CFFFFC
	dc.l	$67D24E94, $64F44E75, $5248603C, $504B321A, $4ED3584B, $221A4ED3, $52486022, $504B321A
	dc.l	$6004584B, $221A6A08, $448110FC, $002D6004, $10FC002B, $51CF0006, $4E9465CA, $4ED351CF
	dc.l	$00064E94, $65C010D9, $51CFFFBC, $4ED44BF9, $00C00004, $4DEDFFFC, $4A516B10, $2A9941D2
	dc.l	$38184EBA, $01F843E9, $002060EC, $54494E63, $2A1926C5, $26D926D9, $36FC5D00, $47FA003A
	dc.l	$2A857000, $32194E93, $2ABC4000, $00007200, $4E932ABC, $C0000000, $70007603, $3C803419
	dc.l	$3C823419, $6AFA7200, $4EB32010, $51CBFFEE, $3ABC8174, $2A854E75, $2C802C80, $2C802C80
	dc.l	$2C802C80, $2C802C80, $51C9FFEE, $4E754CAF, $00030004, $48E76010, $4E6B0C2B, $005D000C
	dc.l	$661A3413, $0242E000, $C2EB000A, $D441D440, $D4403682, $23DB00C0, $000436DB, $4CDF0806
	dc.l	$4E752F0B, $4E6B0C2B, $005D000C, $66127200, $32130241, $1FFF82EB, $000A2001, $4840E248
	dc.l	$265F4E75, $2F0B4E6B, $0C2B005D, $000C6618, $3F003013, $D06B000A, $02405FFF, $368023DB
	dc.l	$00C00004, $36DB301F, $265F4E75, $2F0B4E6B, $0C2B005D, $000C6604, $37410008, $265F4E75
	dc.l	$2F0B4E6B, $0C2B005D, $000C6606, $584B36C1, $36C1265F, $4E7561D4, $487AFFAA, $48E77E12
	dc.l	$4E6B0C2B, $005D000C, $661C2A1B, $4C93005C, $48464DF9, $00C00000, $72001218, $6E0E6B28
	dc.l	$4893001C, $27054CDF, $487E4E75, $51CB000E, $D642DA86, $0885001D, $2D450004, $D2443C81
	dc.l	$72001218, $6EE667D8, $0241001E, $4EFB1002, $DA86721D, $03856020, $6026602A, $6032603A
	dc.l	$14186014, $181860D8, $60361218, $D2417680, $4843CA83, $48418A81, $36022D45, $000460C0
	dc.l	$024407FF, $60BA0244, $07FF0044, $200060B0, $024407FF, $00444000, $60A60044, $600060A0
	dc.l	$3F041E98, $381F6098, $487AFEFA, $2F0C49FA, $00164FEF, $FFF041D7, $7E0E4EBA, $FD3C4FEF
	dc.l	$0010285F, $4E754218, $44470647, $000F90C7, $2F084EBA, $FF28205F, $7E0E4E75, $741E1018
	dc.l	$1200E609, $C2423CB1, $1000D000, $C0423CB1, $000051CC, $FFEA4E75

; ---------------------------------------------------------------
; WARNING!
;	DO NOT put any data from now on! DO NOT use ROM padding!
;	Symbol data should be appended here after ROM is compiled
;	by ConvSym utility, otherwise debugger modules won't be able
;	to resolve symbol names.
; ---------------------------------------------------------------
