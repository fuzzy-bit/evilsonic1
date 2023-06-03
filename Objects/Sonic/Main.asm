
; ===========================================================================
; ---------------------------------------------------------------------------
; Object 01 - Sonic
; ---------------------------------------------------------------------------

SonicPlayer:
		tst.w	(v_debuguse).w	; is debug mode	being used?
		beq.s	Sonic_Normal	; if not, branch
		jmp	(DebugMode).l
; ===========================================================================

Sonic_Normal:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Sonic_Index(pc,d0.w),d1
		jmp	Sonic_Index(pc,d1.w)
; ===========================================================================
Sonic_Index:	dc.w Sonic_Main-Sonic_Index
		dc.w Sonic_Control-Sonic_Index
		dc.w Sonic_Hurt-Sonic_Index
		dc.w Sonic_Death-Sonic_Index
		dc.w Sonic_ResetLevel-Sonic_Index
; ===========================================================================

Sonic_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.l	#Map_Sonic,obMap(a0)
		move.w	#$780,obGfx(a0)
		move.b	#2,obPriority(a0)
		move.b	#$18,obActWid(a0)
		move.b	#4,obRender(a0)
		move.w	#$600,(v_sonspeedmax).w ; Sonic's top speed
		move.w	#$C,(v_sonspeedacc).w ; Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w ; Sonic's deceleration

Sonic_Control:	; Routine 2
		tst.w	(f_debugmode).w	; is debug cheat enabled?
		beq.s	loc_12C58	; if not, branch
		btst	#bitB,(v_jpadpress1).w ; is button B pressed?
		beq.s	loc_12C58	; if not, branch
		move.w	#1,(v_debuguse).w ; change Sonic into a ring/item
		clr.b	(f_lockctrl).w
		rts
; ===========================================================================

loc_12C58:
		tst.b	(f_lockctrl).w	; are controls locked?
		bne.s	loc_12C64	; if yes, branch
		move.w	(v_jpadhold1).w,(v_jpadhold2).w ; enable joypad control

loc_12C64:
		btst	#0,(f_lockmulti).w ; are controls locked?
		bne.s	loc_12C7E	; if yes, branch
		moveq	#0,d0
		move.b	obStatus(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)

loc_12C7E:
		bsr.s	Sonic_Display
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Water
		move.b	(v_anglebuffer).w,$36(a0)
		move.b	($FFFFF76A).w,$37(a0)
		tst.b	(f_wtunnelmode).w
		beq.s	loc_12CA6
		tst.b	obAnim(a0)
		bne.s	loc_12CA6
		move.b	obNextAni(a0),obAnim(a0)

loc_12CA6:
		bsr.w	Sonic_Animate
		tst.b	(f_lockmulti).w
		bmi.s	loc_12CB6
		jsr	(ReactToItem).l

loc_12CB6:
		bsr.w	Sonic_Loops
		bsr.w	Sonic_LoadGfx
		rts
; ===========================================================================
Sonic_Modes:	dc.w Sonic_MdNormal-Sonic_Modes
		dc.w Sonic_MdJump-Sonic_Modes
		dc.w Sonic_MdRoll-Sonic_Modes
		dc.w Sonic_MdJump2-Sonic_Modes

; ===========================================================================
		include	"Objects\Sonic\Display.asm"
		include	"Objects\Sonic\RecordPosition.asm"
		include	"Objects\Sonic\Water.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Modes	for controlling	Sonic
; ---------------------------------------------------------------------------

Sonic_MdNormal:
		bsr.w	Sonic_SpinDash
		bsr.w	Sonic_Jump
		bsr.w	Sonic_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Sonic_LevelBound
		jsr		(SpeedToPos).l
		bsr.w	Sonic_AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; ===========================================================================

Sonic_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_JumpDirection
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,obStatus(a0)
		beq.s	loc_12E5C
		subi.w	#$28,obVelY(a0)

loc_12E5C:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_Floor
		rts
; ===========================================================================

Sonic_MdRoll:
		bsr.w	Sonic_Jump
		bsr.w	Sonic_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Sonic_LevelBound
		jsr	(SpeedToPos).l
		bsr.w	Sonic_AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; ===========================================================================

Sonic_MdJump2:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_JumpDirection
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,obStatus(a0)
		beq.s	loc_12EA6
		subi.w	#$28,obVelY(a0)

