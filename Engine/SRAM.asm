; ===========================================================================
; SRAM loading and saving routines
; ===========================================================================
LoadSRAM:
        EnableSRAM

        lea 	($200000).l, a0
		move.b 	ZoneSave(a0), (v_zone).w
		move.b 	LivesSave(a0), (v_lives).w
		move.b 	DifficultySave(a0), (v_difficulty).w
		move.b 	SecretEnabled(a0), (v_secret).w

        DisableSRAM
		rts

SaveSRAM:
		EnableSRAM

		lea 	($200000).l, a0
		move.b 	(v_zone).w, ZoneSave(a0)
		move.b	(v_lives).w, LivesSave(a0)
		move.b 	(v_difficulty).w, DifficultySave(a0)
		move.b 	(v_secret).w, SecretEnabled(a0)

	    DisableSRAM
		rts