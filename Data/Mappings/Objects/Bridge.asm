; ---------------------------------------------------------------------------
; Sprite mappings - GHZ	bridge
; ---------------------------------------------------------------------------
Map_Bri_internal:
		dc.w M_Bri_Log-Map_Bri_internal
		dc.w M_Bri_Stump-Map_Bri_internal
		dc.w M_Bri_Rope-Map_Bri_internal
M_Bri_Log:	dc.b 1
		dc.b $F8, 5, 0,	0, $FF, $F8	; log
M_Bri_Stump:	dc.b 2
		dc.b $F8, 4, 0,	4, $FF, $F0	; stump & rope
		dc.b 0,	$C, 0, 6, $FF, $F0
M_Bri_Rope:	dc.b 1
		dc.b $FC, 4, 0,	8, $FF, $F8	; rope only
		even