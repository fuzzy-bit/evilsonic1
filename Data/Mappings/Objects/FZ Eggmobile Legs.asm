; ---------------------------------------------------------------------------
; Sprite mappings - legs on Eggman's escape ship (FZ)
; ---------------------------------------------------------------------------
Map_FZLegs_internal:
		dc.w @extended-Map_FZLegs_internal
		dc.w @halfway-Map_FZLegs_internal
		dc.w @retracted-Map_FZLegs_internal
@extended:	dc.b 2
		dc.b $14, $E, $28, 0, $FF, $F4
		dc.b $24, 0, $28, $C, $FF, $EC
@halfway:	dc.b 3
		dc.b $C, 5, $28, $D, $C
		dc.b $1C, 0, $28, $11, $C
		dc.b $14, $D, $28, $12,	$FF, $EC
@retracted:	dc.b 2
		dc.b $C, 1, $28, $1A, $C
		dc.b $14, $C, $28, $1C,	$FF, $EC
		even