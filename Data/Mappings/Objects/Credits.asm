; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC TEAM	PRESENTS" and credits
; ---------------------------------------------------------------------------
Map_Cred_internal:
		dc.w @staff-Map_Cred_internal
		dc.w @gameplan-Map_Cred_internal
		dc.w @program-Map_Cred_internal
		dc.w @character-Map_Cred_internal
		dc.w @design-Map_Cred_internal
		dc.w @soundproduce-Map_Cred_internal
		dc.w @soundprogram-Map_Cred_internal
		dc.w @thanks-Map_Cred_internal
		dc.w @presentedby-Map_Cred_internal
		dc.w @tryagain-Map_Cred_internal
		dc.w @sonicteam-Map_Cred_internal
@staff:		dc.b $E			 ; SONIC TEAM STAFF
		dc.b $F8, 5, 0,	$2E, $FF, $88
		dc.b $F8, 5, 0,	$26, $FF, $98
		dc.b $F8, 5, 0,	$1A, $FF, $A8
		dc.b $F8, 1, 0,	$46, $FF, $B8
		dc.b $F8, 5, 0,	$1E, $FF, $C0
		dc.b $F8, 5, 0,	$3E, $FF, $D8
		dc.b $F8, 5, 0,	$E, $FF, $E8
		dc.b $F8, 5, 0,	4, $FF, $F8
		dc.b $F8, 9, 0,	8, 8
		dc.b $F8, 5, 0,	$2E, $28
		dc.b $F8, 5, 0,	$3E, $38
		dc.b $F8, 5, 0,	4, $48
		dc.b $F8, 5, 0,	$5C, $58
		dc.b $F8, 5, 0,	$5C, $68
@gameplan:	dc.b $10		; GAME PLAN CAROL YAS
		dc.b $D8, 5, 0,	0, $FF, $80
		dc.b $D8, 5, 0,	4, $FF, $90
		dc.b $D8, 9, 0,	8, $FF, $A0
		dc.b $D8, 5, 0,	$E, $FF, $B4
		dc.b $D8, 5, 0,	$12, $FF, $D0
		dc.b $D8, 5, 0,	$16, $FF, $E0
		dc.b $D8, 5, 0,	4, $FF, $F0
		dc.b $D8, 5, 0,	$1A, 0
		dc.b 8,	5, 0, $1E, $FF, $C8
		dc.b 8,	5, 0, 4, $FF, $D8
		dc.b 8,	5, 0, $22, $FF, $E8
		dc.b 8,	5, 0, $26, $FF, $F8
		dc.b 8,	5, 0, $16, 8
		dc.b 8,	5, 0, $2A, $20
		dc.b 8,	5, 0, 4, $30
		dc.b 8,	5, 0, $2E, $44
@program:	dc.b $A			 ; PROGRAM YU 2
		dc.b $D8, 5, 0,	$12, $FF, $80
		dc.b $D8, 5, 0,	$22, $FF, $90
		dc.b $D8, 5, 0,	$26, $FF, $A0
		dc.b $D8, 5, 0,	0, $FF, $B0
		dc.b $D8, 5, 0,	$22, $FF, $C0
		dc.b $D8, 5, 0,	4, $FF, $D0
		dc.b $D8, 9, 0,	8, $FF, $E0
		dc.b 8,	5, 0, $2A, $FF, $E8
		dc.b 8,	5, 0, $32, $FF, $F8
		dc.b 8,	5, 0, $36, 8
@character:	dc.b $18		 ; CHARACTER DESIGN BIGISLAND
		dc.b $D8, 5, 0,	$1E, $FF, $88
		dc.b $D8, 5, 0,	$3A, $FF, $98
		dc.b $D8, 5, 0,	4, $FF, $A8
		dc.b $D8, 5, 0,	$22, $FF, $B8
		dc.b $D8, 5, 0,	4, $FF, $C8
		dc.b $D8, 5, 0,	$1E, $FF, $D8
		dc.b $D8, 5, 0,	$3E, $FF, $E8
		dc.b $D8, 5, 0,	$E, $FF, $F8
		dc.b $D8, 5, 0,	$22, 8
		dc.b $D8, 5, 0,	$42, $20
		dc.b $D8, 5, 0,	$E, $30
		dc.b $D8, 5, 0,	$2E, $40
		dc.b $D8, 1, 0,	$46, $50
		dc.b $D8, 5, 0,	0, $58
		dc.b $D8, 5, 0,	$1A, $68
		dc.b 8,	5, 0, $48, $FF, $C0
		dc.b 8,	1, 0, $46, $FF, $D0
		dc.b 8,	5, 0, 0, $FF, $D8
		dc.b 8,	1, 0, $46, $FF, $E8
		dc.b 8,	5, 0, $2E, $FF, $F0
		dc.b 8,	5, 0, $16, 0
		dc.b 8,	5, 0, 4, $10
		dc.b 8,	5, 0, $1A, $20
		dc.b 8,	5, 0, $42, $30
