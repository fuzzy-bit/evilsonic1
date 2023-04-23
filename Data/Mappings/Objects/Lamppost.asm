; ---------------------------------------------------------------------------
; Sprite mappings - lamppost
; ---------------------------------------------------------------------------
Map_Lamp_internal:
		dc.w @blue-Map_Lamp_internal
		dc.w @poleonly-Map_Lamp_internal
		dc.w @redballonly-Map_Lamp_internal
		dc.w @red-Map_Lamp_internal
@blue:		dc.w 6
		dc.b $E4, 1, 0,	0, $FF, $F8
		dc.b $E4, 1, 8,	0, $00, 0
		dc.b $F4, 3, $20, 2, $FF, $F8
		dc.b $F4, 3, $28, 2, $00, 0
		dc.b $D4, 1, 0,	6, $FF, $F8
		dc.b $D4, 1, 8,	6, $00, 0
@poleonly:	dc.w 4
		dc.b $E4, 1, 0,	0, $FF, $F8
		dc.b $E4, 1, 8,	0, $00, 0
		dc.b $F4, 3, $20, 2, $FF, $F8
		dc.b $F4, 3, $28, 2, $00, 0
@redballonly:	dc.w 2
		dc.b $F8, 1, 0,	8, $FF, $F8
		dc.b $F8, 1, 8,	8, $00, 0
@red:		dc.w 6
		dc.b $E4, 1, 0,	0, $FF, $F8
		dc.b $E4, 1, 8,	0, $00, 0
		dc.b $F4, 3, $20, 2, $FF, $F8
		dc.b $F4, 3, $28, 2, $00, 0
		dc.b $D4, 1, 0,	8, $FF, $F8
		dc.b $D4, 1, 8,	8, $00, 0
		even