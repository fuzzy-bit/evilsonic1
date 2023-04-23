; ---------------------------------------------------------------------------
; Sprite mappings - vanishing platforms	(SBZ)
; ---------------------------------------------------------------------------
Map_VanP_internal:
		dc.w @whole-Map_VanP_internal
		dc.w @half-Map_VanP_internal
		dc.w @quarter-Map_VanP_internal
		dc.w @gone-Map_VanP_internal
@whole:		dc.w 1
		dc.b $F8, $F, 0, 0, $FF, $F0
@half:		dc.w 1
		dc.b $F8, 7, 0,	$10, $FF, $F8
@quarter:	dc.w 1
		dc.b $F8, 3, 0,	$18, $FF, $FC
@gone:		dc.w 0
		even