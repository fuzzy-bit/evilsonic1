; ---------------------------------------------------------------------------
; Subroutines to load palettes

; input:
;	d0 = index number for palette
; ---------------------------------------------------------------------------
PalLoad1:
		lea	(PalPointers).l,a1

LoadUnindexedPalette1:
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		adda.w	#v_pal_dry_dup-v_pal_dry,a3		; skip to "main" RAM address
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts

PalLoad2:
		lea	(PalPointers).l,a1

LoadUnindexedPalette2:
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		move.w	(a1)+,d7	; get length of palette

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts

; ---------------------------------------------------------------------------
; Underwater palette loading subroutine
; ---------------------------------------------------------------------------
PalLoad3_Water:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		suba.w	#v_pal_dry-v_pal_water,a3		; skip to "main" RAM address
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts

PalLoad4_Water:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		suba.w	#v_pal_dry-v_pal_water_dup,a3
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts