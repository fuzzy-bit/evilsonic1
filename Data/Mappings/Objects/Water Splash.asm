; ---------------------------------------------------------------------------
; Sprite mappings - water splash (LZ)
; ---------------------------------------------------------------------------
Map_Splash_internal:
		dc.w @splash1-Map_Splash_internal
		dc.w @splash2-Map_Splash_internal
		dc.w @splash3-Map_Splash_internal
@splash1:	dc.w 2
		dc.b $F2, 4, 0,	$6D, $FF, $F8
		dc.b $FA, $C, 0, $6F, $FF, $F0
@splash2:	dc.w 2
		dc.b $E2, 0, 0,	$73, $FF, $F8
		dc.b $EA, $E, 0, $74, $FF, $F0
@splash3:	dc.w 1
		dc.b $E2, $F, 0, $80, $FF, $F0
		even