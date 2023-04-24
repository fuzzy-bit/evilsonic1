; ---------------------------------------------------------------------------
; Sprite mappings - flapping door (LZ)
; ---------------------------------------------------------------------------
Map_Flap_internal:
		dc.w @closed-Map_Flap_internal
		dc.w @halfway-Map_Flap_internal
		dc.w @open-Map_Flap_internal
@closed:	dc.w 2
		dc.b $E0, 7, 0,	0, $FF, $F8
		dc.b 0,	7, $10,	0, $FF, $F8
@halfway:	dc.w 2
		dc.b $DA, $F, 0, 8, $FF, $FB
		dc.b 6,	$F, $10, 8, $FF, $FB
@open:		dc.w 2
		dc.b $D8, $D, 0, $18, $00, 0
		dc.b $18, $D, $10, $18,	$00, 0
		even