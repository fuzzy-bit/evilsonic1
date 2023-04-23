; ---------------------------------------------------------------------------
; Sprite mappings - cylinders Eggman hides in (FZ)
; ---------------------------------------------------------------------------
Map_EggCyl_internal:
		dc.w @flat-Map_EggCyl_internal
		dc.w @extending1-Map_EggCyl_internal
		dc.w @extending2-Map_EggCyl_internal
		dc.w @extending3-Map_EggCyl_internal
		dc.w @extending4-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @extendedfully-Map_EggCyl_internal
		dc.w @controlpanel-Map_EggCyl_internal
@flat:		dc.b 6
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
@extending1:	dc.w 8
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
		dc.b $D8, $F, $40, $20,	$FF, $E0
		dc.b $D8, $F, $48, $20,	$00, 0
@extending2:	dc.w $A
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
		dc.b $D8, $F, $40, $20,	$FF, $E0
		dc.b $D8, $F, $48, $20,	$00, 0
		dc.b $F8, $F, $40, $30,	$FF, $E0
		dc.b $F8, $F, $48, $30,	$00, 0
@extending3:	dc.w $C
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
		dc.b $D8, $F, $40, $20,	$FF, $E0
		dc.b $D8, $F, $48, $20,	$00, 0
		dc.b $F8, $F, $40, $30,	$FF, $E0
		dc.b $F8, $F, $48, $30,	$00, 0
		dc.b $18, $F, $40, $40,	$FF, $E0
		dc.b $18, $F, $48, $40,	$00, 0
@extending4:	dc.w $D
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
		dc.b $D8, $F, $40, $20,	$FF, $E0
		dc.b $D8, $F, $48, $20,	$00, 0
		dc.b $F8, $F, $40, $30,	$FF, $E0
		dc.b $F8, $F, $48, $30,	$00, 0
		dc.b $18, $F, $40, $40,	$FF, $E0
		dc.b $18, $F, $48, $40,	$00, 0
		dc.b $38, $F, $40, $50,	$FF, $F0
@extendedfully:	dc.w $E
		dc.b $A0, $D, $40, 0, $FF, $E0
		dc.b $A0, $D, $48, 0, $00, 0
		dc.b $B0, $C, $20, 8, $FF, $E0
		dc.b $B0, $C, $20, $C, $00, 0
		dc.b $B8, $F, $40, $10,	$FF, $E0
		dc.b $B8, $F, $48, $10,	$00, 0
		dc.b $D8, $F, $40, $20,	$FF, $E0
		dc.b $D8, $F, $48, $20,	$00, 0
		dc.b $F8, $F, $40, $30,	$FF, $E0
		dc.b $F8, $F, $48, $30,	$00, 0
		dc.b $18, $F, $40, $40,	$FF, $E0
		dc.b $18, $F, $48, $40,	$00, 0
		dc.b $38, $F, $40, $50,	$FF, $F0
		dc.b $58, $F, $40, $50,	$FF, $F0
@controlpanel:	dc.w 2
		dc.b $F8, 4, 0,	$68, $FF, $F0
		dc.b 0,	$C, 0, $6A, $FF, $F0
		even