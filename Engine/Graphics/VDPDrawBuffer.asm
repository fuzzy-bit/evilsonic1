
; =============================================================================
; -----------------------------------------------------------------------------
; VDP Draw Buffer Module
; -----------------------------------------------------------------------------
; (c) 2021, Vladikcomper
; -----------------------------------------------------------------------------

; Constants
_VDPReq_SendPlaneTilesHoriz:	equ		$02
_VDPReq_SendPlaneTilesVer: 		equ		$04
_VDPReq_DMA:					equ 	$06

; RAM Map
VDP_Draw_Buffer_Pointer:	equ		v_draw_buffer_ram+0
VDP_Draw_Buffer: 			equ		v_draw_buffer_ram+2
VDP_Draw_Buffer_End:		equ		v_draw_buffer_ram_end

; =============================================================================
; -----------------------------------------------------------------------------
; Initializes/clears VDP requests buffer
; -----------------------------------------------------------------------------

VDPDraw_Init:
		move.w	#VDP_Draw_Buffer, VDP_Draw_Buffer_Pointer	; flush the buffer
		rts

; =============================================================================
; -----------------------------------------------------------------------------
; Subroutine to execute VDP requests
; -----------------------------------------------------------------------------

VDPDraw_Execute:

@req_buff:		equr	a4
@vdp_ctrl:		equr	a5
@vdp_data:		equr	a6

		; Close and flush the buffer ...
		movea.w	VDP_Draw_Buffer_Pointer, @req_buff
		if def(_DEBUG_)
			cmpa.w	#VDP_Draw_Buffer, @req_buff
			blo.s	@buffer_overflow
			cmpa.w	#VDP_Draw_Buffer_End, @req_buff
			bhs.s	@buffer_overflow
		endif
		clr.w	(@req_buff) 							; place "Halt" command after the end of buffer
		move.w	#VDP_Draw_Buffer, VDP_Draw_Buffer_Pointer	; flush the buffer

		; Start executing the buffer ...
		lea 	VDP_Draw_Buffer, @req_buff
		lea		VDP_control_port, @vdp_ctrl
		lea		-4(@vdp_ctrl), @vdp_data

	@requests_loop:
			moveq	#$E, d0
			and.b	(@req_buff), d0
			jmp		@RequestHandlers(pc,d0)

; -----------------------------------------------------------------------------
	if def(_DEBUG_)
@buffer_overflow:
		RaiseError "VDP Draw Buffer overflow."
	endif

; =============================================================================
; -----------------------------------------------------------------------------
; VDP Requests offsets table
; -----------------------------------------------------------------------------

@RequestHandlers:
		rts									; $00	- Halt processing
; -----------------------------------------------------------------------------
		bra.s	@ExecuteSendPlaneTilesHoriz	; $02	- 
; -----------------------------------------------------------------------------
		bra.s	@ExecuteSendPlaneTilesVert	; $04	- 
; -----------------------------------------------------------------------------
*		bra.s	@ExecuteDMA					; $06	- DMA request
		;fall through


; =============================================================================
; -----------------------------------------------------------------------------
; Command: _VDPReq_DMA ($06)
;
; Executes DMA request
;
; WARNING! It should always start with byte value $97!
;
; Format: 
;	$00	.w	Register 97 ($97xx) - Source address AA
;	$02	.w	Register 96 ($96xx) - Source address BB
;	$04	.w	Register 95 ($95xx) - Source address CC
;	$06	.w	Register 94 ($94xx) - Transfer length AA
;	$08	.w	Register 93 ($93xx) - Transfer length BB
;	$0A	.l	VDP command
;
; -----------------------------------------------------------------------------

@ExecuteDMA:
		assert.b	(@req_buff), eq, #$97

		move.l	(@req_buff)+, (@vdp_ctrl)
		move.l	(@req_buff)+, (@vdp_ctrl)
		move.l	(@req_buff)+, (@vdp_ctrl)
		move.w	(@req_buff)+, (@vdp_ctrl)			; VDP => send write access command (low word)
		bra.s	@requests_loop

; =============================================================================
; -----------------------------------------------------------------------------
; Command: _VDPReq_SendPlaneTilesHoriz ($02)
;
; Format:
;	$00	.b	Command Id ($02)
;	$00 .l	Pointer to the data buffer
;	$04 .l	VPD command for transfer of the fisrt chunk
;	$08	.b	Number of words to transfer for the first chunk
;	$09	.b	Number of words to transfer for the second chunk (optional)
;	$0A	.l	VDP command for transfer of the second chunk (optional)
; 
; -----------------------------------------------------------------------------

