; ---------------------------------------------------------------------------
; Launches a C++ object
; ---------------------------------------------------------------------------

CppObject:
	
	assert.l obCodePtr(a0), ne		; code pointer shouldn't be NULL
	assert.l obCodePtr(a0), lo, #EndOfRom	; make sure it's within ROM section

	movea.l	obCodePtr(a0), a1
	move.w	a0, -(sp)
	move.l	a0, -(sp)
	jsr	(a1)
	addq.w	#4, sp
	move.w	(sp)+, a0
	rts
