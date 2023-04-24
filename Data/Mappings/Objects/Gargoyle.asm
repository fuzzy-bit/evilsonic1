; ---------------------------------------------------------------------------
; Sprite mappings - gargoyle head (LZ)
; ---------------------------------------------------------------------------
Map_Gar_internal:
		dc.w @head-Map_Gar_internal
		dc.w @head-Map_Gar_internal
		dc.w @fireball1-Map_Gar_internal
		dc.w @fireball2-Map_Gar_internal
@head:		dc.w 3
		dc.b $F0, 4, 0,	0, $00, 0
		dc.b $F8, $D, 0, 2, $FF, $F0
		dc.b 8,	8, 0, $A, $FF, $F8
@fireball1:	dc.w 1
		dc.b $FC, 4, 0,	$D, $FF, $F8
@fireball2:	dc.w 1
		dc.b $FC, 4, 0,	$F, $FF, $F8
		even