; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	Robotnik picks up (SYZ)
; ---------------------------------------------------------------------------
Map_BossBlock_internal:
		dc.w @wholeblock-Map_BossBlock_internal
		dc.w @topleft-Map_BossBlock_internal
		dc.w @topright-Map_BossBlock_internal
		dc.w @bottomleft-Map_BossBlock_internal
		dc.w @bottomright-Map_BossBlock_internal
@wholeblock:	dc.w 2
		dc.b $F0, $D, 0, $71, $FF, $F0
		dc.b 0,	$D, 0, $79, $FF, $F0
		dc.b 0
@topleft:	dc.w 1
		dc.b $F8, 5, 0,	$71, $FF, $F8
@topright:	dc.w 1
		dc.b $F8, 5, 0,	$75, $FF, $F8
@bottomleft:	dc.w 1
		dc.b $F8, 5, 0,	$79, $FF, $F8
@bottomright:	dc.w 1
		dc.b $F8, 5, 0,	$7D, $FF, $F8
		even