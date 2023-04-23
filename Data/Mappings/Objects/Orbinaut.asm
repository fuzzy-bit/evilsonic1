; ---------------------------------------------------------------------------
; Sprite mappings - Orbinaut enemy (LZ,	SLZ, SBZ)
; ---------------------------------------------------------------------------
Map_Orb_internal:
		dc.w @normal-Map_Orb_internal
		dc.w @medium-Map_Orb_internal
		dc.w @angry-Map_Orb_internal
		dc.w @spikeball-Map_Orb_internal
@normal:	dc.w 1
		dc.b $F4, $A, 0, 0, $FF, $F4
@medium:	dc.w 1
		dc.b $F4, $A, $20, 9, $FF, $F4
@angry:		dc.b 1
		dc.b $F4, $A, 0, $12, $FF, $F4
@spikeball:	dc.w 1
		dc.b $F8, 5, 0,	$1B, $FF, $F8
		even