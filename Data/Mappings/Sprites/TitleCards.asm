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
M_Card_GHZ:	dc.w 9 			; GREEN HILL
		dc.b	$F8, 5, 0, $45, $FF, $B8
		dc.b	$F8, 5, 0, $71, $FF, $C7
		dc.b	$F8, 5, 0, $3D, $FF, $D6
		dc.b	$F8, 5, 0, $3D, $FF, $E5
		dc.b	$F8, 5, 0, $61, $FF, $F4

		dc.b	$F8, 5, 0, $49, $00, $13
		dc.b	$F8, 5, 0, $4D, $00, $26
		dc.b	$F8, 5, 0, $59, $00, $31
		dc.b	$F8, 5, 0, $59, $00, $40
		even
M_Card_LZ:	dc.w 9			; LABYRINTH
		dc.b	$F8, 5, 0, $59, $FF, $B8
		dc.b	$F8, 5, 0, $2D, $FF, $C7
		dc.b	$F8, 5, 0, $31, $FF, $D6
		dc.b	$F8, 5, 0, $8D, $FF, $E5
		dc.b	$F8, 5, 0, $71, $FF, $F4
		dc.b	$F8, 5, 0, $4D, $00, $8
		dc.b	$F8, 5, 0, $61, $00, $13
		dc.b	$F8, 5, 0, $79, $00, $22
		dc.b	$F8, 5, 0, $49, $00, $31
		even
M_Card_MZ:	dc.w 6			; MARBLE
		dc.b $F8, 5, 0,	$2A, $FF, $CF
		dc.b $F8, 5, 0,	0, $FF, $E0
		dc.b $F8, 5, 0,	$3A, $FF, $F0
		dc.b $F8, 5, 0,	4, $00, 0
		dc.b $F8, 5, 0,	$26, $00, $10
		dc.b $F8, 5, 0,	$10, $00, $20
		even
M_Card_SLZ:	dc.w 9		; STAR LIGHT
		dc.b	$F8, 5, 0, $75, $FF, $B8
		dc.b	$F8, 5, 0, $79, $FF, $C7
		dc.b	$F8, 5, 0, $2D, $FF, $D6
		dc.b	$F8, 5, 0, $71, $FF, $E5

		dc.b	$F8, 5, 0, $59, $00, $4
		dc.b	$F8, 5, 0, $4D, $00, $17
		dc.b	$F8, 5, 0, $45, $00, $22
		dc.b	$F8, 5, 0, $49, $00, $31
		dc.b	$F8, 5, 0, $79, $00, $40

		even
M_Card_SYZ:	dc.w 10		; SPRING YARD
		dc.b	$F8, 5, 0, $75, $FF, $B0
		dc.b	$F8, 5, 0, $69, $FF, $BF
		dc.b	$F8, 5, 0, $71, $FF, $CE
		dc.b	$F8, 5, 0, $4D, $FF, $E1
		dc.b	$F8, 5, 0, $61, $FF, $EC
		dc.b	$F8, 5, 0, $45, $FF, $FB

		dc.b	$F8, 5, 0, $8D, $00, $1A
		dc.b	$F8, 5, 0, $2D, $00, $29
		dc.b	$F8, 5, 0, $71, $00, $38
		dc.b	$F8, 5, 0, $39, $00, $47

		even
M_Card_SBZ:	dc.w 9		; CLOCK WORK
		dc.b	$F8, 5, 0, $35, $FF, $B8
		dc.b	$F8, 5, 0, $59, $FF, $C7
		dc.b	$F8, 5, 0, $65, $FF, $D6
		dc.b	$F8, 5, 0, $35, $FF, $E5
		dc.b	$F8, 5, 0, $55, $FF, $F4

		dc.b	$F8, 5, 0, $85, $00, $13
		dc.b	$F8, 5, 0, $65, $00, $22
		dc.b	$F8, 5, 0, $71, $00, $31
		dc.b	$F8, 5, 0, $55, $00, $40
		even
M_Card_Zone:	dc.w 4			; ZONE
		dc.b $F8, 5, 0,	$91, $FF, $E0
		dc.b $F8, 5, 0,	$65, $FF, $F0
		dc.b $F8, 5, 0,	$61, $00, 0
		dc.b $F8, 5, 0,	$3D, $00, $10
		even
M_Card_Act1:	dc.w 0			; ACT 1
		;dc.b 4,	$C, 0, $0, $FF, $EC
		;dc.b $F4, 2, 0,	$4, $00, $C
M_Card_Act2:	dc.w 0			; ACT 2
		;dc.b 4,	$C, 0, $0, $FF, $EC
		;dc.b $F4, 6, 0,	$7, $00, 8