@design:	dc.b $14		 ; DESIGN JINYA	PHENIX RIE
		dc.b $D0, 5, 0,	$42, $FF, $A0
		dc.b $D0, 5, 0,	$E, $FF, $B0
		dc.b $D0, 5, 0,	$2E, $FF, $C0
		dc.b $D0, 1, 0,	$46, $FF, $D0
		dc.b $D0, 5, 0,	0, $FF, $D8
		dc.b $D0, 5, 0,	$1A, $FF, $E8
		dc.b 0,	5, 0, $4C, $FF, $E8
		dc.b 0,	1, 0, $46, $FF, $F8
		dc.b 0,	5, 0, $1A, 4
		dc.b 0,	5, 0, $2A, $14
		dc.b 0,	5, 0, 4, $24
		dc.b $20, 5, 0,	$12, $FF, $D0
		dc.b $20, 5, 0,	$3A, $FF, $E0
		dc.b $20, 5, 0,	$E, $FF, $F0
		dc.b $20, 5, 0,	$1A, 0
		dc.b $20, 1, 0,	$46, $10
		dc.b $20, 5, 0,	$50, $18
		dc.b $20, 5, 0,	$22, $30
		dc.b $20, 1, 0,	$46, $40
		dc.b $20, 5, 0,	$E, $48
@soundproduce:	dc.b $1A		 ; SOUND PRODUCE MASATO	NAKAMURA
		dc.b $D8, 5, 0,	$2E, $FF, $98
		dc.b $D8, 5, 0,	$26, $FF, $A8
		dc.b $D8, 5, 0,	$32, $FF, $B8
		dc.b $D8, 5, 0,	$1A, $FF, $C8
		dc.b $D8, 5, 0,	$54, $FF, $D8
		dc.b $D8, 5, 0,	$12, $FF, $F8
		dc.b $D8, 5, 0,	$22, 8
		dc.b $D8, 5, 0,	$26, $18
		dc.b $D8, 5, 0,	$42, $28
		dc.b $D8, 5, 0,	$32, $38
		dc.b $D8, 5, 0,	$1E, $48
		dc.b $D8, 5, 0,	$E, $58
		dc.b 8,	9, 0, 8, $FF, $88
		dc.b 8,	5, 0, 4, $FF, $9C
		dc.b 8,	5, 0, $2E, $FF, $AC
		dc.b 8,	5, 0, 4, $FF, $BC
		dc.b 8,	5, 0, $3E, $FF, $CC
		dc.b 8,	5, 0, $26, $FF, $DC
		dc.b 8,	5, 0, $1A, $FF, $F8
		dc.b 8,	5, 0, 4, 8
		dc.b 8,	5, 0, $58, $18
		dc.b 8,	5, 0, 4, $28
		dc.b 8,	9, 0, 8, $38
		dc.b 8,	5, 0, $32, $4C
		dc.b 8,	5, 0, $22, $5C
		dc.b 8,	5, 0, 4, $6C
@soundprogram:	dc.b $17		 ; SOUND PROGRAM JIMITA	MACKY
		dc.b $D0, 5, 0,	$2E, $FF, $98
		dc.b $D0, 5, 0,	$26, $FF, $A8
		dc.b $D0, 5, 0,	$32, $FF, $B8
		dc.b $D0, 5, 0,	$1A, $FF, $C8
		dc.b $D0, 5, 0,	$54, $FF, $D8
		dc.b $D0, 5, 0,	$12, $FF, $F8
		dc.b $D0, 5, 0,	$22, 8
		dc.b $D0, 5, 0,	$26, $18
		dc.b $D0, 5, 0,	0, $28
		dc.b $D0, 5, 0,	$22, $38
		dc.b $D0, 5, 0,	4, $48
		dc.b $D0, 9, 0,	8, $58
		dc.b 0,	5, 0, $4C, $FF, $D0
		dc.b 0,	1, 0, $46, $FF, $E0
		dc.b 0,	9, 0, 8, $FF, $E8
		dc.b 0,	1, 0, $46, $FF, $FC
		dc.b 0,	5, 0, $3E, 4
		dc.b 0,	5, 0, 4, $14
		dc.b $20, 9, 0,	8, $FF, $D0
		dc.b $20, 5, 0,	4, $FF, $E4
		dc.b $20, 5, 0,	$1E, $FF, $F4
		dc.b $20, 5, 0,	$58, 4
		dc.b $20, 5, 0,	$2A, $14
