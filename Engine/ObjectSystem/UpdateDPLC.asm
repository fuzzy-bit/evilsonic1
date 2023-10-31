
UpdateDPLC:

@var0:			equr	d3
@var1:			equr	d4
@dplc_cnt:		equr	d5
@vram_dest:		equr	d6

@obj:			equr	a0
@dplc:			equr	a3
@add_transfer:	equr	a4
@art_ptr:		equr	a5
@dplc_cfg:		equr	a6

		moveq	#0, @var0
		move.b	obFrame(@obj), @var0			; get current sprite frame
		cmp.b	obDPLCFrame(@obj), @var0		; has the frame been changed?
		beq.s	@Done							; if not, branch
		move.b	@var0, obDPLCFrame(@obj)		; remember the new frame

		move.l	(@dplc_cfg)+, @dplc				; DPLC Config => Get DPLC data
		move.l	(@dplc_cfg)+, @art_ptr			; DPLC Config => Get Art pointer

		add.w	@var0, @var0
		adda.w	(@dplc, @var0.w), @dplc
		move.w	(@dplc)+, @dplc_cnt
		subq.w	#1, @dplc_cnt
		bmi.s	@Done
		move.w	(@dplc_cfg)+, @vram_dest

		lea		VDPDraw_AddDMATransfer, @add_transfer

		@entry_loop:
			; "VDPDraw_AddDMATransfer" function:
			@dma_len:	equr	d0				; DMA length (in words)
			@dma_dest:	equr	d1				; DMA destination (VRAM)
			@dma_src:	equr	a2				; DMA source (ROM / RAM)

			moveq	#0, @var0					; NOTE: Don't optimize, `@var0` is used as a longword later
			move.w	(@dplc)+, @var0				; @var0 = $LTTT
			rol.w	#4, @var0					; @var0 = $TTTL

			moveq	#$F, @dma_len
			and.w	@var0, @dma_len				; @dma_len = number of tiles - 1
			addq.w	#1, @dma_len				; @dma_len = number of tiles
			lsl.w	#4, @dma_len				; @dma_len = number of tiles * $10

			and.w	#$FFF0, @var0				; @var0 = $TTT * $10
			add.l	@var0, @var0				; @var0 = $TTT * $20
			lea		(@art_ptr, @var0.l), @dma_src

			move.w	@vram_dest, @dma_dest
			add.w	@dma_len, @vram_dest		; increment VRAM destination by the size of DMA transfer (in bytes)
			add.w	@dma_len, @vram_dest		; ''

			jsr		(@add_transfer)

			dbf		@dplc_cnt, @entry_loop

@Done:
		rts


