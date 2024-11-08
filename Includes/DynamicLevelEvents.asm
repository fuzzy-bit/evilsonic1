; ---------------------------------------------------------------------------
; Dynamic level events
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DynamicLevelEvents:
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		move.w	DLE_Index(pc,d0.w),d0
		jsr	DLE_Index(pc,d0.w) ; run level-specific events
		moveq	#2,d1
		move.w	(v_limitbtm1).w,d0
		sub.w	(v_limitbtm2).w,d0 ; has lower level boundary changed recently?
		beq.s	DLE_NoChg	; if not, branch
		bcc.s	loc_6DAC

		neg.w	d1
		move.w	(v_screenposy).w,d0
		cmp.w	(v_limitbtm1).w,d0
		bls.s	loc_6DA0
		move.w	d0,(v_limitbtm2).w
		andi.w	#$FFFE,(v_limitbtm2).w

loc_6DA0:
		add.w	d1,(v_limitbtm2).w
		move.b	#1,(f_bgscrollvert).w

DLE_NoChg:
		rts	
; ===========================================================================

loc_6DAC:
		move.w	(v_screenposy).w,d0
		addq.w	#8,d0
		cmp.w	(v_limitbtm2).w,d0
		bcs.s	loc_6DC4
		btst	#1,(v_player+obStatus).w
		beq.s	loc_6DC4
		add.w	d1,d1
		add.w	d1,d1

loc_6DC4:
		add.w	d1,(v_limitbtm2).w
		move.b	#1,(f_bgscrollvert).w
		rts	
; End of function DynamicLevelEvents

; ===========================================================================
; ---------------------------------------------------------------------------
; Offset index for dynamic level events
; ---------------------------------------------------------------------------
DLE_Index:	dc.w DLE_GHZ-DLE_Index, DLE_LZ-DLE_Index
		dc.w DLE_MZ-DLE_Index, DLE_SLZ-DLE_Index
		dc.w DLE_SYZ-DLE_Index, DLE_SBZ-DLE_Index
		dc.w DLE_Ending-DLE_Index
		zonewarning DLE_Index,2	
		dc.w DLE_Z7-DLE_Index
; ===========================================================================
; ---------------------------------------------------------------------------
; Green	Hill Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_GHZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_GHZx(pc,d0.w),d0
		jmp	DLE_GHZx(pc,d0.w)
; ===========================================================================
DLE_GHZx:	dc.w DLE_GHZ1-DLE_GHZx
		dc.w DLE_GHZ2-DLE_GHZx
		dc.w DLE_GHZ3-DLE_GHZx
; ===========================================================================

DLE_GHZ1:

@CamXVel:	equ	v_bg3screenposy		; use unused variable

		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	@Routines(pc,d0.w),d0
		jmp	@Routines(pc,d0.w)
; ===========================================================================
@Routines:
		dc.w	@Level-@Routines
		dc.w	@Nullsub-@Routines
		dc.w	@StartScrolling-@Routines
		dc.w	@Autoscroll-@Routines
		dc.w	@End-@Routines
		dc.w	@Nullsub-@Routines

; ===========================================================================
@Level:
		; - DEFAULT ------------------------------------
		move.w	#$300,(v_limitbtm1).w ; set lower y-boundary
		; - PASS 1--------------------------------------
		cmpi.w	#$0840,(v_screenposx).w ; has the camera reached $0840 on x-axis?
		bcs.s	@Pass2	; if not, branch

		move.w	#$400,(v_limitbtm1).w ; set lower y-boundary
		; - PASS 2 -------------------------------------
@Pass2:
		cmpi.w	#$0630,(v_screenposx).w ; has the camera reached $0630 on x-axis?
		bcs.s	@Return	; if not, branch

		cmpi.w	#$0350,(v_screenposy).w ; has the camera reached $0350 on y-axis?
		bcs.s	@Return	; if not, branch
		
		move.w	#$400,(v_limitbtm1).w ; set lower y-boundary

		cmpi.w	#$2500-$200, (v_screenposx).w
		blo.s	@Return
		move.w	#$2500-$200, (v_limitleft2).w
		addq.b	#2, (v_dle_routine).w

		move.l	#execute_ObjFakeSignpost, -(sp)
		pea	v_lvlobjspace.w
		jsr	CreateCppObject__cdecl
		move.l	d0, a1
		move.w	#$2500+320/2, obX(a1)
		move.w	#$400+224-$40, obY(a1)
		addq.w	#8, sp

		moveq	#0, d0
		move.l	d0, @CamXVel
		moveq	#plcid_Signpost,d0
		jsr	NewPLC		; load signpost	patterns
		moveq	#plcid_Boss,d0
		jmp	AddPLC		; load boss patterns

