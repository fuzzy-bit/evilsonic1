; ---------------------------------------------------------------------------
; Sprite mappings - special stage breakable glass blocks and red-white blocks
; ---------------------------------------------------------------------------
Map_SS_Glass_internal:
		dc.w byte_1B928-Map_SS_Glass_internal
		dc.w byte_1B92E-Map_SS_Glass_internal
		dc.w byte_1B934-Map_SS_Glass_internal
		dc.w byte_1B93A-Map_SS_Glass_internal
byte_1B928:	dc.w 1
		dc.b $F4, $A, 0, 0, $FF, $F4
byte_1B92E:	dc.w 1
		dc.b $F4, $A, 8, 0, $FF, $F4
byte_1B934:	dc.w 1
		dc.b $F4, $A, $18, 0, $FF, $F4
byte_1B93A:	dc.w 1
		dc.b $F4, $A, $10, 0, $FF, $F4
		even