loc_12EA6:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_Floor
		rts

		include	"Objects\Sonic\Spindash.asm"
		include	"Objects\Sonic\Move.asm"
		include	"Objects\Sonic\RollSpeed.asm"
		include	"Objects\Sonic\JumpDirection.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine to squash Sonic
; ---------------------------------------------------------------------------
		move.b	obAngle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_13302
		bsr.w	Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	locret_13302
		move.w	#0,obInertia(a0) ; stop Sonic moving
		move.w	#0,obVelX(a0)
		move.w	#0,obVelY(a0)
		move.b	#id_Warp3,obAnim(a0) ; use "warping" animation

locret_13302:
		rts

		include	"Objects\Sonic\LevelBound.asm"
		include	"Objects\Sonic\Roll.asm"
		include	"Objects\Sonic\Jump.asm"
		include	"Objects\Sonic\JumpHeight.asm"
		include	"Objects\Sonic\SlopeResist.asm"
		include	"Objects\Sonic\RollRepel.asm"
		include	"Objects\Sonic\SlopeRepel.asm"
		include	"Objects\Sonic\JumpAngle.asm"
		include	"Objects\Sonic\Floor.asm"
		include	"Objects\Sonic\ResetOnFloor.asm"

; ---------------------------------------------------------------------------
; Sonic	when he	gets hurt
; ---------------------------------------------------------------------------

Sonic_Hurt:	; Routine 4
		jsr	(SpeedToPos).l
		addi.w	#$30,obVelY(a0)
		btst	#6,obStatus(a0)
		beq.s	loc_1380C
		subi.w	#$20,obVelY(a0)

loc_1380C:
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Subroutine to	stop Sonic falling after he's been hurt
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HurtStop:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0
		bcs.w	KillSonic
		bsr.w	Sonic_Floor
		btst	#1,obStatus(a0)
		bne.s	locret_13860
		moveq	#0,d0
		move.w	d0,obVelY(a0)
		move.w	d0,obVelX(a0)
		move.w	d0,obInertia(a0)
		move.b	#id_Walk,obAnim(a0)
		subq.b	#2,obRoutine(a0)
		move.w	#$78,$30(a0)

locret_13860:
		rts	
; End of function Sonic_HurtStop

; ---------------------------------------------------------------------------
; Sonic	when he	dies
; ---------------------------------------------------------------------------

Sonic_Death:	; Routine 6
		bsr.w	GameOver
		jsr	(ObjectFall).l
		jsr (DeformLayers).l
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp	(DisplaySprite).l

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


GameOver:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$100,d0
		cmp.w	obY(a0),d0
		bcc.w	locret_13900
		move.w	#-$38,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		clr.b	(f_timecount).w	; stop time counter
		addq.b	#1,(f_lifecount).w ; update lives counter
		subq.b	#1,(v_lives).w	; subtract 1 from number of lives
		bne.s	loc_138D4
		move.b	#0,deathtime(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load GAME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#1,(v_objspace+$C0+obFrame).w ; set OVER object to correct frame
		clr.b	(f_timeover).w

loc_138C2:
		music	mus_GameOver	; play game over music
		moveq	#3,d0
		jmp	(AddPLC).l	; load game over patterns
; ===========================================================================

loc_138D4:
		move.b	#60,deathtime(a0)	; set time delay to 1 second
		tst.b	(f_timeover).w	; is TIME OVER tag set?
		beq.s	locret_13900	; if not, branch
		move.b	#0,deathtime(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load TIME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#2,(v_objspace+$80+obFrame).w
		move.b	#3,(v_objspace+$C0+obFrame).w
		bra.s	loc_138C2
; ===========================================================================

locret_13900:
		rts	
; End of function GameOver

; ---------------------------------------------------------------------------
; Sonic	when the level is restarted
; ---------------------------------------------------------------------------

Sonic_ResetLevel: ; Routine 8
		tst.b	deathtime(a0)
		beq.s	locret_13914
		subq.b	#1,deathtime(a0)	; subtract 1 from time delay
		bne.s	locret_13914

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

locret_13914:
		rts
		
		include	"Objects\Sonic\Loops.asm"
		include	"Objects\Sonic\Animate.asm"
		
		include	"Data\Animations\Sonic.asm"
		include	"Objects\Sonic\LoadGfx.asm"