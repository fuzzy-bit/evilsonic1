; ---------------------------------------------------------------------------
; Sprite mappings - unused
; ---------------------------------------------------------------------------
Map_Plat_Unused_internal:
		dc.w @small-Map_Plat_Unused_internal
		dc.w @large-Map_Plat_Unused_internal
@small:		dc.w 2
		dc.b $F4, $B, 0, $3C, $FF, $E8
		dc.b $F4, $B, 0, $48, $00, 0
@large:		dc.w $A
		dc.b $F4, $F, 0, $CA, $FF, $E0
		dc.b 4,	$F, 0, $DA, $FF, $E0
		dc.b $24, $F, 0, $DA, $FF, $E0
		dc.b $44, $F, 0, $DA, $FF, $E0
		dc.b $64, $F, 0, $DA, $FF, $E0
		dc.b $F4, $F, 8, $CA, $00, 0
		dc.b 4,	$F, 8, $DA, $00, 0
		dc.b $24, $F, 8, $DA, $00, 0
		dc.b $44, $F, 8, $DA, $00, 0
		dc.b $64, $F, 8, $DA, $00, 0
		even