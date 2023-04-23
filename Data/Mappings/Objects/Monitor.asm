; ---------------------------------------------------------------------------
; Sprite mappings - monitors
; ---------------------------------------------------------------------------
Map_Monitor_internal:
		dc.w @static0-Map_Monitor_internal
		dc.w @static1-Map_Monitor_internal
		dc.w @static2-Map_Monitor_internal
		dc.w @eggman-Map_Monitor_internal
		dc.w @sonic-Map_Monitor_internal
		dc.w @shoes-Map_Monitor_internal
		dc.w @shield-Map_Monitor_internal
		dc.w @invincible-Map_Monitor_internal
		dc.w @rings-Map_Monitor_internal
		dc.w @s-Map_Monitor_internal
		dc.w @goggles-Map_Monitor_internal
		dc.w @broken-Map_Monitor_internal
@static0:	dc.w 1			; static monitor
		dc.b $EF, $F, 0, 0, $FF, $F0
@static1:	dc.w 2			; static monitor
		dc.b $F5, 5, 0,	$10, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@static2:	dc.w 2			; static monitor
		dc.b $F5, 5, 0,	$14, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@eggman:	dc.w 2			; Eggman monitor
		dc.b $F5, 5, 0,	$18, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@sonic:		dc.w 2			; Sonic	monitor
		dc.b $F5, 5, 0,	$1C, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@shoes:		dc.w 2			; speed	shoes monitor
		dc.b $F5, 5, 0,	$24, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@shield:	dc.w 2			; shield monitor
		dc.b $F5, 5, 0,	$28, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@invincible:	dc.w 2			; invincibility	monitor
		dc.b $F5, 5, 0,	$2C, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@rings:		dc.w 2			; 10 rings monitor
		dc.b $F5, 5, 0,	$30, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@s:		dc.w 2			; 'S' monitor
		dc.b $F5, 5, 0,	$34, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@goggles:	dc.w 2			; goggles monitor
		dc.b $F5, 5, 0,	$20, $FF, $F8
		dc.b $EF, $F, 0, 0, $FF, $F0
@broken:	dc.w 1			; broken monitor
		dc.b $FF, $D, 0, $38, $FF, $F0
		even