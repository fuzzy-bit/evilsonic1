; ---------------------------------------------------------------------------
; Sprite mappings - prison capsule
; ---------------------------------------------------------------------------
Map_Pri_internal:
		dc.w @capsule-Map_Pri_internal
		dc.w @switch1-Map_Pri_internal
		dc.w @broken-Map_Pri_internal
		dc.w @switch2-Map_Pri_internal
		dc.w @unusedthing1-Map_Pri_internal
		dc.w @unusedthing2-Map_Pri_internal
		dc.w @blank-Map_Pri_internal
@capsule:	dc.w 7
		dc.b $E0, $C, $20, 0, $FF, $F0
		dc.b $E8, $D, $20, 4, $FF, $E0
		dc.b $E8, $D, $20, $C, $00, 0
		dc.b $F8, $E, $20, $14,	$FF, $E0
		dc.b $F8, $E, $20, $20,	$00, 0
		dc.b $10, $D, $20, $2C,	$FF, $E0
		dc.b $10, $D, $20, $34,	$00, 0
@switch1:	dc.w 1
		dc.b $F8, 9, 0,	$3C, $FF, $F4
@broken:	dc.w 6
		dc.b 0,	8, $20,	$42, $FF, $E0
		dc.b 8,	$C, $20, $45, $FF, $E0
		dc.b 0,	4, $20,	$49, $00, $10
		dc.b 8,	$C, $20, $4B, $00, 0
		dc.b $10, $D, $20, $2C,	$FF, $E0
		dc.b $10, $D, $20, $34,	$00, 0
@switch2:	dc.w 1
		dc.b $F8, 9, 0,	$4F, $FF, $F4
@unusedthing1:	dc.w 2
		dc.b $E8, $E, $20, $55,	$FF, $F0
		dc.b 0,	$E, $20, $61, $FF, $F0
@unusedthing2:	dc.w 1
		dc.b $F0, 7, $20, $6D, $FF, $F8
@blank:		dc.b 0
		even