; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	form a staircase (SLZ)
; ---------------------------------------------------------------------------
Map_Stair_internal:
		dc.w @block-Map_Stair_internal
@block:		dc.w 1
		dc.b $F0, $F, 0, $21, $FF, $F0
		even