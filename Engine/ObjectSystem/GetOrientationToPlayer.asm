; ===========================================================================
; ---------------------------------------------------------------------------
; Get Orientation To Player
; Returns the horizontal and vertical distances of the closest player object.
;
; input variables:
;  a0 = object
;
; returns:
;  a1 = address of closest player character
;  d0 = 0 if player is left from object, 2 if right
;  d1 = 0 if player is above object, 2 if below
;  d2 = closest character's horizontal distance to object
;  d3 = closest character's vertical distance to object
;
; writes:
;  d0, d1, d2, d3
;  a1
; ---------------------------------------------------------------------------
GetOrientationToPlayer:
		moveq	#0,d0
		moveq	#0,d1
		lea		(v_player).w,a1 ; a1=character
		move.w	obX(a0),d2
		sub.w	obX(a1),d2
		tst.w	d2
		bpl.s	@left	; branch, if enemy is on left to player
		addq.w	#2,d0
	@left:
		move.w	obY(a0),d3
		sub.w	obY(a1),d3	; vertical distance to closest character
		bhs.s	@below	; branch, if enemy is under player
		addq.w	#2,d1
	@below:
		rts