; ---------------------------------------------------------------------------
; Sprite mappings - helix of spikes on a pole (GHZ)
; ---------------------------------------------------------------------------
Map_Hel_internal:
		dc.w byte_7E08-Map_Hel_internal
		dc.w byte_7E0E-Map_Hel_internal
		dc.w byte_7E14-Map_Hel_internal
		dc.w byte_7E1A-Map_Hel_internal
		dc.w byte_7E20-Map_Hel_internal
		dc.w byte_7E26-Map_Hel_internal
		dc.w byte_7E2E-Map_Hel_internal
		dc.w byte_7E2C-Map_Hel_internal
byte_7E08:	dc.w 1
		dc.b $F0, 1, 0,	0, $FF, $FC	; points straight up (harmful)
byte_7E0E:	dc.w 1
		dc.b $F5, 5, 0,	2, $FF, $F8	; 45 degree
byte_7E14:	dc.w 1
		dc.b $F8, 5, 0,	6, $FF, $F8	; 90 degree
byte_7E1A:	dc.w 1
		dc.b $FB, 5, 0,	$A, $FF, $F8	; 45 degree
byte_7E20:	dc.w 1
		dc.b 0,	1, 0, $E, $FF, $FC	; straight down
byte_7E26:	dc.w 1
		dc.b 4,	0, 0, $10, $FF, $FD	; 45 degree
byte_7E2C:	dc.w 1
		dc.b $F4
		dc.b 0, 0,	$11, $FF, $FD ; 45 degree
byte_7E2E:	; reads the 0 below	; not visible
		dc.w 0
		even