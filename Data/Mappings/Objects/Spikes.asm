; ---------------------------------------------------------------------------
; Sprite mappings - spikes
; ---------------------------------------------------------------------------
Map_Spike_internal:
		dc.w byte_CFF4-Map_Spike_internal
		dc.w byte_D004-Map_Spike_internal
		dc.w byte_D014-Map_Spike_internal
		dc.w byte_D01A-Map_Spike_internal
		dc.w byte_D02A-Map_Spike_internal
		dc.w byte_D049-Map_Spike_internal
byte_CFF4:	dc.w 3			; 3 spikes
		dc.b $F0, 3, 0,	4, $FF, $EC
		dc.b $F0, 3, 0,	4, $FF, $FC
		dc.b $F0, 3, 0,	4, $00, $C
byte_D004:	dc.w 3			; 3 spikes facing sideways
		dc.b $EC, $C, 0, 0, $FF, $F0
		dc.b $FC, $C, 0, 0, $FF, $F0
		dc.b $C, $C, 0,	0, $FF, $F0
byte_D014:	dc.w 1			; 1 spike
		dc.b $F0, 3, 0,	4, $FF, $FC
byte_D01A:	dc.w 3			; 3 spikes widely spaced
		dc.b $F0, 3, 0,	4, $FF, $E4
		dc.b $F0, 3, 0,	4, $FF, $FC
		dc.b $F0, 3, 0,	4, $00, $14
byte_D02A:	dc.w 6			; 6 spikes
		dc.b $F0, 3, 0,	4, $FF, $C0
		dc.b $F0, 3, 0,	4, $FF, $D8
		dc.b $F0, 3, 0,	4, $FF, $F0
		dc.b $F0, 3, 0,	4, $00, 8
		dc.b $F0, 3, 0,	4, $00, $20
		dc.b $F0, 3, 0,	4, $00, $38
byte_D049:	dc.w 1			; 1 spike facing sideways
		dc.b $FC, $C, 0, 0, $FF, $F0
		even