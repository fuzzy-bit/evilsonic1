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
		; TODO: FINISH INIT CODE
		lea 	@SplatterTable, a2
		
@CheckValidParent:
		move.b 	(a2)+, d0
		movea.w	@ParentObj(a0), a1

		; Check for end of LUT
		cmp.b   #$FF, d0
		beq.s 	@DeleteObject

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
		move.b 	(a2)+, d0 ; DPLC frame
		move.w 	(a2)+, d1 ; X offset
		move.w 	(a2)+, d2 ; Y offset
		move.l 	(a2)+, d4 ; Mapping data 

		move.w 	d1, @XOffset(a0)
		move.w 	d2, @YOffset(a0)
		
		move.l	d4, obMap(a0) 

		add.b 	#2, obRoutine(a0)
		rts
		
@Main:	; Routine 2
		move.w	#$584, obGfx(a0)		
		move.b	#4, obRender(a0)
		move.b	#8, obActWid(a0)

		movea.w	@ParentObj(a0), a1
		move.b	obPriority(a1), obPriority(a0)
		sub.b 	#$1, obPriority(a0)

		; - AFTER APPLYING POSITION, ADD OFFSET --------
		move.w 	obX(a1), obX(a0)
		move.w 	obY(a1), obY(a0)
		; ----------------------------------------------

		tst.b	obRender(a0)
		bmi.s	@DeleteObject

		rts

@DeleteObject:
		addq.w  #4, sp   ; Fix from Vladikcomper: Return to higher in the stack rather than caller 
		jmp 	DeleteObject

; GFX VRAM LOCATION: 0xD160
; ---------------------------------------------------------------------------
; LUT FORMAT
; #$E bytes/index
; ---------------------------------------------------------------------------
; ObjectID		  ; DPLCFrame      
; XOffset 		  ; YOffset 
; MappingData
; ---------------------------------------------------------------------------
@SplatterTable:
		; MZ Pillar
        dc.b $20, $00
		dc.w $0010, $0010 
		dc.l Map_Splat

		; SLZ Elevators
        dc.b $59, $00
		dc.w $0010, $0010 
		dc.l Map_Splat

		; Crabmeat
        dc.b $1F, $00
		dc.w $0010, $0010 
		dc.l Map_Splat

		; End
		dc.w $FFFF

; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------
		include "Data\Mappings\Objects\Blood Splatters.asm"