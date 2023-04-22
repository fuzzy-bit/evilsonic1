; ---------------------------------------------------------------------------
; Sprite mappings - buzz bomber missile vanishing
; ---------------------------------------------------------------------------
Map_MisDissolve_internal:
		dc.w byte_8EAE-Map_MisDissolve_internal
		dc.w byte_8EB4-Map_MisDissolve_internal
		dc.w byte_8EBA-Map_MisDissolve_internal
		dc.w byte_8EC0-Map_MisDissolve_internal
byte_8EAE:	dc.b 1
		dc.b $F4, $A, 0, 0, $FF, $F4
byte_8EB4:	dc.b 1
		dc.b $F4, $A, 0, 9, $FF, $F4
byte_8EBA:	dc.b 1
		dc.b $F4, $A, 0, $12, $FF, $F4
byte_8EC0:	dc.b 1
		dc.b $F4, $A, 0, $1B, $FF, $F4
		even