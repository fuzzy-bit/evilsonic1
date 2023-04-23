; ---------------------------------------------------------------------------
; Sprite mappings - springs
; ---------------------------------------------------------------------------
Map_Spring_internal:
		dc.w M_Spg_Up-Map_Spring_internal
		dc.w M_Spg_UpFlat-Map_Spring_internal
		dc.w M_Spg_UpExt-Map_Spring_internal
		dc.w M_Spg_Left-Map_Spring_internal
		dc.w M_Spg_LeftFlat-Map_Spring_internal
		dc.w M_Spg_LeftExt-Map_Spring_internal
M_Spg_Up:	dc.w 2			; facing up
		dc.b $F8, $C, 0, 0, $FF, $F0
		dc.b 0,	$C, 0, 4, $FF, $F0
M_Spg_UpFlat:	dc.w 1			; facing up, flattened
		dc.b 0,	$C, 0, 0, $FF, $F0
M_Spg_UpExt:	dc.w 3			; facing up, extended
		dc.b $E8, $C, 0, 0, $FF, $F0
		dc.b $F0, 5, 0,	8, $FF, $F8
		dc.b 0,	$C, 0, $C, $FF, $F0
M_Spg_Left:	dc.w 1			; facing left
		dc.b $F0, 7, 0,	0, $FF, $F8
M_Spg_LeftFlat:	dc.w 1			; facing left, flattened
		dc.b $F0, 3, 0,	4, $FF, $F8
M_Spg_LeftExt:	dc.w 4			; facing left, extended
		dc.b $F0, 3, 0,	4, $00, $10
		dc.b $F8, 9, 0,	8, $FF, $F8
		dc.b $F0, 0, 0,	0, $FF, $F8
		dc.b 8,	0, 0, 3, $FF, $F8
		even