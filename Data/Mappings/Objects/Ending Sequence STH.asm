; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC THE HEDGEHOG" text on the ending sequence
; ---------------------------------------------------------------------------
Map_ESth_internal:
		dc.w M_ESth_1-Map_ESth_internal
M_ESth_1:	dc.b 3
		dc.b $F0, $F, 0, 0, $FF, $D0
		dc.b $F0, $F, 0, $10, $FF, $F0
		dc.b $F0, $F, 0, $20, $00, $10
		even