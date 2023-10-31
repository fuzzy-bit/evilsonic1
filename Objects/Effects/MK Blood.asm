; ---------------------------------------------------------------------------
; Mortal Kombat Blood
; ---------------------------------------------------------------------------

; Custom object variables:
ActiveParticles:	= $30						; a number of on-screen particles so far
GeneratorObject:	= $34						; links parent generator object

MKBlood:
        move.w  obRoutine(a0), d0
        move.w  @Index(pc,d0.w), d0
        jmp     @Index(pc,d0.w)

; ---------------------------------------------------------------------------
@Index:
		dc.w	MKBlood_Generate-@Index					; $0000
		dc.w	MKBlood_UpdateGlobal-@Index				; $0002
		dc.w	MKBlood_ParticleMoveUp-@Index			; $0004
        dc.w	MKBlood_ParticleMoveDown-@Index			; $0006

; ---------------------------------------------------------------------------
MKBlood_ParticleData:
		dc.w $0100, $F800
		dc.w $FF00, $F800
		dc.w $0140, $F880 
		dc.w $FEC0, $F880 
		dc.w $0180, $F900 
		dc.w $FE80, $F900 
		dc.w $01C0, $F980
		dc.w $FE40, $F980 
		dc.w $00C0, $FA00
		dc.w $FF40, $FA00
		dc.w $0120, $FB00
		dc.w $FEE0, $FB00

; ---------------------------------------------------------------------------
MKBlood_Generate:
		lea     MKBlood_ParticleData(pc), a2	; load lookup table
        moveq	#12-1, d5						; number of values to be read
		moveq	#0, d6							; will count active particles

@Loop:
		jsr		FindNextFreeObj					; a1 = object
		bne.s	@Done
		move.b  #id_MKBlood, (a1)
		addq.w	#1, d6							; account for this particle
		move.b	#4, obRender(a1)				; object is placed on playfield
		move.w  #$8580, obGfx(a1)				; VRAM art data		
		move.l  #Map_Blood, obMap(a1)			; the mappings
		move.w  obX(a0), obX(a1)				; xpos of item
		move.w  obY(a0), obY(a1)				; ypos of item
		move.w	a0, GeneratorObject(a1)			; link parent obj
		move.w	#4, obRoutine(a1)				; => "MKBlood_ParticleMoveUp"
		move.l  (a2)+, obVelX(a1)				; get all speed data
		bpl.s   @Next							; if speed is positive, branch   
		bset    #0, obRender(a1)				; else, flip X orientation
@Next:
		dbf		d5, @Loop						; repeat for the number of particles

@Done:
        move.b	d6, ActiveParticles(a0)			; remember number of active particles
        addq.w	#2, obRoutine(a0)				; => "MKBlood_UpdateGlobal"
        move.b	#1, obAnim(a0)
        st.b	obDPLCFrame(a0)					; set last frame for DPLC to $FF to force redraw
        ; fallthrough

; ---------------------------------------------------------------------------
MKBlood_UpdateGlobal:
		tst.b	ActiveParticles(a0)				; do we have particles on screen?
		beq.s	MKBlood_Delete					; if not, branch

        lea     (Anim_MKBlood).l, a1
        jsr     AnimateSprite					; update global animation frame
		lea		@DPLCConfig(pc), a6
		jmp		UpdateDPLC						; update global dplcs

; ---------------------------------------------------------------------------
@DPLCConfig:
		dc.l	PLC_MKBlood	; DPLC pointer
		dc.l	Art_MKBlood	; Art pointer
		dc.w	$B000		; VRAM address

; ---------------------------------------------------------------------------
MKBlood_ParticleMoveUp:
		tst.w	obVelY(a0)						; moving up?
		bmi.s	MKBlood_ParticleMove			; if yes, branch
		addq.w	#2, obRoutine(a0)				; => "MKBlood_ParticleMoveDown
		; fallthrough

; ---------------------------------------------------------------------------
MKBlood_ParticleMoveDown:
		tst.b	obRender(a0)					; is object on screen?
		bpl.s	MKBlood_DeleteParticle			; if not, branch

MKBlood_ParticleMove:
       	jsr     ObjectFall
		movea.w	GeneratorObject(a0), a1			; get parent generator object
		move.b	obFrame(a1), obFrame(a0)		; inherit global frame from the parent
       	jmp		DisplaySprite

; ---------------------------------------------------------------------------
MKBlood_DeleteParticle:
		movea.w	GeneratorObject(a0), a1			; get parent generator object
		subq.b	#1, ActiveParticles(a1)		; tell that this particle is dead =(
		; fallthrough

MKBlood_Delete:
		jmp		DeleteObject

; ---------------------------------------------------------------------------
		include	"Data\Mappings\Objects\Blood\MortalKombat.asm"
		even

		include	"Data\Animations\Blood\MortalKombat.asm"
		even

Art_MKBlood:		
		incbin "Data\Art\Uncompressed\Blood\MortalKombat.bin"
		even
		include "Data\DPLCs\Blood\MortalKombat.asm"

; ---------------------------------------------------------------------------
; Subroutine to create the blood object and handle it
; ---------------------------------------------------------------------------

CreateMKBlood:
		jsr     FindFreeObj						; gee i wonder what this does
        bne.s   @Return							; oh noes the object didn't load so sad :(

		move.b  #id_MKBlood, (a1)				; load object into a1
        move.w  obX(a0), obX(a1)				; xpos of item
        move.w  obY(a0), obY(a1)				; ypos of item

@Return:
        rts
