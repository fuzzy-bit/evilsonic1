; ---------------------------------------------------------------------------
; Sprite mappings - Robotnik on	the "TRY AGAIN"	and "END" screens
; ---------------------------------------------------------------------------
Map_EEgg_internal:
		dc.w M_EEgg_Try1-Map_EEgg_internal
		dc.w M_EEgg_Try2-Map_EEgg_internal
		dc.w M_EEgg_Try3-Map_EEgg_internal
		dc.w M_EEgg_Try4-Map_EEgg_internal
		dc.w M_EEgg_End1-Map_EEgg_internal
		dc.w M_EEgg_End2-Map_EEgg_internal
		dc.w M_EEgg_End3-Map_EEgg_internal
		dc.w M_EEgg_End4-Map_EEgg_internal
M_EEgg_Try1:	dc.w 8
		dc.b $E9, 5, 0,	0, $FF, $F0
		dc.b $F9, $C, 0, 4, $FF, $E0
		dc.b $E9, 4, 0,	8, $00, 0
		dc.b $F1, $D, 0, $A, $00, 0
		dc.b 1,	6, 0, $23, $FF, $F0
		dc.b 1,	6, 8, $23, $00, 0
		dc.b $18, 4, 0,	$29, $FF, $EC
		dc.b $18, 4, 8,	$29, $00, 4
M_EEgg_Try2:	dc.w 8
		dc.b $E8, $D, 0, $12, $FF, $E0
		dc.b $F8, 8, 0,	$1A, $FF, $E8
		dc.b $E8, 5, 8,	0, $00, 0
		dc.b $F8, $C, 8, 4, $00, 0
		dc.b 0,	6, 0, $1D, $FF, $F0
		dc.b 0,	6, 8, $1D, $00, 0
		dc.b $18, 4, 0,	$29, $FF, $EC
		dc.b $18, 4, 8,	$29, $00, 4
M_EEgg_Try3:	dc.w 8
		dc.b $E9, 4, 8,	8, $FF, $F0
		dc.b $F1, $D, 8, $A, $FF, $E0
		dc.b $E9, 5, 8,	0, $00, 0
		dc.b $F9, $C, 8, 4, $00, 0
		dc.b 1,	6, 0, $23, $FF, $F0
		dc.b 1,	6, 8, $23, $00, 0
		dc.b $18, 4, 0,	$29, $FF, $EC
		dc.b $18, 4, 8,	$29, $00, 4
M_EEgg_Try4:	dc.w 8
		dc.b $E8, 5, 0,	0, $FF, $F0
		dc.b $F8, $C, 0, 4, $FF, $E0
		dc.b $E8, $D, 8, $12, $00, 0
		dc.b $F8, 8, 8,	$1A, $00, 0
		dc.b 0,	6, 0, $1D, $FF, $F0
		dc.b 0,	6, 8, $1D, $00, 0
		dc.b $18, 4, 0,	$29, $FF, $EC
		dc.b $18, 4, 8,	$29, $00, 4
M_EEgg_End1:	dc.w $C
		dc.b $ED, $A, 0, $2B, $FF, $E8
		dc.b $F5, 0, 0,	$34, $FF, $E0
		dc.b 5,	4, 0, $35, $FF, $F0
		dc.b $D, 8, 0, $37, $FF, $E8
		dc.b $ED, $A, 8, $2B, $00, 0
		dc.b $F5, 0, 8,	$34, $00, $18
		dc.b 5,	4, 8, $35, $00, 0
		dc.b $D, 8, 8, $37, $00, 0
		dc.b $10, $D, 0, $73, $FF, $E0
		dc.b $10, $D, 0, $7B, $00, 0
		dc.b $1C, $C, 0, $5B, $FF, $E0
		dc.b $1C, $C, 8, $5B, $00, 0
M_EEgg_End2:	dc.w $A
		dc.b $D2, 7, 0,	$3A, $FF, $F0
		dc.b $DA, 0, 0,	$42, $FF, $E8
		dc.b $F2, 7, 0,	$43, $FF, $F0
		dc.b $D2, 7, 8,	$3A, $00, 0
		dc.b $DA, 0, 8,	$42, $00, $10
		dc.b $F2, 7, 8,	$43, $00, 0
		dc.b $10, $D, 0, $67, $FF, $E8
		dc.b $10, 5, 0,	$6F, $00, 8
		dc.b $1C, $C, 0, $5F, $FF, $E0
		dc.b $1C, $C, 8, $5F, $00, 0
M_EEgg_End3:	dc.w $A
		dc.b $C4, $B, 0, $4B, $FF, $E8
		dc.b $E4, 8, 0,	$57, $FF, $E8
		dc.b $EC, 0, 0,	$5A, $FF, $F0
		dc.b $C4, $B, 8, $4B, $00, 0
		dc.b $E4, 8, 8,	$57, $00, 0
		dc.b $EC, 0, 8,	$5A, $00, 8
		dc.b $10, $D, 0, $67, $FF, $E8
		dc.b $10, 5, 0,	$6F, $00, 8
		dc.b $1C, $C, 0, $63, $FF, $E0
		dc.b $1C, $C, 8, $63, $00, 0
M_EEgg_End4:	dc.w $C
		dc.b $F4, $A, 0, $2B, $FF, $E8
		dc.b $FC, 0, 0,	$34, $FF, $E0
		dc.b $C, 4, 0, $35, $FF, $F0
		dc.b $14, 8, 0,	$37, $FF, $E8
		dc.b $F4, $A, 8, $2B, $00, 0
		dc.b $FC, 0, 8,	$34, $00, $18
		dc.b $C, 4, 8, $35, $00, 0
		dc.b $14, 8, 8,	$37, $00, 0
		dc.b $18, $C, 0, $83, $FF, $E0
		dc.b $18, $C, 0, $87, $00, 0
		dc.b $1C, $C, 0, $5B, $FF, $E0
		dc.b $1C, $C, 8, $5B, $00, 0
		even