; ===========================================================================
@Nullsub:
@Return:
		rts

; ===========================================================================
@StartScrolling:

@ScrollSpeed:	= 3

		cmp.b	#6, v_player+obRoutine	; Sonic dying?
		bhs.s	@Return			; if yes, branch

		; Start moving camera increasingly fast
		move.l	@CamXVel,d0
		add.l	d0, (v_screenposx).w
		move.l	d0,d1
		asr.l	#8,d1
		swap	d0
		subq.w	#@ScrollSpeed,d0
		beq.s	@ScrollingOk
		addi.l	#$800, @CamXVel
		move.w	d1, (v_scrshiftx).w

@Scrolling_UpdateBoundaries:
		move.w	(v_screenposx).w, d0
		move.w	d0,(v_limitleft2).w		; update camera boundaries
		move.w	d0,(v_limitright2).w		;
		move.w	d0,(v_screenposx_final).w	; ''
		rts

; ---------------------------------------------------------------------------
@ScrollingOk:
		addq.b	#2, (v_dle_routine).w
		bra.s	@Scrolling_UpdateBoundaries
; ===========================================================================

@Autoscroll:

@WarpPeriod:	= $600

		cmp.b	#6, v_player+obRoutine	; Sonic dying?
		bhs.s	@Return			; if yes, branch

		move.w	(v_limitleft2).w,d0
		move.w	#$300,(v_scrshiftx).w	; keep camera scrolling ...
		addq.w	#@ScrollSpeed,d0
		cmpi.w	#$2500+@WarpPeriod,d0	; has camera went past warp border?
		bcs.s	@NoWarp			; if not, branch

		move.w	#@WarpPeriod,d1
		sub.w	d1,d0			; warp Camera

		lea	(v_objspace).w, a3
		moveq	#$7F,d6
		
	@WarpLoop:
		tst.b	(a3)			; is this slot occupied?
		beq.s	@WarpNext		; if not, branch
		moveq	#%1100, d2		; does object use playfield coordinates?
		and.b	obRender(a3), d2	; ''
		subq.w	#1<<2, d2		; ''
		bne.s	@WarpNext		; if not, branch

		sub.w	d1, obX(a3)		; warp object

	@WarpNext:
		lea	$40(a3),a3
		dbf	d6,@WarpLoop

	@NoWarp:
		move.w	d0,(v_limitleft2).w		; update camera boundaries
		move.w	d0,(v_limitright2).w		;
		move.w	d0,(v_screenposx).w		; update camera position            
		move.w	d0,(v_screenposx_final).w	; ''

		; Prevent Sonic from getting stuck on the left boundary
		lea	(v_player).w,a0
		sub.w	obX(a0), d0
		cmp.w	#-$11, d0		; is Sonic touching the left boundary?
		blt	@Return			; if nope, branch
		add.w	#$11, d0		; d0 = CameraX - SonicX + $11
		add.w	d0, obX(a0)		; SonicX = CameraX + $11
		move.w	#@ScrollSpeed<<8, obVelX(a0)
		move.w	#@ScrollSpeed<<8, obInertia(a0)
		rts
; ===========================================================================

@End:
		sf.b	(f_lockscreen).w				; unlock right boundary
		addq.b	#2,(v_dle_routine).w
		move.w	#$2C80+$E0,(v_limitright2).w		; setup right boundary
		move.w	(v_screenposx).w,(v_limitleft2).w		; limit left boundary

		moveq	#plcid_Signpost,d0
		jmp	NewPLC					; load signpost	patterns

; ===========================================================================

DLE_GHZ2:
		move.w	#$300,(v_limitbtm1).w
		cmpi.w	#$ED0,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$200,(v_limitbtm1).w
		cmpi.w	#$1600,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$400,(v_limitbtm1).w
		cmpi.w	#$1D60,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$300,(v_limitbtm1).w

locret_6E3A:
		rts	
; ===========================================================================

DLE_GHZ3:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	@Routines(pc,d0.w),d0
		jmp	@Routines(pc,d0.w)
; ===========================================================================
@Routines:	dc.w @Level_Part1-@Routines
		dc.w @Level_Part2-@Routines
		dc.w @Nullsub-@Routines
		dc.w @Autoscroll-@Routines
		dc.w @End-@Routines
		dc.w @Nullsub-@Routines
; ===========================================================================

