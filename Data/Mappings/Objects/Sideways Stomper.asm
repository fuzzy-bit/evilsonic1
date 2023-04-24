; ---------------------------------------------------------------------------
; Sprite mappings - spiked metal block from beta version (MZ)
; ---------------------------------------------------------------------------
Map_SStom_internal:
		dc.w @block-Map_SStom_internal
		dc.w @spikes-Map_SStom_internal
		dc.w @wallbracket-Map_SStom_internal
		dc.w @pole1-Map_SStom_internal
		dc.w @pole2-Map_SStom_internal
		dc.w @pole3-Map_SStom_internal
		dc.w @pole4-Map_SStom_internal
		dc.w @pole5-Map_SStom_internal
		dc.w @pole5-Map_SStom_internal
@block:		dc.w 3
		dc.b $E0, $B, 0, $1F, $FF, $F4 ; main metal block
		dc.b 0,	$B, $10, $1F, $FF, $F4
		dc.b $F0, 3, 0,	$2B, $00, $C
@spikes:	dc.w 3
		dc.b $E8, $C, $12, $1B,	$FF, $F0 ; three spikes
		dc.b $FC, $C, $12, $1B,	$FF, $F0
		dc.b $10, $C, $12, $1B,	$FF, $F0
@wallbracket:	dc.w 1
		dc.b $F0, 3, 8,	$2B, $FF, $FC ; thing holding it to the wall
@pole1:		dc.w 2
		dc.b $F8, 5, 0,	$41, $FF, $E0 ; poles of various lengths
		dc.b $F8, 5, 0,	$41, $FF, $F0
@pole2:		dc.w 4
		dc.b $F8, 5, 0,	$41, $FF, $E0
		dc.b $F8, 5, 0,	$41, $FF, $F0
		dc.b $F8, 5, 0,	$41, $00, 0
		dc.b $F8, 5, 0,	$41, $00, $10
@pole3:		dc.w 6
		dc.b $F8, 5, 0,	$41, $FF, $E0
		dc.b $F8, 5, 0,	$41, $FF, $F0
		dc.b $F8, 5, 0,	$41, $00, 0
		dc.b $F8, 5, 0,	$41, $00, $10
		dc.b $F8, 5, 0,	$41, $00, $20
		dc.b $F8, 5, 0,	$41, $00, $30
@pole4:		dc.w 8
		dc.b $F8, 5, 0,	$41, $FF, $E0
		dc.b $F8, 5, 0,	$41, $FF, $F0
		dc.b $F8, 5, 0,	$41, $00, 0
		dc.b $F8, 5, 0,	$41, $00, $10
		dc.b $F8, 5, 0,	$41, $00, $20
		dc.b $F8, 5, 0,	$41, $00, $30
		dc.b $F8, 5, 0,	$41, $00, $40
		dc.b $F8, 5, 0,	$41, $00, $50
@pole5:		dc.b 8		; Incorrect: this should be $A
		dc.b $F8, 5, 0,	$41, $FF, $E0
		dc.b $F8, 5, 0,	$41, $FF, $F0
		dc.b $F8, 5, 0,	$41, $00, 0
		dc.b $F8, 5, 0,	$41, $00, $10
		dc.b $F8, 5, 0,	$41, $00, $20
		dc.b $F8, 5, 0,	$41, $00, $30
		dc.b $F8, 5, 0,	$41, $00, $40
		dc.b $F8, 5, 0,	$41, $00, $50
		dc.b $F8, 5, 0,	$41, $00, $60
		dc.b $F8, 5, 0,	$41, $00, $70
		; @pole6 should be here, but it isn't...
		even