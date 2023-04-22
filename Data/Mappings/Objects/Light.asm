; ---------------------------------------------------------------------------
; Sprite mappings - lamp (SYZ)
; ---------------------------------------------------------------------------
Map_Light_internal:
		dc.w @0-Map_Light_internal
		dc.w @1-Map_Light_internal
		dc.w @2-Map_Light_internal
		dc.w @3-Map_Light_internal
		dc.w @4-Map_Light_internal
		dc.w @5-Map_Light_internal
@0:		dc.b 2
		dc.b $F8, $C, 0, $31, $FF, $F0
		dc.b 0,	$C, $10, $31, $FF, $F0
@1:		dc.b 2
		dc.b $F8, $C, 0, $35, $FF, $F0
		dc.b 0,	$C, $10, $35, $FF, $F0
@2:		dc.b 2
		dc.b $F8, $C, 0, $39, $FF, $F0
		dc.b 0,	$C, $10, $39, $FF, $F0
@3:		dc.b 2
		dc.b $F8, $C, 0, $3D, $FF, $F0
		dc.b 0,	$C, $10, $3D, $FF, $F0
@4:		dc.b 2
		dc.b $F8, $C, 0, $41, $FF, $F0
		dc.b 0,	$C, $10, $41, $FF, $F0
@5:		dc.b 2
		dc.b $F8, $C, 0, $45, $FF, $F0
		dc.b 0,	$C, $10, $45, $FF, $F0
		even