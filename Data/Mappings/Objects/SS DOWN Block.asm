; ---------------------------------------------------------------------------
; Sprite mappings - special stage "DOWN" block
; ---------------------------------------------------------------------------
Map_SS_Down_internal:
		dc.w byte_1B954-Map_SS_Down_internal
		dc.w byte_1B95A-Map_SS_Down_internal
byte_1B954:	dc.w 1
		dc.b $F4, $A, 0, 9, $FF, $F4
byte_1B95A:	dc.w 1
		dc.b $F4, $A, 0, $12, $FF, $F4
		even