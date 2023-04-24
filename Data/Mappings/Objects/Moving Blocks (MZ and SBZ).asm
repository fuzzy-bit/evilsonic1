; ---------------------------------------------------------------------------
; Sprite mappings - moving blocks (MZ, SBZ)
; ---------------------------------------------------------------------------
Map_MBlock_internal:
		dc.w @mz1-Map_MBlock_internal
		dc.w @mz2-Map_MBlock_internal
		dc.w @sbz-Map_MBlock_internal
		dc.w @sbzwide-Map_MBlock_internal
		dc.w @mz3-Map_MBlock_internal
@mz1:		dc.w 1
		dc.b $F8, $F, 0, 8, $FF, $F0
@mz2:		dc.w 2
		dc.b $F8, $F, 0, 8, $FF, $E0
		dc.b $F8, $F, 0, 8, $00, 0
@sbz:		dc.w 4
		dc.b $F8, $C, $20, 0, $FF, $E0
		dc.b 0,	$D, 0, 4, $FF, $E0
		dc.b $F8, $C, $20, 0, $00, 0
		dc.b 0,	$D, 0, 4, $00, 0
@sbzwide:	dc.w 4
		dc.b $F8, $E, 0, 0, $FF, $C0
		dc.b $F8, $E, 0, 3, $FF, $E0
		dc.b $F8, $E, 0, 3, $00, 0
		dc.b $F8, $E, 8, 0, $00, $20
@mz3:		dc.w 3
		dc.b $F8, $F, 0, 8, $FF, $D0
		dc.b $F8, $F, 0, 8, $FF, $F0
		dc.b $F8, $F, 0, 8, $00, $10
		even