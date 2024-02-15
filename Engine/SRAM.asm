
; ===========================================================================
; SRAM loading and saving routines
; ===========================================================================

InitSRAM:
		OperateInSRAM
		KDebug.WriteLine "Initializing SRAM..."
		lea 	($200001).l, a0     ; Load SRAM memory into a0 (Change the last digit to 0 if you're using even SRAM)

		movep.l Kino(a0), d0		; Get the existing string at the start of SRAM
		cmp.l   #"KINO", d0			; Was it already in SRAM?
		bne.s   ResetSRAM2			; If so, skip

		ExitSRAM
		rts

; ===========================================================================

ResetSRAM:
		OperateInSRAM
		lea		($200001).l, a0

ResetSRAM2:
		KDebug.WriteLine "Resetting SRAM..."

		move.l	#"KINO", d0
		movep.l	d0, 0(a0)			; SRAM => "KINO"
		move.l	SRAMDefaults(pc), d0
		movep.l	d0, 8(a0)			; SRAM => Zone, Lives, Difficulty, Secret Progression
		move.l	SRAMDefaults+4(pc), d0
		movep.l	d0, $10(a0)			; SRAM => Secret Enabled, Game Completed, Shake Disabled, RNG
		move.l	SRAMDefaults+8(pc), d0
		movep.l	d0, $18(a0)			; SRAM => RNG, RNG, RNG, Null

		ExitSRAM
		rts

; ===========================================================================

SRAMDefaults:
		dc.b 0, 3, 1, 0 			; Zone, Lives, Difficulty, Secret Progression
		dc.b 0, 0, 0, 0 			; Secret Enabled, Game Completed, Shake Disabled, RNG
		dc.b 0, 0, 0, 0 			; RNG, RNG, RNG, Null
		even


; ===========================================================================
; SRAM loading and saving routines
; ===========================================================================
LoadSRAM:
		OperateInSRAM
		KDebug.WriteLine "Loading from SRAM..."

		lea 	($200001).l, a0
		move.b 	ZoneSave(a0), (v_zone).w
		move.b 	LivesSave(a0), (v_lives).w
		move.b 	DifficultySave(a0), (v_difficulty).w
		move.b 	SecretProgression(a0), (v_secretprog).w
		move.b 	SecretEnabled(a0), (v_secret).w
		move.b 	GameCompleted(a0), (v_gamecomplete).w
		move.b 	ShakeDisabled(a0), (v_shake).W
		
		ExitSRAM
		rts

; ===========================================================================

SaveSRAM:
		OperateInSRAM
		KDebug.WriteLine "Saving to SRAM..."

		lea 	($200001).l, a0
		move.b 	(v_zone).w, ZoneSave(a0)
		move.b	(v_lives).w, LivesSave(a0)
		move.b 	(v_difficulty).w, DifficultySave(a0)
		move.b 	(v_secretprog).w, SecretProgression(a0)
		move.b 	(v_secret).w, SecretEnabled(a0)
		move.b 	(v_gamecomplete).w, GameCompleted(a0)
		move.b 	(v_shake).w, ShakeDisabled(a0)

		ExitSRAM
		rts

; ===========================================================================

SaveRandom:
		OperateInSRAM
		
		lea 	($200001).l, a0
		move.l 	(v_random).w, d0
		movep.l d0, SavedRandomNumber(a0)

		ExitSRAM
		rts


; ===========================================================================

LoadRandom:
		OperateInSRAM
		
		lea 	($200001).l, a0
		movep.l SavedRandomNumber(a0), d0
		move.l 	d0, (v_random).w

		ExitSRAM
		rts