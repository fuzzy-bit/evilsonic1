
	include	"Engine/CD/Common.i"

; -------------------------------------------------------------------------
; Header
; -------------------------------------------------------------------------

	dc.b	"SEGADISCSYSTEM  "		; Disk type ID
	dc.b	"SEGAIPSAMP ", 0
	dc.w	$0000				; Volume version
	dc.w	$0001				; CD-ROM = $0001
	dc.b	"SYSTEM NAME", 0		; System name
	dc.w	$0000				; System version
	dc.w	$0000				; Always 0
	dc.l	$00000200			; IP disk address
	dc.l	$00000600			; IP load size
	dc.l	$00000000			; IP entry offset
	dc.l	$00000000			; IP work RAM size
	dc.l	$00000800			; SP disk address
	dc.l	$00007800			; SP load size
	dc.l	$00000000			; SP entry offset
	dc.l	$00000000			; SP work RAM size
        dc.b	"        "                      ; Build date (blank)

	align	$100, $20

        dc.b	"SEGA MEGA DRIVE "	; Hardware ID
        dc.b	"(C)SEGA 1993.APR"	; Release date
	dc.b	"CD-SONIC THE HEDGEHOG                           "
	dc.b	"CD-SONIC THE HEDGEHOG                           "
	dc.b	"XX 00000000-00  "      ; Game version
	dc.b	"J               "	; I/O support
	dc.b	"                "	; Space

	align	$1F0, $20

	if REGION=JAPAN			; Region
		dc.b	"J"
	elseif REGION=USA
		dc.b	"U"
	else
		dc.b	"E"
	endif

	align	$200, $20

; -------------------------------------------------------------------------
; Initial program
; -------------------------------------------------------------------------

	incbin	"_Built/Misc/IP.BIN"

; -------------------------------------------------------------------------
; Version number? (Blank)
; -------------------------------------------------------------------------

	align	$800

; -------------------------------------------------------------------------
; System program
; -------------------------------------------------------------------------

SPStart:
	incbin	"_Built/Misc/SP.BIN"
	align	$8000

; -------------------------------------------------------------------------
; File data
; -------------------------------------------------------------------------

	incbin	"_Built/Misc/FILES.BIN", $8000
	align	$800

; -------------------------------------------------------------------------
