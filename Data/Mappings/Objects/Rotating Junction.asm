; ---------------------------------------------------------------------------
; Sprite mappings - rotating disc that grabs Sonic (SBZ)
; ---------------------------------------------------------------------------
Map_Jun_internal:
		dc.w @gap0-Map_Jun_internal
		dc.w @gap1-Map_Jun_internal
		dc.w @gap2-Map_Jun_internal
		dc.w @gap3-Map_Jun_internal
		dc.w @gap4-Map_Jun_internal
		dc.w @gap5-Map_Jun_internal
		dc.w @gap6-Map_Jun_internal
		dc.w @gap7-Map_Jun_internal
		dc.w @gap8-Map_Jun_internal
		dc.w @gap9-Map_Jun_internal
		dc.w @gapA-Map_Jun_internal
		dc.w @gapB-Map_Jun_internal
		dc.w @gapC-Map_Jun_internal
		dc.w @gapD-Map_Jun_internal
		dc.w @gapE-Map_Jun_internal
		dc.w @gapF-Map_Jun_internal
		dc.w @circle-Map_Jun_internal
@gap0:		dc.w 6
		dc.b $E8, 5, 0,	$22, $FF, $D0
		dc.b 8,	5, $10,	$22, $FF, $D0
		dc.b $E8, $A, 0, 0, $FF, $C8
		dc.b $E8, $A, 8, 0, $FF, $E0
		dc.b 0,	$A, $10, 0, $FF, $C8
		dc.b 0,	$A, $18, 0, $FF, $E0
@gap1:		dc.w 6
		dc.b $F8, 3, 0,	$26, $FF, $D0
		dc.b $18, 5, 0,	$2A, $FF, $D8
		dc.b $F6, $A, 0, 0, $FF, $CA
		dc.b $F6, $A, 8, 0, $FF, $E2
		dc.b $E, $A, $10, 0, $FF, $CA
		dc.b $E, $A, $18, 0, $FF, $E2
@gap2:		dc.w 6
		dc.b 0,	6, 0, $2E, $FF, $D0
		dc.b $20, 9, 0,	$34, $FF, $E8
		dc.b 0,	$A, 0, 0, $FF, $D0
		dc.b 0,	$A, 8, 0, $FF, $E8
		dc.b $18, $A, $10, 0, $FF, $D0
		dc.b $18, $A, $18, 0, $FF, $E8
@gap3:		dc.w 6
		dc.b 8,	7, 0, $3A, $FF, $D8
		dc.b $28, 8, 0,	$42, $FF, $F0
		dc.b 6,	$A, 0, 0, $FF, $DA
		dc.b 6,	$A, 8, 0, $FF, $F2
		dc.b $1E, $A, $10, 0, $FF, $DA
		dc.b $1E, $A, $18, 0, $FF, $F2
@gap4:		dc.w 6
		dc.b $20, 5, 0,	$45, $FF, $E8
		dc.b $20, 5, 8,	$45, $00, 8
		dc.b 8,	$A, 0, 0, $FF, $E8
		dc.b 8,	$A, 8, 0, $00, 0
		dc.b $20, $A, $10, 0, $FF, $E8
		dc.b $20, $A, $18, 0, $00, 0
@gap5:		dc.w 6
		dc.b $28, 8, 8,	$42, $FF, $F8
		dc.b 8,	7, 8, $3A, $00, $18
		dc.b 6,	$A, 0, 0, $FF, $F6
		dc.b 6,	$A, 8, 0, $00, $E
		dc.b $1E, $A, $10, 0, $FF, $F6
		dc.b $1E, $A, $18, 0, $00, $E
@gap6:		dc.w 6
		dc.b $20, 9, 8,	$34, $00, 0
		dc.b 0,	6, 8, $2E, $00, $20
		dc.b 0,	$A, 0, 0, $00, 0
		dc.b 0,	$A, 8, 0, $00, $18
		dc.b $18, $A, $10, 0, $00, 0
		dc.b $18, $A, $18, 0, $00, $18
@gap7:		dc.w 6
		dc.b $18, 5, 8,	$2A, $00, $18
		dc.b $F8, 3, 8,	$26, $00, $28
		dc.b $F6, $A, 0, 0, $00, 6
		dc.b $F6, $A, 8, 0, $00, $1E
		dc.b $E, $A, $10, 0, $00, 6
		dc.b $E, $A, $18, 0, $00, $1E
