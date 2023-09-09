; -------------------------------------------------------------------------
; =========================================================================
; MARBLE ZONE ACT 4 BOSS
; Coded by Vladikcomper
; =========================================================================

v_BossHits	= 8		; total number of hits
v_BossPinchHits	= 4		; number of hits left for pinch mode
v_CamXBase	= $1800		; X position of camera at boss arena
v_CamYBase	= $200-$20	; Y position of camera at boss arena

; -------------------------------------------------------------------------
BossMarble:
		moveq	#0,d0
		move.b	$24(a0),d0
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
		lea	BossMarble_ObjData(pc),a2		; a2 => Load config
		movea.l	a0,a1				; use this object slot for first object configured
		moveq	#4-1,d1				; do 4 objects
		bra.s	@ConfigObject			; skip creation part for the first object
		
	@CreateObject:
		jsr	FindNextFreeObj			; important! this slot should be placed after ship slot to aviod code conflicts
		bne.s	@ConfigBoss			; if we fail, branch
		move.b	#$73,(a1)			; -- I'm Object 73 and I'm proud of it!
		move.w	8(a0),8(a1)			; copy X, Y coords
		move.w	$C(a0),$C(a1)			;
		move.w	a0,$34(a1)			; set parent obj address
		
	@ConfigObject:
		move.b	#4,1(a1)
		move.w	#$400,2(a1)
		move.l	#Map_Eggman,4(a1)
		move.b	#$20,$19(a1)
		move.b	(a2)+,$24(a1)			; config => set up routine
		move.b	(a2)+,$1C(a1)			; config => set up animation
		move.b	(a2)+,$18(a1)			; config => set up priority

		dbf	d1,@CreateObject

		move.l	#Map_BossItems,4(a1)		; fix config for boss items
		move.w	#$246C,2(a1)			;
		move.b	#4,$1A(a1)			;
		
	@ConfigBoss:
		move.b	#v_BossHits,$21(a0)		; set number of hits to beat him  
		move.w	#-$100,$10(a0)			; set launching speed
		move.w	#120,$34(a0)			; set timer


; =========================================================================
; -------------------------------------------------------------------------
; Main ship processing routine
; -------------------------------------------------------------------------

BossMarble_ShipMain:
		moveq	#0,d0
		move.b	$25(a0),d0
		move.w	@Routines(pc,d0.w),d0
		jsr	@Routines(pc,d0.w)

		; Animation, display and flipping stuff
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		move.b	$22(a0),d0	; load object status
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
		cmpi.w	#v_CamXBase+$110+$20,8(a0); has the ship reached boss music point?
		bne.s	@0			; if not, branch
		move.w	#$8C,d0			
		jsr	PlaySound		; play boss music

@0:		cmpi.w	#v_CamXBase+$110,8(a0)	; has the ship reached a laugh-point?
		bne.s	@MoveShip		; if not, branch

		clr.w	$10(a0)
		subq.w	#1,$34(a0)		; subtract 1 from timer
		bne.s	@NoMove		; if time is over, branch
		move.w	#-$400,$10(a0)		; setup new speed

	@MoveShip:
		cmpi.w	#v_CamXBase-$40,8(a0)	; has the ship gone past left boundary?
		bcs.s	@NextRoutine		; if yep, go to next routine
		jmp	SpeedToPos

	@NextRoutine:
		addq.b	#2,$25(a0)
		bset	#0,$22(a0)		; set orientation to right
		move.w	#$280,$10(a0)		; set speeds
		move.w	#90,$34(a0)		; set timer
		move.w	#$20,$36(a0)		; set interval
		move.b	#$F,$20(a0)		; set touch response
		addq.b	#2,($FFFFF742).w	; -- Now we ROCK!!!

	@NoMove:
		rts

; =========================================================================
; -------------------------------------------------------------------------
; Eggman flies from the left to mid-screen then starts going down
; -------------------------------------------------------------------------

BossMarble_FlyAction1:
		bsr.w	BossMarble_ThrowLava
		tst.w	$12(a0)			; are we going down?
		bne.s	@FlyDown
		move.w	8(a0),d0		; d0 -> BossX
		sub.w	($FFFFF700).w,d0	; d0 -> BossX - CamX
		cmpi.w	#200,d0			; is Boss in mid screen?
		blt.s	@MoveShip		; if not, branch
		
	@FlyDown:
		subq.w	#8,$10(a0)
		beq.s	@NextRoutine
		addq.w	#4,$12(a0)

	@MoveShip:                     
		bsr.w	BossMarble_ShipProcess
		jmp	SpeedToPos  
		
	@NextRoutine:
		addq.b	#2,$25(a0)

; =========================================================================
; -------------------------------------------------------------------------
; Eggman flies from left bottom to right top
; -------------------------------------------------------------------------

