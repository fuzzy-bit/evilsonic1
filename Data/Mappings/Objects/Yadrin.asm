; ---------------------------------------------------------------------------
; Sprite mappings - Yadrin enemy (SYZ)
; ---------------------------------------------------------------------------
Map_Yad_internal:
		dc.w @walk0-Map_Yad_internal
		dc.w @walk1-Map_Yad_internal
		dc.w @walk2-Map_Yad_internal
		dc.w @walk3-Map_Yad_internal
		dc.w @walk4-Map_Yad_internal
		dc.w @walk5-Map_Yad_internal
@walk0:		dc.b 5
		dc.b $F4, 8, 0,	0, $FF, $F4
		dc.b $FC, $E, 0, 3, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $31, $FF, $FC
@walk1:		dc.b 5
		dc.b $F4, 8, 0,	$14, $FF, $F4
		dc.b $FC, $E, 0, $17, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $31, $FF, $FC
@walk2:		dc.b 5
		dc.b $F4, 9, 0,	$23, $FF, $F4
		dc.b 4,	$D, 0, $29, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $31, $FF, $FC
@walk3:		dc.b 5
		dc.b $F4, 8, 0,	0, $FF, $F4
		dc.b $FC, $E, 0, 3, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $37, $FF, $FC
@walk4:		dc.b 5
		dc.b $F4, 8, 0,	$14, $FF, $F4
		dc.b $FC, $E, 0, $17, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $37, $FF, $FC
@walk5:		dc.b 5
		dc.b $F4, 9, 0,	$23, $FF, $F4
		dc.b 4,	$D, 0, $29, $FF, $EC
		dc.b $EC, 4, 0,	$F, $FF, $FC
		dc.b $F4, 2, 0,	$11, $C
		dc.b 4,	9, 0, $37, $FF, $FC
		even