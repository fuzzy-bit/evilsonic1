
; ===========================================================================
; SRAM loading and saving routines
; ===========================================================================

InitSRAM:
		move.w	sr, -(sp)
		move	#$2700, sr
		stopZ80
		EnableSRAM

		KDebug.WriteLine "Initializing SRAM..."
		lea 	($200001).l, a0     ; Load SRAM memory into a0 (Change the last digit to 0 if you're using even SRAM)

		movep.l Kino(a0), d0		; Get the existing string at the start of SRAM
		cmp.l   #"KINO", d0			; Was it already in SRAM?
		bne.s   ResetSRAM2			; If so, skip

		DisableSRAM
		startZ80
		move.w	(sp)+, sr
		rts

; ===========================================================================

ResetSRAM:
		move.w	sr, -(sp)
		move	#$2700, sr
		stopZ80
		EnableSRAM

		lea		($200001).l, a0

ResetSRAM2:
		KDebug.WriteLine "Resetting SRAM..."

		move.l	#"KINO", d0
		movep.l	d0, 0(a0)			; SRAM => "KINO"
		move.l	SRAMDefaults(pc), d0
		movep.l	d0, 8(a0)			; SRAM => Zone, Lives, Difficulty, Secret Progression
		move.l	SRAMDefaults+4(pc), d0
		movep.l	d0, $10(a0)			; SRAM => Secret Enabled, Game Completed, Null, Null

		DisableSRAM
		startZ80
		move.w	(sp)+, sr
		rts

; ===========================================================================
SRAMDefaults:
		dc.b 0, 3, 1, 0 			; Zone, Lives, Difficulty, Secret Progression
		dc.b 0, 0, 0, 0 			; Secret Enabled, Game Completed, Null, Null
		even


; ===========================================================================
; SRAM loading and saving routines
; ===========================================================================
LoadSRAM:
		move.w	sr, -(sp)
		move	#$2700, sr
		stopZ80
		EnableSRAM

		KDebug.WriteLine "Loading from SRAM..."

		lea 	($200001).l, a0
		move.b 	ZoneSave(a0), (v_zone).w
		move.b 	LivesSave(a0), (v_lives).w
		move.b 	DifficultySave(a0), (v_difficulty).w
		move.b 	SecretProgression(a0), (v_secretprog).w
		move.b 	SecretEnabled(a0), (v_secret).w
		move.b 	GameCompleted(a0), (v_gamecomplete).w

		DisableSRAM
		startZ80
		move.w	(sp)+, sr
		rts

; ===========================================================================
SaveSRAM:
		move.w	sr, -(sp)
		move	#$2700, sr
		stopZ80
		EnableSRAM

		KDebug.WriteLine "Saving to SRAM..."

		lea 	($200001).l, a0
		move.b 	(v_zone).w, ZoneSave(a0)
		move.b	(v_lives).w, LivesSave(a0)
		move.b 	(v_difficulty).w, DifficultySave(a0)
		move.b 	(v_secretprog).w, SecretProgression(a0)
		move.b 	(v_secret).w, SecretEnabled(a0)
		move.b 	(v_gamecomplete).w, GameCompleted(a0)

		DisableSRAM
		startZ80
		move.w	(sp)+, sr
		rts
