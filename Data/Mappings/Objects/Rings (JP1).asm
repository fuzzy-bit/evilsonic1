; ---------------------------------------------------------------------------
; Sprite mappings - rings
; ---------------------------------------------------------------------------
Map_Ring_internal:
		dc.w @front-Map_Ring_internal
		dc.w @angle1-Map_Ring_internal
		dc.w @edge-Map_Ring_internal
		dc.w @angle2-Map_Ring_internal
		dc.w @sparkle1-Map_Ring_internal
		dc.w @sparkle2-Map_Ring_internal
		dc.w @sparkle3-Map_Ring_internal
		dc.w @sparkle4-Map_Ring_internal
		dc.w @blank-Map_Ring_internal
@front:		dc.w 1
		dc.b $F8, 5, 0,	0, $FF, $F8	; ring front
@angle1:	dc.w 1
		dc.b $F8, 5, 0,	4, $FF, $F8	; ring angle
@edge:		dc.w 1
		dc.b $F8, 1, 0,	8, $FF, $FC	; ring perpendicular
@angle2:	dc.w 1
		dc.b $F8, 5, 8,	4, $FF, $F8	; ring angle
@sparkle1:	dc.w 1
		dc.b $F8, 5, 0,	$A, $FF, $F8	; sparkle
@sparkle2:	dc.w 1
		dc.b $F8, 5, $18, $A, $FF, $F8 ; sparkle
@sparkle3:	dc.w 1
		dc.b $F8, 5, 8,	$A, $FF, $F8	;sparkle
@sparkle4:	dc.w 1
		dc.b $F8, 5, $10, $A, $FF, $F8 ; sparkle
@blank:		dc.w 0
		even