; ===========================================================================
; Subroutine - FindOtherObject
; ---------------------------------------------------------------------------
; Description:
; 		Chases the specified object
; 
; Parameters:
; 		a0: Calling object
;		a1: Target object
;
; Returns:
;		d0: Target object is left (0) or right (2) of calling object
;		d1: Target object is above (0) or below (2) calling object
; ===========================================================================
FindOtherObject:
		moveq	#0,d0			; d0 = 0 if other object is left of calling object, 2 if right of it
		moveq	#0,d1			; d1 = 0 if other object is above calling object, 2 if below it
		move.w	obX(a0),d2
		sub.w	obX(a1),d2
		bpl.s	FindOtherObjectYCheck
		neg.w	d2
		addq.w	#2,d0

FindOtherObjectYCheck:
		moveq	#0,d1
		move.w	obY(a0),d3
		sub.w	obY(a1),d3
		bpl.s	FindOtherObject_rts
		neg.w	d3
		addq.w	#2,d1

FindOtherObject_rts:
		rts