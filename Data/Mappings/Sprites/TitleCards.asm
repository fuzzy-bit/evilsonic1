; ---------------------------------------------------------------------------
; Sprite mappings - zone title cards
; ---------------------------------------------------------------------------
Map_Card:	dc.w M_Card_GHZ-Map_Card
		dc.w M_Card_LZ-Map_Card
		dc.w M_Card_MZ-Map_Card
		dc.w M_Card_SLZ-Map_Card
		dc.w M_Card_SYZ-Map_Card
		dc.w M_Card_SBZ-Map_Card
		dc.w M_Card_Zone-Map_Card
		dc.w M_Card_Act1-Map_Card
		dc.w M_Card_Act2-Map_Card
		dc.w M_Card_Act3-Map_Card
		dc.w M_Card_Oval-Map_Card
		dc.w M_Card_FZ-Map_Card
M_Card_GHZ:	dc.b 9 			; GREEN HILL
		dc.b	$F8, 5, 0, $45, $B8
		dc.b	$F8, 5, 0, $71, $C7
		dc.b	$F8, 5, 0, $3D, $D6
		dc.b	$F8, 5, 0, $3D, $E5
		dc.b	$F8, 5, 0, $61, $F4

		dc.b	$F8, 5, 0, $49, $13
		dc.b	$F8, 5, 0, $4D, $26
		dc.b	$F8, 5, 0, $59, $31
		dc.b	$F8, 5, 0, $59, $40
		even
M_Card_LZ:	dc.b 9			; LABYRINTH
		dc.b	$F8, 5, 0, $59, $B8
		dc.b	$F8, 5, 0, $2D, $C7
		dc.b	$F8, 5, 0, $31, $D6
		dc.b	$F8, 5, 0, $8D, $E5
		dc.b	$F8, 5, 0, $71, $F4
		dc.b	$F8, 5, 0, $4D, $8
		dc.b	$F8, 5, 0, $61, $13
		dc.b	$F8, 5, 0, $79, $22
		dc.b	$F8, 5, 0, $49, $31
		even
M_Card_MZ:	dc.b 6			; MARBLE
		dc.b $F8, 5, 0,	$2A, $CF
		dc.b $F8, 5, 0,	0, $E0
		dc.b $F8, 5, 0,	$3A, $F0
		dc.b $F8, 5, 0,	4, 0
		dc.b $F8, 5, 0,	$26, $10
		dc.b $F8, 5, 0,	$10, $20
		even
M_Card_SLZ:	dc.b 9		; STAR LIGHT
		dc.b	$F8, 5, 0, $75, $B8
		dc.b	$F8, 5, 0, $79, $C7
		dc.b	$F8, 5, 0, $2D, $D6
		dc.b	$F8, 5, 0, $71, $E5

		dc.b	$F8, 5, 0, $59, $4
		dc.b	$F8, 5, 0, $4D, $17
		dc.b	$F8, 5, 0, $45, $22
		dc.b	$F8, 5, 0, $49, $31
		dc.b	$F8, 5, 0, $79, $40

		even
M_Card_SYZ:	dc.b 10		; SPRING YARD
		dc.b	$F8, 5, 0, $75, $B0
		dc.b	$F8, 5, 0, $69, $BF
		dc.b	$F8, 5, 0, $71, $CE
		dc.b	$F8, 5, 0, $4D, $E1
		dc.b	$F8, 5, 0, $61, $EC
		dc.b	$F8, 5, 0, $45, $FB

		dc.b	$F8, 5, 0, $8D, $1A
		dc.b	$F8, 5, 0, $2D, $29
		dc.b	$F8, 5, 0, $71, $38
		dc.b	$F8, 5, 0, $39, $47

		even
M_Card_SBZ:	dc.b 9		; CLOCK WORK
		dc.b	$F8, 5, 0, $35, $B8
		dc.b	$F8, 5, 0, $59, $C7
		dc.b	$F8, 5, 0, $65, $D6
		dc.b	$F8, 5, 0, $35, $E5
		dc.b	$F8, 5, 0, $55, $F4

		dc.b	$F8, 5, 0, $85, $13
		dc.b	$F8, 5, 0, $65, $22
		dc.b	$F8, 5, 0, $71, $31
		dc.b	$F8, 5, 0, $55, $40
		even
M_Card_Zone:	dc.b 4			; ZONE
		dc.b $F8, 5, 0,	$91, $E0
		dc.b $F8, 5, 0,	$65, $F0
		dc.b $F8, 5, 0,	$61, 0
		dc.b $F8, 5, 0,	$3D, $10
		even
