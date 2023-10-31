; ---------------------------------------------------------------------------
; Sonic Death
; ---------------------------------------------------------------------------
SonicDeath:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d1
		jsr		@Index(pc,d1.w)
		jmp		DisplaySprite

; ===========================================================================
@Index:	dc.w @Init-@Index
		dc.w @Main-@Index
		dc.w @Reset-@Index
; ===========================================================================

@Init:	; Routine 0
		jsr 	RandomNumber
		andi.b	#$B, d0
		move.b	d0, obFrame(a0) 
		move.b	d0, obDPLCFrame(a0)
		move.l	#Map_SonicDeath, obMap(a0) 

		lea		(v_player).w, a1
		move.w 	obX(a1), obX(a0)
		move.w 	obY(a1), obY(a0)

		move.w	#-$500, obVelY(a0)
		addq.b	#2, obRoutine(a0)
		rts

; ===========================================================================

@Main:	; Routine 2
		bsr.s 	@GameOver

		move.w	#$780, obGfx(a0)		
		move.b	#4, obRender(a0)
		move.b	#8, obActWid(a0)

        move.b	#$FF, obDPLCFrame(a0)
		lea		@DPLCConfig(pc), a6
		jsr		UpdateDPLC

		jsr 	ObjectFall
		rts

@Delete:
		move.b	#id_SonicPlayer, (v_player).w
		move.w	#1, (f_restart).w
		rts

@GameOver:
		lea		v_player, a1

		move.w	(v_limitbtm2).w,d0
		addi.w	#$100,d0
		cmp.w	obY(a0),d0
		bcc.w	@ReturnMain
		move.w	#-$38,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		addq.b	#2,obRoutine(a1)
		clr.b	(f_timecount).w	; stop time counter
		addq.b	#1,(f_lifecount).w ; update lives counter
		subq.b	#1,(v_lives).w	; subtract 1 from number of lives
		bne.s	@RunGameOver
		move.b	#0,deathtime(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load GAME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#1,(v_objspace+$C0+obFrame).w ; set OVER object to correct frame
		clr.b	(f_timeover).w

@PLCAndMusic:
		music	mus_GameOver	; play game over music
		moveq	#3,d0
		jmp	(AddPLC).l	; load game over patterns
; ===========================================================================

@RunGameOver:
		move.b	#60,deathtime(a0)	; set time delay to 1 second
		tst.b	(f_timeover).w	; is TIME OVER tag set?
		beq.s	@ReturnMain	; if not, branch
		move.b	#0,deathtime(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load TIME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#2,(v_objspace+$80+obFrame).w
		move.b	#3,(v_objspace+$C0+obFrame).w
		bra.s	@PLCAndMusic
		
; ===========================================================================

@ReturnMain:
		rts	

; ===========================================================================

@Reset:
		tst.b	deathtime(a0)
		beq.s	@ReturnReset
		subq.b	#1,deathtime(a0)	; subtract 1 from time delay
		bne.s	@ReturnReset

		if Respawn=1
			move.b	#4,obRoutine(a0)
			jsr 	LevSz_ChkLamp
			jsr 	LoadTilesFromStart
			move.b	#1,	f_timecount
		else
			; Old death code
			move.b	#id_SonicPlayer,(v_player).w ; load Sonic object
			move.w	#1,(f_restart).w ; restart the level
		endc

		rts

; ===========================================================================

@ReturnReset:
		rts	

; ===========================================================================

; ---------------------------------------------------------------------------
; DPLC Config
; ---------------------------------------------------------------------------
@DPLCConfig:
		dc.l	PLC_SonicDeath	; DPLC pointer
		dc.l	@Art			; Art pointer
		dc.w	$F000			; VRAM address

; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------
@Art:
		incbin "Data\Art\Uncompressed\Sonic Death.bin"
		even

		include "Data\Mappings\Objects\Sonic Death.asm"
		include "Data\DPLCs\Sonic Death.asm"