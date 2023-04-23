; ---------------------------------------------------------------------------
; Sprite mappings - doors (SBZ)
; ---------------------------------------------------------------------------
Map_ADoor_internal:
		dc.w @closed-Map_ADoor_internal
		dc.w @01-Map_ADoor_internal
		dc.w @02-Map_ADoor_internal
		dc.w @03-Map_ADoor_internal
		dc.w @04-Map_ADoor_internal
		dc.w @05-Map_ADoor_internal
		dc.w @06-Map_ADoor_internal
		dc.w @07-Map_ADoor_internal
		dc.w @open-Map_ADoor_internal
@closed:	dc.w 2
		dc.b $E0, 7, 8,	0, $FF, $F8	; door closed
		dc.b 0,	7, 8, 0, $FF, $F8
@01:		dc.w 2
		dc.b $DC, 7, 8,	0, $FF, $F8
		dc.b 4,	7, 8, 0, $FF, $F8
@02:		dc.w 2
		dc.b $D8, 7, 8,	0, $FF, $F8
		dc.b 8,	7, 8, 0, $FF, $F8
@03:		dc.w 2
		dc.b $D4, 7, 8,	0, $FF, $F8
		dc.b $C, 7, 8, 0, $FF, $F8
@04:		dc.w 2
		dc.b $D0, 7, 8,	0, $FF, $F8
		dc.b $10, 7, 8,	0, $FF, $F8
@05:		dc.w 2
		dc.b $CC, 7, 8,	0, $FF, $F8
		dc.b $14, 7, 8,	0, $FF, $F8
@06:		dc.w 2
		dc.b $C8, 7, 8,	0, $FF, $F8
		dc.b $18, 7, 8,	0, $FF, $F8
@07:		dc.w 2
		dc.b $C4, 7, 8,	0, $FF, $F8
		dc.b $1C, 7, 8,	0, $FF, $F8
@open:		dc.w 2
		dc.b $C0, 7, 8,	0, $FF, $F8	; door fully open
		dc.b $20, 7, 8,	0, $FF, $F8
		even