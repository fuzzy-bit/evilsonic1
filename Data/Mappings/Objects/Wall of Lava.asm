; ---------------------------------------------------------------------------
; Sprite mappings - advancing wall of lava (MZ)
; ---------------------------------------------------------------------------
Map_LWall_internal:
		dc.w byte_F538-Map_LWall_internal
		dc.w byte_F566-Map_LWall_internal
		dc.w byte_F594-Map_LWall_internal
		dc.w byte_F5C2-Map_LWall_internal
		dc.w byte_F5F0-Map_LWall_internal
byte_F538:	dc.w 9
		dc.b $E0, $F, 0, $60, $00, $20
		dc.b 0,	$F, 0, $70, $00, $3C
		dc.b 0,	$F, $FF, $2A, $00, $20
		dc.b $E0, $F, $FF, $2A,	$00, 0
		dc.b 0,	$F, $FF, $2A, $00, 0
		dc.b $E0, $F, $FF, $2A,	$FF, $E0
		dc.b 0,	$F, $FF, $2A, $FF, $E0
		dc.b $E0, $F, $FF, $2A,	$FF, $C0
		dc.b 0,	$F, $FF, $2A, $FF, $C0
byte_F566:	dc.w 9
		dc.b $E0, $F, 0, $70, $00, $20
		dc.b 0,	$F, 0, $80, $00, $3C
		dc.b 0,	$F, $FF, $2A, $00, $20
		dc.b $E0, $F, $FF, $2A,	$00, 0
		dc.b 0,	$F, $FF, $2A, $00, 0
		dc.b $E0, $F, $FF, $2A,	$FF, $E0
		dc.b 0,	$F, $FF, $2A, $FF, $E0
		dc.b $E0, $F, $FF, $2A,	$FF, $C0
		dc.b 0,	$F, $FF, $2A, $FF, $C0
byte_F594:	dc.w 9
		dc.b $E0, $F, 0, $80, $00, $20
		dc.b 0,	$F, 0, $70, $00, $3C
		dc.b 0,	$F, $FF, $2A, $00, $20
		dc.b $E0, $F, $FF, $2A,	$00, 0
		dc.b 0,	$F, $FF, $2A, $00, 0
		dc.b $E0, $F, $FF, $2A,	$FF, $E0
		dc.b 0,	$F, $FF, $2A, $FF, $E0
		dc.b $E0, $F, $FF, $2A,	$FF, $C0
		dc.b 0,	$F, $FF, $2A, $FF, $C0
byte_F5C2:	dc.w 9
		dc.b $E0, $F, 0, $70, $00, $20
		dc.b 0,	$F, 0, $60, $00, $3C
		dc.b 0,	$F, $FF, $2A, $00, $20
		dc.b $E0, $F, $FF, $2A,	$00, 0
		dc.b 0,	$F, $FF, $2A, $00, 0
		dc.b $E0, $F, $FF, $2A,	$FF, $E0
		dc.b 0,	$F, $FF, $2A, $FF, $E0
		dc.b $E0, $F, $FF, $2A,	$FF, $C0
		dc.b 0,	$F, $FF, $2A, $FF, $C0
byte_F5F0:	dc.w 8
		dc.b $E0, $F, $FF, $2A,	$00, $20
		dc.b 0,	$F, $FF, $2A, $00, $20
		dc.b $E0, $F, $FF, $2A,	$00, 0
		dc.b 0,	$F, $FF, $2A, $00, 0
		dc.b $E0, $F, $FF, $2A,	$FF, $E0
		dc.b 0,	$F, $FF, $2A, $FF, $E0
		dc.b $E0, $F, $FF, $2A,	$FF, $C0
		dc.b 0,	$F, $FF, $2A, $FF, $C0
		even