; ---------------------------------------------------------------------------
; Sprite mappings - flame thrower (SBZ)
; ---------------------------------------------------------------------------
Map_Flame_internal:
		dc.w @pipe1-Map_Flame_internal
		dc.w @pipe2-Map_Flame_internal
		dc.w @pipe3-Map_Flame_internal
		dc.w @pipe4-Map_Flame_internal
		dc.w @pipe5-Map_Flame_internal
		dc.w @pipe6-Map_Flame_internal
		dc.w @pipe7-Map_Flame_internal
		dc.w @pipe8-Map_Flame_internal
		dc.w @pipe9-Map_Flame_internal
		dc.w @pipe10-Map_Flame_internal
		dc.w @pipe11-Map_Flame_internal
		dc.w @valve1-Map_Flame_internal
		dc.w @valve2-Map_Flame_internal
		dc.w @valve3-Map_Flame_internal
		dc.w @valve4-Map_Flame_internal
		dc.w @valve5-Map_Flame_internal
		dc.w @valve6-Map_Flame_internal
		dc.w @valve7-Map_Flame_internal
		dc.w @valve8-Map_Flame_internal
		dc.w @valve9-Map_Flame_internal
		dc.w @valve10-Map_Flame_internal
		dc.w @valve11-Map_Flame_internal
@pipe1:		dc.w 1
		dc.b $28, 5, $40, $14, $FF, $FB ; broken pipe style flamethrower
@pipe2:		dc.w 2
		dc.b $20, 1, 0,	0, $FF, $FD
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe3:		dc.w 2
		dc.b $20, 1, 8,	0, $FF, $FC
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe4:		dc.w 3
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $20, 1, 0,	0, $FF, $FD
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe5:		dc.w 3
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $20, 1, 8,	0, $FF, $FC
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe6:		dc.w 4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $20, 1, 0,	0, $FF, $FD
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe7:		dc.w 4
		dc.b 8,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $20, 1, 8,	0, $FF, $FC
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe8:		dc.w 5
		dc.b $F8, $B, 0, 8, $FF, $F4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $20, 1, 0,	0, $FF, $FD
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe9:		dc.w 5
		dc.b $F8, $B, 8, 8, $FF, $F4
		dc.b 8,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $20, 1, 8,	0, $FF, $FC
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe10:	dc.w 6
		dc.b $E8, $B, 0, 8, $FF, $F4
		dc.b $F7, $B, 0, 8, $FF, $F4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $F, 6, 0, 2, $FF, $F8
		dc.b $20, 1, 0,	0, $FF, $FD
		dc.b $28, 5, $40, $14, $FF, $FB
@pipe11:	dc.w 6
		dc.b $E7, $B, 8, 8, $FF, $F4
		dc.b $F8, $B, 8, 8, $FF, $F4
		dc.b 7,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $20, 1, 8,	0, $FF, $FC
		dc.b $28, 5, $40, $14, $FF, $FB
@valve1:	dc.w 1
		dc.b $28, 5, $40, $18, $FF, $F9 ; valve style flamethrower
@valve2:	dc.w 2
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 0,	0, $FF, $FD
@valve3:	dc.w 2
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 8,	0, $FF, $FC
@valve4:	dc.w 3
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 0,	0, $FF, $FD
@valve5:	dc.w 3
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 8,	0, $FF, $FC
@valve6:	dc.w 4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 0,	0, $FF, $FD
@valve7:	dc.w 4
		dc.b 8,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 8,	0, $FF, $FC
@valve8:	dc.w 5
		dc.b $F8, $B, 0, 8, $FF, $F4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $10, 6, 0,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 0,	0, $FF, $FD
@valve9:	dc.w 5
		dc.b $F8, $B, 8, 8, $FF, $F4
		dc.b 8,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 8,	0, $FF, $FC
@valve10:	dc.w 6
		dc.b $E8, $B, 0, 8, $FF, $F4
		dc.b $F7, $B, 0, 8, $FF, $F4
		dc.b 8,	6, 0, 2, $FF, $F8
		dc.b $F, 6, 0, 2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 0,	0, $FF, $FD
@valve11:	dc.w 6
		dc.b $E7, $B, 8, 8, $FF, $F4
		dc.b $F8, $B, 8, 8, $FF, $F4
		dc.b 7,	6, 8, 2, $FF, $F8
		dc.b $10, 6, 8,	2, $FF, $F8
		dc.b $28, 5, $40, $18, $FF, $F9
		dc.b $20, 1, 8,	0, $FF, $FC
		even