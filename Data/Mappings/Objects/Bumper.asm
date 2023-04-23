; ---------------------------------------------------------------------------
; Sprite mappings - pinball bumper (SYZ)
; ---------------------------------------------------------------------------
Map_Bump_internal:
		dc.w @normal-Map_Bump_internal
		dc.w @bumped1-Map_Bump_internal
		dc.w @bumped2-Map_Bump_internal
@normal:	dc.w 2
		dc.b $F0, 7, 0,	0, $FF, $F0
		dc.b $F0, 7, 8,	0, $00, 0
@bumped1:	dc.w 2
		dc.b $F4, 6, 0,	8, $FF, $F4
		dc.b $F4, 2, 8,	8, $00, 4
@bumped2:	dc.w 2
		dc.b $F0, 7, 0,	$E, $FF, $F0
		dc.b $F0, 7, 8,	$E, $00, 0
		even