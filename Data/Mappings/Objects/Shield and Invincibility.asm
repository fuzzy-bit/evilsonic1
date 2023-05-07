; ---------------------------------------------------------------------------
; Sprite mappings - shield and invincibility stars
; ---------------------------------------------------------------------------
Map_Shield_internal:
		dc.w @shield1-Map_Shield_internal
		dc.w @shield2-Map_Shield_internal
		dc.w @shield3-Map_Shield_internal
		dc.w @shield4-Map_Shield_internal
		dc.w @stars1-Map_Shield_internal
		dc.w @stars2-Map_Shield_internal
		dc.w @stars3-Map_Shield_internal
		dc.w @stars4-Map_Shield_internal
@shield2:	dc.w 4
		dc.b $E8, $A, 0, 0, $FF, $E8
		dc.b $E8, $A, 0, 9, $00, 0
		dc.b 0,	$A, $10, 0, $FF, $E8
		dc.b 0,	$A, $10, 9, $00, 0
@shield1:	dc.w 0
@shield3:	dc.w 4
		dc.b $E8, $A, 8, $12, $FF, $E9
		dc.b $E8, $A, 0, $12, $00, 0
		dc.b 0,	$A, $18, $12, $FF, $E9
		dc.b 0,	$A, $10, $12, $00, 0
@shield4:	dc.w 4
		dc.b $E8, $A, 8, 9, $FF, $E8
		dc.b $E8, $A, 8, 0, $00, 0
		dc.b 0,	$A, $18, 9, $FF, $E8
		dc.b 0,	$A, $18, 0, $00, 0
@stars1:	dc.w 4
		dc.b $E8, $A, 0, 0, $FF, $E8
		dc.b $E8, $A, 0, 9, $00, 0
		dc.b 0,	$A, $18, 9, $FF, $E8
		dc.b 0,	$A, $18, 0, $00, 0
@stars2:	dc.w 4
		dc.b $E8, $A, 8, 9, $FF, $E8
		dc.b $E8, $A, 8, 0, $00, 0
		dc.b 0,	$A, $10, 0, $FF, $E8
		dc.b 0,	$A, $10, 9, $00, 0
@stars3:	dc.w 4
		dc.b $E8, $A, 0, $12, $FF, $E8
		dc.b $E8, $A, 0, $1B, $00, 0
		dc.b 0,	$A, $18, $1B, $FF, $E8
		dc.b 0,	$A, $18, $12, $00, 0
@stars4:	dc.w 4
		dc.b $E8, $A, 8, $1B, $FF, $E8
		dc.b $E8, $A, 8, $12, $00, 0
		dc.b 0,	$A, $10, $12, $FF, $E8
		dc.b 0,	$A, $10, $1B, $00, 0
		even