@Level_Part1:
		move.w	#$300,(v_limitbtm1).w
		cmpi.w	#$380,(v_screenposx).w
		bcs.s	@Nullsub
		move.w	#$310,(v_limitbtm1).w
		cmpi.w	#$960,(v_screenposx).w
		bcs.s	@Nullsub
		cmpi.w	#$280,(v_screenposy).w
		bcs.s	@1
		move.w	#$400,(v_limitbtm1).w
		cmpi.w	#$1380,(v_screenposx).w
		bcc.s	@0
		move.w	#$4C0,(v_limitbtm1).w
		move.w	#$4C0,(v_limitbtm2).w

@0:
		cmpi.w	#$1700,(v_screenposx).w
		bcc.s	@1

@Nullsub:
		rts	
; ===========================================================================

@1:
		move.w	#$300,(v_limitbtm1).w
		addq.b	#2,(v_dle_routine).w
		rts	
; ===========================================================================

@Level_Part2:
		cmpi.w	#$960,(v_screenposx).w
		bcc.s	@2
		subq.b	#2,(v_dle_routine).w

@2:
		cmpi.w	#$2500,(v_screenposx).w
		bcs.s	@Nullsub
		bsr.w	FindFreeObj
		bne.s	@StartBoss
		move.b	#id_BossGreenHill, (a1) ; load GHZ boss	object

		move.b 	(v_difficulty).w, d0
		cmpi.b 	#2, d0 ; is difficulty hard+?
		blt.s 	@StartBoss ; if not, branch

		move.w	#0,(v_rings).w
		move.b	#$80,(f_ringcount).w ; update ring counter

@StartBoss:
		move.w	(v_screenposx).w,d0
		move.w	d0,(v_limitleft2).w	; lock left side

		;command	mus_FadeOut	; fade out music
		music $8C

		move.b	#1,(f_lockscreen).w	; lock screen
		addq.b	#2,(v_dle_routine).w
		addq.b	#2,(v_dle_routine).w ; ############3
		moveq	#plcid_Boss,d0
		jmp	AddPLC			; load boss patterns
		; ----------------------------------------------

@Return:
		rts	
; ===========================================================================

@Autoscroll:
@WarpPeriod:	= $600
@ScrollSpeed:	= 3

		cmp.b	#6, v_player+obRoutine	; Sonic dying?
		bhs.s	@Return			; if yes, branch

		move.w	(v_limitleft2).w,d0
		move.w	#$300,(v_scrshiftx).w	; keep camera scrolling ...
		addq.w	#@ScrollSpeed,d0
		cmpi.w	#$2500+@WarpPeriod,d0	; has camera went past warp border?
		bcs.s	@NoWarp			; if not, branch

		move.w	#@WarpPeriod,d1
		sub.w	d1,d0			; warp Camera

		lea	(v_objspace).w, a3
		moveq	#$7F,d6
		
	@WarpLoop:
		tst.b	(a3)			; is this slot occupied?
		beq.s	@WarpNext		; if not, branch
		moveq	#%1100, d2		; does object use playfield coordinates?
		and.b	obRender(a3), d2	; ''
		subq.w	#1<<2, d2		; ''
		bne.s	@WarpNext		; if not, branch

		sub.w	d1, obX(a3)		; warp object

	@WarpNext:
		lea	$40(a3),a3
		dbf	d6,@WarpLoop

	@NoWarp:
		move.w	d0,(v_limitleft2).w		; update camera boundaries
		move.w	d0,(v_limitright2).w		;
		move.w	d0,(v_screenposx).w		; update camera position            
		move.w	d0,(v_screenposx_final).w	; ''

		; Prevent Sonic from getting stuck on the left boundary
		lea	(v_player).w,a0
		sub.w	obX(a0), d0
		cmp.w	#-$11, d0		; is Sonic touching the left boundary?
		blt.s	@Return			; if nope, branch
		add.w	#$11, d0		; d0 = CameraX - SonicX + $11
		add.w	d0, obX(a0)		; SonicX = CameraX + $11
		move.w	#@ScrollSpeed<<8, obVelX(a0)
		move.w	#@ScrollSpeed<<8, obInertia(a0)
		rts
; ===========================================================================

@End:
		sf.b	(f_lockscreen).w				; unlock right boundary
		addq.b	#2,(v_dle_routine).w
		move.w	#$2900+$180,(v_limitright2).w		; setup right boundary
		move.w	(v_screenposx).w,(v_limitleft2).w		; limit left boundary

		moveq	#plcid_Signpost,d0
		jmp	NewPLC					; load signpost	patterns

