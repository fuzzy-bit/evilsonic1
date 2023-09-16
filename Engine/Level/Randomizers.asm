; ---------------------------------------------------------------------------
; Randomizers
; ---------------------------------------------------------------------------
RandomPalette:
		lea     ($FFFFFB00).w,a1
RandomPalette2:
		move.w  #$1F,d6

@Loop:
		jsr     (RandomNumber).l
		andi.w  #$666, d0
		move.l  d0, (a1)+
		dbf     d6, @Loop
		rts

; ===========================================================================

RandomWaterPalette:
		move.w  #1, d7

@Loop1:
		lea     ($FFFFFA20).w, a1
		move.w  #$2F, d6

@Loop2:
		jsr     (RandomNumber).l
		andi.w  #$666, d0
		move.w  d0, (a1)+
		dbf     d6, @Loop2
		dbf     d7, @Loop1

		rts

; ===========================================================================

RandomSound:
		lea     ($FFFFF078).w, a1
		move.w  #4,d6

@Loop:
		jsr     (RandomNumber).l
		andi.w  #$F0, d0
		or.b    d0, (a1)
		lea     $30(a1), a1
		dbf     d6, @loop
		rts

; ===========================================================================

set_randomsound2:
		lea     ($FFFFF078).w, a1
		move.w  #4, d6

@Loop:
		jsr     (RandomNumber).l
		andi.w  #$FF, d0
		move.b  d0, (a1)
		lea     $30(a1), a1
		dbf     d6, @Loop
		rts