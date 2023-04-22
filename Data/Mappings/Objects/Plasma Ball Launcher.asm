; ---------------------------------------------------------------------------
; Sprite mappings - energy ball	launcher (FZ)
; ---------------------------------------------------------------------------
Map_PLaunch_internal:
		dc.w @red-Map_PLaunch_internal
		dc.w @white-Map_PLaunch_internal
		dc.w @sparking1-Map_PLaunch_internal
		dc.w @sparking2-Map_PLaunch_internal
@red:		dc.b 1
		dc.b $F8, 5, 0,	$6E, $FF, $F8
@white:		dc.b 1
		dc.b $F8, 5, 0,	$76, $FF, $F8
@sparking1:	dc.b 1
		dc.b $F8, 5, 0,	$72, $FF, $F8
@sparking2:	dc.b 1
		dc.b $F8, 5, $10, $72, $FF, $F8
		even