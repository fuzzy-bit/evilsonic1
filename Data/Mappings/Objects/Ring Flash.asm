; ---------------------------------------------------------------------------
; Sprite mappings - flash effect when you collect the giant ring
; ---------------------------------------------------------------------------
Map_Flash_internal:
		dc.w byte_A084-Map_Flash_internal
		dc.w byte_A08F-Map_Flash_internal
		dc.w byte_A0A4-Map_Flash_internal
		dc.w byte_A0B9-Map_Flash_internal
		dc.w byte_A0CE-Map_Flash_internal
		dc.w byte_A0E3-Map_Flash_internal
		dc.w byte_A0F8-Map_Flash_internal
		dc.w byte_A103-Map_Flash_internal
byte_A084:	dc.w 2
		dc.b $E0, $F, 0, 0, $00, 0
		dc.b 0,	$F, $10, 0, $00, 0
byte_A08F:	dc.w 4
		dc.b $E0, $F, 0, $10, $FF, $F0
		dc.b $E0, 7, 0,	$20, $00, $10
		dc.b 0,	$F, $10, $10, $FF, $F0
		dc.b 0,	7, $10,	$20, $00, $10
byte_A0A4:	dc.w 4
		dc.b $E0, $F, 0, $28, $FF, $E8
		dc.b $E0, $B, 0, $38, $00, 8
		dc.b 0,	$F, $10, $28, $FF, $E8
		dc.b 0,	$B, $10, $38, $00, 8
byte_A0B9:	dc.w 4
		dc.b $E0, $F, 8, $34, $FF, $E0
		dc.b $E0, $F, 0, $34, $00, 0
		dc.b 0,	$F, $18, $34, $FF, $E0
		dc.b 0,	$F, $10, $34, $00, 0
byte_A0CE:	dc.w 4
		dc.b $E0, $B, 8, $38, $FF, $E0
		dc.b $E0, $F, 8, $28, $FF, $F8
		dc.b 0,	$B, $18, $38, $FF, $E0
		dc.b 0,	$F, $18, $28, $FF, $F8
byte_A0E3:	dc.w 4
		dc.b $E0, 7, 8,	$20, $FF, $E0
		dc.b $E0, $F, 8, $10, $FF, $F0
		dc.b 0,	7, $18,	$20, $FF, $E0
		dc.b 0,	$F, $18, $10, $FF, $F0
byte_A0F8:	dc.w 2
		dc.b $E0, $F, 8, 0, $FF, $E0
		dc.b 0,	$F, $18, 0, $FF, $E0
byte_A103:	dc.w 4
		dc.b $E0, $F, 0, $44, $FF, $E0
		dc.b $E0, $F, 8, $44, $00, 0
		dc.b 0,	$F, $10, $44, $FF, $E0
		dc.b 0,	$F, $18, $44, $00, 0
		even