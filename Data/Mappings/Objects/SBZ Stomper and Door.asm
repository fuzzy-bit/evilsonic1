; ---------------------------------------------------------------------------
; Sprite mappings - stomper and	platforms (SBZ)
; ---------------------------------------------------------------------------
Map_Stomp_internal:
		dc.w @door-Map_Stomp_internal
		dc.w @stomper-Map_Stomp_internal
		dc.w @stomper-Map_Stomp_internal
		dc.w @stomper-Map_Stomp_internal
		dc.w @bigdoor-Map_Stomp_internal
@door:		dc.b 4
		dc.b $F4, $E, $21, $AF,	$FF, $C0 ; horizontal sliding door
		dc.b $F4, $E, $21, $B2,	$FF, $E0
		dc.b $F4, $E, $21, $B2,	$00, 0
		dc.b $F4, $E, $29, $AF,	$00, $20
@stomper:	dc.w 8
		dc.b $E0, $C, 0, $C, $FF, $E4 ; stomper block with yellow/black stripes
		dc.b $E0, 8, 0,	$10, $00, 4
		dc.b $E8, $E, $20, $13,	$FF, $E4
		dc.b $E8, $A, $20, $1F,	$00, 4
		dc.b 0,	$E, $20, $13, $FF, $E4
		dc.b 0,	$A, $20, $1F, $00, 4
		dc.b $18, $C, 0, $C, $FF, $E4
		dc.b $18, 8, 0,	$10, $00, 4
@bigdoor:	dc.w $E
		dc.b $C0, $F, 0, 0, $FF, $80	; huge diagonal sliding door from SBZ3
		dc.b $C0, $F, 0, $10, $FF, $A0
		dc.b $C0, $F, 0, $20, $FF, $C0
		dc.b $C0, $F, 0, $10, $FF, $E0
		dc.b $C0, $F, 0, $20, $00, 0
		dc.b $C0, $F, 0, $10, $00, $20
		dc.b $C0, $F, 0, $30, $00, $40
		dc.b $C0, $D, 0, $40, $00, $60
		dc.b $E0, $F, 0, $48, $FF, $80
		dc.b $E0, $F, 0, $48, $FF, $C0
		dc.b $E0, $F, 0, $58, $00, 0
		dc.b 0,	$F, 0, $48, $FF, $80
		dc.b 0,	$F, 0, $58, $FF, $C0
		dc.b $20, $F, 0, $58, $FF, $80
		even