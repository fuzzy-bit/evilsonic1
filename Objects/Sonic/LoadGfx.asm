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

; ---------------------------------------------------------------------------
; MK blood graphics loading subroutine
; ---------------------------------------------------------------------------
MKBlood_LoadGFX:
	lea	@Config(pc), a6
	jmp	UpdateDPLC

@Config:
	dc.l	PLC_MKBlood	; DPLC pointer
	dc.l	Art_MKBlood	; Art pointer
	dc.w	$B000		; VRAM address
