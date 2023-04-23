; ---------------------------------------------------------------------------
; Sprite mappings - Unused switch thingy
; ---------------------------------------------------------------------------
Map_Swi_internal:
		dc.w byte_891E-Map_Swi_internal
byte_891E:	dc.b 4
		dc.b $E8, 7, 0,	$54, $FF, $F0
		dc.b 8,	5, 0, $5C, $FF, $F0
		dc.b $E8, 7, 0,	$54, $00, 0
		dc.b 8,	5, 0, $5C, $00, 0
		even