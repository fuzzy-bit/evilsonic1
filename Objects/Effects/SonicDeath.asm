; ---------------------------------------------------------------------------
; Sonic Death
; ---------------------------------------------------------------------------
SonicDeath:
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
		jsr 	RandomNumber
		andi.b	#$B, d0
		move.b	d0, obFrame(a0) 
		move.l	#Map_SonicDeath, obFrame(a0) 

		addq.b	#2, obRoutine(a0)
		rts

; ===========================================================================

@Main:	; Routine 2
		move.w	#$780, obGfx(a0)		
		move.b	#4, obRender(a0)
		move.b	#8, obActWid(a0)

        move.b	#$FF, obDPLCFrame(a0)
		lea		@DPLCConfig(pc), a6
		jsr		UpdateDPLC

		jsr 	ObjectFall
		rts

; ---------------------------------------------------------------------------
; DPLC Config
; ---------------------------------------------------------------------------
@DPLCConfig:
		dc.l	PLC_SonicDeath	; DPLC pointer
		dc.l	@Art			; Art pointer
		dc.w	$F000			; VRAM address

; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------
@Art:
		incbin "Data\Art\Uncompressed\Sonic Death.bin"
		even

		include "Data\Mappings\Objects\Sonic Death.asm"
		include "Data\DPLCs\Sonic Death.asm"