M_Card_Act1:	dc.b 2			; ACT 1
		dc.b 4,	$C, 0, $0, $EC
		dc.b $F4, 2, 0,	$4, $C
M_Card_Act2:	dc.b 2			; ACT 2
		dc.b 4,	$C, 0, $0, $EC
		dc.b $F4, 6, 0,	$7, 8
M_Card_Act3:	dc.b 2			; ACT 3
		dc.b 4,	$C, 0, $0, $EC
		dc.b $F4, 6, 0,	$D, 8
M_Card_Oval:	dc.b $D			; Oval
		dc.b $E4, $C, 0, $1D, $F4
		dc.b $E4, 2, 0,	$21, $14
		dc.b $EC, 4, 0,	$24, $EC 
		dc.b $F4, 5, 0,	$26, $E4	
		dc.b $14, $C, $18, $1D,	$EC
		dc.b 4,	2, $18,	$21, $E4
		dc.b $C, 4, $18, $24, 4	
		dc.b $FC, 5, $18, $26, $C	
		dc.b $EC, 8, 0,	$2A, $FC
		dc.b $F4, $C, 0, $29, $F4
		dc.b $FC, 8, 0,	$29, $F4
		dc.b 4,	$C, 0, $29, $EC
		dc.b $C, 8, 0, $29, $EC
		even
M_Card_FZ:	dc.b 5			; FINAL
		dc.b $F8, 5, 0,	$14, $DC
		dc.b $F8, 1, 0,	$20, $EC
		dc.b $F8, 5, 0,	$2E, $F4
		dc.b $F8, 5, 0,	0, 4
		dc.b $F8, 5, 0,	$26, $14
		even

Map_Over:	include	"Data\Mappings\Objects\Game Over.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC HAS PASSED" title card
; ---------------------------------------------------------------------------
Map_Got:	dc.w M_Got_SonicHas-Map_Got
		dc.w M_Got_Passed-Map_Got
		dc.w M_Got_Score-Map_Got
		dc.w M_Got_TBonus-Map_Got
		dc.w M_Got_RBonus-Map_Got
		dc.w M_Card_Oval-Map_Got
		dc.w M_Card_Act1-Map_Got
		dc.w M_Card_Act2-Map_Got
		dc.w M_Card_Act3-Map_Got
M_Got_SonicHas:	dc.b 8			; SONIC HAS
		dc.b	$F8, 5, 0, $75, $B8
		dc.b	$F8, 5, 0, $65, $C7
		dc.b	$F8, 5, 0, $61, $D6
		dc.b	$F8, 5, 0, $4D, $E9
		dc.b	$F8, 5, 0, $35, $F4

		dc.b	$F8, 5, 0, $49, $13
		dc.b	$F8, 5, 0, $2D, $22
		dc.b	$F8, 5, 0, $75, $31
M_Got_Passed:	dc.b 6			; PASSED
		dc.b $F8, 5, 0,	$36, $D0
		dc.b $F8, 5, 0,	0, $E0
		dc.b $F8, 5, 0,	$3E, $F0
		dc.b $F8, 5, 0,	$3E, 0
		dc.b $F8, 5, 0,	$10, $10
		dc.b $F8, 5, 0,	$C, $20
M_Got_Score:	dc.b 6			; SCORE
		dc.b $F8, $D, 1, $4A, $B0
		dc.b $F8, 1, 1,	$62, $D0
		dc.b $F8, 9, 1,	$64, $18
		dc.b $F8, $D, 1, $6A, $30
		dc.b $F7, 4, 0,	$6E, $CD
		dc.b $FF, 4, $18, $6E, $CD
M_Got_TBonus:	dc.b 7			; TIME BONUS
		dc.b $F8, $D, 1, $5A, $B0
		dc.b $F8, $D, 0, $66, $D9
		dc.b $F8, 1, 1,	$4A, $F9
		dc.b $F7, 4, 0,	$6E, $F6
		dc.b $FF, 4, $18, $6E, $F6
		dc.b $F8, $D, $FF, $F0,	$28
		dc.b $F8, 1, 1,	$70, $48
M_Got_RBonus:	dc.b 7			; RING BONUS
		dc.b $F8, $D, 1, $52, $B0
		dc.b $F8, $D, 0, $66, $D9
		dc.b $F8, 1, 1,	$4A, $F9
		dc.b $F7, 4, 0,	$6E, $F6
		dc.b $FF, 4, $18, $6E, $F6
		dc.b $F8, $D, $FF, $F8,	$28
		dc.b $F8, 1, 1,	$70, $48
		even
