; ---------------------------------------------------------------------------
; Sprite mappings - Basaran enemy (MZ)
; ---------------------------------------------------------------------------
Map_Bas_internal:
		dc.w @still-Map_Bas_internal
		dc.w @fly1-Map_Bas_internal
		dc.w @fly2-Map_Bas_internal
		dc.w @fly3-Map_Bas_internal
@still:		dc.b 1
		dc.b $F4, 6, 0,	0, $FF, $F8
@fly1:		dc.b 3
		dc.b $F2, $E, 0, 6, $FF, $F4
		dc.b $A, 4, 0, $12, $FF, $FC
		dc.b 2,	0, 0, $27, $00, $C
@fly2:		dc.b 4
		dc.b $F8, 4, 0,	$14, $FF, $F8
		dc.b 0,	$C, 0, $16, $FF, $F0
		dc.b 8,	4, 0, $1A, $00, 0
		dc.b 0,	0, 0, $28, $00, $C
@fly3:		dc.b 4
		dc.b $F6, 9, 0,	$1C, $FF, $F5
		dc.b 6,	8, 0, $22, $FF, $F4
		dc.b $E, 4, 0, $25, $FF, $F4
		dc.b $FE, 0, 0,	$27, $00, $C
		even