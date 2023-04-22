; ---------------------------------------------------------------------------
; Sprite mappings - spiked ball	on a chain (LZ)
; ---------------------------------------------------------------------------
Map_SBall2_internal:
		dc.w @chain-Map_SBall2_internal
		dc.w @spikeball-Map_SBall2_internal
		dc.w @base-Map_SBall2_internal
@chain:		dc.b 1
		dc.b $F8, 5, 0,	0, $FF, $F8	; chain link
@spikeball:	dc.b 1
		dc.b $F0, $F, 0, 4, $FF, $F0	; spikeball
@base:		dc.b 1
		dc.b $F8, 5, 0,	$14, $FF, $F8 ; wall attachment
		even