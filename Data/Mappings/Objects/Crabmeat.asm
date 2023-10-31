; ---------------------------------------------------------------------------
; Sprite mappings - Crabmeat enemy (GHZ, SYZ)
; ---------------------------------------------------------------------------
Map_Crab_internal:
		dc.w @stand-Map_Crab_internal
		dc.w @walk-Map_Crab_internal
		dc.w @slope1-Map_Crab_internal
		dc.w @slope2-Map_Crab_internal
		dc.w @firing-Map_Crab_internal
		dc.w @ball1-Map_Crab_internal
		dc.w @ball2-Map_Crab_internal
@stand:		dc.w 4
		dc.b $F0, 9, 0,	0, $FF, $E8	; standing/middle walking frame
		dc.b $F0, 9, 8,	0, $00, 0
		dc.b 0,	5, 0, 6, $FF, $F0
		dc.b 0,	5, 8, 6, $00, 0
@walk:		dc.w 4
		dc.b $F0, 9, 0,	$A, $FF, $E8	; walking
		dc.b $F0, 9, 0,	$10, $00, 0
		dc.b 0,	5, 0, $16, $FF, $F0
		dc.b 0,	9, 0, $1A, $00, 0
@slope1:	dc.w 4
		dc.b $EC, 9, 0,	0, $FF, $E8	; walking on slope
		dc.b $EC, 9, 8,	0, $00, 0
		dc.b $FC, 5, 8,	6, $00, 0
		dc.b $FC, 6, 0,	$20, $FF, $F0
@slope2:	dc.w 4
		dc.b $EC, 9, 0,	$A, $FF, $E8	; walking on slope
		dc.b $EC, 9, 0,	$10, $00, 0
		dc.b $FC, 9, 0,	$26, $00, 0
		dc.b $FC, 6, 0,	$2C, $FF, $F0
@firing:	dc.w 6
		dc.b $F0, 4, 0,	$32, $FF, $F0 ; firing projectiles
		dc.b $F0, 4, 8,	$32, $00, 0
		dc.b $F8, 9, 0,	$34, $FF, $E8
		dc.b $F8, 9, 8,	$34, $00, 0
		dc.b 8,	4, 0, $3A, $FF, $F0
		dc.b 8,	4, 8, $3A, $00, 0
@ball1:		dc.w 1
		dc.b $F8, 5, 0,	$3C, $FF, $F8 ; projectile
@ball2:		dc.w 1
		dc.b $F8, 5, 0,	$40, $FF, $F8 ; projectile
		even