; ---------------------------------------------------------------------------
; Sprite mappings - disc that you run around (SBZ)
; (It's just a small blob that moves around in a circle. The disc itself is
; part of the level tiles.)
; ---------------------------------------------------------------------------
Map_Disc_internal:
		dc.w @spot-Map_Disc_internal
@spot:		dc.w 1
		dc.b $F8, 5, 0,	0, $FF, $F8
		even