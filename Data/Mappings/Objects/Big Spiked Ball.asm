; ---------------------------------------------------------------------------
; Sprite mappings - spiked ball on a chain (SBZ) and big spiked ball (SYZ)
; ---------------------------------------------------------------------------
Map_BBall_internal:
		dc.w @ball-Map_BBall_internal
		dc.w @chain-Map_BBall_internal
		dc.w @anchor-Map_BBall_internal
@ball:		dc.b 5
		dc.b $E8, 4, 0,	0, $FF, $F8	; big spiked ball
		dc.b $F0, $F, 0, 2, $FF, $F0
		dc.b $F8, 1, 0,	$12, $FF, $E8
		dc.b $F8, 1, 0,	$14, $00, $10
		dc.b $10, 4, 0,	$16, $FF, $F8
@chain:		dc.b 1
		dc.b $F8, 5, 0,	$20, $FF, $F8 ; chain link (SBZ)
@anchor:	dc.b 2
		dc.b $F8, $D, 0, $18, $FF, $F0 ; anchor at base of chain (SBZ)
		dc.b $E8, $D, $10, $18,	$FF, $F0
		even