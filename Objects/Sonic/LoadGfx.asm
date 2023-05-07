; ---------------------------------------------------------------------------
; Sonic	graphics loading subroutine
; ---------------------------------------------------------------------------

Sonic_LoadGfx:
	lea	Sonic_DPLC_Config(pc), a6
	jmp	UpdateDPLC

; ---------------------------------------------------------------------------
; Sonic pattern loading data
; ---------------------------------------------------------------------------

Sonic_DPLC_Config:
	dc.l	SonicDynPLC	; DPLC pointer
	dc.l	Art_Sonic	; Art pointer
	dc.w	$F000		; VRAM address
