; ---------------------------------------------------------------------------
; Sprite mappings - electrocution orbs (SBZ)
; ---------------------------------------------------------------------------
Map_Elec_internal:
		dc.w @normal-Map_Elec_internal
		dc.w @zap1-Map_Elec_internal
		dc.w @zap2-Map_Elec_internal
		dc.w @zap3-Map_Elec_internal
		dc.w @zap4-Map_Elec_internal
		dc.w @zap5-Map_Elec_internal
@normal:	dc.w 2
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
@zap1:		dc.w 3
		dc.b $F8, 5, 0,	8, $FF, $F8
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
@zap2:		dc.w 5
		dc.b $F8, 5, 0,	8, $FF, $F8
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
		dc.b $F6, $D, 0, $C, $00, 8
		dc.b $F6, $D, 8, $C, $FF, $DC
@zap3:		dc.w 4
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
		dc.b $F6, $D, 0, $C, $00, 8
		dc.b $F6, $D, 8, $C, $FF, $DC
@zap4:		dc.w 6
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
		dc.b $F6, $D, $10, $C, $00, 8
		dc.b $F6, $D, $18, $C, $FF, $DC
		dc.b $F6, $D, 0, $C, $00, $24
		dc.b $F6, $D, 8, $C, $FF, $C0
@zap5:		dc.w 4
		dc.b $F8, 4, $60, 0, $FF, $F8
		dc.b 0,	6, $40,	2, $FF, $F8
		dc.b $F6, $D, $10, $C, $00, $24
		dc.b $F6, $D, $18, $C, $FF, $C0
		even