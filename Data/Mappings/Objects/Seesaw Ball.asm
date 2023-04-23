; ---------------------------------------------------------------------------
; Sprite mappings - spiked balls on the	seesaws	(SLZ)
; ---------------------------------------------------------------------------
Map_SSawBall_internal:
		dc.w @red-Map_SSawBall_internal
		dc.w @silver-Map_SSawBall_internal
@red:		dc.w 1
		dc.b $F4, $A, 0, 0, $FF, $F4
@silver:	dc.w 1
		dc.b $F4, $A, 0, 9, $FF, $F4
		even