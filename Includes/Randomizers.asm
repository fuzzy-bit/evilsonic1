; ---------------------------------------------------------------------------
; Randomizers
; ---------------------------------------------------------------------------
load_randompalette:
		lea     ($FFFFFB00).w,a1
load_randompalette2:
		move.w  #$1F,d6

load_randompalette3:
		jsr     (randomnumber).l
		andi.w  #$666,d0
		move.l  d0,(a1)+
		dbf     d6,load_randompalette3
		rts

; ===========================================================================

load_randomwaterpalette:
		move.w  #1,d7

@loop1:
		lea     ($FFFFFA20).w,a1
		move.w  #$2F,d6

@loop2:
		jsr     (randomnumber).l
		andi.w  #$666,d0
		move.w  d0,(a1)+
		dbf     d6,@loop2
		dbf     d7,@loop1
		
		rts
		
; ===========================================================================

set_randomsound:
		lea     ($FFFFF078).w,a1
		move.w  #4,d6

@loop:
		jsr     (randomnumber).l
		andi.w  #$F0,d0
		or.b    d0,(a1)
		lea     $30(a1),a1
		dbf     d6,@loop
		rts

; ===========================================================================

set_randomsound2:
		lea     ($FFFFF078).w,a1
		move.w  #4,d6

@loop:
		jsr     (randomnumber).l
		andi.w  #$FF,d0
		move.b  d0,(a1)
		lea     $30(a1),a1
		dbf     d6,@loop
		rts