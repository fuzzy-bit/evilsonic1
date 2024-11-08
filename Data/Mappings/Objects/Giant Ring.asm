; ---------------------------------------------------------------------------
; Sprite mappings - giant ring
; ---------------------------------------------------------------------------
Map_GRing_internal:
		dc.w byte_9FDA-Map_GRing_internal
		dc.w byte_A00D-Map_GRing_internal
		dc.w byte_A036-Map_GRing_internal
		dc.w byte_A04B-Map_GRing_internal
byte_9FDA:	dc.w $A
		dc.b $E0, 8, 0,	0, $FF, $E8	; ring front
		dc.b $E0, 8, 0,	3, $00, 0
		dc.b $E8, $C, 0, 6, $FF, $E0
		dc.b $E8, $C, 0, $A, $00, 0
		dc.b $F0, 7, 0,	$E, $FF, $E0
		dc.b $F0, 7, 0,	$16, $00, $10
		dc.b $10, $C, 0, $1E, $FF, $E0
		dc.b $10, $C, 0, $22, $00, 0
		dc.b $18, 8, 0,	$26, $FF, $E8
		dc.b $18, 8, 0,	$29, $00, 0
byte_A00D:	dc.w 8
		dc.b $E0, $C, 0, $2C, $FF, $F0 ; ring angle
		dc.b $E8, 8, 0,	$30, $FF, $E8
		dc.b $E8, 9, 0,	$33, $00, 0
		dc.b $F0, 7, 0,	$39, $FF, $E8
		dc.b $F8, 5, 0,	$41, $00, 8
		dc.b 8,	9, 0, $45, $00, 0
		dc.b $10, 8, 0,	$4B, $FF, $E8
		dc.b $18, $C, 0, $4E, $FF, $F0
byte_A036:	dc.w 4
		dc.b $E0, 7, 0,	$52, $FF, $F4 ; ring perpendicular
		dc.b $E0, 3, 8,	$52, $00, 4
		dc.b 0,	7, 0, $5A, $FF, $F4
		dc.b 0,	3, 8, $5A, $00, 4
byte_A04B:	dc.w 8
		dc.b $E0, $C, 8, $2C, $FF, $F0 ; ring angle
		dc.b $E8, 8, 8,	$30, $00, 0
		dc.b $E8, 9, 8,	$33, $FF, $E8
		dc.b $F0, 7, 8,	$39, $00, 8
		dc.b $F8, 5, 8,	$41, $FF, $E8
		dc.b 8,	9, 8, $45, $FF, $E8
		dc.b $10, 8, 8,	$4B, $00, 0
		dc.b $18, $C, 8, $4E, $FF, $F0
		even