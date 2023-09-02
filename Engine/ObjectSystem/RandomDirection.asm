; ---------------------------------------------------------------------------
; Random Direction - Stolen from Selbi
; ---------------------------------------------------------------------------
RandomDirection:
		jsr		RandomNumber
		andi.l	#$01FF01FF,d0
		subi.w	#$FF,d0
		move.w	d0,obVelX(a0)
		swap	d0
		subi.w	#$FF,d0
		move.w	d0,obVelY(a0)
		rts

RandomDirectionA1:
		jsr		RandomNumber
		andi.l	#$01FF01FF,d0
		subi.w	#$FF,d0
		move.w	d0,obVelX(a1)
		swap	d0
		subi.w	#$FF,d0
		move.w	d0,obVelY(a1)
		rts