@ExecuteSendPlaneTilesHoriz:
		movea.l	(@req_buff)+, a1			; a1 = Data buffer
		move.l	(@req_buff)+, (a5)			; VDP => Send write access command (first transfer)
		moveq	#0, d0
		move.b	(@req_buff)+, d0			; d0 = Jump location for the first transfer
		jsr		@TransferTiles(pc,d0)		; transfer first chunk ...

		move.b	(@req_buff)+, d0			; d0 = Jump location for the second transfer
		bmi.s	@jmp0
		move.l	(@req_buff)+, (a5)			; VDP => Send write access command (second transfer)
		jsr		@TransferTiles(pc,d0)		; trasnfer second chunk ...
		bra		@requests_loop

; -----------------------------------------------------------------------------
@jmp0:	addq.w	#4, @req_buff
		bra		@requests_loop

; =============================================================================
; -----------------------------------------------------------------------------
; Command: _VDPReq_SendPlaneTilesVer ($04)
;
; Format:
;	$00	.b	Command Id ($04)
;	$00 .l	Pointer to the data buffer
;	$04 .l	VPD command for transfer of the fisrt chunk
;	$08	.b	Number of words to transfer for the first chunk
;	$09	.b	Number of words to transfer for the second chunk (optional)
;	$0A	.l	VDP command for transfer of the second chunk (optional)
; 
; -----------------------------------------------------------------------------

@ExecuteSendPlaneTilesVert:
		movea.l	(@req_buff)+, a1			; a1 = Data buffer
		move.w	#$8F80, (@vdp_ctrl)			; VDP => Set auto-increment counter to $80
		move.l	(@req_buff)+, (@vdp_ctrl)	; VDP => Send write access command (first transfer)
		moveq	#0, d0
		move.b	(@req_buff)+, d0			; d0 = Jump location for the first transfer
		jsr		@TransferTiles(pc,d0)		; transfer first chunk ...

		move.b	(@req_buff)+, d0			; d0 = Jump location for the second transfer
		bmi.s	@jmp1
		move.l	(@req_buff)+, (@vdp_ctrl)	; VDP => Send write access command (second transfer)
		jsr		@TransferTiles(pc,d0)		; trasnfer second chunk ...

		move.w	#$8F02, (@vdp_ctrl)			; VDP => Restore auto-increment counter
		bra		@requests_loop

; -----------------------------------------------------------------------------
@jmp1	addq.w	#4, @req_buff
		move.w	#$8F02, (@vdp_ctrl)			; VDP => Restore auto-increment counter
		bra		@requests_loop

; -----------------------------------------------------------------------------
; Tiles transfer function
; -----------------------------------------------------------------------------

@TransferTiles:
		rept $20
			move.l	(a1)+, (@vdp_data)
		endr
		rts

; =============================================================================






; =============================================================================
; -----------------------------------------------------------------------------
; Adds raw DMA transfer
; -----------------------------------------------------------------------------
; INPUT:
;		d0	.w	Transfer size (words)
;		d1	.w	Transfer destination (VRAM)
;		a2		Source art pointer
;
; USES:
;		d0-d3, a1
; -----------------------------------------------------------------------------

VDPDraw_AddDMATransfer:
		movea.w	VDP_Draw_Buffer_Pointer, a1
		cmpa.w	#VDP_Draw_Buffer_End, a1
		bhs.s	@buffer_full

		move.l	a2, d2
		lsr.l	#1, d2					; d2 = SourceAddress / 2
		movep.w	d2, 3(a1)				; BUFFER => Fill registers $96, $95 - Source address BB CC (initialized below)

		moveq	#-1, d3
		swap	d2
		move.b	d2, d3					; d3 = Source address AA
		and.w	#$977F, d3
		move.w	d3, (a1)+				; BUFFER => Put Register $97xx - Source address AA

		move.l	#$96959493, d3
		movep.l	d3, 2-2(a1)				; BUFFER => Setup Registers $96, $95, $94, $93
		movep.w	d0, 7-2(a1)				; BUFFER => Fill registers $94, $93 - Transfer size AA BB
		addq.w	#8, a1

		moveq	#$80/4, d3				; will result in $80 (for DMA)
		move.w	d1, d2					; d2 = $AAAA
		and.w	#$3FFF, d1
		or.w	#$4000, d1
		move.w	d1, (a1)+				; BUFFER =>
		add.w	d2, d2
		addx.w	d3, d3
		add.w	d2, d2
		addx.w	d3, d3					; d3 = higest 2 bits or AA + $80 (for DMA)
		move.w	d3, (a1)+				; BUFFER => VDP command for transfer

		move.w	a1, VDP_Draw_Buffer_Pointer
		rts

; -----------------------------------------------------------------------------
@buffer_full:
	if def(_DEBUG_)
		RaiseError "VDP Draw Buffer full"
	else
		rts
	endif
