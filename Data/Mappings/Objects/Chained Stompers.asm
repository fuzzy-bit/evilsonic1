; ---------------------------------------------------------------------------
; Sprite mappings - metal stomping blocks on chains (MZ)
; ---------------------------------------------------------------------------
Map_CStom_internal:
		dc.w @wideblock-Map_CStom_internal
		dc.w @spikes-Map_CStom_internal
		dc.w @ceiling-Map_CStom_internal
		dc.w @chain1-Map_CStom_internal
		dc.w @chain2-Map_CStom_internal
		dc.w @chain3-Map_CStom_internal
		dc.w @chain4-Map_CStom_internal
		dc.w @chain5-Map_CStom_internal
		dc.w @chain5-Map_CStom_internal
		dc.w @mediumblock-Map_CStom_internal
		dc.w @smallblock-Map_CStom_internal
@wideblock:	dc.w 5
		dc.b $F4, 6, 0,	0, $FF, $C8
		dc.b $F4, $A, 0, 6, $FF, $D8
		dc.b $EC, $F, 0, $F, $FF, $F0
		dc.b $F4, $A, 8, 6, $00, $10
		dc.b $F4, 6, 8,	0, $00, $28
@spikes:	dc.w 5
		dc.b $F0, 3, $12, $1F, $FF, $D4
		dc.b $F0, 3, $12, $1F, $FF, $E8
		dc.b $F0, 3, $12, $1F, $FF, $FC
		dc.b $F0, 3, $12, $1F, $00, $10
		dc.b $F0, 3, $12, $1F, $00, $24
@ceiling:	dc.w 1
		dc.b $DC, $F, $10, $F, $FF, $F0
@chain1:	dc.w 2
		dc.b 0,	1, 0, $3F, $FF, $FC
		dc.b $10, 1, 0,	$3F, $FF, $FC
@chain2:	dc.w 4
		dc.b $E0, 1, 0,	$3F, $FF, $FC
		dc.b $F0, 1, 0,	$3F, $FF, $FC
		dc.b 0,	1, 0, $3F, $FF, $FC
		dc.b $10, 1, 0,	$3F, $FF, $FC
@chain3:	dc.w 6
		dc.b $C0, 1, 0,	$3F, $FF, $FC
		dc.b $D0, 1, 0,	$3F, $FF, $FC
		dc.b $E0, 1, 0,	$3F, $FF, $FC
		dc.b $F0, 1, 0,	$3F, $FF, $FC
		dc.b 0,	1, 0, $3F, $FF, $FC
		dc.b $10, 1, 0,	$3F, $FF, $FC
@chain4:	dc.w 8
		dc.b $A0, 1, 0,	$3F, $FF, $FC
		dc.b $B0, 1, 0,	$3F, $FF, $FC
		dc.b $C0, 1, 0,	$3F, $FF, $FC
		dc.b $D0, 1, 0,	$3F, $FF, $FC
		dc.b $E0, 1, 0,	$3F, $FF, $FC
		dc.b $F0, 1, 0,	$3F, $FF, $FC
		dc.b 0,	1, 0, $3F, $FF, $FC
		dc.b $10, 1, 0,	$3F, $FF, $FC
@chain5:	dc.w $A
		dc.b $80, 1, 0,	$3F, $FF, $FC
		dc.b $90, 1, 0,	$3F, $FF, $FC
		dc.b $A0, 1, 0,	$3F, $FF, $FC
		dc.b $B0, 1, 0,	$3F, $FF, $FC
		dc.b $C0, 1, 0,	$3F, $FF, $FC
		dc.b $D0, 1, 0,	$3F, $FF, $FC
		dc.b $E0, 1, 0,	$3F, $FF, $FC
		dc.b $F0, 1, 0,	$3F, $FF, $FC
		dc.b 0,	1, 0, $3F, $FF, $FC
		dc.b $10, 1, 0,	$3F, $FF, $FC
@mediumblock:	dc.w 5
		dc.b $F4, 6, 0,	0, $FF, $D0
		dc.b $F4, $A, 0, 6, $FF, $E0
		dc.b $F4, $A, 8, 6, $00, 8
		dc.b $F4, 6, 8,	0, $00, $20
		dc.b $EC, $F, 0, $F, $FF, $F0
@smallblock:	dc.w 1
		dc.b $EC, $F, 0, $2F, $FF, $F0
		even
