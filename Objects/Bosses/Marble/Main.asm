; -------------------------------------------------------------------------
; =========================================================================
; MARBLE ZONE ACT 4 BOSS
; Coded by Vladikcomper
; =========================================================================

v_BossHits	= 8		; total number of hits
v_BossPinchHits	= 4		; number of hits left for pinch mode
v_CamXBase	= $1800		; X position of camera at boss arena
v_CamYBase	= $200-$20	; Y position of camera at boss arena

timer	= $28
timer_interval = $2A

; -------------------------------------------------------------------------
BossMarble:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Routines(pc,d0.w),d0		; get routine relative offset
		jmp	@Routines(pc,d0.w)		; jump to routine

; -------------------------------------------------------------------------
	@Routines:
		dc.w	BossMarble_BossLoad-@Routines	; $00
		dc.w	BossMarble_ShipMain-@Routines	; $02
		dc.w	BossMarble_FaceMain-@Routines	; $04
		dc.w	BossMarble_FlameMain-@Routines	; $06
		dc.w	BossMarble_TubeMain-@Routines	; $08


; =========================================================================
; -------------------------------------------------------------------------
; Boss object configuration data
; -------------------------------------------------------------------------
; FORMAT:	Routine number, Animation, Priority
; -------------------------------------------------------------------------

BossMarble_ObjData:
		dc.b	2, 0, 4		; ship object
		dc.b	4, 1, 4		; face object
		dc.b	6, 7, 4		; flame object
		dc.b	8, 0, 3		; tube object


; =========================================================================
; -------------------------------------------------------------------------
; Main boss loading & initialization routine
; -------------------------------------------------------------------------

BossMarble_BossLoad:
		move.w	obY(a0), $38(a0)			; setup Y-pos

		lea	BossMarble_ObjData(pc),a2	; a2 => Load config
		movea.l	a0,a1				; use this object slot for first object configured
		moveq	#4-1,d1				; do 4 objects
		bra.s	@ConfigObject			; skip creation part for the first object
		
	@CreateObject:
		jsr	FindNextFreeObj			; important! this slot should be placed after ship slot to aviod code conflicts
		bne.s	@ConfigBoss			; if we fail, branch
		move.b	#id_BossMarble,(a1)		; -- I'm MZ Boss and I'm proud of it!
		move.w	obX(a0), obX(a1)		; copy X, Y coords
		move.w	obY(a0),obY(a1)			;
		move.w	a0, $34(a1)			; set parent obj address
		
	@ConfigObject:
		move.b	#4, obRender(a1)
		move.w	#$400, obGfx(a1)
		move.l	#Map_Eggman, obMap(a1)
		move.b	#$20, obActWid(a1)
		move.b	(a2)+, obRoutine(a1)		; config => set up routine
		move.b	(a2)+, obAnim(a1)		; config => set up animation
		move.b	(a2)+, obPriority(a1)		; config => set up priority

		dbf	d1, @CreateObject

		move.l	#Map_BossItems, obMap(a1)	; fix config for boss items
		move.w	#$246C, obGfx(a1)		;
		move.b	#4, obFrame(a1)			;
		
	@ConfigBoss:
		move.b	#v_BossHits, obColProp(a0)	; set number of hits to beat him  
		move.w	#-$100, obVelX(a0)		; set launching speed

		move.w	#90, timer(a0)			; set timer


; =========================================================================
; -------------------------------------------------------------------------
; Main ship processing routine
; -------------------------------------------------------------------------

BossMarble_ShipMain:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	@Routines(pc,d0.w),d0
		jsr	@Routines(pc,d0.w)

		; Make boss slightly float up-down
		move.b	$3F(a0), d0
		jsr	(CalcSine).l
		asr.w	#6, d0
		add.w	$38(a0), d0
		move.w	d0, obY(a0)
		addq.b	#2, $3F(a0)

		; Animation, display and flipping stuff
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		move.b	obStatus(a0),d0	; load object status
		andi.b	#3,d0		; mask only X-Y orientation
		andi.b	#$FC,1(a0)	; clear X-Y orientation bits in render flags
		or.b	d0,1(a0)	; set up orientation according to obj status
		jmp	DisplaySprite

; -------------------------------------------------------------------------
	@Routines:
		dc.w	BossMarble_ShipAppear-@Routines	; $00
		dc.w	BossMarble_FlyAction1-@Routines	; $02
		dc.w	BossMarble_FlyAction2-@Routines	; $04
		dc.w	BossMarble_FlyAction3-@Routines	; $06
		dc.w	BossMarble_FlyAction2-@Routines	; $08
		dc.w	BossMarble_FlyAction4-@Routines	; $0A
		dc.w	BossMarble_Defeated-@Routines	; $0C

