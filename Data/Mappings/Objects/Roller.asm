; ---------------------------------------------------------------------------
; Sprite mappings - Roller enemy (SYZ)
; ---------------------------------------------------------------------------
Map_Roll_internal:
		dc.w M_Roll_Stand-Map_Roll_internal
		dc.w M_Roll_Fold-Map_Roll_internal
		dc.w M_Roll_Roll1-Map_Roll_internal
		dc.w M_Roll_Roll2-Map_Roll_internal
		dc.w M_Roll_Roll3-Map_Roll_internal
M_Roll_Stand:	dc.w 2
		dc.b $DE, $E, 0, 0, $FF, $F0	; standing
		dc.b $F6, $E, 0, $C, $FF, $F0
M_Roll_Fold:	dc.w 2
		dc.b $E6, $E, 0, 0, $FF, $F0	; folding
		dc.b $FE, $D, 0, $18, $FF, $F0
M_Roll_Roll1:	dc.w 1
		dc.b $F0, $F, 0, $20, $FF, $F0 ; rolling
M_Roll_Roll2:	dc.w 1
		dc.b $F0, $F, 0, $30, $FF, $F0 ; rolling
M_Roll_Roll3:	dc.w 1
		dc.b $F0, $F, 0, $40, $FF, $F0 ; rolling
		even