BossMarble_FlyAction2:
		bsr.w	BossMarble_ThrowLava
		tst.w	$12(a0)			; is ship going up?
		bmi.s	@MoveUp			; if yes, branch
		subq.w	#4-2,$12(a0)		; establish ship

	@MoveUp:
		subq.w	#2,$12(a0)
		addq.w	#8,$10(a0)		; accelerate ship horizonatally
		move.w	8(a0),d0		; d0 -> BossX
		sub.w	($FFFFF700).w,d0	; d0 -> BossX - CamX
		cmpi.w	#320+$40,d0		; has boss went out of screen?
		bge.s	@NextRoutine		; if yes, branch  
		bsr.w	BossMarble_ShipProcess
		jmp	SpeedToPos

	@NextRoutine:
		addq.b	#2,$25(a0)
		move.w	#$23C,$C(a0)		; restore Y-pos
		clr.w	$12(a0)			; reset Y-speed
		move.w	#$1C0,$10(a0)		; set X-speed

; =========================================================================
; -------------------------------------------------------------------------
; Eggman slowly appears from right, start rising up-down at some point
; -------------------------------------------------------------------------

BossMarble_FlyAction3:
		bsr.w	BossMarble_ThrowLava
		move.w	8(a0),d0		; d0 -> BossX
		sub.w	($FFFFF700).w,d0	; d0 -> BossX - CamX

		cmpi.w	#320-$40,d0		; has boss went past screen ~quater?
		bgt.s	@MoveShip		; if not, branch
		addq.w	#4,$12(a0)		; make ship fly down
		cmpi.w	#$23C-$20+$40,$C(a0)	; has the boss passed Y-mid screen?
		bcs.s	@MoveShip		; if nah, branch
		subq.w	#8,$12(a0)		; make ship rise
		bne.s	@MoveShip		; if speed is not zero, branch
		cmpi.w	#160,d0			; has the boss passed X-mid screen?
		bgt.s	@MoveShip		; if not, branch
		addq.b	#2,$25(a0)		; => "BossMarble_FlyAction2"

	@MoveShip:         
		bsr.w	BossMarble_ShipProcess
		jmp	SpeedToPos

; =========================================================================
; -------------------------------------------------------------------------
; Eggman quickly flies from right, reaching bottom then going up to left
; -------------------------------------------------------------------------

BossMarble_FlyAction4:
		bclr	#0,$22(a0)		; flip ship right
		move.w	#-$100,$10(a0)		; set attack speed
		move.w	8(a0),d0		; d0 -> BossX
		sub.w	($FFFFF700).w,d0	; d0 -> BossX - CamX
		cmpi.w	#-$40,d0		; has the boss flied to the left border?
		blt.s	@NextRoutine		; if yes, branch
		addi.w	#$1C,$12(a0)		; make ship fly down
		cmpi.w	#$23C-$20+$40,$C(a0)	; has the boss passed Y-mid screen?
		bcs.s	@MoveAndFire		; if nah, branch
		subi.w	#$38,$12(a0)
		bra.s	@MoveShip
		
	@MoveAndFire:   
		bsr.w	BossMarble_ThrowLava

	@MoveShip:                     
		bsr.w	BossMarble_ShipProcess
		jmp	SpeedToPos

	@NextRoutine:
		move.b	#2,$25(a0)		; => "BossMarble_FlyAction1"
		move.w	#$23C,$C(a0)		; reset Y-pos
		bset	#0,$22(a0)		; flip boss right
		move.w	#$280,$10(a0)		; set speeds
		clr.w	$12(a0)			;
		rts


; =========================================================================
; -------------------------------------------------------------------------
; Subroutine to buring every fucking pixel inda hell
; -------------------------------------------------------------------------

BossMarble_ThrowLava:
		subq.w	#1,$34(a0)		; subtract 1 from timer
		bne.s	@Return			; if time remains, branch
		move.w	$36(a0),$34(a0)		; reset timer
		jsr	FindFreeObj
		bne.s	@Return
		move.b	#$14,(a1)		; load lava ball
		move.w	8(a0),8(a1)		; set X-pos
		move.w	$C(a0),d0
		add.w	#$28,d0
		move.w	d0,$C(a1)		; set Y-pos
		move.b	#5,$28(a1)
		
	@Return:
		rts
		

; =========================================================================
; -------------------------------------------------------------------------
; Subroutine to process main ship stuff
; ---------------------------------------------------------------------------

