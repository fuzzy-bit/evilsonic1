; ---------------------------------------------------------------------------
; Sprite mappings - Sonic on the ending	sequence
; ---------------------------------------------------------------------------
Map_ESon_internal:
		dc.w M_ESon_Hold1-Map_ESon_internal
		dc.w M_ESon_Hold2-Map_ESon_internal
		dc.w M_ESon_Up-Map_ESon_internal
		dc.w M_ESon_Conf1-Map_ESon_internal
		dc.w M_ESon_Conf2-Map_ESon_internal
		dc.w M_ESon_Leap1-Map_ESon_internal
		dc.w M_ESon_Leap2-Map_ESon_internal
		dc.w M_ESon_Leap3-Map_ESon_internal
M_ESon_Hold1:	dc.b 2
		dc.b $EC, $B, 0, 0, $FF, $F8	; holding emeralds
		dc.b $C, $C, 0,	$C, $FF, $F0
M_ESon_Hold2:	dc.b 3
		dc.b $FC, $D, 0, $10, $FF, $F0 ; holding emeralds (glowing)
		dc.b $EC, $B, 0, 0, $FF, $F8
		dc.b $C, $C, 0,	$C, $FF, $F0
M_ESon_Up:	dc.b 2
		dc.b $EC, 9, 0,	$18, $FF, $F8 ; looking up
		dc.b $FC, $E, 0, $1E, $FF, $F0
M_ESon_Conf1:	dc.b 2
		dc.b $EC, 9, 0,	$2A, $FF, $F8 ; confused
		dc.b $FC, $E, 0, $30, $FF, $F0
M_ESon_Conf2:	dc.b 2
		dc.b $EC, 9, 8,	$2A, $FF, $F0 ; confused #2
		dc.b $FC, $E, 8, $30, $FF, $F0
M_ESon_Leap1:	dc.b 3
		dc.b $EC, 6, 0,	$3C, $FF, $F0 ; leaping
		dc.b $EC, 6, 8,	$3C, 0
		dc.b 4,	$D, 0, $42, $FF, $F0
M_ESon_Leap2:	dc.b 7
		dc.b $B2, $C, 0, $4A, $FF, $F8 ; leaping #2
		dc.b $BA, $F, 0, $4E, $FF, $F0
		dc.b $BA, 5, 0,	$5E, $10
		dc.b $CA, 2, 0,	$62, $10
		dc.b $DA, $C, 0, $65, $FF, $F0
		dc.b $E2, 8, 0,	$69, $FF, $F8
		dc.b $EA, 5, 0,	$6C, $FF, $F8
M_ESon_Leap3:	dc.b $18
		dc.b $80, $F, 0, $70, $FF, $F8 ; leaping #3
		dc.b $90, $B, 0, $80, $FF, $E0
		dc.b $90, $B, 0, $8C, $18
		dc.b $98, $B, 0, $98, $30
		dc.b $A0, $F, 0, $A4, $58
		dc.b $88, 0, 0,	$B4, $FF, $F0
		dc.b $80, 5, 0,	$B5, $18
		dc.b $A0, $F, 0, $B9, $FF, $F8
		dc.b $B0, $B, 0, $C9, $FF, $E0
		dc.b $B8, $F, 0, $D5, $38
		dc.b $A8, 5, 0,	$E5, $48
		dc.b $C0, 2, 0,	$E9, $58
		dc.b $C0, $F, 0, $EC, $FF, $F8
		dc.b $B8, $F, 0, $FC, $18
		dc.b $B0, 8, 1,	$C, $18
		dc.b $D8, $D, 1, $F, $30
		dc.b $D8, 8, 1,	$17, $18
		dc.b $D8, $F, 1, $1A, $FF, $D8
		dc.b $E0, $D, 1, $2A, $FF, $F8
		dc.b $E0, 0, 1,	$32, $28
		dc.b $D0, 4, 1,	$33, $FF, $E0
		dc.b $E8, 5, 1,	$35, $FF, $C8
		dc.b $F8, $C, 1, $39, $FF, $C8
		dc.b $F0, 6, 1,	$3D, $FF, $F8
		even