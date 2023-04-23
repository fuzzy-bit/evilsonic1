; ---------------------------------------------------------------------------
; Sprite mappings - missile that Buzz Bomber throws
; ---------------------------------------------------------------------------
Map_Missile_internal:
		dc.w @Flare1-Map_Missile_internal
		dc.w @Flare2-Map_Missile_internal
		dc.w @Ball1-Map_Missile_internal
		dc.w @Ball2-Map_Missile_internal
@Flare1:	dc.w 1
		dc.b $F8, 5, 0,	$24, $FF, $F8 ; buzz bomber firing flare
@Flare2:	dc.w 1
		dc.b $F8, 5, 0,	$28, $FF, $F8
@Ball1:		dc.w 1
		dc.b $F8, 5, 0,	$2C, $FF, $F8 ; missile itself
@Ball2:		dc.w 1
		dc.b $F8, 5, 0,	$33, $FF, $F8
		even