; =========================================================================
BossMarble_ShipAppear:
		cmpi.w	#v_CamXBase+$110+$20,obX(a0); has the ship reached boss music point?
		bne.s	@0			; if not, branch

		music mus_Final			; play boss music

@0:		cmpi.w	#v_CamXBase+$110,obX(a0); has the ship reached a laugh-point?
		bne.s	@MoveShip		; if not, branch

		clr.w	obVelX(a0)
		subq.w	#1,timer(a0)		; subtract 1 from timer
		bne.s	@NoMove			; if time is over, branch
		move.w	#-$400,obVelX(a0)	; setup new speed

	@MoveShip:
		cmpi.w	#v_CamXBase-$40,obX(a0)	; has the ship gone past left boundary?
		bcs.s	@NextRoutine		; if yep, go to next routine
		jmp	BossMove2

	@NextRoutine:
		addq.b	#2,ob2ndRout(a0)
		bset	#0,obStatus(a0)		; set orientation to right
		move.w	#$280,obVelX(a0)	; set speeds
		move.w	#90,timer(a0)		; set timer
		move.w	#$20,timer_interval(a0)	; set interval
		move.b	#$F,obColType(a0)	; set touch response
		addq.b	#2,(v_dle_routine).w	; -- Now we ROCK!!!

	@NoMove:
		rts

; =========================================================================
; -------------------------------------------------------------------------
; Eggman flies from the left to mid-screen then starts going down
; -------------------------------------------------------------------------

BossMarble_FlyAction1:
		bsr.w	BossMarble_ThrowLava
		tst.w	obVelY(a0)		; are we going down?
		bne.s	@FlyDown
		move.w	obX(a0),d0		; d0 -> BossX
		sub.w	(v_screenposx).w,d0	; d0 -> BossX - CamX
		cmpi.w	#200,d0			; is Boss in mid screen?
		blt.s	@MoveShip		; if not, branch
		
	@FlyDown:
		subq.w	#8,obVelX(a0)
		beq.s	@NextRoutine
		addq.w	#4,obVelY(a0)

	@MoveShip:                     
		bsr.w	BossMarble_ShipProcess
		jmp	BossMove2  
		
	@NextRoutine:
		addq.b	#2,ob2ndRout(a0)

; =========================================================================
; -------------------------------------------------------------------------
; Eggman flies from left bottom to right top
; -------------------------------------------------------------------------

BossMarble_FlyAction2:
		bsr.w	BossMarble_ThrowLava
		tst.w	obVelY(a0)			; is ship going up?
		bmi.s	@MoveUp			; if yes, branch
		subq.w	#4-2,obVelY(a0)		; establish ship

	@MoveUp:
		subq.w	#2,obVelY(a0)
		addq.w	#8,obVelX(a0)		; accelerate ship horizonatally
		move.w	obX(a0),d0		; d0 -> BossX
		sub.w	(v_screenposx).w,d0	; d0 -> BossX - CamX
		cmpi.w	#320+$40,d0		; has boss went out of screen?
		bge.s	@NextRoutine		; if yes, branch  
		bsr.w	BossMarble_ShipProcess
		jmp	BossMove2

	@NextRoutine:
		addq.b	#2,ob2ndRout(a0)
		move.w	#$23C,$38(a0)		; restore Y-pos
		clr.w	obVelY(a0)		; reset Y-speed
		move.w	#$1C0,obVelX(a0)	; set X-speed

; =========================================================================
; -------------------------------------------------------------------------
; Eggman slowly appears from right, start rising up-down at some point
; -------------------------------------------------------------------------

BossMarble_FlyAction3:
		bsr.w	BossMarble_ThrowLava
		move.w	obX(a0),d0		; d0 -> BossX
		sub.w	(v_screenposx).w,d0	; d0 -> BossX - CamX

		cmpi.w	#320-$40,d0		; has boss went past screen ~quater?
		bgt.s	@MoveShip		; if not, branch
		addq.w	#4,obVelY(a0)		; make ship fly down
		cmpi.w	#$23C-$20+$40,$38(a0)	; has the boss passed Y-mid screen?
		bcs.s	@MoveShip		; if nah, branch
		subq.w	#8,obVelY(a0)		; make ship rise
		bne.s	@MoveShip		; if speed is not zero, branch
		cmpi.w	#160,d0			; has the boss passed X-mid screen?
		bgt.s	@MoveShip		; if not, branch
		addq.b	#2,ob2ndRout(a0)		; => "BossMarble_FlyAction2"

	@MoveShip:         
		bsr.w	BossMarble_ShipProcess
		jmp	BossMove2

