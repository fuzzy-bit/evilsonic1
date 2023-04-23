; ---------------------------------------------------------------------------
; Sprite mappings - Eggman in broken eggmobile (FZ)
; ---------------------------------------------------------------------------
Map_FZDamaged_internal:
		dc.w @damage1-Map_FZDamaged_internal
		dc.w @damage2-Map_FZDamaged_internal
@damage1:	dc.w 6
		dc.b $E4, 8, 0,	$20, $FF, $F4
		dc.b $EC, $D, 0, $23, $FF, $E4
		dc.b $EC, 9, 0,	$2B, $00, 4
		dc.b $FC, 5, $20, $3A, $FF, $E4
		dc.b $FC, $E, $20, $3E,	$00, 4
		dc.b $14, 4, $20, $4A, $00, 4
@damage2:	dc.w 6
		dc.b $E4, $A, 0, $31, $FF, $F4
		dc.b $EC, 5, 0,	$23, $FF, $E4
		dc.b $EC, 9, 0,	$2B, $00, 4
		dc.b $FC, 5, $20, $3A, $FF, $E4
		dc.b $FC, $E, $20, $3E,	$00, 4
		dc.b $14, 4, $20, $4A, $00, 4
		even