; ===========================================================================
; ---------------------------------------------------------------------------
; Labyrinth Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_LZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_LZx(pc,d0.w),d0
		jmp	DLE_LZx(pc,d0.w)
; ===========================================================================
DLE_LZx:	dc.w DLE_LZ12-DLE_LZx
		dc.w DLE_LZ12-DLE_LZx
		dc.w DLE_LZ3-DLE_LZx
		dc.w DLE_SBZ3-DLE_LZx
; ===========================================================================

DLE_LZ12:
		rts	
; ===========================================================================

DLE_LZ3:
		tst.b	(f_switch+$F).w	; has switch $F	been pressed?
		beq.s	loc_6F28	; if not, branch
		lea	(v_lvllayout+$106).w,a1
		cmpi.b	#7,(a1)
		beq.s	loc_6F28
		move.b	#7,(a1)		; modify level layout
		sfx	sfx_Rumble	; play rumbling sound

loc_6F28:
		tst.b	(v_dle_routine).w
		bne.s	locret_6F64
		cmpi.w	#$1CA0,(v_screenposx).w
		bcs.s	locret_6F62
		cmpi.w	#$600,(v_screenposy).w
		bcc.s	locret_6F62
		bsr.w	FindFreeObj
		bne.s	loc_6F4A
		move.b	#id_BossLabyrinth,0(a1) ; load LZ boss object

loc_6F4A:
		music	mus_Boss	; play boss music
		move.b	#1,(f_lockscreen).w ; lock screen
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_Boss,d0
		jmp		AddPLC		; load boss patterns
; ===========================================================================

locret_6F62:
		rts	
; ===========================================================================

locret_6F64:
		rts	
; ===========================================================================

DLE_SBZ3:
		cmpi.w	#$D00,(v_screenposx).w
		bcs.s	locret_6F8C
		cmpi.w	#$18,(v_player+obY).w ; has Sonic reached the top of the level?
		bcc.s	locret_6F8C	; if not, branch
		clr.b	(v_lastlamp).w
		move.w	#1,(f_restart).w ; restart level
		move.w	#(id_SBZ<<8)+2,(v_zone).w ; set level number to 0502 (FZ)
		move.b	#1,(f_lockmulti).w ; freeze Sonic

locret_6F8C:
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Marble Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_MZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_MZx(pc,d0.w),d0
		jmp	DLE_MZx(pc,d0.w)
; ===========================================================================
DLE_MZx:	dc.w DLE_MZ1-DLE_MZx
		dc.w DLE_MZ2-DLE_MZx
		dc.w DLE_MZ3-DLE_MZx
; ===========================================================================

DLE_MZ1:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	@Routines(pc,d0.w),d0
		jmp	@Routines(pc,d0.w)
; ===========================================================================
@Routines:	dc.w @Level-@Routines
		dc.w @Nullsub-@Routines
		dc.w @Autoscroll-@Routines
		dc.w @End-@Routines
		dc.w @Nullsub-@Routines
; ===========================================================================

@Level:
		; - DEFAULT ------------------------------------
		move.w	#$12C,(v_limitbtm1).w ; set lower y-boundary
		; - PASS 1--------------------------------------
		cmpi.w	#$154,(v_screenposy).w ; has the camera reached $0154 on y-axis?
		bcc.s	@Pass2	; if yes, branch

		cmpi.w	#$41A,(v_screenposx).w ; has the camera reached $044A on x-axis?
		bcs.s	@Return	; if not, branch
		; - PASS 2 -------------------------------------
@Pass2:
		move.w	#$560,(v_limitbtm1).w ; set lower y-boundary
		; - PASS 3--------------------------------------
		cmpi.w	#$1500,(v_screenposx).w ; has the camera reached $1500 on x-axis?
		bcs.s	@Return ; if not, branch
		move.w	#$200,(v_limitbtm1).w	; lock bottom

		cmpi.w	#$1800,(v_screenposx).w ; has the camera reached $1800 on x-axis?
		bcs.s	@Return ; if not, branch

		jsr	FindFreeObj
		bne.s	@StartBoss
		move.b	#id_BossMarble, (a1)	; load MZ boss object
		move.w	#$19F0+$80, obX(a1)
		move.w	#$23C-$20, obY(a1)

		move.b 	(v_difficulty).w, d0
		cmpi.b 	#2, d0 ; is difficulty hard+?
		blt.s 	@StartBoss ; if not, branch

		move.w	#0,(v_rings).w
		move.b	#$80,(f_ringcount).w ; update ring counter

