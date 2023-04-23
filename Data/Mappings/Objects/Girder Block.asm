; ---------------------------------------------------------------------------
; Sprite mappings - large girder block (SBZ)
; ---------------------------------------------------------------------------
Map_Gird_internal:
		dc.w @girder-Map_Gird_internal
@girder:	dc.b $C
		dc.b $E8, $E, 0, 0, $FF, $A0
		dc.b 0,	$E, $10, 0, $FF, $A0
		dc.b $E8, $E, 0, 6, $FF, $C0
		dc.b 0,	$E, $10, 6, $FF, $C0
		dc.b $E8, $E, 0, 6, $FF, $E0
		dc.b 0,	$E, $10, 6, $FF, $E0
		dc.b $E8, $E, 0, 6, $00, 0
		dc.b 0,	$E, $10, 6, $00, 0
		dc.b $E8, $E, 0, 6, $00, $20
		dc.b 0,	$E, $10, 6, $00, $20
		dc.b $E8, $E, 0, 6, $00, $40
		dc.b 0,	$E, $10, 6, $00, $40
		even