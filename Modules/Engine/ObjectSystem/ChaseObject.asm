; ===========================================================================
; Subroutine - ChaseObject
; ---------------------------------------------------------------------------
; Description:
; 		Chases the specified object
; 
; Parameters:
; 		a0: Chasing object
;		a1: Target object
;
;		d0: Maximum velocity
;		d1: Acceleration
; ===========================================================================
ChaseObject:
	move.w	d0, d2			; move max velocity to d2
	neg.w	d2			; negate max velocity in d2
	move.w	d1, d3			
	
	move.w	obX(a0), d4		; set a0's X position to d4
	cmp.w	obX(a1), d4		; is a1's X position equal to d4?
	seq	d5			; if X position is equal, set d5 to $FF
	beq.s	ChaseObject_HandleY	; if X position is equal, only handle Y axis
	bcs.s	ChaseObject_HandleX	; if d4 is lower than a1's X position, handle both axes and don't negate acceleration.
	
	neg.w	d1			; negate d1

ChaseObject_HandleX:
	move.w	obVelX(a0), d4		; move target's X velocity to d4
	add.w	d1, d4			; add acceleration to new velocity
	
	cmp.w	d2, d4			; compare negative max velocity with new velocity
	blt.s	ChaseObject_HandleY	; if new velocity is lower than negative max velocity, branch
	
	cmp.w	d0, d4			; compare max velocity with new velocity
	bgt.s	ChaseObject_HandleY	; if new velocity is greater than max velocity, branch
	
	move.w	d4, obVelX(a0)		; now that we know that we're within bounds of the max velocity, set the new X velocity

ChaseObject_HandleY:
	move.w	obY(a0), d4		; move target's Y position
	
	cmp.w	obY(a1), d4		; is a1's Y position equal to a0's X position?
	beq.s	ChaseObject_AxesAreParallel	; if true, handle case when axes are parallel
	bcs.s	ChaseObject_HandleYVelocity	; if false, handle Y velocity
	
	neg.w	d3

ChaseObject_HandleYVelocity:
	move.w	obVelY(a0), d4
	add.w	d3, d4
	cmp.w	d2, d4
	blt.s	ChaseObject_rts
	cmp.w	d0, d4
	bgt.s	ChaseObject_rts
	move.w	d4, obVelY(a0)

ChaseObject_rts:
	rts

; ---------------------------------------------------------------------------
; something idfk
; ---------------------------------------------------------------------------

ChaseObject_AxesAreParallel:
	tst.b	d5			; are both X positions equal?
	beq.s	ChaseObject_rts		; if true, return and don't clear a0's velocity
	
	clr.w	obVelX(a0)
	clr.w	obVelY(a0)
	
	rts