BossMarble_ShipProcess:
		tst.b	$22(a0)		; was boss defeated?
		bmi.s	BossMarble_ShipGone	; if yes, branch
		tst.b	$20(a0)		; is touch response zero?
		bne.s	@Return		; if not, branch
		tst.b	$3E(a0)		; is flashes counter zero?
		bne.s	@ShipFlash	; if not, branch
		move.b	#$20,$3E(a0)	; set number of	times to flash 

		cmpi.b	#v_BossPinchHits,$21(a0)	; is it time for pinch mode?
		bne.s	@DamageBoss			; if nah, branch
		move.w	#4,$36(a0)			; fire harder
		move.w	#$60,$34(a0)			; wait some time before firing hard
		addi.b	#$40,$3E(a0)			; flash longer

	@DamageBoss:
		move.w	#$AC,d0
		jsr	(PlaySound_Special).l ;	play boss damage sound

	@ShipFlash:
		lea	($FFFFFB22).w,a1 ; load	2nd pallet, 2nd	entry
		moveq	#0,d0		; move 0 (black) to d0
		tst.w	(a1)		; is colour in pallete black?
		bne.s	@MakeFlash	; if not, branch
		move.w	#$EEE,d0	; move 0EEE (white) to d0

	@MakeFlash:
		move.w	d0,(a1)		; apply colour stored in d0
		subq.b	#1,$3E(a0)	; subtract 1 from flashes counter
		bne.s	@Return		; if flashes counter is not zero, branch
		move.b	#$F,$20(a0)	; restore touch responsibility

	;	cmpi.b	#v_BossPinchHits,$21(a0)	; flashed after pinch mode?
	;	bne.s	@Return				; if nah, branch
	;	move.b	#$4A,d0		; play pinch music for the MZ boss
	;	jsr	(PlaySound).l

	@Return:
		rts

; ===========================================================================
BossMarble_ShipGone:
		moveq	#100,d0
		bsr.w	AddPoints		; add 1000 points
		clr.w	$12(a0)			; clear Y-vel
		move.w	#$1C0,$10(a0)		; set X-vel
		move.b	#$C,$25(a0)		; => "BossMarble_Defeated"
		move.w	#180,$38(a0)		; set up clever timer
		move.w	#$AC,d0
		jmp	(PlaySound_Special).l	; play boss damage sound

; =========================================================================
BossMarble_Defeated:
		subq.w	#1,$38(a0)		; subtract 1 from timer
		bpl.s	@MoveShip
		bset	#0,$22(a0)		; flip him right
		move.w	8(a0),d0		; d0 -> BossX
		sub.w	($FFFFF700).w,d0	; d0 -> BossX - CamX
		addq.w	#8,$10(a0)		; move ship horizontally
		cmpi.w	#60,d0			; has the boss passed special point on screen?
		blt.s	@MoveShip		; if not, branch
		subq.w	#8,$12(a0)		; move ship vertically
		cmpi.w	#320+$80,d0		; has the boss run out for quite long distance?
		bgt.s	@DeleteBoss		; if yes, make it all finish
		
	@MoveShip:
		jsr	SpeedToPos
		jmp	BossDefeated		; -- FUCK NO! I'M EXPLODING!!!

	@DeleteBoss:
		addq.b	#2,($FFFFF742).w
		move.b	#$83,d0
		jsr	PlaySound		; TODOh: Custom song
		jmp	DeleteObject


; =========================================================================
; -------------------------------------------------------------------------
; Main face processing routine
; -------------------------------------------------------------------------

BossMarble_FaceMain:
		movea.w	$34(a0),a1		; load ship object slot
		tst.b	(a1)
		beq.s	BossMarble_DeleteSubObj
		moveq	#1,d1			; => Normal Face
		tst.b	$25(a1)
		bne.s	@BehaveNormal
		
	; -- Routine $00
		tst.w	$10(a1)			; has the boss stoped? (boss only stops to laugh at Sonic, so yeah)
		bne.s	@SetAnimation		; if nah, branch
		moveq	#4,d1			; => Face Laugh
		bra.s	@SetAnimation

	; -- Routines $02+
	@BehaveNormal:      
		tst.b	$20(a1)
		bne.s	@CheckSonic
		moveq	#5,d1			; => Face Hurt
		bra.s	@SetAnimation

	@CheckSonic:
		cmpi.b	#4,($FFFFD024).w	; is Sonic hurt?
		bcs.s	@SetAnimation		; if no, branch
		moveq	#4,d1			; => Face Laugh

	@SetAnimation:
		move.b	d1,$1C(a0)


; =========================================================================
; -------------------------------------------------------------------------
; Rotine to display sub-object according to ship position
; -------------------------------------------------------------------------

BossMarble_DisplaySubObj:
		move.w	8(a1),8(a0)		; copy coords
		move.w	$C(a1),$C(a0)		;
		move.b	$22(a1),$22(a0)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		
BossMarble_DisplaySubObj2:
		move.b	$22(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,1(a0)
		or.b	d0,1(a0)
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
		tst.w	$10(a1)
		beq.s	@SetAnimation
		moveq	#8,d1			; => Normal flame
		
	@SetAnimation:
		move.b	d1,$1C(a0)
		bra.s	BossMarble_DisplaySubObj



; =========================================================================
; -------------------------------------------------------------------------
; Main tube processing routine
; -------------------------------------------------------------------------

BossMarble_TubeMain:
		movea.w	$34(a0),a1		; load ship object slot
		tst.b	(a1)
		beq.s	BossMarble_DeleteSubObj
		move.w	8(a1),8(a0)		; copy coords
		move.w	$C(a1),$C(a0)		;
		move.b	$22(a1),$22(a0)
		bra.s	BossMarble_DisplaySubObj2

; =========================================================================