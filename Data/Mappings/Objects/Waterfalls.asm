; ---------------------------------------------------------------------------
; Sprite mappings - waterfalls (LZ)
; ---------------------------------------------------------------------------
Map_WFall_internal:
		dc.w @vertnarrow-Map_WFall_internal
		dc.w @cornerwide-Map_WFall_internal
		dc.w @cornermedium-Map_WFall_internal
		dc.w @cornernarrow-Map_WFall_internal
		dc.w @cornermedium2-Map_WFall_internal
		dc.w @cornernarrow2-Map_WFall_internal
		dc.w @cornernarrow3-Map_WFall_internal
		dc.w @vertwide-Map_WFall_internal
		dc.w @diagonal-Map_WFall_internal
		dc.w @splash1-Map_WFall_internal
		dc.w @splash2-Map_WFall_internal
		dc.w @splash3-Map_WFall_internal
@vertnarrow:	dc.w 1
		dc.b $F0, 7, 0,	0, $FF, $F8
@cornerwide:	dc.w 2
		dc.b $F8, 4, 0,	8, $FF, $FC
		dc.b 0,	8, 0, $A, $FF, $F4
@cornermedium:	dc.w 2
		dc.b $F8, 0, 0,	8, $00, 0
		dc.b 0,	4, 0, $D, $FF, $F8
@cornernarrow:	dc.w 1
		dc.b $F8, 1, 0,	$F, $00, 0
@cornermedium2:	dc.w 2
		dc.b $F8, 0, 0,	8, $00, 0
		dc.b 0,	4, 0, $D, $FF, $F8
@cornernarrow2:	dc.w 1
		dc.b $F8, 1, 0,	$11, $00, 0
@cornernarrow3:	dc.w 1
		dc.b $F8, 1, 0,	$13, $00, 0
@vertwide:	dc.w 1
		dc.b $F0, 7, 0,	$15, $FF, $F8
@diagonal:	dc.w 2
		dc.b $F8, $C, 0, $1D, $FF, $F6
		dc.b 0,	$C, 0, $21, $FF, $E8
@splash1:	dc.w 2
		dc.b $F0, $B, 0, $25, $FF, $E8
		dc.b $F0, $B, 0, $31, $00, 0
@splash2:	dc.w 2
		dc.b $F0, $B, 0, $3D, $FF, $E8
		dc.b $F0, $B, 0, $49, $00, 0
@splash3:	dc.w 2
		dc.b $F0, $B, 0, $55, $FF, $E8
		dc.b $F0, $B, 0, $61, $00, 0
		even