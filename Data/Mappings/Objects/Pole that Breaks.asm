; ---------------------------------------------------------------------------
; Sprite mappings - pole that breaks (LZ)
; ---------------------------------------------------------------------------
Map_Pole_internal:
		dc.w @normal-Map_Pole_internal
		dc.w @broken-Map_Pole_internal
@normal:	dc.w 2			; normal pole
		dc.b $E0, 3, 0,	0, $FF, $FC
		dc.b 0,	3, $10,	0, $FF, $FC
@broken:	dc.w 4			; broken pole
		dc.b $E0, 1, 0,	0, $FF, $FC
		dc.b $F0, 5, 0,	4, $FF, $FC
		dc.b 0,	5, $10,	4, $FF, $FC
		dc.b $10, 1, $10, 0, $FF, $FC
		even