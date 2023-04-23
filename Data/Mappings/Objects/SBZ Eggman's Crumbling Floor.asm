; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	disintegrate when Eggman presses a switch
; ---------------------------------------------------------------------------
Map_FFloor_internal:
		dc.w @wholeblock-Map_FFloor_internal
		dc.w @topleft-Map_FFloor_internal
		dc.w @topright-Map_FFloor_internal
		dc.w @bottomleft-Map_FFloor_internal
		dc.w @bottomright-Map_FFloor_internal
@wholeblock:	dc.w 1
		dc.b $F0, $F, 0, 0, $FF, $F0
@topleft:	dc.w 2
		dc.b $F8, 1, 0,	0, $FF, $F8
		dc.b $F8, 1, 0,	4, $00, 0
		dc.b 0
@topright:	dc.w 2
		dc.b $F8, 1, 0,	8, $FF, $F8
		dc.b $F8, 1, 0,	$C, $00, 0
		dc.b 0
@bottomleft:	dc.w 2
		dc.b $F8, 1, 0,	2, $FF, $F8
		dc.b $F8, 1, 0,	6, $00, 0
		dc.b 0
@bottomright:	dc.w 2
		dc.b $F8, 1, 0,	$A, $FF, $F8
		dc.b $F8, 1, 0,	$E, $00, 0
		even