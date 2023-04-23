; ---------------------------------------------------------------------------
; Sprite mappings - special stage entry	from beta
; ---------------------------------------------------------------------------
Map_Vanish_internal:
		dc.w @flash1-Map_Vanish_internal
		dc.w @flash2-Map_Vanish_internal
		dc.w @flash3-Map_Vanish_internal
		dc.w @sparkle1-Map_Vanish_internal
		dc.w @sparkle2-Map_Vanish_internal
		dc.w @sparkle3-Map_Vanish_internal
		dc.w @sparkle4-Map_Vanish_internal
		dc.w @blank-Map_Vanish_internal
@flash1:	dc.w 3
		dc.b $F8, 0, 0,	0, $00, 8
		dc.b 0,	4, 0, 1, $00, 0
		dc.b 8,	0, $10,	0, $00, 8
@flash2:	dc.w 3
		dc.b $F0, $D, 0, 3, $FF, $F0
		dc.b 0,	$C, 0, $B, $FF, $F0
		dc.b 8,	$D, $10, 3, $FF, $F0
@flash3:	dc.w 5
		dc.b $E4, $E, 0, $F, $FF, $F4
		dc.b $EC, 2, 0,	$1B, $FF, $EC
		dc.b $FC, $C, 0, $1E, $FF, $F4
		dc.b 4,	$E, $10, $F, $FF, $F4
		dc.b 4,	1, $10,	$1B, $FF, $EC
@sparkle1:	dc.w 9
		dc.b $F0, 8, 0,	$22, $FF, $F8
		dc.b $F8, $E, 0, $25, $FF, $F0
		dc.b $10, 8, 0,	$31, $FF, $F0
		dc.b 0,	5, 0, $34, $00, $10
		dc.b $F8, 0, 8,	$25, $00, $10
		dc.b $F0, 0, $18, $36, $00, $18
		dc.b $F8, 0, $18, $25, $00, $20
		dc.b 0,	0, 8, $25, $00, $28
		dc.b $F8, 0, 0,	$25, $00, $30
@sparkle2:	dc.w $12
		dc.b 0,	0, $18,	$25, $FF, $F0
		dc.b $F8, 4, 0,	$38, $FF, $F8
		dc.b $F0, 0, 0,	$26, $00, 8
		dc.b 0,	0, 0, $25, $00, 0
		dc.b 8,	0, $18,	$25, $FF, $F8
		dc.b $10, 0, $10, $26, $00, 0
		dc.b 8,	0, $10,	$38, $00, 8
		dc.b $F8, 0, 0,	$29, $00, $10
		dc.b 0,	0, 0, $26, $00, $10
		dc.b 0,	0, 0, $2D, $00, $18
		dc.b 8,	0, 8, $26, $00, $18
		dc.b 8,	0, 0, $29, $00, $20
		dc.b $F8, 0, 0,	$26, $00, $20
		dc.b $F8, 0, 0,	$2D, $00, $28
		dc.b 0,	0, 0, $3A, $00, $28
		dc.b $F8, 0, $18, $26, $00, $30
		dc.b 0,	0, $10,	$25, $00, $38
		dc.b $F8, 0, $10, $25, $00, $40
@sparkle3:	dc.w $11
		dc.b $F8, 0, 8,	$25, $00, 0
		dc.b $F0, 0, 0,	$38, $00, $10
		dc.b $10, 0, 8,	$25, $00, 0
		dc.b 0,	0, $18,	$25, $00, $10
		dc.b 8,	0, $10,	$25, $00, $18
		dc.b $F8, 0, $18, $25, $00, $20
		dc.b 0,	0, $10,	$26, $00, $28
		dc.b $F8, 0, $10, $25, $00, $30
		dc.b 0,	0, 0, $25, $00, $30
		dc.b 8,	0, 8, $25, $00, $30
		dc.b 0,	0, 8, $26, $00, $38
		dc.b 8,	0, 0, $29, $00, $38
		dc.b $F8, 0, 8,	$26, $00, $40
		dc.b 0,	0, 0, $2D, $00, $40
		dc.b $F8, 0, 8,	$25, $00, $48
		dc.b 0,	0, 0, $25, $00, $48
		dc.b 0,	0, $10,	$25, $00, $50
@sparkle4:	dc.w 9
		dc.b $FC, 0, 8,	$26, $00, $30
		dc.b 4,	0, 8, $25, $00, $28
		dc.b 4,	0, $10,	$27, $00, $38
		dc.b 4,	0, 8, $26, $00, $40
		dc.b $FC, 0, $10, $25, $00, $40
		dc.b $FC, 0, $10, $26, $00, $48
		dc.b $C, 0, 8, $27, $00, $48
		dc.b 4,	0, $18,	$26, $00, $50
		dc.b 4
@blank:		dc.b 0,	8, $27,	$58, $00, 0
		even