; =========================================================================
; -------------------------------------------------------------------------
; Eggman quickly flies from right, reaching bottom then going up to left
; -------------------------------------------------------------------------

BossMarble_FlyAction4:
		bclr	#0,obStatus(a0)		; flip ship right
		move.w	#-$100,obVelX(a0)	; set attack speed
		move.w	obX(a0),d0		; d0 -> BossX
		sub.w	(v_screenposx).w,d0	; d0 -> BossX - CamX
		cmpi.w	#-$40,d0		; has the boss flied to the left border?
		blt.s	@NextRoutine		; if yes, branch
		addi.w	#$1C,obVelY(a0)		; make ship fly down
		cmpi.w	#$23C-$20+$40,$38(a0)	; has the boss passed Y-mid screen?
		bcs.s	@MoveShip		; if nah, branch
		subi.w	#$38,obVelY(a0)

	@MoveShip:                     
		bsr.w	BossMarble_ShipProcess
		jmp	BossMove2

	@NextRoutine:
		move.b	#2,ob2ndRout(a0)	; => "BossMarble_FlyAction1"
		move.w	#$23C,$38(a0)		; reset Y-pos
		bset	#0,obStatus(a0)		; flip boss right
		move.w	#$280,obVelX(a0)	; set speeds
		clr.w	obVelY(a0)		;
		rts


; =========================================================================
; -------------------------------------------------------------------------
; Subroutine to buring every fucking pixel inda hell
; -------------------------------------------------------------------------

BossMarble_ThrowLava:
		subq.w	#1,timer(a0)		; subtract 1 from timer
		bne.s	@Return			; if time remains, branch
		move.w	timer_interval(a0),timer(a0)		; reset timer
		jsr	FindFreeObj
		bne.s	@Return
		move.b	#id_ObjDynamic, (a1)
		move.l	#MZBossLavaBall, obCodePtr(a1)
		move.w	obX(a0), obX(a1)	; set X-pos
		move.w	obVelX(a0), obVelX(a1)	; set X-pos
		move.w	#$200, obVelY(a1)
		moveq	#$28, d0
		add.w	obY(a0),d0
		move.w	d0,obY(a1)		; set Y-pos
		
	@Return:
		rts
		

; =========================================================================
; -------------------------------------------------------------------------
; Subroutine to process main ship stuff
; ---------------------------------------------------------------------------

BossMarble_ShipProcess:
		tst.b	obStatus(a0)			; was boss defeated?
		bmi.s	BossMarble_ShipGone		; if yes, branch
		tst.b	obColType(a0)			; is touch response zero?
		bne.s	@Return				; if not, branch
		tst.b	$3E(a0)				; is flashes counter zero?
		bne.s	@ShipFlash			; if not, branch
		move.b	#$20,$3E(a0)			; set number of	times to flash 

		cmpi.b	#v_BossPinchHits, obColProp(a0)	; is it time for pinch mode?
		bne.s	@DamageBoss			; if nah, branch
		move.w	#4, timer_interval(a0)		; fire harder
		move.w	#$60, timer(a0)			; wait some time before firing hard
		addi.b	#$40, $3E(a0)			; flash longer

	@DamageBoss:
		sfx sfx_bosshit				; play boss damage sound

	@ShipFlash:
		lea	(v_pal_dry+$22).w,a1 		; load	2nd pallet, 2nd	entry
		moveq	#0,d0				; move 0 (black) to d0
		tst.w	(a1)				; is colour in pallete black?
		bne.s	@MakeFlash			; if not, branch
		move.w	#$EEE,d0			; move 0EEE (white) to d0

	@MakeFlash:
		move.w	d0,(a1)				; apply colour stored in d0
		subq.b	#1,$3E(a0)			; subtract 1 from flashes counter
		bne.s	@Return				; if flashes counter is not zero, branch
		move.b	#$F,obColType(a0)		; restore touch responsibility

	;	cmpi.b	#v_BossPinchHits,obColProp(a0)	; flashed after pinch mode?
	;	bne.s	@Return				; if nah, branch
	;	move.b	#$4A,d0		; play pinch music for the MZ boss
	;	jsr	(PlaySound).l

	@Return:
		rts

