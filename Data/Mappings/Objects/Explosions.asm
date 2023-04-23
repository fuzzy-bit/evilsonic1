; ---------------------------------------------------------------------------
; Sprite mappings - explosion from a badnik or monitor
; ---------------------------------------------------------------------------
Map_ExplodeItem:dc.w byte_8ED0-Map_ExplodeItem, byte_8ED6-Map_ExplodeItem
		dc.w byte_8EDC-Map_ExplodeItem, byte_8EE2-Map_ExplodeItem
		dc.w byte_8EF7-Map_ExplodeItem
byte_8ED0:	dc.b 1
		dc.b $F8, 9, 0,	0, $FF, $F4
byte_8ED6:	dc.b 1
		dc.b $F0, $F, 0, 6, $FF, $F0
byte_8EDC:	dc.b 1
		dc.b $F0, $F, 0, $16, $FF, $F0
byte_8EE2:	dc.b 4
		dc.b $EC, $A, 0, $26, $FF, $EC
		dc.b $EC, 5, 0,	$2F, $00, 4
		dc.b 4,	5, $18,	$2F, $FF, $EC
		dc.b $FC, $A, $18, $26,	$FF, $FC
byte_8EF7:	dc.b 4
		dc.b $EC, $A, 0, $33, $FF, $EC
		dc.b $EC, 5, 0,	$3C, $00, 4
		dc.b 4,	5, $18,	$3C, $FF, $EC
		dc.b $FC, $A, $18, $33,	$FF, $FC
		even
; ---------------------------------------------------------------------------
; Sprite mappings - explosion from when	a boss is destroyed
; ---------------------------------------------------------------------------
Map_ExplodeBomb:dc.w byte_8ED0-Map_ExplodeBomb
		dc.w byte_8F16-Map_ExplodeBomb
		dc.w byte_8F1C-Map_ExplodeBomb
		dc.w byte_8EE2-Map_ExplodeBomb
		dc.w byte_8EF7-Map_ExplodeBomb
byte_8F16:	dc.b 1
		dc.b $F0, $F, 0, $40, $FF, $F0
byte_8F1C:	dc.b 1
		dc.b $F0, $F, 0, $50, $FF, $F0
		even