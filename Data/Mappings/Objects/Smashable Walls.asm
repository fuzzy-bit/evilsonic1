; ---------------------------------------------------------------------------
; Sprite mappings - smashable walls (GHZ, SLZ)
; ---------------------------------------------------------------------------
Map_Smash_internal:
		dc.w @left-Map_Smash_internal
		dc.w @middle-Map_Smash_internal
		dc.w @right-Map_Smash_internal
@left:		dc.b 8
		dc.b $E0, 5, 0,	0, $FF, $F0
		dc.b $F0, 5, 0,	0, $FF, $F0
		dc.b 0,	5, 0, 0, $FF, $F0
		dc.b $10, 5, 0,	0, $FF, $F0
		dc.b $E0, 5, 0,	4, $00, 0
		dc.b $F0, 5, 0,	4, $00, 0
		dc.b 0,	5, 0, 4, $00, 0
		dc.b $10, 5, 0,	4, $00, 0
@middle:	dc.w 8
		dc.b $E0, 5, 0,	4, $FF, $F0
		dc.b $F0, 5, 0,	4, $FF, $F0
		dc.b 0,	5, 0, 4, $FF, $F0
		dc.b $10, 5, 0,	4, $FF, $F0
		dc.b $E0, 5, 0,	4, $00, 0
		dc.b $F0, 5, 0,	4, $00, 0
		dc.b 0,	5, 0, 4, $00, 0
		dc.b $10, 5, 0,	4, $00, 0
@right:		dc.b 8
		dc.b $E0, 5, 0,	4, $FF, $F0
		dc.b $F0, 5, 0,	4, $FF, $F0
		dc.b 0,	5, 0, 4, $FF, $F0
		dc.b $10, 5, 0,	4, $FF, $F0
		dc.b $E0, 5, 0,	8, $00, 0
		dc.b $F0, 5, 0,	8, $00, 0
		dc.b 0,	5, 0, 8, $00, 0
		dc.b $10, 5, 0,	8, $00, 0
		even