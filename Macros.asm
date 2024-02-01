; ---------------------------------------------------------------------------
; Align and pad
; ---------------------------------------------------------------------------

align:		macro
		cnop 0,\1
		endm

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is ($C00004).l)
; ---------------------------------------------------------------------------

locVRAM:	macro	offset,operand
	if (narg=1)
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),VDP_Ctrl
	else
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),\operand
	endc
	endm

; ---------------------------------------------------------------------------
; VRAM request const
; ---------------------------------------------------------------------------

dcvram	macro	offset
	dc.l	($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14))
	endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the VRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeVRAM:	macro
		lea	(vdp_control_port).l,a5
		move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
		move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
		move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$4000+(\3&$3FFF),(a5)
		move.w	#$80+((\3&$C000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the CRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeCRAM:	macro
		lea	(vdp_control_port).l,a5
		move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
		move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
		move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$C000+(\3&$3FFF),(a5)
		move.w	#$80+((\3&$C000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA fill VRAM with a value
; input: value, length, destination
; ---------------------------------------------------------------------------

fillVRAM:	macro value,length,loc
		lea	(vdp_control_port).l,a5
		move.w	#$8F01,(a5)
		move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
		move.w	#$9780,(a5)
		move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
		move.w	#value,(vdp_data_port).l
		endm

; ---------------------------------------------------------------------------
; Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
; input: source, destination, width [cells], height [cells]
; ---------------------------------------------------------------------------

copyTilemap:	macro source,loc,width,height
		lea	(source).l,a1
		move.l	#$40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14),d0
		moveq	#width,d1
		moveq	#height,d2
		jsr		TilemapToVRAM
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80:	macro
		move.w	#$100,(z80_reset).l
		endm

resetZ80a:	macro
		move.w	#0,(z80_reset).l
		endm

; ---------------------------------------------------------------------------
; Macro to start Z80
; ---------------------------------------------------------------------------
startZ80:	macro
		move.w	#0,(z80_bus_request).l
		endm


; ---------------------------------------------------------------------------
; Macro to stop Z80
; ---------------------------------------------------------------------------
stopZ80 macro
		move.w	#$100,(z80_bus_request).l
		nop
		nop
		nop

@wait\@:btst	#0,(z80_bus_request).l
		bne.s	@wait\@
		endm


; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints:	macro
		move	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints:	macro
		move	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; long conditional jumps
; ---------------------------------------------------------------------------

jhi:		macro loc
		bls.s	@nojump
		jmp	loc
	@nojump:
		endm

jcc:		macro loc
		bcs.s	@nojump
		jmp	loc
	@nojump:
		endm

jhs:		macro loc
		jcc	loc
		endm

jls:		macro loc
		bhi.s	@nojump
		jmp	loc
	@nojump:
		endm

jcs:		macro loc
		bcc.s	@nojump
		jmp	loc
	@nojump:
		endm

jlo:		macro loc
		jcs	loc
		endm

jeq:		macro loc
		bne.s	@nojump
		jmp	loc
	@nojump:
		endm

jne:		macro loc
		beq.s	@nojump
		jmp	loc
	@nojump:
		endm

jgt:		macro loc
		ble.s	@nojump
		jmp	loc
	@nojump:
		endm

jge:		macro loc
		blt.s	@nojump
		jmp	loc
	@nojump:
		endm

jle:		macro loc
		bgt.s	@nojump
		jmp	loc
	@nojump:
		endm

jlt:		macro loc
		bge.s	@nojump
		jmp	loc
	@nojump:
		endm

jpl:		macro loc
		bmi.s	@nojump
		jmp	loc
	@nojump:
		endm

jmi:		macro loc
		bpl.s	@nojump
		jmp	loc
	@nojump:
		endm

; ---------------------------------------------------------------------------
; check if object moves out of range
; input: location to jump to if out of range, x-axis pos (obX(a0) by default)
; ---------------------------------------------------------------------------