@StartBoss:
		move.w	(v_screenposx).w,d0
		move.w	d0,(v_limitleft2).w	; lock left side
		move.w	#$200,(v_limittop2).w	; lock the top

		command	mus_FadeOut	; fade out music

		move.b	#1,(f_lockscreen).w	; lock screen
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_Boss,d0
		jmp	AddPLC			; load boss patterns
		; ----------------------------------------------

@Nullsub:
@Return:
		rts	

; ===========================================================================

@Autoscroll:
@WarpPeriod:	= $400
@ScrollSpeed:	= 2

		cmp.b	#6, v_player+obRoutine	; Sonic dying?
		bhs.s	@Return			; if yes, branch
		move.w	(v_limitleft2).w,d0
		move.w	#$200,(v_scrshiftx).w	; keep camera scrolling ...
		addq.w	#@ScrollSpeed,d0
		cmpi.w	#$1900+@WarpPeriod,d0	; has camera went past warp border?
		bcs.s	@NoWarp			; if not, branch

		move.w	#@WarpPeriod,d1
		sub.w	d1,d0			; warp Camera

		lea	(v_objspace).w, a3
		moveq	#$7F,d6
		
	@WarpLoop:
		tst.b	(a3)			; is this slot occupied?
		beq.s	@WarpNext		; if not, branch
		moveq	#%1100, d2		; does object use playfield coordinates?
		and.b	obRender(a3), d2	; ''
		subq.w	#1<<2, d2		; ''
		bne.s	@WarpNext		; if not, branch

		sub.w	d1, obX(a3)		; warp object

	@WarpNext:
		lea	$40(a3),a3
		dbf	d6,@WarpLoop

	@NoWarp:
		move.w	d0,(v_limitleft2).w		; update camera boundaries
		move.w	d0,(v_limitright2).w		;
		move.w	d0,(v_screenposx).w		; update camera position            
		move.w	d0,(v_screenposx_final).w	; ''

		; Prevent Sonic from getting stuck on the left boundary
		lea	(v_player).w,a0
		sub.w	obX(a0), d0
		cmp.w	#-$11, d0		; is Sonic touching the left boundary?
		blt.s	@Return			; if nope, branch
		add.w	#$11, d0		; d0 = CameraX - SonicX + $11
		add.w	d0, obX(a0)		; SonicX = CameraX + $11
		move.w	#@ScrollSpeed<<8, obVelX(a0)
		move.w	#@ScrollSpeed<<8, obInertia(a0)
		rts
; ===========================================================================

@End:
		sf.b	(f_lockscreen).w				; unlock right boundary
		addq.b	#2,(v_dle_routine).w
		move.w	#$1D00+$180,(v_limitright2).w		; setup right boundary
		move.w	(v_screenposx).w,(v_limitleft2).w		; limit left boundary

		moveq	#plcid_Signpost,d0
		jmp	NewPLC					; load signpost	patterns

; ===========================================================================

DLE_MZ2:
		move.w	#$520,(v_limitbtm1).w
		cmpi.w	#$1700,(v_screenposx).w
		bcs.s	locret_7088
		move.w	#$200,(v_limitbtm1).w

locret_7088:
		rts	
; ===========================================================================

DLE_MZ3:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Star Light Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_SLZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_SLZx(pc,d0.w),d0
		jmp	DLE_SLZx(pc,d0.w)
; ===========================================================================
DLE_SLZx:	dc.w DLE_SLZ1-DLE_SLZx
		dc.w DLE_SLZ2-DLE_SLZx
		dc.w DLE_SLZ3-DLE_SLZx
; ===========================================================================
DLE_SLZ1:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	DLE_SLZ1Table(pc,d0.w),d0
		jmp		DLE_SLZ1Table(pc,d0.w)
; ===========================================================================
DLE_SLZ1Table:	
		dc.w DLE_SLZ1Main-DLE_SLZ1Table
		dc.w DLE_SLZ1Boss-DLE_SLZ1Table
		dc.w DLE_SLZ1End-DLE_SLZ1Table
; ===========================================================================
DLE_SLZ1Main:
		move.w	#$520,(v_limitbtm1).w
		cmpi.w	#$1800,(v_screenposx).w
		bcs.w	locret_7130
		move.w	#$120,(v_limitbtm1).w
		cmpi.w	#$1D00,(v_screenposx).w
		bcs.w	locret_7130		
		move.w	#$220,(v_limitbtm1).w
		cmpi.w	#$2500,(v_screenposx).w
		bcs.w	locret_7130		
		move.w	#$620,(v_limitbtm1).w
		move.w	#$620,(v_limitbtm2).w
		cmpi.w	#$3100,(v_screenposx).w
		bcs.s	locret_7130	
		addq.b	#2,(v_dle_routine).w
		rts

