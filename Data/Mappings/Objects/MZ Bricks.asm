; ---------------------------------------------------------------------------
; Sprite mappings - solid blocks and blocks that fall from the ceiling (MZ)
; ---------------------------------------------------------------------------
Map_Brick_internal:
		dc.w @brick-Map_Brick_internal
@brick:		dc.w 1
		dc.b $F0, $F, 0, 1, $FF, $F0
		even