; ---------------------------------------------------------------------------
; Sprite mappings - chain of spiked balls (SYZ)
; ---------------------------------------------------------------------------
Map_SBall_internal:
		dc.w @0-Map_SBall_internal
@0:		dc.w 1
		dc.b $F8, 5, 0,	0, $FF, $F8
		even