; ---------------------------------------------------------------------------
; Sprite mappings - Newtron enemy (GHZ)
; ---------------------------------------------------------------------------
Map_Newt_internal:
		dc.w M_Newt_Trans-Map_Newt_internal
		dc.w M_Newt_Norm-Map_Newt_internal
		dc.w M_Newt_Fires-Map_Newt_internal
		dc.w M_Newt_Drop1-Map_Newt_internal
		dc.w M_Newt_Drop2-Map_Newt_internal
		dc.w M_Newt_Drop3-Map_Newt_internal
		dc.w M_Newt_Fly1a-Map_Newt_internal
		dc.w M_Newt_Fly1b-Map_Newt_internal
		dc.w M_Newt_Fly2a-Map_Newt_internal
		dc.w M_Newt_Fly2b-Map_Newt_internal
		dc.w M_Newt_Blank-Map_Newt_internal
M_Newt_Trans:	dc.w 3
		dc.b $EC, $D, 0, 0, $FF, $EC	; partially visible
		dc.b $F4, 0, 0,	8, $00, $C
		dc.b $FC, $E, 0, 9, $FF, $F4
M_Newt_Norm:	dc.w 3
		dc.b $EC, 6, 0,	$15, $FF, $EC ; visible
		dc.b $EC, 9, 0,	$1B, $FF, $FC
		dc.b $FC, $A, 0, $21, $FF, $FC
M_Newt_Fires:	dc.w 3
		dc.b $EC, 6, 0,	$2A, $FF, $EC ; open mouth, firing
		dc.b $EC, 9, 0,	$1B, $FF, $FC
		dc.b $FC, $A, 0, $21, $FF, $FC
M_Newt_Drop1:	dc.w 4
		dc.b $EC, 6, 0,	$30, $FF, $EC ; dropping
		dc.b $EC, 9, 0,	$1B, $FF, $FC
		dc.b $FC, 9, 0,	$36, $FF, $FC
		dc.b $C, 0, 0, $3C, $00, $C
M_Newt_Drop2:	dc.w 3
		dc.b $F4, $D, 0, $3D, $FF, $EC
		dc.b $FC, 0, 0,	$20, $00, $C
		dc.b 4,	8, 0, $45, $FF, $FC
M_Newt_Drop3:	dc.w 2
		dc.b $F8, $D, 0, $48, $FF, $EC
		dc.b $F8, 1, 0,	$50, $00, $C
M_Newt_Fly1a:	dc.w 3
		dc.b $F8, $D, 0, $48, $FF, $EC ; flying
		dc.b $F8, 1, 0,	$50, $00, $C
		dc.b $FE, 0, 0,	$52, $00, $14
M_Newt_Fly1b:	dc.w 3
		dc.b $F8, $D, 0, $48, $FF, $EC
		dc.b $F8, 1, 0,	$50, $00, $C
		dc.b $FE, 4, 0,	$53, $00, $14
M_Newt_Fly2a:	dc.w 3
		dc.b $F8, $D, 0, $48, $FF, $EC
		dc.b $F8, 1, 0,	$50, $00, $C
		dc.b $FE, 0, $E0, $52, $00, $14
M_Newt_Fly2b:	dc.w 3
		dc.b $F8, $D, 0, $48, $FF, $EC
		dc.b $F8, 1, 0,	$50, $00, $C
		dc.b $FE, 4, $E0, $53, $00, $14
M_Newt_Blank:	dc.w 0
		even