M_Card_Act3:	dc.w 0			; ACT 3
		;dc.b 4,	$C, 0, $0, $FF, $EC
		;dc.b $F4, 6, 0,	$D, $00, 8
M_Card_Oval:	dc.w $0			; Oval
		; dc.b $E4, $C, 0, $1D, $FF, $F4
		; dc.b $E4, 2, 0,	$21, $00, $14
		; dc.b $EC, 4, 0,	$24, $FF, $EC 
		; dc.b $F4, 5, 0,	$26, $FF, $E4	
		; dc.b $14, $C, $18, $1D,	$FF, $EC
		; dc.b 4,	2, $18,	$21, $FF, $E4
		; dc.b $C, 4, $18, $24, $00, 4	
		; dc.b $FC, 5, $18, $26, $00, $C	
		; dc.b $EC, 8, 0,	$2A, $FF, $FC
		; dc.b $F4, $C, 0, $29, $FF, $F4
		; dc.b $FC, 8, 0,	$29, $FF, $F4
		; dc.b 4,	$C, 0, $29, $FF, $EC
		; dc.b $C, 8, 0, $29, $FF, $EC
		; even
M_Card_FZ:	dc.w 5			; FINAL
		dc.b $F8, 5, 0,	$14, $FF, $DC
		dc.b $F8, 1, 0,	$20, $FF, $EC
		dc.b $F8, 5, 0,	$2E, $FF, $F4
		dc.b $F8, 5, 0,	0, $00, 4
		dc.b $F8, 5, 0,	$26, $00, $14
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
M_Got_SonicHas:	dc.w 11		; SONIC REIGNS
		dc.b	$F8, 5, 0, $75, $FF, $A4
		dc.b	$F8, 5, 0, $65, $FF, $B3
		dc.b	$F8, 5, 0, $61, $FF, $C2
		dc.b	$F8, 5, 0, $4D, $FF, $D5
		dc.b	$F8, 5, 0, $35, $FF, $E0

		dc.b	$F8, 5, 0, $71, $FF, $FE
		dc.b	$F8, 5, 0, $3D, $0, $E
		dc.b	$F8, 5, 0, $4D, $0, $21
		dc.b	$F8, 5, 0, $45, $0, $2C
		dc.b	$F8, 5, 0, $61, $0, $3B
		dc.b	$F8, 5, 0, $75, $0, $4A
		
M_Got_Passed:	dc.w 7		; SUPREME
		dc.b	$F8, 5, 0, $75, $FF, $CA
		dc.b	$F8, 5, 0, $7D, $FF, $DA
		dc.b	$F8, 5, 0, $69, $FF, $EA
		dc.b	$F8, 5, 0, $71, $FF, $FA
		dc.b	$F8, 5, 0, $3D, $0, $B
		dc.b	$F8, 5, 0, $5D, $0, $1C
		dc.b	$F8, 5, 0, $3D, $0, $2B

M_Got_Score:	dc.w 6			; SCORE
		dc.b $F8, $D, 1, $4A, $FF, $B0
		dc.b $F8, 1, 1,	$62, $FF, $D0
		dc.b $F8, 9, 1,	$64, $00, $18
		dc.b $F8, $D, 1, $6A, $00, $30
		dc.b $F7, 4, 0,	$6E, $FF, $CD
		dc.b $FF, 4, $18, $6E, $FF, $CD
M_Got_TBonus:	dc.w 7			; TIME BONUS
		dc.b $F8, $D, 1, $5A, $FF, $B0
		dc.b $F8, $D, 0, $66, $FF, $D9
		dc.b $F8, 1, 1,	$4A, $FF, $F9
		dc.b $F7, 4, 0,	$6E, $FF, $F6
		dc.b $FF, 4, $18, $6E, $FF, $F6
		dc.b $F8, $D, $FF, $F0,	$00, $28
		dc.b $F8, 1, 1,	$70, $00, $48
