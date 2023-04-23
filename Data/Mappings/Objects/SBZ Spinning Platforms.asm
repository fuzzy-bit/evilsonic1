; ---------------------------------------------------------------------------
; Sprite mappings - spinning platforms (SBZ)
; ---------------------------------------------------------------------------
Map_Spin_internal:
		dc.w @flat-Map_Spin_internal
		dc.w @spin1-Map_Spin_internal
		dc.w @spin2-Map_Spin_internal
		dc.w @spin3-Map_Spin_internal
		dc.w @spin4-Map_Spin_internal
@flat:		dc.w 2
		dc.b $F8, 5, 0,	0, $FF, $F0
		dc.b $F8, 5, 8,	0, $00, 0
@spin1:		dc.w 2
		dc.b $F0, $D, 0, $14, $FF, $F0
		dc.b 0,	$D, 0, $1C, $FF, $F0
@spin2:		dc.w 2
		dc.b $F0, 9, 0,	4, $FF, $F0
		dc.b 0,	9, 0, $A, $FF, $F8
@spin3:		dc.w 2
		dc.b $F0, 9, 0,	$24, $FF, $F0
		dc.b 0,	9, 0, $2A, $FF, $F8
@spin4:		dc.w 2
		dc.b $F0, 5, 0,	$10, $FF, $F8
		dc.b 0,	5, $10,	$10, $FF, $F8
		even