@gap8:		dc.w 6
		dc.b $E8, 5, 8,	$22, $00, $20
		dc.b 8,	5, $18,	$22, $00, $20
		dc.b $E8, $A, 0, 0, $00, 8
		dc.b $E8, $A, 8, 0, $00, $20
		dc.b 0,	$A, $10, 0, $00, 8
		dc.b 0,	$A, $18, 0, $00, $20
@gap9:		dc.w 6
		dc.b $D8, 5, $18, $2A, $00, $18
		dc.b $E8, 3, $18, $26, $00, $28
		dc.b $DA, $A, 0, 0, $00, 6
		dc.b $DA, $A, 8, 0, $00, $1E
		dc.b $F2, $A, $10, 0, $00, 6
		dc.b $F2, $A, $18, 0, $00, $1E
@gapA:		dc.w 6
		dc.b $D0, 9, $18, $34, $00, 0
		dc.b $E8, 6, $18, $2E, $00, $20
		dc.b $D0, $A, 0, 0, $00, 0
		dc.b $D0, $A, 8, 0, $00, $18
		dc.b $E8, $A, $10, 0, $00, 0
		dc.b $E8, $A, $18, 0, $00, $18
@gapB:		dc.w 6
		dc.b $D0, 8, $18, $42, $FF, $F8
		dc.b $D8, 7, $18, $3A, $00, $18
		dc.b $CA, $A, 0, 0, $FF, $F6
		dc.b $CA, $A, 8, 0, $00, $E
		dc.b $E2, $A, $10, 0, $FF, $F6
		dc.b $E2, $A, $18, 0, $00, $E
@gapC:		dc.w 6
		dc.b $D0, 5, $10, $45, $FF, $E8
		dc.b $D0, 5, $18, $45, $00, 8
		dc.b $C8, $A, 0, 0, $FF, $E8
		dc.b $C8, $A, 8, 0, $00, 0
		dc.b $E0, $A, $10, 0, $FF, $E8
		dc.b $E0, $A, $18, 0, $00, 0
@gapD:		dc.w 6
		dc.b $D8, 7, $10, $3A, $FF, $D8
		dc.b $D0, 8, $10, $42, $FF, $F0
		dc.b $CA, $A, 0, 0, $FF, $DA
		dc.b $CA, $A, 8, 0, $FF, $F2
		dc.b $E2, $A, $10, 0, $FF, $DA
		dc.b $E2, $A, $18, 0, $FF, $F2
@gapE:		dc.w 6
		dc.b $E8, 6, $10, $2E, $FF, $D0
		dc.b $D0, 9, $10, $34, $FF, $E8
		dc.b $D0, $A, 0, 0, $FF, $D0
		dc.b $D0, $A, 8, 0, $FF, $E8
		dc.b $E8, $A, $10, 0, $FF, $D0
		dc.b $E8, $A, $18, 0, $FF, $E8
@gapF:		dc.w 6
		dc.b $E8, 3, $10, $26, $FF, $D0
		dc.b $D8, 5, $10, $2A, $FF, $D8
		dc.b $DA, $A, 0, 0, $FF, $CA
		dc.b $DA, $A, 8, 0, $FF, $E2
		dc.b $F2, $A, $10, 0, $FF, $CA
		dc.b $F2, $A, $18, 0, $FF, $E2
@circle:	dc.w $C
		dc.b $C8, $D, 0, 9, $FF, $E0
		dc.b $D0, $A, 0, $11, $FF, $D0
		dc.b $E0, 7, 0,	$1A, $FF, $C8
		dc.b $C8, $D, 8, 9, $00, 0
		dc.b $D0, $A, 8, $11, $00, $18
		dc.b $E0, 7, 8,	$1A, $00, $28
		dc.b 0,	7, $10,	$1A, $FF, $C8
		dc.b $18, $A, $10, $11,	$FF, $D0
		dc.b $28, $D, $10, 9, $FF, $E0
		dc.b $28, $D, $18, 9, $00, 0
		dc.b $18, $A, $18, $11,	$00, $18
		dc.b 0,	7, $18,	$1A, $00, $28
		even