M_Got_RBonus:	dc.w 7			; RING BONUS
		dc.b $F8, $D, 1, $52, $FF, $B0
		dc.b $F8, $D, 0, $66, $FF, $D9
		dc.b $F8, 1, 1,	$4A, $FF, $F9
		dc.b $F7, 4, 0,	$6E, $FF, $F6
		dc.b $FF, 4, $18, $6E, $FF, $F6
		dc.b $F8, $D, $FF, $F8,	$00, $28
		dc.b $F8, 1, 1,	$70, $00, $48
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
M_SSR_Chaos:	dc.w $D			; "CHAOS EMERALDS"
		dc.b $F8, 5, 0,	8, $FF, $90
		dc.b $F8, 5, 0,	$1C, $FF, $A0
		dc.b $F8, 5, 0,	0, $FF, $B0
		dc.b $F8, 5, 0,	$32, $FF, $C0
		dc.b $F8, 5, 0,	$3E, $FF, $D0
		dc.b $F8, 5, 0,	$10, $FF, $F0
		dc.b $F8, 5, 0,	$2A, $00, 0
		dc.b $F8, 5, 0,	$10, $00, $10
		dc.b $F8, 5, 0,	$3A, $00, $20
		dc.b $F8, 5, 0,	0, $00, $30
		dc.b $F8, 5, 0,	$26, $00, $40
		dc.b $F8, 5, 0,	$C, $00, $50
		dc.b $F8, 5, 0,	$3E, $00, $60
M_SSR_Score:	dc.w 6			; "SCORE"
		dc.b $F8, $D, 1, $4A, $FF, $B0
		dc.b $F8, 1, 1,	$62, $FF, $D0
		dc.b $F8, 9, 1,	$64, $00, $18
		dc.b $F8, $D, 1, $6A, $00, $30
		dc.b $F7, 4, 0,	$6E, $FF, $CD
		dc.b $FF, 4, $18, $6E, $FF, $CD
byte_CD0D:	dc.w 7
		dc.b $F8, $D, 1, $52, $FF, $B0
		dc.b $F8, $D, 0, $66, $FF, $D9
		dc.b $F8, 1, 1,	$4A, $FF, $F9
		dc.b $F7, 4, 0,	$6E, $FF, $F6
		dc.b $FF, 4, $18, $6E, $FF, $F6
		dc.b $F8, $D, $FF, $F8,	$00, $28
		dc.b $F8, 1, 1,	$70, $00, $48
byte_CD31:	dc.w 4
		dc.b $F8, $D, $FF, $D1,	$FF, $B0
		dc.b $F8, $D, $FF, $D9,	$FF, $D0
		dc.b $F8, 1, $FF, $E1, $FF, $F0
		dc.b $F8, 6, $1F, $E3, $00, $40
byte_CD46:	dc.w 4
		dc.b $F8, $D, $FF, $D1,	$FF, $B0
		dc.b $F8, $D, $FF, $D9,	$FF, $D0
		dc.b $F8, 1, $FF, $E1, $FF, $F0
		dc.b $F8, 6, $1F, $E9, $00, $40
byte_CD5B:	dc.w 3
		dc.b $F8, $D, $FF, $D1,	$FF, $B0
		dc.b $F8, $D, $FF, $D9,	$FF, $D0
		dc.b $F8, 1, $FF, $E1, $FF, $F0
byte_CD6B:	dc.w $C			; "SPECIAL STAGE"
		dc.b $F8, 5, 0,	$3E, $FF, $9C
		dc.b $F8, 5, 0,	$36, $FF, $AC
		dc.b $F8, 5, 0,	$10, $FF, $BC
		dc.b $F8, 5, 0,	8, $FF, $CC
		dc.b $F8, 1, 0,	$20, $FF, $DC
		dc.b $F8, 5, 0,	0, $FF, $E4
		dc.b $F8, 5, 0,	$26, $FF, $F4
		dc.b $F8, 5, 0,	$3E, $00, $14
		dc.b $F8, 5, 0,	$42, $00, $24
		dc.b $F8, 5, 0,	0, $00, $34
		dc.b $F8, 5, 0,	$18, $00, $44
		dc.b $F8, 5, 0,	$10, $00, $54
byte_CDA8:	dc.w $F			; "SONIC GOT THEM ALL"
		dc.b $F8, 5, 0,	$3E, $FF, $88
		dc.b $F8, 5, 0,	$32, $FF, $98
		dc.b $F8, 5, 0,	$2E, $FF, $A8
		dc.b $F8, 1, 0,	$20, $FF, $B8
		dc.b $F8, 5, 0,	8, $FF, $C0
		dc.b $F8, 5, 0,	$18, $FF, $D8
		dc.b $F8, 5, 0,	$32, $FF, $E8
		dc.b $F8, 5, 0,	$42, $FF, $F8
		dc.b $F8, 5, 0,	$42, $00, $10
		dc.b $F8, 5, 0,	$1C, $00, $20
		dc.b $F8, 5, 0,	$10, $00, $30
		dc.b $F8, 5, 0,	$2A, $00, $40
		dc.b $F8, 5, 0,	0, $00, $58
		dc.b $F8, 5, 0,	$26, $00, $68
		dc.b $F8, 5, 0,	$26, $00, $78
		even