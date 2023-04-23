; ---------------------------------------------------------------------------
; Sprite mappings - smashable green block (MZ)
; ---------------------------------------------------------------------------
Map_Smab_internal:
		dc.w @two-Map_Smab_internal
		dc.w @four-Map_Smab_internal
@two:		dc.w 2
		dc.b $F0, $D, 0, 0, $FF, $F0	; two fragments, arranged vertically
		dc.b 0,	$D, 0, 0, $FF, $F0
@four:		dc.w 4
		dc.b $F0, 5, $80, 0, $FF, $F0 ; four fragments
		dc.b 0,	5, $80,	0, $FF, $F0
		dc.b $F0, 5, $80, 0, $00, 0
		dc.b 0,	5, $80,	0, $00, 0
		even