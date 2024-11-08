; ---------------------------------------------------------------------------
; Sprite mappings - "PRESS START BUTTON" and "TM" from title screen
; ---------------------------------------------------------------------------
Map_PSB_internal:
		dc.w byte_A7CD-Map_PSB_internal
		dc.w M_PSB_PSB-Map_PSB_internal
		dc.w M_PSB_Limiter-Map_PSB_internal
		dc.w M_PSB_TM-Map_PSB_internal
M_PSB_PSB:	dc.w 6			; "PRESS START BUTTON"
byte_A7CD:	dc.w 0,	$C, 0, $F0, $00, 0
		dc.b 0,	0, 0, $F3, $00, $20
		dc.b 0,	0, 0, $F3, $00, $30
		dc.b 0,	$C, 0, $F4, $00, $38
		dc.b 0,	8, 0, $F8, $00, $60
		dc.b 0,	8, 0, $FB, $00, $78
M_PSB_Limiter:	dc.w $1E		; sprite line limiter
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $B8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $D8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
		dc.b $F8, $F, 0, 0, $FF, $80
M_PSB_TM:	dc.w 1			; "TM"
		dc.b $FC, 4, 0,	0, $FF, $F8
		even