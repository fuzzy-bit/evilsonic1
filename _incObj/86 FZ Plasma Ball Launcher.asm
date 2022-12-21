; ---------------------------------------------------------------------------
; Object 86 - energy balls (FZ)
; ---------------------------------------------------------------------------

BossPlasma:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	@Index(pc,d0.w),d0
		jmp	@Index(pc,d0.w)
; ===========================================================================
@Index:	dc.w @Main-@Index
		dc.w @Generator-@Index
		dc.w @MakeBalls-@Index
		dc.w @BeforeMovement-@Index
		dc.w @Movement-@Index
		
		@DropXVelocity:		equ $30
		@SpreadTimer:		equ $32
		@FinishedMoving:	equ $34
		@DropTimer:		equ $38
; ===========================================================================

@Main:	; Routine 0
		move.w	#$2588,obX(a0)
		move.w	#$53C,obY(a0)
		move.w	#$300,obGfx(a0)
		move.l	#Map_PLaunch,obMap(a0)
		move.b	#0,obAnim(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obWidth(a0)
		move.b	#8,obHeight(a0)
		move.b	#4,obRender(a0)
		bset	#7,obRender(a0)
		addq.b	#2,obRoutine(a0)
		
@Generator: 	; Routine 2
		movea.l	@FinishedMoving(a0),a1
		cmpi.b	#6,@FinishedMoving(a1)
		bne.s	@AnimateGenerator
		move.b	#id_ExplosionBomb,(a0)
		move.b	#0,obRoutine(a0)
		jmp	(DisplaySprite).l
; ===========================================================================

@AnimateGenerator:
		move.b	#0,obAnim(a0)
		tst.b	$29(a0)
		beq.s	@GeneratorHitbox
		addq.b	#2,obRoutine(a0)
		move.b	#1,obAnim(a0)
		move.b	#$3E,obSubtype(a0)

@GeneratorHitbox:
		move.w	#$13,d1		; width
		move.w	#8,d2		; height when jumping
		move.w	#$11,d3		; height when walking
		move.w	obX(a0),d4	; x position
		jsr	(SolidObject).l
		
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bmi.s	@DisplayGenerator
		subi.w	#$140,d0
		bmi.s	@DisplayGenerator
		
		tst.b	obRender(a0)	; is object within camera view?
		bpl.w	DeletePlasmaBalls	; if not, delete object

@DisplayGenerator:
		lea	Ani_PLaunch(pc),a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
; ===========================================================================

@MakeBalls:; Routine 4
		tst.b	$29(a0)
		beq.w	@NoFreeObject
		
		clr.b	$29(a0)
		add.w	@DropXVelocity(a0),d0
		andi.w	#$1E,d0
		adda.w	d0,a2
		addq.w	#4,@DropXVelocity(a0)
		clr.w	@SpreadTimer(a0)
		moveq	#3,d2

@Loop:
		jsr	(FindNextFreeObj).l
		bne.w	@NoFreeObject
		
		move.b	#id_BossPlasma,(a1)
		move.w	obX(a0),obX(a1)
		move.w	#$53C,obY(a1)
		move.b	#8,obRoutine(a1)
		move.w	#$2300,obGfx(a1)
		move.l	#Map_Plasma,obMap(a1)
		move.b	#$C,obHeight(a1)
		move.b	#$C,obWidth(a1)
		move.b	#0,obColType(a1)
		move.b	#3,obPriority(a1)
		move.w	#$3E,obSubtype(a1)
		move.b	#4,obRender(a1)
		bset	#7,obRender(a1)
		move.l	a0,@FinishedMoving(a1)
		jsr	(RandomNumber).l
		move.w	@SpreadTimer(a0),d1
		muls.w	#-$4F,d1
		addi.w	#$2578,d1
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d1,d0
		move.w	d0,@DropXVelocity(a1)
		
		; for the amount of time spread out, do the same for the Movement
		addq.w	#1,@SpreadTimer(a0)
		move.w	@SpreadTimer(a0),@DropTimer(a0) 
		
		dbf	d2,@Loop	; repeat sequence 3 more times

@NoFreeObject:
		tst.w	@SpreadTimer(a0)
		bne.s	@HandleGenerator
		addq.b	#2,obRoutine(a0)

@HandleGenerator:
		bra.w	@GeneratorHitbox
; ===========================================================================

@BeforeMovement:	; Routine 6
		move.b	#2,obAnim(a0)
		tst.w	@DropTimer(a0)
		bne.s	@HandleGenerator2
		move.b	#2,obRoutine(a0)
		movea.l	@FinishedMoving(a0),a1
		move.w	#-1,@SpreadTimer(a1)

@HandleGenerator2:
		bra.w	@GeneratorHitbox
; ===========================================================================

@Movement:	; Routine 8
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	@Index2(pc,d0.w),d0
		jsr	@Index2(pc,d0.w)
		lea	Ani_Plasma(pc),a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
; ===========================================================================
@Index2:	dc.w @ApplyMovement-@Index2
		dc.w @Pause-@Index2
		dc.w @ApplySpeed-@Index2
; ===========================================================================

@ApplyMovement:
		move.w	@DropXVelocity(a0),d0
		sub.w	obX(a0),d0
		asl.w	#4,d0
		move.w	d0,obVelX(a0)
		move.w	#$B4,obSubtype(a0)
		addq.b	#2,ob2ndRout(a0)
		rts	
; ===========================================================================

@Pause:
		tst.w	obVelX(a0)
		beq.s	@Drop
		jsr	(SpeedToPos).l
		move.w	obX(a0),d0
		sub.w	@DropXVelocity(a0),d0
		bcc.s	@Drop
		clr.w	obVelX(a0)
		add.w	d0,obX(a0)
		movea.l	@FinishedMoving(a0),a1
		subq.w	#1,@SpreadTimer(a1)

@Drop:
		move.b	#0,obAnim(a0)
		subq.w	#1,obSubtype(a0)
		bne.s	@DropReturn
		addq.b	#2,ob2ndRout(a0)
		move.b	#1,obAnim(a0)
		move.b	#$9A,obColType(a0)
		move.w	#$B4,obSubtype(a0)
		moveq	#0,d0
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		move.w	d0,obVelX(a0)
		move.w	#$140,obVelY(a0)

@DropReturn:
		rts	
; ===========================================================================

@ApplySpeed:
		jsr	(SpeedToPos).l
		cmpi.w	#$5E0,obY(a0)
		bcc.s	@Delete
		subq.w	#1,obSubtype(a0)
		beq.s	@Delete
		rts	
; ===========================================================================

@Delete:
		movea.l	@FinishedMoving(a0),a1
		subq.w	#1,@DropTimer(a1)
		bra.w	DeletePlasmaBalls