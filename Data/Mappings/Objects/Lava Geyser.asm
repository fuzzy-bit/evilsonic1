; ---------------------------------------------------------------------------
; Sprite mappings - lava geyser / lava that falls from the ceiling (MZ)
; ---------------------------------------------------------------------------
Map_Geyser_internal:
		dc.w @bubble1-Map_Geyser_internal
		dc.w @bubble2-Map_Geyser_internal
		dc.w @bubble3-Map_Geyser_internal
		dc.w @bubble4-Map_Geyser_internal
		dc.w @bubble5-Map_Geyser_internal
		dc.w @bubble6-Map_Geyser_internal
		dc.w @end1-Map_Geyser_internal
		dc.w @end2-Map_Geyser_internal
		dc.w @medcolumn1-Map_Geyser_internal
		dc.w @medcolumn2-Map_Geyser_internal
		dc.w @medcolumn3-Map_Geyser_internal
		dc.w @shortcolumn1-Map_Geyser_internal
		dc.w @shortcolumn2-Map_Geyser_internal
		dc.w @shortcolumn3-Map_Geyser_internal
		dc.w @longcolumn1-Map_Geyser_internal
		dc.w @longcolumn2-Map_Geyser_internal
		dc.w @longcolumn3-Map_Geyser_internal
		dc.w @bubble7-Map_Geyser_internal
		dc.w @bubble8-Map_Geyser_internal
		dc.w @blank-Map_Geyser_internal
@bubble1:	dc.w 2
		dc.b $EC, $B, 0, 0, $FF, $E8
		dc.b $EC, $B, 8, 0, $00, 0
@bubble2:	dc.w 2
		dc.b $EC, $B, 0, $18, $FF, $E8
		dc.b $EC, $B, 8, $18, $00, 0
@bubble3:	dc.w 4
		dc.b $EC, $B, 0, 0, $FF, $C8
		dc.b $F4, $E, 0, $C, $FF, $E0
		dc.b $F4, $E, 8, $C, $00, 0
		dc.b $EC, $B, 8, 0, $00, $20
@bubble4:	dc.w 4
		dc.b $EC, $B, 0, $18, $FF, $C8
		dc.b $F4, $E, 0, $24, $FF, $E0
		dc.b $F4, $E, 8, $24, $00, 0
		dc.b $EC, $B, 8, $18, $00, $20
@bubble5:	dc.w 6
		dc.b $EC, $B, 0, 0, $FF, $C8
		dc.b $F4, $E, 0, $C, $FF, $E0
		dc.b $F4, $E, 8, $C, $00, 0
		dc.b $EC, $B, 8, 0, $00, $20
		dc.b $E8, $E, 0, $90, $FF, $E0
		dc.b $E8, $E, 8, $90, $00, 0
@bubble6:	dc.w 6
		dc.b $EC, $B, 0, $18, $FF, $C8
		dc.b $F4, $E, 0, $24, $FF, $E0
		dc.b $F4, $E, 8, $24, $00, 0
		dc.b $EC, $B, 8, $18, $00, $20
		dc.b $E8, $E, 8, $90, $FF, $E0
		dc.b $E8, $E, 0, $90, $00, 0
@end1:		dc.w 2
		dc.b $E0, $F, 0, $30, $FF, $E0
		dc.b $E0, $F, 8, $30, $00, 0
@end2:		dc.w 2
		dc.b $E0, $F, 8, $30, $FF, $E0
		dc.b $E0, $F, 0, $30, $00, 0
@medcolumn1:	dc.w $A
		dc.b $90, $F, 0, $40, $FF, $E0
		dc.b $90, $F, 8, $40, $00, 0
		dc.b $B0, $F, 0, $40, $FF, $E0
		dc.b $B0, $F, 8, $40, $00, 0
		dc.b $D0, $F, 0, $40, $FF, $E0
		dc.b $D0, $F, 8, $40, $00, 0
		dc.b $F0, $F, 0, $40, $FF, $E0
		dc.b $F0, $F, 8, $40, $00, 0
		dc.b $10, $F, 0, $40, $FF, $E0
		dc.b $10, $F, 8, $40, $00, 0
@medcolumn2:	dc.w $A
		dc.b $90, $F, 0, $50, $FF, $E0
		dc.b $90, $F, 8, $50, $00, 0
		dc.b $B0, $F, 0, $50, $FF, $E0
		dc.b $B0, $F, 8, $50, $00, 0
		dc.b $D0, $F, 0, $50, $FF, $E0
		dc.b $D0, $F, 8, $50, $00, 0
		dc.b $F0, $F, 0, $50, $FF, $E0
		dc.b $F0, $F, 8, $50, $00, 0
		dc.b $10, $F, 0, $50, $FF, $E0
		dc.b $10, $F, 8, $50, $00, 0
@medcolumn3:	dc.w $A
		dc.b $90, $F, 0, $60, $FF, $E0
		dc.b $90, $F, 8, $60, $00, 0
		dc.b $B0, $F, 0, $60, $FF, $E0
		dc.b $B0, $F, 8, $60, $00, 0
		dc.b $D0, $F, 0, $60, $FF, $E0
		dc.b $D0, $F, 8, $60, $00, 0
		dc.b $F0, $F, 0, $60, $FF, $E0
		dc.b $F0, $F, 8, $60, $00, 0
		dc.b $10, $F, 0, $60, $FF, $E0
		dc.b $10, $F, 8, $60, $00, 0
