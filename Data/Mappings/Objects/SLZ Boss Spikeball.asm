; ---------------------------------------------------------------------------
; Sprite mappings - exploding spikeys that the SLZ boss	drops
; ---------------------------------------------------------------------------
Map_BSBall_internal:
		dc.w @fireball1-Map_BSBall_internal
		dc.w @fireball2-Map_BSBall_internal
@fireball1:	dc.w 1
		dc.b $FC, 0, 0,	$27, $FF, $FC
@fireball2:	dc.w 1
		dc.b $FC, 0, 0,	$28, $FF, $FC
		even