@thanks:	dc.b $1F		 ; SPECIAL THANKS FUJIO	MINEGISHI PAPA
		dc.b $D8, 5, 0,	$2E, $FF, $80
		dc.b $D8, 5, 0,	$12, $FF, $90
		dc.b $D8, 5, 0,	$E, $FF, $A0
		dc.b $D8, 5, 0,	$1E, $FF, $B0
		dc.b $D8, 1, 0,	$46, $FF, $C0
		dc.b $D8, 5, 0,	4, $FF, $C8
		dc.b $D8, 5, 0,	$16, $FF, $D8
		dc.b $D8, 5, 0,	$3E, $FF, $F8
		dc.b $D8, 5, 0,	$3A, 8
		dc.b $D8, 5, 0,	4, $18
		dc.b $D8, 5, 0,	$1A, $28
		dc.b $D8, 5, 0,	$58, $38
		dc.b $D8, 5, 0,	$2E, $48
		dc.b 0,	5, 0, $5C, $FF, $B0
		dc.b 0,	5, 0, $32, $FF, $C0
		dc.b 0,	5, 0, $4C, $FF, $D0
		dc.b 0,	1, 0, $46, $FF, $E0
		dc.b 0,	5, 0, $26, $FF, $E8
		dc.b 0,	9, 0, 8, 0
		dc.b 0,	1, 0, $46, $14
		dc.b 0,	5, 0, $1A, $1C
		dc.b 0,	5, 0, $E, $2C
		dc.b 0,	5, 0, 0, $3C
		dc.b 0,	1, 0, $46, $4C
		dc.b 0,	5, 0, $2E, $54
		dc.b 0,	5, 0, $3A, $64
		dc.b 0,	1, 0, $46, $74
		dc.b $20, 5, 0,	$12, $FF, $F8
		dc.b $20, 5, 0,	4, 8
		dc.b $20, 5, 0,	$12, $18
		dc.b $20, 5, 0,	4, $28
@presentedby:	dc.b $F			 ; PRESENTED BY	SEGA
		dc.b $F8, 5, 0,	$12, $FF, $80
		dc.b $F8, 5, 0,	$22, $FF, $90
		dc.b $F8, 5, 0,	$E, $FF, $A0
		dc.b $F8, 5, 0,	$2E, $FF, $B0
		dc.b $F8, 5, 0,	$E, $FF, $C0
		dc.b $F8, 5, 0,	$1A, $FF, $D0
		dc.b $F8, 5, 0,	$3E, $FF, $E0
		dc.b $F8, 5, 0,	$E, $FF, $F0
		dc.b $F8, 5, 0,	$42, 0
		dc.b $F8, 5, 0,	$48, $18
		dc.b $F8, 5, 0,	$2A, $28
		dc.b $F8, 5, 0,	$2E, $40
		dc.b $F8, 5, 0,	$E, $50
		dc.b $F8, 5, 0,	0, $60
		dc.b $F8, 5, 0,	4, $70
@tryagain:	dc.b 8			 ; TRY AGAIN
		dc.b $30, 5, 0,	$3E, $FF, $C0
		dc.b $30, 5, 0,	$22, $FF, $D0
		dc.b $30, 5, 0,	$2A, $FF, $E0
		dc.b $30, 5, 0,	4, $FF, $F8
		dc.b $30, 5, 0,	0, 8
		dc.b $30, 5, 0,	4, $18
		dc.b $30, 1, 0,	$46, $28
		dc.b $30, 5, 0,	$1A, $30
@sonicteam:	dc.b $11		 ; SONIC TEAM PRESENTS
		dc.b $E8, 5, 0,	$2E, $FF, $B4
		dc.b $E8, 5, 0,	$26, $FF, $C4
		dc.b $E8, 5, 0,	$1A, $FF, $D4
		dc.b $E8, 1, 0,	$46, $FF, $E4
		dc.b $E8, 5, 0,	$1E, $FF, $EC
		dc.b $E8, 5, 0,	$3E, 4
		dc.b $E8, 5, 0,	$E, $14
		dc.b $E8, 5, 0,	4, $24
		dc.b $E8, 9, 0,	8, $34
		dc.b 0,	5, 0, $12, $FF, $C0
		dc.b 0,	5, 0, $22, $FF, $D0
		dc.b 0,	5, 0, $E, $FF, $E0
		dc.b 0,	5, 0, $2E, $FF, $F0
		dc.b 0,	5, 0, $E, 0
		dc.b 0,	5, 0, $1A, $10
		dc.b 0,	5, 0, $3E, $20
		dc.b 0,	5, 0, $2E, $30
		even