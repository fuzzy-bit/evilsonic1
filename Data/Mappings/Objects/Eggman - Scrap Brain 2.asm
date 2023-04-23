; ---------------------------------------------------------------------------
; Sprite mappings - Eggman (SBZ2)
; ---------------------------------------------------------------------------
Map_SEgg_internal:
		dc.w @stand-Map_SEgg_internal
		dc.w @laugh1-Map_SEgg_internal
		dc.w @laugh2-Map_SEgg_internal
		dc.w @jump1-Map_SEgg_internal
		dc.w @jump2-Map_SEgg_internal
		dc.w @surprise-Map_SEgg_internal
		dc.w @starjump-Map_SEgg_internal
		dc.w @running1-Map_SEgg_internal
		dc.w @running2-Map_SEgg_internal
		dc.w @intube-Map_SEgg_internal
		dc.w @cockpit-Map_SEgg_internal
@stand:		dc.b 3
		dc.b $FC, 0, 0,	$8F, $FF, $E8
		dc.b $E8, $E, 0, 0, $FF, $F0
		dc.b 0,	$F, 0, $6F, $FF, $F0
@laugh1:	dc.w 4
		dc.b $E8, $D, 0, $E, $FF, $F0
		dc.b $E8, $E, 0, 0, $FF, $F0
		dc.b 0,	$F, 0, $6F, $FF, $F0
		dc.b $FC, 0, 0,	$8F, $FF, $E8
		dc.b 0
@laugh2:	dc.w 4
		dc.b $E9, $D, 0, $E, $FF, $F0
		dc.b $E9, $E, 0, 0, $FF, $F0
		dc.b 1,	$F, 0, $7F, $FF, $F0
		dc.b $FD, 0, 0,	$8F, $FF, $E8
		dc.b 0
@jump1:		dc.b 4
		dc.b $F4, $F, 8, $20, $FF, $F0
		dc.b $F5, 4, 8,	$30, $00, $10
		dc.b 8,	9, 8, $4E, $FF, $F0
		dc.b $EC, $E, 0, 0, $FF, $F0
		dc.b 0
@jump2:		dc.b 4
		dc.b $F0, $F, 8, $20, $FF, $F0
		dc.b $F1, 4, 8,	$30, $00, $10
		dc.b 8,	6, 8, $3E, $FF, $F8
		dc.b $E8, $E, 0, 0, $FF, $F0
		dc.b 0
@surprise:	dc.w 4
		dc.b $E8, $D, 0, $16, $FF, $EC
		dc.b $E8, 1, 0,	$1E, $00, $C
		dc.b $E8, $E, 0, 0, $FF, $F0
		dc.b 0,	$F, 0, $6F, $FF, $F0
		dc.b 0
@starjump:	dc.w 7
		dc.b $E8, $D, 0, $16, $FF, $EC
		dc.b $E8, 1, 0,	$1E, $00, $C
		dc.b 4,	9, 8, $34, $00, 0
		dc.b 4,	5, 8, $3A, $FF, $E8
		dc.b $F0, $F, 8, $20, $FF, $F0
		dc.b $F1, 4, 8,	$54, $00, $10
		dc.b $F1, 4, 0,	$54, $FF, $E0
@running1:	dc.w 5
		dc.b $F0, $F, 8, $20, $FF, $F0
		dc.b $F1, 4, 8,	$30, $00, $10
		dc.b 4,	9, 8, $34, $00, 0
		dc.b 4,	5, 8, $3A, $FF, $E8
		dc.b $E8, $E, 0, 0, $FF, $F0
@running2:	dc.w 6
		dc.b $EE, $F, 8, $20, $FF, $F0
		dc.b $EF, 4, 8,	$30, $00, $10
		dc.b 9,	5, 8, $44, $00, 0
		dc.b 3,	1, 8, $48, $FF, $F8
		dc.b $B, 5, 8, $4A, $FF, $E8
		dc.b $E6, $E, 0, 0, $FF, $F0
		dc.b 0
@intube:	dc.w 8
		dc.b $E8, $D, 0, $16, $FF, $EC ; Eggman inside tube in Final Zone
		dc.b $E8, 1, 0,	$1E, $00, $C
		dc.b $E8, $E, 0, 0, $FF, $F0
		dc.b 0,	$F, 0, $6F, $FF, $F0
		dc.b $E0, $D, $3E, $F0,	$FF, $F0
		dc.b $F0, $D, $3E, $F0,	$FF, $F0
		dc.b 0,	$D, $3E, $F0, $FF, $F0
		dc.b $10, $D, $3E, $F0,	$FF, $F0
@cockpit:	dc.w 3
		dc.b $EC, $D, 0, $56, $FF, $E4 ; empty cockpit of Eggmobile in Final Zone
		dc.b $F4, 8, 0,	$5E, $00, 4
		dc.b $EC, $D, 0, $61, $FF, $FC
		even