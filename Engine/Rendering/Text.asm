; ================================================================
; Giovanni's text rendering routines.
; Designed for tile sized letters.
; ================================================================

; ===========================================================================
; Subroutine that renders one line of text, where the number of character is static (old format).
; Input:
; a6: VDP
; d3: Character in VRAM
; d2: Characters in line
; a1: Pointer to character to render
; ===========================================================================	
	
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

SingleLineRender:
		moveq	#0,d0				; Init d0
		move.b	(a1)+,d0			; Get character
		bpl.s	LineRender_NotBlank	; If not blank, render the character
		move.w	#0,(a6)				; Render a null tile
		dbf	d2,SingleLineRender		; Repeat
		rts	
; ===========================================================================

LineRender_NotBlank:				; XREF: SingleLineRender
        sub.w    #$21,d0        ; Subtract #$21
        add.w    d3,d0        	; combine char with VRAM setting
        move.w   d0,(a6)        ; send to VRAM
        dbf      d2,SingleLineRender  
        rts
; End of function SingleLineRender

; ===========================================================================
; Subroutine that renders one line of text, where the strings have a line terminator (new format).
; Input:
; a6: VDP
; d3: Character in VRAM
; a1: Pointer to character to render
; ===========================================================================	
	
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

RenderLineToEnd:
		moveq	#0,d0				; Init d0
		move.b	(a1)+,d0			; Get character
		bpl.s	@notblank			; If not blank, render the character
		cmpi.b	#$FF,d0				; Check if it's a line terminator
		beq.s	@end				; If yes, return
		move.w	#0,(a6)				; Render a null tile
		bra.s	RenderLineToEnd		; Repeat
; ===========================================================================

@notblank:				; XREF: SingleLineRender
        sub.w   #$21,d0        		; Subtract #$21
        add.w   d3,d0        		; combine char with VRAM setting
        move.w  d0,(a6)				; send to VRAM
		bra.s	RenderLineToEnd		; repeat
	@end:	
        rts
; End of function RenderLineToEnd

; ===========================================================================
; Subroutine that wipes one line of text of predetermined length.
; Input:
; a6: VDP
; d2: Number of characters to blank out
; ===========================================================================	

WipeTextLine:
		move.w	#0,(a6)
		dbf		d2,WipeTextLine
		rts

; ===========================================================================
; Subroutine that renders a decimal number.
; Input:
; a6: VDP
; d1: number to render
; d3: position of digit 0 in VRAM + palette (order of digits must match ASCII)
; a2: how many digits you want to display (in the form of Hud_100000 variants)
; d0: the actual number of digits you want to display
; ===========================================================================	

DecimalNumberRender:				; XREF: HudUpdate
		moveq	#0,d2            ; d2 is the digit I want to render, and it is cleared here
      	move.l	(a2)+,d6         ; set d5 to the current position in the array, and increment it too
		
@count:		
		sub.l	d6,d1            ; subtract d6 from d1
		bcs.s	@done       ; if lower than zero, go to the next step
		addq.w	#1,d2            ; increment d2
		bra.s	@count        ; repeat this step continuously
; ===========================================================================

@done:
		add.l	d6,d1            ; add back d6 to d1 only once
		; enabling the below code disables leading zeroes
;		tst.w	d2               ; check if the digit is zero
;		beq.s	@zero        ; if it is, branch
;		move.w	#1,d5

;@zero:
;		tst.w	d5
;		beq.s	@skip
		add.w	d3,d2				; add VRAM setting to d2
;@skip:
		move.w	d2,(a6)				; send d2 to a6, therefore executing the instruction
 	    dbf     d0,DecimalNumberRender
 	    rts		

; ===========================================================================
; Subroutine that renders a hexadecimal byte.
; Input:
; a6: VDP
; d2: number to render
; d3: position of digit 0 in VRAM + palette (order of digits must match ASCII)
; ===========================================================================	

HexByteRender:
		move.b	d2,d1
		; Render a 2 digit number
		lsr.l	#4,d1
		bsr.s	@renderdigit
		; Render a digit
		move.b	d2,d1
		
@renderdigit:	
		andi.w	#$F,d1				; account for one digit only
		cmpi.b	#$A,d1				; is value "A" or higher?
		bcs.s	@skipchars			; if not, branch
		addi.b	#7,d1				; else, skip non alphanumeric characters (value needs an update for proper hex nu,ber rendering)

@skipchars:
		add.w	d3,d1				; add VRAM setting to d1	
		move.w	d1,(a6)				; send d2 to a6, therefore rendering the digit
 	    rts				

Art_Font:	incbin "Data\Art\Uncompressed\Sonic 2 ASCII Text.bin"
Art_FontEnd:
	even