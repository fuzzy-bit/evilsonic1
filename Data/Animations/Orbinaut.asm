; ---------------------------------------------------------------------------
; Animation script - Orbinaut enemy
; ---------------------------------------------------------------------------
Ani_Orb:	dc.w @normal-Ani_Orb
		dc.w @angers-Ani_Orb
		dc.w @veryangers-Ani_Orb
@normal:	dc.b $F, 0, afEnd
		even
@angers:	dc.b $F, 1, 2, afBack, 1
		even
@veryangers:	dc.b	$F, 4, afEnd
		even