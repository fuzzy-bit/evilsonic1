; ---------------------------------------------------------------------------
; Sprite mappings - chaos emeralds on the ending sequence
; ---------------------------------------------------------------------------
Map_ECha_internal:
		dc.w M_ECha_1-Map_ECha_internal
		dc.w M_ECha_2-Map_ECha_internal
		dc.w M_ECha_3-Map_ECha_internal
		dc.w M_ECha_4-Map_ECha_internal
		dc.w M_ECha_5-Map_ECha_internal
		dc.w M_ECha_6-Map_ECha_internal
		dc.w M_ECha_7-Map_ECha_internal
M_ECha_1:	dc.w 1
		dc.b $F8, 5, 0,	0, $FF, $F8
M_ECha_2:	dc.w 1
		dc.b $F8, 5, 0,	4, $FF, $F8
M_ECha_3:	dc.w 1
		dc.b $F8, 5, $40, $10, $FF, $F8
M_ECha_4:	dc.w 1
		dc.b $F8, 5, $20, $18, $FF, $F8
M_ECha_5:	dc.w 1
		dc.b $F8, 5, $40, $14, $FF, $F8
M_ECha_6:	dc.w 1
		dc.b $F8, 5, 0,	8, $FF, $F8
M_ECha_7:	dc.w 1
		dc.b $F8, 5, 0,	$C, $FF, $F8
		even