; ---------------------------------------------------------------------------
; Sprite mappings - collapsing floors (MZ, SLZ,	SBZ)
; ---------------------------------------------------------------------------
Map_CFlo_internal:
		dc.w byte_874E-Map_CFlo_internal
		dc.w byte_8763-Map_CFlo_internal
		dc.w byte_878C-Map_CFlo_internal
		dc.w byte_87A1-Map_CFlo_internal
byte_874E:	dc.w 4
		dc.b $F8, $D, 0, 0, $FF, $E0	; MZ and SBZ blocks
		dc.b 8,	$D, 0, 0, $FF, $E0
		dc.b $F8, $D, 0, 0, $00, 0
		dc.b 8,	$D, 0, 0, $00, 0
byte_8763:	dc.w 8
		dc.b $F8, 5, 0,	0, $FF, $E0
		dc.b $F8, 5, 0,	0, $FF, $F0
		dc.b $F8, 5, 0,	0, $00, 0
		dc.b $F8, 5, 0,	0, $00, $10
		dc.b 8,	5, 0, 0, $FF, $E0
		dc.b 8,	5, 0, 0, $FF, $F0
		dc.b 8,	5, 0, 0, $00, 0
		dc.b 8,	5, 0, 0, $00, $10
byte_878C:	dc.w 4
		dc.b $F8, $D, 0, 0, $FF, $E0	; SLZ blocks
		dc.b 8,	$D, 0, 8, $FF, $E0
		dc.b $F8, $D, 0, 0, $00, 0
		dc.b 8,	$D, 0, 8, $00, 0
byte_87A1:	dc.w 8
		dc.b $F8, 5, 0,	0, $FF, $E0
		dc.b $F8, 5, 0,	4, $FF, $F0
		dc.b $F8, 5, 0,	0, $00, 0
		dc.b $F8, 5, 0,	4, $00, $10
		dc.b 8,	5, 0, 8, $FF, $E0
		dc.b 8,	5, 0, $C, $FF, $F0
		dc.b 8,	5, 0, 8, $00, 0
		dc.b 8,	5, 0, $C, $00, $10
		even