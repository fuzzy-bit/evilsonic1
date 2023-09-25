; ---------------------------------------------------------------------------
; Subroutine to	make an	object fall downwards, increasingly fast
; ---------------------------------------------------------------------------

ObjectFall:
		movem.w	obVelX(a0),d2-d3
		asl.l	#8, d2
		add.l	d2, obX(a0)
		asl.l	#8, d3
		add.l	d3, obY(a0)
		addi.w	#$38,obVelY(a0)	; increase vertical speed
		rts

; for screen-space objects =P
ScreenObjectFall:
		move.l	obX(a0),d2
		move.l	obScreenY(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	obVelY(a0),d0
		addi.w	#$38,obVelY(a0)	; increase vertical speed
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,obX(a0)
		move.l	d3,obScreenY(a0)
		rts	