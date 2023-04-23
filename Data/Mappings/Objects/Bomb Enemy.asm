; ---------------------------------------------------------------------------
; Sprite mappings - walking bomb enemy (SLZ, SBZ)
; ---------------------------------------------------------------------------
Map_Bomb_internal:
		dc.w @stand1-Map_Bomb_internal
		dc.w @stand2-Map_Bomb_internal
		dc.w @walk1-Map_Bomb_internal
		dc.w @walk2-Map_Bomb_internal
		dc.w @walk3-Map_Bomb_internal
		dc.w @walk4-Map_Bomb_internal
		dc.w @activate1-Map_Bomb_internal
		dc.w @activate2-Map_Bomb_internal
		dc.w @fuse1-Map_Bomb_internal
		dc.w @fuse2-Map_Bomb_internal
		dc.w @shrapnel1-Map_Bomb_internal
		dc.w @shrapnel2-Map_Bomb_internal
@stand1:	dc.w 3
		dc.b $F1, $A, 0, 0, $FF, $F4	; bomb standing still
		dc.b 9,	8, 0, $12, $FF, $F4
		dc.b $E7, 1, 0,	$21, $FF, $FC
@stand2:	dc.w 3
		dc.b $F1, $A, 0, 9, $FF, $F4
		dc.b 9,	8, 0, $12, $FF, $F4
		dc.b $E7, 1, 0,	$21, $FF, $FC
@walk1:		dc.b 3
		dc.b $F0, $A, 0, 0, $FF, $F4	; bomb walking
		dc.b 8,	8, 0, $15, $FF, $F4
		dc.b $E6, 1, 0,	$21, $FF, $FC
@walk2:		dc.b 3
		dc.b $F1, $A, 0, 9, $FF, $F4
		dc.b 9,	8, 0, $18, $FF, $F4
		dc.b $E7, 1, 0,	$21, $FF, $FC
@walk3:		dc.b 3
		dc.b $F0, $A, 0, 0, $FF, $F4
		dc.b 8,	8, 0, $1B, $FF, $F4
		dc.b $E6, 1, 0,	$21, $FF, $FC
@walk4:		dc.b 3
		dc.b $F1, $A, 0, 9, $FF, $F4
		dc.b 9,	8, 0, $1E, $FF, $F4
		dc.b $E7, 1, 0,	$21, $FF, $FC
@activate1:	dc.w 2
		dc.b $F1, $A, 0, 0, $FF, $F4	; bomb during detonation countdown
		dc.b 9,	8, 0, $12, $FF, $F4
@activate2:	dc.w 2
		dc.b $F1, $A, 0, 9, $FF, $F4
		dc.b 9,	8, 0, $12, $FF, $F4
@fuse1:		dc.b 1
		dc.b $E7, 1, 0,	$23, $FF, $FC ; fuse	(just before it	explodes)
@fuse2:		dc.b 1
		dc.b $E7, 1, 0,	$25, $FF, $FC
@shrapnel1:	dc.w 1
		dc.b $FC, 0, 0,	$27, $FF, $FC ; shrapnel (after it exploded)
@shrapnel2:	dc.w 1
		dc.b $FC, 0, 0,	$28, $FF, $FC
		even