@shortcolumn1:	dc.w 6
		dc.b $90, $F, 0, $40, $FF, $E0
		dc.b $90, $F, 8, $40, $00, 0
		dc.b $B0, $F, 0, $40, $FF, $E0
		dc.b $B0, $F, 8, $40, $00, 0
		dc.b $D0, $F, 0, $40, $FF, $E0
		dc.b $D0, $F, 8, $40, $00, 0
@shortcolumn2:	dc.w 6
		dc.b $90, $F, 0, $50, $FF, $E0
		dc.b $90, $F, 8, $50, $00, 0
		dc.b $B0, $F, 0, $50, $FF, $E0
		dc.b $B0, $F, 8, $50, $00, 0
		dc.b $D0, $F, 0, $50, $FF, $E0
		dc.b $D0, $F, 8, $50, $00, 0
@shortcolumn3:	dc.w 6
		dc.b $90, $F, 0, $60, $FF, $E0
		dc.b $90, $F, 8, $60, $00, 0
		dc.b $B0, $F, 0, $60, $FF, $E0
		dc.b $B0, $F, 8, $60, $00, 0
		dc.b $D0, $F, 0, $60, $FF, $E0
		dc.b $D0, $F, 8, $60, $00, 0
@longcolumn1:	dc.w $10
		dc.b $90, $F, 0, $40, $FF, $E0
		dc.b $90, $F, 8, $40, $00, 0
		dc.b $B0, $F, 0, $40, $FF, $E0
		dc.b $B0, $F, 8, $40, $00, 0
		dc.b $D0, $F, 0, $40, $FF, $E0
		dc.b $D0, $F, 8, $40, $00, 0
		dc.b $F0, $F, 0, $40, $FF, $E0
		dc.b $F0, $F, 8, $40, $00, 0
		dc.b $10, $F, 0, $40, $FF, $E0
		dc.b $10, $F, 8, $40, $00, 0
		dc.b $30, $F, 0, $40, $FF, $E0
		dc.b $30, $F, 8, $40, $00, 0
		dc.b $50, $F, 0, $40, $FF, $E0
		dc.b $50, $F, 8, $40, $00, 0
		dc.b $70, $F, 0, $40, $FF, $E0
		dc.b $70, $F, 8, $40, $00, 0
@longcolumn2:	dc.w $10
		dc.b $90, $F, 0, $50, $FF, $E0
		dc.b $90, $F, 8, $50, $00, 0
		dc.b $B0, $F, 0, $50, $FF, $E0
		dc.b $B0, $F, 8, $50, $00, 0
		dc.b $D0, $F, 0, $50, $FF, $E0
		dc.b $D0, $F, 8, $50, $00, 0
		dc.b $F0, $F, 0, $50, $FF, $E0
		dc.b $F0, $F, 8, $50, $00, 0
		dc.b $10, $F, 0, $50, $FF, $E0
		dc.b $10, $F, 8, $50, $00, 0
		dc.b $30, $F, 0, $50, $FF, $E0
		dc.b $30, $F, 8, $50, $00, 0
		dc.b $50, $F, 0, $50, $FF, $E0
		dc.b $50, $F, 8, $50, $00, 0
		dc.b $70, $F, 0, $50, $FF, $E0
		dc.b $70, $F, 8, $50, $00, 0
@longcolumn3:	dc.w $10
		dc.b $90, $F, 0, $60, $FF, $E0
		dc.b $90, $F, 8, $60, $00, 0
		dc.b $B0, $F, 0, $60, $FF, $E0
		dc.b $B0, $F, 8, $60, $00, 0
		dc.b $D0, $F, 0, $60, $FF, $E0
		dc.b $D0, $F, 8, $60, $00, 0
		dc.b $F0, $F, 0, $60, $FF, $E0
		dc.b $F0, $F, 8, $60, $00, 0
		dc.b $10, $F, 0, $60, $FF, $E0
		dc.b $10, $F, 8, $60, $00, 0
		dc.b $30, $F, 0, $60, $FF, $E0
		dc.b $30, $F, 8, $60, $00, 0
		dc.b $50, $F, 0, $60, $FF, $E0
		dc.b $50, $F, 8, $60, $00, 0
		dc.b $70, $F, 0, $60, $FF, $E0
		dc.b $70, $F, 8, $60, $00, 0
@bubble7:	dc.w 6
		dc.b $E0, $B, 0, 0, $FF, $C8
		dc.b $E8, $E, 0, $C, $FF, $E0
		dc.b $E8, $E, 8, $C, $00, 0
		dc.b $E0, $B, 8, 0, $00, $20
		dc.b $D8, $E, 0, $90, $FF, $E0
		dc.b $D8, $E, 8, $90, $00, 0
@bubble8:	dc.w 6
		dc.b $E0, $B, 0, $18, $FF, $C8
		dc.b $E8, $E, 0, $24, $FF, $E0
		dc.b $E8, $E, 8, $24, $00, 0
		dc.b $E0, $B, 8, $18, $00, $20
		dc.b $D8, $E, 8, $90, $FF, $E0
		dc.b $D8, $E, 0, $90, $00, 0
@blank:	dc.w 0
		even