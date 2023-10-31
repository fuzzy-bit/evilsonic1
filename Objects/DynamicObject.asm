; ---------------------------------------------------------------------------
; Object with a dynamic code pointer
; ---------------------------------------------------------------------------

DynamicObject:

	assert.l obCodePtr(a0), ne		; code pointer shouldn't be NULL
	assert.l obCodePtr(a0), lo, #EndOfRom	; make sure it's within ROM section

	movea.l	obCodePtr(a0), a1
	jmp	(a1)
