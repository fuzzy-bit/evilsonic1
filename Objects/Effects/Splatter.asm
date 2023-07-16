; ---------------------------------------------------------------------------
; Blood splatter
; ---------------------------------------------------------------------------
Splatter:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jsr		@Index(pc,d1.w)
		jmp		DisplaySprite

@ParentObj:		equ $30
@XOffset:		equ $32	
@YOffset:		equ $34

; ===========================================================================
@Index:	dc.w @Init-@Index
		dc.w @Main-@Index
; ===========================================================================

@Init:	; Routine 0
		lea 	@SplatterTable, a2
		
@CheckValidParent:
		move.b 	(a2)+, d0
		movea.w	@ParentObj(a0), a1

		; Check for end of LUT
		cmp.b   #$FF, d0
		beq.w 	@DeleteObject

		; Check for object match
		cmp.b   $0(a1), d0
		beq.s 	@SetUp

		; Skip rest of index
		move.b 	(a2)+, d0
		move.l 	(a2)+, d0
		move.l 	(a2)+, d0

		bra.s 	@CheckValidParent

@SetUp:
		; Load values into registers
		move.b 	(a2)+, d4 ; DPLC frame
		move.w 	(a2)+, d5 ; X offset
		move.w 	(a2)+, d6 ; Y offset

		movea.w a0, a3
		movea.w	@ParentObj(a0), a0
		jsr 	GetOrientationToPlayer
		movea.w a3, a0

		tst.b 	d1
		bne.s 	@DontNegateY
		neg.w 	d6

@DontNegateY:
		move.w 	d5, @XOffset(a0)
		move.w 	d6, @YOffset(a0)
		
		move.l	(a2)+, obMap(a0) 

		add.b 	#2, obRoutine(a0)
		rts

@Main:	; Routine 2
		; TODO: APPLY DPLC FRAME
		move.w	#$584, obGfx(a0)		
		move.b	#4, obRender(a0)
		move.b	#8, obActWid(a0)
		
		; Put parent object into a1 and set object priority
		movea.w	@ParentObj(a0), a1
		move.b	obPriority(a1), obPriority(a0)
		sub.b 	#$1, obPriority(a0)

		; Load offset into registers d0 and d1
		move.w 	@XOffset(a0), d0
		move.w 	@YOffset(a0), d1

		; Apply position and subsequently offset
		move.w 	obX(a1), obX(a0)
		move.w 	obY(a1), obY(a0)
		add.w 	d0, obX(a0)
		add.w 	d1, obY(a0)

		; Update DPLC
        st.b	obDPLCFrame(a0)					; set last frame for DPLC to $FF to force redraw
		lea		@DPLCConfig(pc), a6
		jsr		UpdateDPLC

		; Remove splatter if offscreen
		tst.b	obRender(a0)
		bmi.s	@DeleteObject

		rts

@DeleteObject:
		addq.w  #4, sp  						; Fix from Vladikcomper: Return to higher in the stack rather than caller 
		jmp 	DeleteObject

; ---------------------------------------------------------------------------
; LUT FORMAT
; #$A bytes/index
; ---------------------------------------------------------------------------
; ObjectID		  ; DPLCFrame      
; XOffset 		  ; YOffset 
; MappingData
; ---------------------------------------------------------------------------
@SplatterTable:
		; MZ Pillar
        dc.b $30, $00
		dc.w $0000, $0046
		dc.l Map_Splat

		; SYZ Big Blocks
        dc.b $56, $00
		dc.w $0000, $001E
		dc.l Map_Splat
		
		; End
		dc.w $FFFF

; ---------------------------------------------------------------------------
; DPLC Config
; ---------------------------------------------------------------------------
@DPLCConfig:
		dc.l	PLC_Splatters	; DPLC pointer
		dc.l	@SplatterArt	; Art pointer
		dc.w	$584*$20		; VRAM address

; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------
@SplatterArt:
		incbin "Data\Art\Uncompressed\Blood Splatters.bin"
		even

		include "Data\Mappings\Objects\Blood Splatters.asm"
		include "Data\DPLCs\Blood Splatters.asm"