DoChecksum:
		move.l	RomEndLoc.w,a6			; load ROM end address to a6
		sub.w	#56-1,a6			; this will trip the detection before ROM ends (in case it would happen mid-transfer)
		move.l	v_csum_addr.w,a5		; load the check address to a5

		cmp.l	a5,a6				; check if checksum is done
		blo.w	ChecksumEndChk			; if yes, skip this
		move.w	v_csum_value.w,d0		; copy the last checksum value to d0
		move.w	#(127840/268)-(40000/268)-1,d1	; load a fairly safe estimate for the maximum number of loops per frame. If you get lag, just increase the 40000 to a higher number (check will take longer!)

	@loop:						; 268 cycles per loop
		movem.l	(a5)+,d2-a4			; laod 44 ($2C) bytes from ROM
		add.w	d2,d0				; add low words to d0
		swap	d2				; swap to high word
		add.w	d2,d0				; add high words to d0

		add.w	d3,d0
		swap	d3
		add.w	d3,d0

		add.w	d4,d0
		swap	d4
		add.w	d4,d0

		add.w	d5,d0
		swap	d5
		add.w	d5,d0

		add.w	d6,d0
		swap	d6
		add.w	d6,d0

		add.w	d7,d0
		swap	d7
		add.w	d7,d0

		move.l	a0,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a1,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a2,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a3,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		move.l	a4,d2
		add.w	d2,d0
		swap	d2
		add.w	d2,d0

		cmp.l	a5,a6				; check if we have passed the address
		dblo	d1,@loop			; if not, go back to loop, but only if we havent looped too many times

		move.l	a5,v_csum_addr.w		; save the check address from a5
		move.w	d0,v_csum_value.w		; save as the new checksum value

		cmp.l	a5,a6				; check if we have passed the address (again)
		bhi.s	ChecksumEndChk			; if not, exit
		move.l	RomEndLoc.w,a6			; load ROM end address to a6

	@end:
		add.w	(a5)+,d0			; add remaining words to d0
		cmp.l	a5,a6				; check if we have passed the final address
		bhi.s	@end				; if not, go back to loop

		cmp.w	Checksum.w,d0			; check if the checksum matches
		beq.s	ChecksumEndChk			; if yes, we are golden
		jmp	CheckSumError(pc)		; we have a checksum error

ChecksumEndChk:
        rts