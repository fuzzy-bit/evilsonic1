Vectors: 
		dc.l 0							; Initial stack pointer value (DONTFIX: avoids crash in BuildSprite due to NULL pointer dereference)
		dc.l EntryPoint 				; Start of program
		dc.l MDDBG__BusError			; Bus error
		dc.l MDDBG__AddressError		; Address error (4)
		dc.l MDDBG__IllegalInstr		; Illegal instruction
		dc.l MDDBG__ZeroDivide			; Division by zero
		dc.l MDDBG__ChkInstr			; CHK exception
		dc.l MDDBG__TrapvInstr			; TRAPV exception (8)
		dc.l MDDBG__PrivilegeViol		; Privilege violation
		dc.l MDDBG__Trace				; TRACE exception
		dc.l MDDBG__Line1010Emu			; Line-A emulator
		dc.l MDDBG__Line1111Emu			; Line-F emulator (12)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved) (16)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved) (20)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved)
		dc.l MDDBG__ErrorExcept			; Unused (reserved) (24)
		dc.l MDDBG__ErrorExcept			; Spurious exception
		dc.l ErrorTrap					; IRQ level 1
		dc.l ErrorTrap					; IRQ level 2
		dc.l ErrorTrap					; IRQ level 3 (28)
		dc.l HBlank						; IRQ level 4 (horizontal retrace interrupt)
		dc.l ErrorTrap					; IRQ level 5
		dc.l VBlank						; IRQ level 6 (vertical retrace interrupt)
		dc.l ErrorTrap					; IRQ level 7 (32)
		dc.l ErrorTrap					; TRAP #00 exception
		dc.l ErrorTrap					; TRAP #01 exception
		dc.l ErrorTrap					; TRAP #02 exception
		dc.l ErrorTrap					; TRAP #03 exception (36)
		dc.l ErrorTrap					; TRAP #04 exception
		dc.l ErrorTrap					; TRAP #05 exception
		dc.l ErrorTrap					; TRAP #06 exception
		dc.l ErrorTrap					; TRAP #07 exception (40)
		dc.l ErrorTrap					; TRAP #08 exception
		dc.l ErrorTrap					; TRAP #09 exception
		dc.l ErrorTrap					; TRAP #10 exception
		dc.l ErrorTrap					; TRAP #11 exception (44)
		dc.l ErrorTrap					; TRAP #12 exception
		dc.l ErrorTrap					; TRAP #13 exception
		dc.l ErrorTrap					; TRAP #14 exception
		dc.l ErrorTrap					; TRAP #15 exception (48)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)
		dc.l ErrorTrap					; Unused (reserved)

MEGADRIVE:		dc.b "SEGA MEGA DRIVE " ; Hardware system ID (Console name)
Date:			dc.b "(C)FUZZY 2023   " ; Copyright holder and release date (generally year)
Title_Local:	dc.b "BRUTALSONIC                                     " ; Domestic name
Title_Int:		dc.b "BRUTALSONIC                                     " ; International name
Serial:			dc.b "MY BALLS ITCH " ; Serial/version number (Rev non-0)
Checksum:		dc.w $0
				dc.b "J               " ; I/O support
RomStartLoc:	dc.l StartOfRom		; Start address of ROM
RomEndLoc:		dc.l EndOfRom-1		; End address of ROM
RamStartLoc:	dc.l $FF0000		; Start address of RAM
RamEndLoc:		dc.l $FFFFFF		; End address of RAM
SRAMSupport:	if SRAMEnabled=1
	    dc.b    "RA", $F8, $20
		else
		dc.l $20202020
		endc
		dc.l $200001		; SRAM start ($200001)
		dc.l $2003FF		; SRAM end ($20xxxx)
Notes:		dc.b "    https://youtube.com/watch?v=JUtqriLVF5Q         " ; Notes (unused, anything can be put in this space, but it has to be 52 bytes.)
Region:		dc.b "JUE             " ; Region (Country code)
EndOfHeader:

SymbolData_Ptr:
		dc.l 0			; symbol table pointer (injected by ConvSym after build)
