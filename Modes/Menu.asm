Menu:
		lea    $FFFF0000, a0
		move.l    #(($FFFF/2)/4)-1, d0
		moveq    #0, d1
@ClearRAM:
		move.l    d1, (a0)+
		dbra    d0, @ClearRAM

@MenuLoop
		bsr.w	ClearScreen
	    move.l    #$78000003, vdp_control_port
		move.w    #$0080, vdp_data_port        ;Y position
		move.w    #$0000, vdp_data_port        ;sprite size 0 (8x8px) and sprite link 0 (0 ends the sprite list)
		move.w    #$0001, vdp_data_port        ;Sprite starting tile (same as a tile)
		move.w    #$0080, vdp_data_port        ;X position

		jsr 	WaitForVBla
		bra.s 	@MenuLoop