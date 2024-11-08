; ---------------------------------------------------------------------------
; Sprite mappings - large green	glassy blocks (MZ)
; ---------------------------------------------------------------------------
Map_Glass_internal:
		dc.w @tall-Map_Glass_internal
		dc.w @shine-Map_Glass_internal
		dc.w @short-Map_Glass_internal
@tall:		dc.w $C
		dc.b $B8, $C, 0, 0, $FF, $E0	; tall block
		dc.b $B8, $C, 8, 0, $00, 0
		dc.b $C0, $F, 0, 4, $FF, $E0
		dc.b $C0, $F, 8, 4, $00, 0
		dc.b $E0, $F, 0, 4, $FF, $E0
		dc.b $E0, $F, 8, 4, $00, 0
		dc.b 0,	$F, 0, 4, $FF, $E0
		dc.b 0,	$F, 8, 4, $00, 0
		dc.b $20, $F, 0, 4, $FF, $E0
		dc.b $20, $F, 8, 4, $00, 0
		dc.b $40, $C, $10, 0, $FF, $E0
		dc.b $40, $C, $18, 0, $00, 0
@shine:		dc.w 2
		dc.b 8,	6, 0, $14, $FF, $F0	; reflected shine on block
		dc.b 0,	6, 0, $14, $00, 0
@short:		dc.w $A
		dc.b $C8, $C, 0, 0, $FF, $E0	; short block
		dc.b $C8, $C, 8, 0, $00, 0
		dc.b $D0, $F, 0, 4, $FF, $E0
		dc.b $D0, $F, 8, 4, $00, 0
		dc.b $F0, $F, 0, 4, $FF, $E0
		dc.b $F0, $F, 8, 4, $00, 0
		dc.b $10, $F, 0, 4, $FF, $E0
		dc.b $10, $F, 8, 4, $00, 0
		dc.b $30, $C, $10, 0, $FF, $E0
		dc.b $30, $C, $18, 0, $00, 0
		even