; ---------------------------------------------------------------------------
; Sprite mappings - special stage results screen
; ---------------------------------------------------------------------------
Map_SSR:	dc.w M_SSR_Chaos-Map_SSR
		dc.w M_SSR_Score-Map_SSR
		dc.w byte_CD0D-Map_SSR
		dc.w M_Card_Oval-Map_SSR
		dc.w byte_CD31-Map_SSR
		dc.w byte_CD46-Map_SSR
		dc.w byte_CD5B-Map_SSR
		dc.w byte_CD6B-Map_SSR
		dc.w byte_CDA8-Map_SSR
M_SSR_Chaos:	dc.b $D			; "CHAOS EMERALDS"
		dc.b $F8, 5, 0,	8, $90
		dc.b $F8, 5, 0,	$1C, $A0
		dc.b $F8, 5, 0,	0, $B0
		dc.b $F8, 5, 0,	$32, $C0
		dc.b $F8, 5, 0,	$3E, $D0
		dc.b $F8, 5, 0,	$10, $F0
		dc.b $F8, 5, 0,	$2A, 0
		dc.b $F8, 5, 0,	$10, $10
		dc.b $F8, 5, 0,	$3A, $20
		dc.b $F8, 5, 0,	0, $30
		dc.b $F8, 5, 0,	$26, $40
		dc.b $F8, 5, 0,	$C, $50
		dc.b $F8, 5, 0,	$3E, $60
M_SSR_Score:	dc.b 6			; "SCORE"
		dc.b $F8, $D, 1, $4A, $B0
		dc.b $F8, 1, 1,	$62, $D0
		dc.b $F8, 9, 1,	$64, $18
		dc.b $F8, $D, 1, $6A, $30
		dc.b $F7, 4, 0,	$6E, $CD
		dc.b $FF, 4, $18, $6E, $CD
byte_CD0D:	dc.b 7
		dc.b $F8, $D, 1, $52, $B0
		dc.b $F8, $D, 0, $66, $D9
		dc.b $F8, 1, 1,	$4A, $F9
		dc.b $F7, 4, 0,	$6E, $F6
		dc.b $FF, 4, $18, $6E, $F6
		dc.b $F8, $D, $FF, $F8,	$28
		dc.b $F8, 1, 1,	$70, $48
byte_CD31:	dc.b 4
		dc.b $F8, $D, $FF, $D1,	$B0
		dc.b $F8, $D, $FF, $D9,	$D0
		dc.b $F8, 1, $FF, $E1, $F0
		dc.b $F8, 6, $1F, $E3, $40
byte_CD46:	dc.b 4
		dc.b $F8, $D, $FF, $D1,	$B0
		dc.b $F8, $D, $FF, $D9,	$D0
		dc.b $F8, 1, $FF, $E1, $F0
		dc.b $F8, 6, $1F, $E9, $40
byte_CD5B:	dc.b 3
		dc.b $F8, $D, $FF, $D1,	$B0
		dc.b $F8, $D, $FF, $D9,	$D0
		dc.b $F8, 1, $FF, $E1, $F0
byte_CD6B:	dc.b $C			; "SPECIAL STAGE"
		dc.b $F8, 5, 0,	$3E, $9C
		dc.b $F8, 5, 0,	$36, $AC
		dc.b $F8, 5, 0,	$10, $BC
		dc.b $F8, 5, 0,	8, $CC
		dc.b $F8, 1, 0,	$20, $DC
		dc.b $F8, 5, 0,	0, $E4
		dc.b $F8, 5, 0,	$26, $F4
		dc.b $F8, 5, 0,	$3E, $14
		dc.b $F8, 5, 0,	$42, $24
		dc.b $F8, 5, 0,	0, $34
		dc.b $F8, 5, 0,	$18, $44
		dc.b $F8, 5, 0,	$10, $54
byte_CDA8:	dc.b $F			; "SONIC GOT THEM ALL"
		dc.b $F8, 5, 0,	$3E, $88
		dc.b $F8, 5, 0,	$32, $98
		dc.b $F8, 5, 0,	$2E, $A8
		dc.b $F8, 1, 0,	$20, $B8
		dc.b $F8, 5, 0,	8, $C0
		dc.b $F8, 5, 0,	$18, $D8
		dc.b $F8, 5, 0,	$32, $E8
		dc.b $F8, 5, 0,	$42, $F8
		dc.b $F8, 5, 0,	$42, $10
		dc.b $F8, 5, 0,	$1C, $20
		dc.b $F8, 5, 0,	$10, $30
		dc.b $F8, 5, 0,	$2A, $40
		dc.b $F8, 5, 0,	0, $58
		dc.b $F8, 5, 0,	$26, $68
		dc.b $F8, 5, 0,	$26, $78
		even