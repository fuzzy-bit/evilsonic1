; ---------------------------------------------------------------------------
; Sprite mappings - SLZ	swinging platforms
; ---------------------------------------------------------------------------
Map_Swing_SLZ_internal:
		dc.w @block-Map_Swing_SLZ_internal
		dc.w @chain-Map_Swing_SLZ_internal
		dc.w @anchor-Map_Swing_SLZ_internal
@block:		dc.b 8
		dc.b $F0, $F, 0, 4, $FF, $E0
		dc.b $F0, $F, 8, 4, $00, 0
		dc.b $F0, 5, 0,	$14, $FF, $D0
		dc.b $F0, 5, 8,	$14, $00, $20
		dc.b $10, 4, 0,	$18, $FF, $E0
		dc.b $10, 4, 8,	$18, $00, $10
		dc.b $10, 1, 0,	$1A, $FF, $F8
		dc.b $10, 1, 8,	$1A, $00, 0
@chain:		dc.b 1
		dc.b $F8, 5, $40, 0, $FF, $F8
@anchor:	dc.w 1
		dc.b $F8, 5, 0,	$1C, $FF, $F8
		even