DLE_SLZ1Boss:
		bsr.w	FindFreeObj
		bne.s	@Start
		move.b	#id_BossStarLight,(a1) ; load SLZ boss object
		move.w	#$32C0,obX(a1)
		move.w	#$455,obY(a1)
		
@Start:
		music	mus_Boss	; play boss music
		move.w	#$420,(v_limitbtm1).w
		move.b	#1,(f_lockscreen).w ; lock screen
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_Boss,d0
		jmp	AddPLC		; load boss patterns

DLE_SLZ1End:
		move.w	(v_screenposx).w,(v_limitleft2).w
		rts	
; ===========================================================================

DLE_SLZ2:
		rts	
; ===========================================================================

DLE_SLZ3:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	off_7118(pc,d0.w),d0
		jmp	off_7118(pc,d0.w)
; ===========================================================================
off_7118:	dc.w DLE_SLZ3main-off_7118
		dc.w DLE_SLZ3boss-off_7118
		dc.w DLE_SLZ3end-off_7118
; ===========================================================================

DLE_SLZ3main:
		cmpi.w	#$1E70,(v_screenposx).w
		bcs.s	locret_7130
		move.w	#$210,(v_limitbtm1).w
		addq.b	#2,(v_dle_routine).w

locret_7130:
		rts	
; ===========================================================================

DLE_SLZ3boss:
		cmpi.w	#$2000,(v_screenposx).w
		bcs.s	locret_715C
		bsr.w	FindFreeObj
		bne.s	loc_7144
		move.b	#id_BossStarLight,(a1) ; load SLZ boss object
		move.w	#$2170,obX(a1)
		move.w	#$255,obY(a1)
loc_7144:
		music	mus_Boss	; play boss music
		move.b	#1,(f_lockscreen).w ; lock screen
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_Boss,d0
		jmp	AddPLC		; load boss patterns
; ===========================================================================

locret_715C:
		rts	
; ===========================================================================

DLE_SLZ3end:
		move.w	(v_screenposx).w,(v_limitleft2).w
		rts
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Spring Yard Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_SYZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_SYZx(pc,d0.w),d0
		jmp	DLE_SYZx(pc,d0.w)
; ===========================================================================
DLE_SYZx:	dc.w DLE_SYZ1-DLE_SYZx
		dc.w DLE_SYZ2-DLE_SYZx
		dc.w DLE_SYZ3-DLE_SYZx
; ===========================================================================

DLE_SYZ1:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	DLE_SYZ1_Table(pc,d0.w),d0
		jmp	DLE_SYZ1_Table(pc,d0.w)
; ===========================================================================
DLE_SYZ1_Table:	dc.w DLE_SYZ1main-DLE_SYZ1_Table
		dc.w DLE_SYZ1boss-DLE_SYZ1_Table
		dc.w DLE_SYZ1end-DLE_SYZ1_Table
; ===========================================================================

DLE_SYZ1main:
		cmpi.w	#$3600,(v_screenposx).w
		bcs.s	@return
		;bsr.w	FindFreeObj
		;bne.s	locret_71CE
		;move.b	#id_BossBlock,(a1) ; load blocks that boss picks up
		addq.b	#2,(v_dle_routine).w

@return:
		rts	
; ===========================================================================

DLE_SYZ1boss:
		move.w	#$AC,(v_limitbtm1).w
		bsr.w	FindFreeObj
		bne.s	@loc_71EC
		move.b	#id_BossSpringYard,(a1) ; load SYZ boss	object
		move.w	#$37C0,obX(a1)
		move.w	#$C5,obY(a1)

@loc_71EC:
		addq.b	#2,(v_dle_routine).w	; => "DLE_SYZ3end"
		music	mus_Boss	; play boss music
		move.b	#1,(f_lockscreen).w ; lock screen
		moveq	#plcid_Boss,d0
		jmp		AddPLC		; load boss patterns
; ===========================================================================

@locret_7200:
		rts	
; ===========================================================================

DLE_SYZ1end:
		move.w	(v_screenposx).w,(v_limitleft2).w
		rts	
; ===========================================================================

DLE_SYZ2:
		move.w	#$520,(v_limitbtm1).w
		cmpi.w	#$25A0,(v_screenposx).w
		bcs.s	locret_71A2
		move.w	#$420,(v_limitbtm1).w
		cmpi.w	#$4D0,(v_player+obY).w
		bcs.s	locret_71A2
		move.w	#$520,(v_limitbtm1).w

