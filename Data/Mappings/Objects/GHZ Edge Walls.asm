; ---------------------------------------------------------------------------
; Sprite mappings - walls (GHZ)
; ---------------------------------------------------------------------------
Map_Edge_internal:
		dc.w M_Edge_Shadow-Map_Edge_internal
		dc.w M_Edge_Light-Map_Edge_internal
		dc.w M_Edge_Dark-Map_Edge_internal
M_Edge_Shadow:	dc.b 4
		dc.b $E0, 5, 0,	4, $FF, $F8	; light with shadow
		dc.b $F0, 5, 0,	8, $FF, $F8
		dc.b 0,	5, 0, 8, $FF, $F8
		dc.b $10, 5, 0,	8, $FF, $F8
M_Edge_Light:	dc.b 4
		dc.b $E0, 5, 0,	8, $FF, $F8	; light with no shadow
		dc.b $F0, 5, 0,	8, $FF, $F8
		dc.b 0,	5, 0, 8, $FF, $F8
		dc.b $10, 5, 0,	8, $FF, $F8
M_Edge_Dark:	dc.b 4
		dc.b $E0, 5, 0,	0, $FF, $F8	; all shadow
		dc.b $F0, 5, 0,	0, $FF, $F8
		dc.b 0,	5, 0, 0, $FF, $F8
		dc.b $10, 5, 0,	0, $FF, $F8
		even