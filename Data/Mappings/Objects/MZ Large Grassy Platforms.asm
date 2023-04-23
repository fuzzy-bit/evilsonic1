; ---------------------------------------------------------------------------
; Sprite mappings - large moving grass-covered platforms (MZ)
; ---------------------------------------------------------------------------
Map_LGrass_internal:
		dc.w @wide-Map_LGrass_internal
		dc.w @sloped-Map_LGrass_internal
		dc.w @narrow-Map_LGrass_internal
@wide:		dc.b $D
		dc.b $D8, 6, 0,	$57, $FF, $C0 ; wide platform
		dc.b $F0, 5, 0,	$53, $FF, $C0
		dc.b 0,	$F, 0, 1, $FF, $C0
		dc.b $D0, $F, 0, $27, $FF, $D0
		dc.b $F0, $D, 0, $37, $FF, $D0
		dc.b $F0, $F, 0, 1, $FF, $E0
		dc.b $D0, $F, 0, $11, $FF, $F0
		dc.b $D0, $F, 0, $3F, $10
		dc.b $F0, $D, 0, $4F, $10
		dc.b $F0, $F, 0, 1, $00, 0
		dc.b 0,	$F, 0, 1, $20
		dc.b $D8, 6, 0,	$57, $30
		dc.b $F0, 5, 0,	$53, $30
@sloped:	dc.b $A
		dc.b $D0, $F, 0, $27, $FF, $C0 ; sloped platform (catches fire)
		dc.b $F0, $D, 0, $37, $FF, $C0
		dc.b 0,	$F, 0, 1, $FF, $C0
		dc.b $C0, $F, 0, $27, $FF, $E0
		dc.b $E0, $D, 0, $37, $FF, $E0
		dc.b $F0, $F, 0, 1, $FF, $E0
		dc.b $C0, $F, 0, $11, $00, 0
		dc.b $E0, $F, 0, 1, $00, 0
		dc.b $C0, $F, 0, $3F, $20
		dc.b $E0, $D, 0, $4F, $20
@narrow:	dc.b 6
		dc.b $D0, $F, 0, $11, $FF, $E0 ; narrow platform
		dc.b $F0, $F, 0, 1, $FF, $E0
		dc.b $10, $F, 0, 1, $FF, $E0
		dc.b $D0, $F, 0, $11, $00, 0
		dc.b $F0, $F, 0, 1, $00, 0
		dc.b $10, $F, 0, 1, $00, 0
		even