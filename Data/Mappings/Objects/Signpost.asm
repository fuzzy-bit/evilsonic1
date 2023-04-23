; ---------------------------------------------------------------------------
; Sprite mappings - signpost
; ---------------------------------------------------------------------------
Map_Sign_internal:
		dc.w @eggman-Map_Sign_internal
		dc.w @spin1-Map_Sign_internal
		dc.w @spin2-Map_Sign_internal
		dc.w @spin3-Map_Sign_internal
		dc.w @sonic-Map_Sign_internal
@eggman:	dc.b 3
		dc.b $F0, $B, 0, 0, $FF, $E8
		dc.b $F0, $B, 8, 0, $00, 0
		dc.b $10, 1, 0,	$38, $FF, $FC
@spin1:		dc.b 2
		dc.b $F0, $F, 0, $C, $FF, $F0
		dc.b $10, 1, 0,	$38, $FF, $FC
@spin2:		dc.b 2
		dc.b $F0, 3, 0,	$1C, $FF, $FC
		dc.b $10, 1, 8,	$38, $FF, $FC
@spin3:		dc.b 2
		dc.b $F0, $F, 8, $C, $FF, $F0
		dc.b $10, 1, 8,	$38, $FF, $FC
@sonic:		dc.b 3
		dc.b $F0, $B, 0, $20, $FF, $E8
		dc.b $F0, $B, 0, $2C, $00, 0
		dc.b $10, 1, 0,	$38, $FF, $FC
		even