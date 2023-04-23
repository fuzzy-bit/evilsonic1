; ---------------------------------------------------------------------------
; Sprite mappings - seesaws (SLZ)
; ---------------------------------------------------------------------------
Map_Seesaw_internal:
		dc.w @sloping-Map_Seesaw_internal
		dc.w @flat-Map_Seesaw_internal
		dc.w @sloping-Map_Seesaw_internal
		dc.w @flat-Map_Seesaw_internal
@sloping:	dc.w 7
		dc.b $D4, 6, 0,	0, $FF, $D3
		dc.b $DC, 6, 0,	6, $FF, $E3
		dc.b $E4, 4, 0,	$C, $FF, $F3
		dc.b $EC, $D, 0, $E, $FF, $F3
		dc.b $FC, 8, 0,	$16, $FF, $FB
		dc.b $F4, 6, 0,	6, $00, $13
		dc.b $FC, 5, 0,	$19, $00, $23
@flat:		dc.b 4
		dc.b $E6, $A, 0, $1D, $FF, $D0
		dc.b $E6, $A, 0, $23, $FF, $E8
		dc.b $E6, $A, 8, $23, $00, 0
		dc.b $E6, $A, 8, $1D, $00, $18
		even
