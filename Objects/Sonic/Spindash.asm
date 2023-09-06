; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1AC3E:
Sonic_SpinDash:
	tst.b	f_spindash(a0)
	bne.s	Sonic_UpdateSpindash
	cmpi.b #id_duck,obAnim(a0) 
	bne.s	return_1AC8C
	move.b (v_jpadpress2).w,d0 
	andi.b #$70,d0 
	beq.w	return_1AC8C
	move.b #id_Spindash,obAnim(a0) 
	move.w #$D1,d0 
	jsr	(PlaySound_Special).l
	addq.l	#4,sp
	move.b	#1,f_spindash(a0)
	move.w	#0,spindash_charger(a0)
	cmpi.b #$C,$28(a0) 	; if he's drowning, branch to not make dust
	blo.s	loc_1AC84
	move.b #2,($FFFFD11C).w
loc_1AC84:
	bsr.w	Sonic_LevelBound
	bsr.w	Sonic_AnglePos

return_1AC8C:
	rts
; End of subroutine Sonic_CheckSpindash


; ---------------------------------------------------------------------------
; Subrouting to update an already-charging spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1AC8E:
Sonic_UpdateSpindash:
	move.b	#id_Spindash,obAnim(a0)	
	move.b  (v_jpadhold2).w,d0 
	btst    #1,d0 
	bne.w	Sonic_ChargingSpindash
	

	; unleash the charged spindash and start rolling quickly:
	move.b #$E,$16(a0) 
	move.b #7,$17(a0) 
	move.b	#id_Roll,obAnim(a0)
	addq.w	#5,y_pos(a0)	; add the difference between Sonic's rolling and standing heights
	move.b	#0,f_spindash(a0)
	moveq	#0,d0
	move.b	spindash_charger(a0),d0
	add.w	d0,d0
	move.w	SpindashSpeeds(pc,d0.w),obInertia(a0)
;	tst.b	(Super_Sonic_flag).w
;	beq.s	+
;	move.w	SpindashSpeedsSuper(pc,d0.w),obInertia(a0)
;+
	move.w	obInertia(a0),d0
	subi.w	#$800,d0
	add.w	d0,d0
	andi.w	#$1F00,d0
	neg.w	d0
	addi.w	#$2000,d0
	move.w  d0,($FFFFEED0).w 
	btst    #0,$22(a0) 
	beq.s	loc_1ACF4
	neg.w   $14(a0)
loc_1ACF4:
	bset    #2,$22(a0) 
	move.b #0,($FFFFD11C).w 
	move.w #$BC,d0 
	jsr     (PlaySound_Special).l 
	bra.s	Obj01_Spindash_ResetScr
; ===========================================================================
; word_1AD0C:
SpindashSpeeds:
	dc.w  $800	; 0
	dc.w  $880	; 1
	dc.w  $900	; 2
	dc.w  $980	; 3
	dc.w  $A00	; 4
	dc.w  $A80	; 5
	dc.w  $B00	; 6
	dc.w  $B80	; 7
	dc.w  $C00	; 8
; word_1AD1E:
;SpindashSpeedsSuper:
;	dc.w  $B00	; 0
;	dc.w  $B80	; 1
;	dc.w  $C00	; 2
;	dc.w  $C80	; 3
;	dc.w  $D00	; 4
;	dc.w  $D80	; 5
;	dc.w  $E00	; 6
;	dc.w  $E80	; 7
;	dc.w  $F00	; 8
; ===========================================================================
; loc_1AD30:
Sonic_ChargingSpindash:			; If still charging the dash...
	tst.w	spindash_charger(a0)
	beq.s	loc_1AD48
	move.w	spindash_charger(a0),d0
	lsr.w	#5,d0
	sub.w	d0,spindash_charger(a0)
	bcc.s	loc_1AD48
	move.w	#0,spindash_charger(a0)
loc_1AD48:
	move.b  (v_jpadpress2).w,d0 
	andi.b  #$70,d0 ; 'p' 
	beq.w   Obj01_Spindash_ResetScr
	move.w  #id_Spindash<<8,obAnim(a0) ; reset spin dash animation to the beginning
	move.w  #$D1,d0 ; 'à' 
	jsr	(PlaySound_Special).l
	addi.w	#$200,spindash_charger(a0)
	cmpi.w	#$800,spindash_charger(a0)
	blo.s	Obj01_Spindash_ResetScr
	move.w	#$800,spindash_charger(a0)

; loc_1AD78:
Obj01_Spindash_ResetScr:
	addq.l	#4,sp
	cmpi.w	#(224/2)-16,(v_lookshift).w
	beq.s	@skip
	bhs.s	@sub
	addq.w	#4,(v_lookshift).w
@sub:
    subq.w	#2,(v_lookshift).w

@skip:
	bsr.w	Sonic_LevelBound
	bsr.w	Sonic_AnglePos
	rts
; End of subroutine Sonic_UpdateSpindash