locret_71A2:
		rts	
; ===========================================================================

DLE_SYZ3:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	off_71B2(pc,d0.w),d0
		jmp	off_71B2(pc,d0.w)
; ===========================================================================
off_71B2:	dc.w DLE_SYZ3main-off_71B2
		dc.w DLE_SYZ3boss-off_71B2
		dc.w DLE_SYZ3end-off_71B2
; ===========================================================================

DLE_SYZ3main:
		cmpi.w	#$2AC0,(v_screenposx).w
		bcs.s	locret_71CE
		;bsr.w	FindFreeObj
		;bne.s	locret_71CE
		;move.b	#id_BossBlock,(a1) ; load blocks that boss picks up
		addq.b	#2,(v_dle_routine).w

locret_71CE:
		rts	
; ===========================================================================

DLE_SYZ3boss:
		cmpi.w	#$2C00,(v_screenposx).w
		bcs.s	locret_7200
		move.w	#$4CC,(v_limitbtm1).w
		bsr.w	FindFreeObj
		bne.s	loc_71EC
		move.b	#id_BossSpringYard,(a1) ; load SYZ boss	object
		move.w	#$2E60,obX(a1)
		move.w	#$4F0,obY(a1)

loc_71EC:
		addq.b	#2,(v_dle_routine).w	; => "DLE_SYZ3end"
		music	mus_Boss	; play boss music
		move.b	#1,(f_lockscreen).w ; lock screen
		moveq	#plcid_Boss,d0
		jmp		AddPLC		; load boss patterns
; ===========================================================================

locret_7200:
		rts	
; ===========================================================================

DLE_SYZ3end:
		move.w	(v_screenposx).w,(v_limitleft2).w
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Scrap	Brain Zone dynamic level events
; ---------------------------------------------------------------------------

DLE_SBZ:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_SBZx(pc,d0.w),d0
		jmp	DLE_SBZx(pc,d0.w)
; ===========================================================================
DLE_SBZx:	dc.w DLE_SBZ1-DLE_SBZx
		dc.w DLE_SBZ2-DLE_SBZx
		dc.w DLE_FZ-DLE_SBZx
; ===========================================================================

DLE_SBZ1:
		rts	
; ===========================================================================

DLE_SBZ2:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	off_7252(pc,d0.w),d0
		jmp	off_7252(pc,d0.w)
; ===========================================================================
off_7252:	dc.w DLE_SBZ2main-off_7252
		dc.w DLE_SBZ2boss-off_7252
		dc.w DLE_SBZ2boss2-off_7252
		dc.w DLE_SBZ2end-off_7252
; ===========================================================================

DLE_SBZ2main:
		move.w	#$800,(v_limitbtm1).w
		cmpi.w	#$1800,(v_screenposx).w
		bcs.s	locret_727A
		move.w	#$510,(v_limitbtm1).w
		cmpi.w	#$1E00,(v_screenposx).w
		bcs.s	locret_727A
		addq.b	#2,(v_dle_routine).w

locret_727A:
		rts	
; ===========================================================================

DLE_SBZ2boss:
		cmpi.w	#$1EB0,(v_screenposx).w
		bcs.s	locret_7298
		bsr.w	FindFreeObj
		bne.s	locret_7298
		move.b	#id_FalseFloor,(a1) ; load collapsing block object
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_EggmanSBZ2,d0
		jmp		AddPLC		; load SBZ2 Eggman patterns
; ===========================================================================

locret_7298:
		rts	
; ===========================================================================

DLE_SBZ2boss2:
		cmpi.w	#$1F60,(v_screenposx).w
		bcs.s	loc_72B6
		bsr.w	FindFreeObj
		bne.s	loc_72B0
		move.b	#id_ScrapEggman,(a1) ; load SBZ2 Eggman object
		addq.b	#2,(v_dle_routine).w

loc_72B0:
		move.b	#1,(f_lockscreen).w ; lock screen

loc_72B6:
		bra.s	LockLeft
; ===========================================================================

DLE_SBZ2end:
		cmpi.w	#$2050,(v_screenposx).w
		bcs.s	LockLeft
		rts	
; ===========================================================================

LockLeft:
		move.w	(v_screenposx).w,(v_limitleft2).w
		rts	
; ===========================================================================

DLE_FZ:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	off_72D8(pc,d0.w),d0
		jmp	off_72D8(pc,d0.w)
; ===========================================================================
off_72D8:	dc.w DLE_FZmain-off_72D8
		dc.w DLE_FZboss-off_72D8
		dc.w LockLeft-off_72D8
		dc.w DLE_FZend-off_72D8
		dc.w DLE_FZend2-off_72D8
