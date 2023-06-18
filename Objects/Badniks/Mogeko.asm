; ---------------------------------------------------------------------------
; Mogege - Mogehaha (??)
; ---------------------------------------------------------------------------
Mogeko:
		moveq	#0, d0
		move.b	obRoutine(a0), d0
		move.w	@Index(pc,d0.w), d1
		jsr	    @Index(pc, d1.w)

		lea	    (Ani_Mogeko).l,a1
        jsr     AnimateSprite
		jmp		DisplaySprite

; ===========================================================================
@Index: dc.w @Init-@Index
        dc.w @Move-@Index
; ===========================================================================

@Init:	; Routine 0
        move.l	#Map_Mogeko, obMap(a0)
		move.w	#$6000/$20, obGfx(a0)
		move.b	#4, obRender(a0)
		move.b	#4, obPriority(a0)
		move.b	#8, obColType(a0)
        move.b  #$14, obWidth(a0)
        move.b  #$14, obHeight(a0)
		move.b	#$14, obActWid(a0)
		move.b	#1, obFrame(a0)

        ; HELP HOUW DOES ANIMATION DELAY WORK
		move.b	#5, obDelayAni(a0)      ; Prosciutto Love Affair
		addq.b	#2, obRoutine(a0)       ; ~Vows on the Sunset Hill~ 
                                        
@Move:
        lea     (v_player).w, a1
        move.w  #$320, d0
        move.w  #$F0, d1
        jsr     ChaseObject

        move.w  #0, obVelY(a0)
        jsr     SpeedToPos

        jsr	    ObjFloorDist
		add.w	d1, obY(a0)	            ; Match	object's position with the floor

@Return:
        rts                             ; Fun fact: Half of this object was written on a plane