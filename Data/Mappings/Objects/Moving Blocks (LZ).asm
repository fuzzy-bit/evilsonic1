; ---------------------------------------------------------------------------
; Sprite mappings - moving block (LZ)
; ---------------------------------------------------------------------------
Map_MBlockLZ_internal:
		dc.w @0-Map_MBlockLZ_internal
@0:		dc.w 1
		dc.b $F8, $D, 0, 0, $FF, $F0
		even