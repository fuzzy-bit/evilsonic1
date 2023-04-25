Menu:
		lea    $FFFF0000, a0
		move.l    #(($FFFF/2)/4)-1, d0
		moveq    #0, d1
@ClearRAM:
		move.l    d1, (a0)+
		dbra    d0, @ClearRAM

@MenuLoop
		bsr.w	ClearScreen
		
		jsr 	WaitForVBla
		;bra.s 	@MenuLoop
		rts