Menu:
		bsr.w	ClearScreen

		ClearRAM

		locVRAM	$6000
		lea	(Nem_TitleSonic).l,a0 ;	load Sonic title screen	patterns
		bsr.w	NemDec

@MenuLoop
		move.b	#4, (v_vbla_routine).w
		jsr 	WaitForVBla
		jsr		(ExecuteObjects).l
		jsr		(BuildSprites).l
		bra.s 	@MenuLoop
		rts