; ---------------------------------------------------------------------------
; Sprite mappings - ground saws	and pizza cutters (SBZ)
; ---------------------------------------------------------------------------
Map_Saw_internal:
		dc.w @pizzacutter1-Map_Saw_internal
		dc.w @pizzacutter2-Map_Saw_internal
		dc.w @groundsaw1-Map_Saw_internal
		dc.w @groundsaw2-Map_Saw_internal
@pizzacutter1:	dc.w 7
		dc.b $C4, 1, 0,	$20, $FF, $FC
		dc.b $D4, 1, 0,	$20, $FF, $FC
		dc.b $E4, 3, 0,	$20, $FF, $FC
		dc.b $E0, $F, 0, 0, $FF, $E0
		dc.b $E0, $F, 8, 0, $00, 0
		dc.b 0,	$F, $10, 0, $FF, $E0
		dc.b 0,	$F, $18, 0, $00, 0
@pizzacutter2:	dc.w 7
		dc.b $C4, 1, 0,	$20, $FF, $FC
		dc.b $D4, 1, 0,	$20, $FF, $FC
		dc.b $E4, 3, 0,	$20, $FF, $FC
		dc.b $E0, $F, 0, $10, $FF, $E0
		dc.b $E0, $F, 8, $10, $00, 0
		dc.b 0,	$F, $10, $10, $FF, $E0
		dc.b 0,	$F, $18, $10, $00, 0
@groundsaw1:	dc.w 4
		dc.b $E0, $F, 0, 0, $FF, $E0
		dc.b $E0, $F, 8, 0, $00, 0
		dc.b 0,	$F, $10, 0, $FF, $E0
		dc.b 0,	$F, $18, 0, $00, 0
@groundsaw2:	dc.w 4
		dc.b $E0, $F, 0, $10, $FF, $E0
		dc.b $E0, $F, 8, $10, $00, 0
		dc.b 0,	$F, $10, $10, $FF, $E0
		dc.b 0,	$F, $18, $10, $00, 0
		even