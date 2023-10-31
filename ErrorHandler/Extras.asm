
RaiseError__cdecl:
	move	#$2700, sr						; disable interrupts for good
	jsr		__global__ErrorHandler_SetupVDP
	lea		($FF0000).l, a3					; use $FF0000 for Console RAM (TODO: extract "Console_RAM.size", allocate on stack)
	jsr		__global__Error_InitConsole
	moveq	#0, d1
	jsr		__global__Console_SetBasePattern

	movea.l	4(sp), a1						; argument #0: error text
	lea		8(sp), a2						; arguments #1, #2, ... : arguments buffer
	jsr		__global__Console_WriteLine_Formatted

	@idle:
		nop
		bra.s	@idle

; -----------------------------------------------------------------------------

KWrite_cdecl:
	move.l	a2, -(sp)
	move.l	d7, -(sp)
	movea.l	8+4(sp), a1						; argument #0: error text
	lea		8+8(sp), a2						; arguments #1, #2, ... : arguments buffer
	jsr		__global__KDebug_Write_Formatted
	move.l	(sp)+, d7
	move.l	(sp)+, a2
	rts