; ===========================================================================

DLE_FZmain:
		cmpi.w	#$2200,(v_screenposx).w
		bcs	LockLeft
		addq.b	#2,(v_dle_routine).w
		move.w	#$580,(v_limitbtm1).w
		moveq	#plcid_FZBoss,d0
		jsr 	AddPLC		; load FZ boss patterns
		bra.s	LockLeft
; ===========================================================================

DLE_FZboss:
		cmpi.w	#$23E0,(v_screenposx).w
		bcs	LockLeft
		addq.b	#2,(v_dle_routine).w
		move.b	#1,(f_lockscreen).w ; lock screen
		move.w	#$23E0,(v_limitright2).w

		move.l	#execute_ObjPlasmaBoss, -(sp)
		pea	v_lvlobjspace.w
		jsr	createCppObject__cdecl
		addq.w	#8, sp
		bra.s	LockLeft
; ===========================================================================

DLE_FZend:
		sf.b	(f_lockscreen).w			; unlock right boundary
		addq.b	#2,(v_dle_routine).w
		move.w	#0,(v_limittop2).w
		move.w	#$2600+$130,(v_limitright2).w		; setup right boundary

		moveq	#plcid_Signpost,d0
		jsr	NewPLC					; load signpost	patterns
		bra	LockLeft
; ===========================================================================
DLE_FZend2:
		cmp.w	#$2600+$130, (v_screenposx).w
		blo.s	@End
		move.w	#$4A0, (v_limitbtm1).w
@End:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Ending sequence dynamic level events (empty)
; ---------------------------------------------------------------------------

DLE_Ending:
		rts

LeftSpawnPos: 	equ $01F0
RightSpawnPos:	equ $0440

; ---------------------------------------------------------------------------
; Zone 7 dynamic level events
; ---------------------------------------------------------------------------
DLE_Z7:
		moveq	#0, d0
		move.b	(v_dle_routine).w, d0
		move.w	@Index(pc,d0.w), d0
		jmp		@Index(pc,d0.w)

@Index:
		dc.w DLE_Z7_Init-@Index
		dc.w DLE_Z7_Main-@Index
		dc.w DLE_Z7_Horde-@Index
		dc.w DLE_Z7_End-@Index

; ===========================================================================

DLE_Z7_Init:
		move.b	#1, (v_dashdisabled).w	; disable spindash >:)
		move.w	#$124,(v_limitbtm1).w 	; set lower y-boundary
		move.b  #50, (v_hordecount).w 	; KILL THEM
		addq.b 	#2, (v_dle_routine).w
		rts
; ===========================================================================

DLE_Z7_Main:
		tst.b 	(f_lockscreen).w	; is screen locked?
		bne.w 	@Return				; if yes, branch

		cmpi.w	#$1E5, (v_screenposx).w ; has the camera reached $1E5 on x-axis?
		bcs.w	@Return	; if not, branch
		
		sfx		sfx_BigRing
		music	mus_zone7

		move.b	#1, (f_lockscreen).w ; lock screen
		jsr		PaletteWhiteIn

		move.b 	#$50, (v_spawntimer).w
		move.w	#$300,(v_limitright2).w
		addq.b 	#2, (v_dle_routine).w
		rts

@Return:
		rts
; ===========================================================================

DLE_Z7_Horde:
		tst.b 	(v_hordecount).w
		beq.w 	@GoodJob

		sub.b 	#1, (v_spawntimer).w
		
		tst.b 	(v_spawntimer).w
		bne.w 	@Return

@ResetTimer:
		move.b  #$3A, (v_spawntimer).w
		not.b 	(v_spawndirection).w
		move.b 	(v_spawndirection).w, d0

		move.w 	#LeftSpawnPos, d1
		tst.b 	(v_spawndirection).w
		beq.s 	@Spawn
		move.w 	#RightSpawnPos, d1

@Spawn:
		Instance.new Mogeko, a1
		move.w 	d1, obX(a1)
		move.w 	#$01EC, obY(a1)

@Return:
		rts

@GoodJob:
		command	mus_stop
		jsr 	PaletteFadeOut
		addq.b 	#2, (v_dle_routine).w
		rts
; ===========================================================================

DLE_Z7_End:
		move.b 	#id_Title, (v_gamemode).w

		sfx		sfx_enterss
		jsr 	PaletteWhiteOut
		
		move.b 	#1, (v_secretprog).w
		move.b 	#0, (v_zone).w
		jsr		SaveSRAM

		rts