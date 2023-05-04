; ---------------------------------------------------------------------------
; Blood splatter
; ---------------------------------------------------------------------------
Splatter:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jsr		@Index(pc,d1.w)
		jmp		DisplaySprite

; ===========================================================================
@Index:	dc.w @Init-@Index
		dc.w @Main-@Index
; ===========================================================================

@Init:	; Routine 0
		; TODO: FINISH INIT CODE
		lea 	SplatterTable, a2

@CheckValidParent:
		move.b 	(a2)+, d0

		cmp.b 	ParentObj(a0), d0
		bne.s 	@DeleteObject

		add.b 	#2, obRoutine(a0)
		
@Main:	; Routine 2
		move.l	#Map_Poi, obMap(a0)
		move.w	#$2797, obGfx(a0)
		move.b	#4, obRender(a0)
		move.b	#1, obPriority(a0)
		move.b	#8, obActWid(a0)

		move.w 	ParentObj(a0), a1
		move.w 	obX(a1), obX(a0)
		move.w 	obY(a1), obY(a0)

		tst.b	obRender(a0)
		bmi.s	@DeleteObject

		rts

@DeleteObject:
		jmp 	DeleteObject
		
; GFX VRAM LOCATION: 0xD800
; ---------------------------------------------------------------------------
; LUT FORMAT
; #$E bytes/index
; ---------------------------------------------------------------------------
; ObjectID		  ; PaletteLine ; XOffset ; YOffset 
; NemesisGraphics ; MappingData
; ---------------------------------------------------------------------------
SplatterTable:
		; MZ Pillar
        dc.w $D901, $0010, $0010 
		dc.l Nem_Points, Map_Poi

		; End
		dc.b $FF