; ---------------------------------------------------------------------------
; Sonic	graphics loading subroutine
; ---------------------------------------------------------------------------

Sonic_LoadGfx:
	lea	@Config(pc), a6
	jmp	UpdateDPLC
	
@Config:
	dc.l	PLC_Sonic	; DPLC pointer
	dc.l	Art_Sonic	; Art pointer
	dc.w	$F000		; VRAM address