out_of_range:	macro exit,pos
		if (narg=2)
		move.w	pos,d0		; get object position (if specified as not obX)
		else
		move.w	obX(a0),d0	; get object position
		endc
		andi.w	#$FF80,d0	; round down to nearest $80
		move.w	(v_screenposx).w,d1 ; get screen position
		subi.w	#128,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0		; approx distance between object and screen
		cmpi.w	#128+320+192,d0
		bhi.\0	exit
		endm

; ---------------------------------------------------------------------------
; VEPS macros
; ---------------------------------------------------------------------------

; Macro for playing a command
command		macro id
	move.b #id, d0
	jsr		VEPS_PlaySound
    endm

; Macro for playing music
music		macro id
	move.b 	#id, d0
	jsr		VEPS_PlaySound
    endm

; Macro for playing sound effect
sfx		macro id
	move.b 	#id, d0
	jsr		VEPS_PlaySound
    endm

; ---------------------------------------------------------------------------
; bankswitch between SRAM and ROM
; (remember to enable SRAM in the header first!)
; ---------------------------------------------------------------------------

EnableSRAM:		macro
	move.b  #1,($A130F1).l
	endm

DisableSRAM:	macro
	move.b  #0,($A130F1).l
	endm

; ---------------------------------------------------------------------------
; compare the size of an index with ZoneCount constant
; (should be used immediately after the index)
; input: index address, element size
; ---------------------------------------------------------------------------

zonewarning:	macro loc,elementsize
	@end:
		if (@end-loc)-(ZoneCount*elementsize)<>0
		inform 1,"Size of \loc ($%h) does not match ZoneCount ($\#ZoneCount).",(@end-loc)/elementsize
		endc
		endm

; ---------------------------------------------------------------------------
; Macro to create a new object
; - fuzzy
; ---------------------------------------------------------------------------
Instance:	macro id, register
;Label	substr	instr('\0', '(') + 1, instr('\0', ')') - 1,'\0'
;\Label\

	if strcmp('\0','new')
		jsr	(FindFreeObj).l
		move.b	#id_\id, 0(\register)	; load object
	endif
	endm

; ---------------------------------------------------------------------------
; Macro to initialize a sprite
; - fuzzy
; ---------------------------------------------------------------------------
Sprite:	macro X, Y, Size, StartTile
	if strcmp('\0','new')
	    move.l    #$78000003, vdp_control_port
		move.w    \Y, vdp_data_port        ;Y position
		move.w    \Size, vdp_data_port        ;sprite size 0 (8x8px) and sprite link 0 (0 ends the sprite list)
		move.w    \StartTile, vdp_data_port        ;Sprite starting tile (same as a tile)
		move.w    \X, vdp_data_port        ;X position
	endif
	endm

; ---------------------------------------------------------------------------
; Macro to clear RAM for gamemode init
; - fuzzy
; ---------------------------------------------------------------------------
ClearRAM: macro
		lea		v_objspace, a0
		moveq	#0, d1
		move.l	#$7FF, d1
	@ClearObjects:
		move.l	d0, (a0)+
		dbf		d1, @ClearObjects

		lea		($FFFFF628).w, a1
		moveq	#0, d0
		move.w	#$15, d1
	@ClearVariables:
		move.l	d0, (a1)+
		dbf		d1, @ClearVariables

		lea		(v_screenposx).w, a1
		moveq	#0, d0
		move.w	#$3F, d1
	@ClearVariables2:
		move.l	d0, (a1)+
		dbf		d1, @ClearVariables2

		lea	(v_oscillate+2).w, a1
		moveq	#0, d0
		move.w	#$47, d1
	@ClearVariables3:
		move.l	d0, (a1)+
		dbf		d1, @ClearVariables3
	endm

; ---------------------------------------------------------------------------
; Optimized st/sf
; - fuzzy
; ---------------------------------------------------------------------------
sto: 	macro destination
		move.b 	#$FF, \destination
		endm
		
sfo: 	macro destination
		moveq 	#0, \destination
		endm

; ---------------------------------------------------------------------------
; Absoulte value
; - fuzzy
; ---------------------------------------------------------------------------
abs: macro source
		tst.\0 \source
		bpl.s  @positive\@
		neg.\0 \source
		@positive\@:
		endm