; ---------------------------------------------------------------------------
; Object 49 - waterfall	sound effect (GHZ)
; ---------------------------------------------------------------------------

WaterSound:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	WSnd_Index(pc,d0.w),d1
		jmp	WSnd_Index(pc,d1.w)
; ===========================================================================
WSnd_Index:	dc.w WSnd_Main-WSnd_Index
		dc.w WSnd_PlaySnd-WSnd_Index
; ===========================================================================

WSnd_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.b	#4,obRender(a0)

WSnd_PlaySnd:	; Routine 2
		; this is to avoid overwriting any other sfx
		move.b	#sfx_Waterfall, d0
		jsr		PlaySound

	WSnd_ChkDel:
		out_of_range	DeleteObject
		rts
