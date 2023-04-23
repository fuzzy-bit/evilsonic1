; ---------------------------------------------------------------------------
; Sprite mappings - switches (MZ, SYZ, LZ, SBZ)
; ---------------------------------------------------------------------------
Map_But_internal:
		dc.w byte_BEAC-Map_But_internal
		dc.w byte_BEB7-Map_But_internal
		dc.w byte_BEC2-Map_But_internal
		dc.w byte_BEB7-Map_But_internal
byte_BEAC:	dc.w 2
		dc.b $F5, 5, 0,	0, $FF, $F0
		dc.b $F5, 5, 8,	0, $00, 0
byte_BEB7:	dc.w 2
		dc.b $F5, 5, 0,	4, $FF, $F0
		dc.b $F5, 5, 8,	4, $00, 0
byte_BEC2:	dc.w 2
		dc.b $F5, 5, $FF, $FC, $FF, $F0
		dc.b $F5, 5, 7,	$FC, $00, 0
		dc.b $F8, 5, 0,	0, $FF, $F8
		even