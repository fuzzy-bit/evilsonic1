; ---------------------------------------------------------------------------
; Sprite mappings - Moto Bug enemy (GHZ)
; ---------------------------------------------------------------------------
Map_Moto_internal:
		dc.w @moto1-Map_Moto_internal
		dc.w @moto2-Map_Moto_internal
		dc.w @moto3-Map_Moto_internal
		dc.w @smoke1-Map_Moto_internal
		dc.w @smoke2-Map_Moto_internal
		dc.w @smoke3-Map_Moto_internal
		dc.w @blank-Map_Moto_internal
@moto1:		dc.w 4
		dc.b $F0, $D, 0, 0, $FF, $EC
		dc.b 0,	$C, 0, 8, $FF, $EC
		dc.b $F8, 1, 0,	$C, $00, $C
		dc.b 8,	8, 0, $E, $FF, $F4
@moto2:		dc.w 4
		dc.b $F1, $D, 0, 0, $FF, $EC
		dc.b 1,	$C, 0, 8, $FF, $EC
		dc.b $F9, 1, 0,	$C, $00, $C
		dc.b 9,	8, 0, $11, $FF, $F4
@moto3:		dc.w 5
		dc.b $F0, $D, 0, 0, $FF, $EC
		dc.b 0,	$C, 0, $14, $FF, $EC
		dc.b $F8, 1, 0,	$C, $00, $C
		dc.b 8,	4, 0, $18, $FF, $EC
		dc.b 8,	4, 0, $12, $FF, $FC
@smoke1:	dc.w 1
		dc.b $FA, 0, 0,	$1A, $00, $10
@smoke2:	dc.w 1
		dc.b $FA, 0, 0,	$1B, $00, $10
@smoke3:	dc.w 1
		dc.b $FA, 0, 0,	$1C, $00, $10
@blank:		dc.w 0
		even