; ---------------------------------------------------------------------------
; Sprite mappings - Eggman (boss levels)
; ---------------------------------------------------------------------------
Map_Eggman_internal:
		dc.w @ship-Map_Eggman_internal
		dc.w @facenormal1-Map_Eggman_internal
		dc.w @facenormal2-Map_Eggman_internal
		dc.w @facelaugh1-Map_Eggman_internal
		dc.w @facelaugh2-Map_Eggman_internal
		dc.w @facehit-Map_Eggman_internal
		dc.w @facepanic-Map_Eggman_internal
		dc.w @facedefeat-Map_Eggman_internal
		dc.w @flame1-Map_Eggman_internal
		dc.w @flame2-Map_Eggman_internal
		dc.w @blank-Map_Eggman_internal
		dc.w @escapeflame1-Map_Eggman_internal
		dc.w @escapeflame2-Map_Eggman_internal
@ship:		dc.b 6
		dc.b $EC, 1, 0,	$A, $FF, $E4
		dc.b $EC, 5, 0,	$C, $00, $C
		dc.b $FC, $E, $20, $10,	$FF, $E4
		dc.b $FC, $E, $20, $1C,	$00, 4
		dc.b $14, $C, $20, $28,	$FF, $EC
		dc.b $14, 0, $20, $2C, $00, $C
@facenormal1:	dc.b 2
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, 2, $FF, $EC
@facenormal2:	dc.b 2
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, $35, $FF, $EC
@facelaugh1:	dc.b 3
		dc.b $E4, 8, 0,	$3D, $FF, $F4
		dc.b $EC, 9, 0,	$40, $FF, $EC
		dc.b $EC, 5, 0,	$46, $00, 4
@facelaugh2:	dc.b 3
		dc.b $E4, 8, 0,	$4A, $FF, $F4
		dc.b $EC, 9, 0,	$4D, $FF, $EC
		dc.b $EC, 5, 0,	$53, $00, 4
@facehit:	dc.b 3
		dc.b $E4, 8, 0,	$57, $FF, $F4
		dc.b $EC, 9, 0,	$5A, $FF, $EC
		dc.b $EC, 5, 0,	$60, $00, 4
@facepanic:	dc.b 3
		dc.b $E4, 4, 0,	$64, $00, 4
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, $35, $FF, $EC
@facedefeat:	dc.b 4
		dc.b $E4, 9, 0,	$66, $FF, $F4
		dc.b $E4, 8, 0,	$57, $FF, $F4
		dc.b $EC, 9, 0,	$5A, $FF, $EC
		dc.b $EC, 5, 0,	$60, $00, 4
@flame1:	dc.b 1
		dc.b 4,	5, 0, $2D, $00, $22
@flame2:	dc.b 1
		dc.b 4,	5, 0, $31, $00, $22
@blank:		dc.b 0
@escapeflame1:	dc.b 2
		dc.b 0,	8, 1, $2A, $00, $22
		dc.b 8,	8, $11,	$2A, $00, $22
@escapeflame2:	dc.b 2
		dc.b $F8, $B, 1, $2D, $00, $22
		dc.b 0,	1, 1, $39, $00, $3A
		even