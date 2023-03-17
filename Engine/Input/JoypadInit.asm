; ---------------------------------------------------------------------------
; Subroutine to	initialise joypads
; ---------------------------------------------------------------------------
JoypadInit:
		moveq	#$40,d0
		move.b	d0,($A10009).l	; init port 1 (joypad 1)
		move.b	d0,($A1000B).l	; init port 2 (joypad 2)
		move.b	d0,($A1000D).l	; init port 3 (expansion/extra)
		rts