; ===========================================================================
BossMarble_ShipGone:
		moveq	#100,d0
		bsr.w	AddPoints		; add 1000 points
		clr.w	obVelY(a0)		; clear Y-vel
		move.w	#$1C0,obVelX(a0)	; set X-vel
		move.b	#$C,ob2ndRout(a0)	; => "BossMarble_Defeated"
		move.w	#180,$30(a0)		; set up clever timer

		sfx sfx_bosshit			; play boss damage sound

; =========================================================================
BossMarble_Defeated:
		subq.w	#1,$30(a0)		; subtract 1 from timer
		bpl.s	@MoveShip
		bset	#0,obStatus(a0)		; flip him right
		move.w	obX(a0),d0		; d0 -> BossX
		sub.w	(v_screenposx).w,d0	; d0 -> BossX - CamX
		addq.w	#8,obVelX(a0)		; move ship horizontally
		cmpi.w	#60,d0			; has the boss passed special point on screen?
		blt.s	@MoveShip		; if not, branch
		subq.w	#8,obVelY(a0)		; move ship vertically
		cmpi.w	#320+$80,d0		; has the boss run out for quite long distance?
		bgt.s	@DeleteBoss		; if yes, make it all finish
		
	@MoveShip:
		jsr	BossMove2
		jmp	BossDefeated		; -- FUCK NO! I'M EXPLODING!!!

	@DeleteBoss:
		addq.b	#2,(v_dle_routine).w

		music mus_mz			; play BGM

		jmp	DeleteObject


; =========================================================================
; -------------------------------------------------------------------------
; Main face processing routine
; -------------------------------------------------------------------------

BossMarble_FaceMain:
		movea.w	$34(a0),a1			; load ship object slot
		tst.b	(a1)
		beq.s	BossMarble_DeleteSubObj
		moveq	#1,d1				; => Normal Face
		tst.b	ob2ndRout(a1)
		bne.s	@BehaveNormal
		
	; -- Routine $00
		tst.w	obVelX(a1)			; has the boss stoped? (boss only stops to laugh at Sonic, so yeah)
		bne.s	@SetAnimation			; if nah, branch
		moveq	#4,d1				; => Face Laugh
		bra.s	@SetAnimation

	; -- Routines $02+
	@BehaveNormal:      
		tst.b	obColType(a1)
		bne.s	@CheckSonic
		moveq	#5,d1				; => Face Hurt
		bra.s	@SetAnimation

	@CheckSonic:
		cmpi.b	#4,(v_player+obRoutine).w	; is Sonic hurt?
		bcs.s	@SetAnimation			; if no, branch
		moveq	#4,d1				; => Face Laugh

	@SetAnimation:
		move.b	d1, obAnim(a0)


; =========================================================================
; -------------------------------------------------------------------------
; Rotine to display sub-object according to ship position
; -------------------------------------------------------------------------

BossMarble_DisplaySubObj:
		move.w	obX(a1), obX(a0)	; copy coords
		move.w	obY(a1), obY(a0)	;
		move.b	obStatus(a1), obStatus(a0)
		lea	(Ani_Eggman).l, a1
		jsr	AnimateSprite
		
BossMarble_DisplaySubObj2:
		move.b	obStatus(a0), d0
		andi.b	#3, d0
		andi.b	#$FC, obRender(a0)
		or.b	d0, obRender(a0)
		jmp	DisplaySprite


; =========================================================================
BossMarble_DeleteSubObj:
		jmp	DeleteObject


; =========================================================================
; -------------------------------------------------------------------------
; Main flame processing routine
; -------------------------------------------------------------------------

BossMarble_FlameMain:
		movea.w	$34(a0),a1		; load ship object slot
		tst.b	(a1)
		beq.s	BossMarble_DeleteSubObj
		moveq	#0,d1			; => No Flame
		tst.w	obVelX(a1)
		beq.s	@SetAnimation
		moveq	#8,d1			; => Normal flame
		
	@SetAnimation:
		move.b	d1,obAnim(a0)
		bra.s	BossMarble_DisplaySubObj



; =========================================================================
; -------------------------------------------------------------------------
; Main tube processing routine
; -------------------------------------------------------------------------

BossMarble_TubeMain:
		movea.w	$34(a0),a1			; load ship object slot
		tst.b	(a1)
		beq.s	BossMarble_DeleteSubObj
		move.w	obX(a1), obX(a0)		; copy coords
		move.w	obY(a1), obY(a0)		; ''
		move.b	obStatus(a1), obStatus(a0)
		bra.s	BossMarble_DisplaySubObj2

; =========================================================================