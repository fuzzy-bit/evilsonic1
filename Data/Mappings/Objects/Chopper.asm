; ---------------------------------------------------------------------------
; Sprite mappings - Chopper enemy (GHZ)
; ---------------------------------------------------------------------------
Map_Chop_internal:
		dc.w @mouthshut-Map_Chop_internal
		dc.w @mouthopen-Map_Chop_internal
@mouthshut:	dc.w 1
		dc.b $F0, $F, 0, 0, $FF, $F0
@mouthopen:	dc.w 1
		dc.b $F0, $F, 0, $10, $FF, $F0
		even