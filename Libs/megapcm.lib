
; ==============================================================================
; ------------------------------------------------------------------------------
; Mega PCM 2.0 - DAC Sound Driver
;
; Documentation, examples and source code are available at:
; - https://github.com/vladikcomper/MegaPCM/tree/2.x
;
; (c) 2012-2024, Vladikcomper
; ------------------------------------------------------------------------------

; ==============================================================================
; ------------------------------------------------------------------------------
; Constants
; ------------------------------------------------------------------------------


; ------------------------------------------------------------------------------
; Definitions for sample table
; ------------------------------------------------------------------------------

FLAGS_SFX:		equ	$01		; sample is SFX, normal drums cannot interrupt it
FLAGS_LOOP:		equ	$02		; loop sample indefinitely

TYPE_NONE:		equ	$00
TYPE_PCM:		equ	'P'
TYPE_PCM_TURBO:	equ	'T'
TYPE_DPCM:		equ	'D'

; ------------------------------------------------------------------------------
; Maximum playback rates:
TYPE_PCM_TURBO_MAX_RATE:	equ	32000 ; Hz
TYPE_PCM_MAX_RATE:			equ	25100 ; Hz
TYPE_DPCM_MAX_RATE:			equ	20600 ; Hz

; Internal driver's base rates for pitched playback.
; NOTICE: Actual max rates are slightly lower,
; because the highest pitch is 255/256, not 256/256.
TYPE_PCM_BASE_RATE:			equ	25208 ; Hz
TYPE_DPCM_BASE_RATE:		equ	20691 ; Hz


; ------------------------------------------------------------------------------
; Return error codes for `MegaPCM_LoadSampleTable`
; ------------------------------------------------------------------------------

MPCM_ST_TOO_MANY_SAMPLES:			equ	$01
MPCM_ST_UNKNOWN_SAMPLE_TYPE:		equ	$02

MPCM_ST_PITCH_NOT_SET:				equ	$10

MPCM_ST_WAVE_INVALID_HEADER:		equ	$20
MPCM_ST_WAVE_BAD_AUDIO_FORMAT:		equ	$21
MPCM_ST_WAVE_NOT_MONO:				equ	$22
MPCM_ST_WAVE_NOT_8BIT:				equ	$23
MPCM_ST_WAVE_BAD_SAMPLE_RATE:		equ	$24
MPCM_ST_WAVE_MISSING_DATA_CHUNK:	equ	$25


; ------------------------------------------------------------------------------
; System Ports used by Mega PCM
; ------------------------------------------------------------------------------

MPCM_Z80_RAM:		equ		$A00000
MPCM_Z80_BUSREQ:	equ		$A11100
MPCM_Z80_RESET:		equ		$A11200

MPCM_YM2612_A0:		equ		$A04000
MPCM_YM2612_D0:		equ		$A04001
MPCM_YM2612_A1:		equ		$A04002
MPCM_YM2612_D1:		equ		$A04003

; ------------------------------------------------------------------------------
; Z80 equates
; ------------------------------------------------------------------------------

Z_MPCM_DriverReady:	equ $1fc3
Z_MPCM_CommandInput:	equ $1fc2
Z_MPCM_VolumeInput:	equ $1fc4
Z_MPCM_SFXVolumeInput:	equ $1fc5
Z_MPCM_PanInput:	equ $1fc6
Z_MPCM_SFXPanInput:	equ $1fc7
Z_MPCM_LoopId:	equ $1fdd
Z_MPCM_ActiveSamplePitch:	equ $1fdc
Z_MPCM_VBlankActive:	equ $1fe2
Z_MPCM_CalibrationApplied:	equ $1fe3
Z_MPCM_CalibrationScore_ROM:	equ $1fe4
Z_MPCM_CalibrationScore_RAM:	equ $1fe6
Z_MPCM_LastErrorCode:	equ $1fe8
Z_MPCM_SampleTable:	equ $1976
Z_MPCM_COMMAND_STOP:	equ $1
Z_MPCM_COMMAND_PAUSE:	equ $2
Z_MPCM_LOOP_IDLE:	equ $1
Z_MPCM_LOOP_PAUSE:	equ $2
Z_MPCM_LOOP_PCM:	equ $10
Z_MPCM_LOOP_PCM_TURBO:	equ $18
Z_MPCM_LOOP_DPCM:	equ $20
Z_MPCM_LOOP_CALIBRATION:	equ $80
Z_MPCM_ERROR__BAD_INTERRUPT:	equ $2
Z_MPCM_ERROR__BAD_SAMPLE_TYPE:	equ $1
Z_MPCM_ERROR__UNKNOWN_COMMAND:	equ $80

; ==============================================================================
; ------------------------------------------------------------------------------
; Macros
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; Macro to generate sample record in a sample table
; ------------------------------------------------------------------------------
; ARGUMENTS:
;	type - Sample type (TYPE_PCM, TYPE_DPCM, TYPE_PCM_TURBO or TYPE_NONE)
;	samplePtr - Sample pointer/name (assigned via `incdac` macro)
;	sampleRateHz? - (Optional) Playback rate in Hz, auto-detected for .WAV
;	flags? - (Optional) Additional flags (e.g. FLAGS_SFX or FLAGS_LOOP)
; ------------------------------------------------------------------------------

dcSample: macro	type, samplePtr, sampleRateHz, flags
	if narg>4
		inform 2, "Too many arguments. USAGE: dcSample type, samplePtr, sampleRateHz, flags"
	endif

	dc.b	\type					; $00	- type

	if \type=TYPE_PCM
		if \sampleRateHz+0>TYPE_PCM_MAX_RATE
			inform 2, "Invalid sample rate: \sampleRateHz\. TYPE_PCM only supports sample rates <= \#TYPE_PCM_MAX_RATE Hz"
		endif
		dc.b	\flags+0								; $01	- flags (optional)
		dc.b	(\sampleRateHz+0)*256/TYPE_PCM_BASE_RATE; $02	- pitch (optional for .WAV files)
		dc.b	0										; $03	- <RESERVED>
		dc.l	\samplePtr								; $04	- start offset
		dc.l	\samplePtr\_End							; $08	- end offset

	elseif \type=TYPE_PCM_TURBO
		if (\sampleRateHz+0<>TYPE_PCM_TURBO_MAX_RATE)&(\sampleRateHz+0<>0)
			inform 2, "Invalid sample rate: \sampleRateHz\. TYPE_PCM_TURBO only supports sample rate of \#TYPE_PCM_TURBO_MAX_RATE Hz"
		endif
		dc.b	\flags+0								; $01	- flags (optional)
		dc.b	$FF										; $02	- pitch (optional for .WAV files)
		dc.b	0										; $03	- <RESERVED>
		dc.l	\samplePtr								; $04	- start offset
		dc.l	\samplePtr\_End							; $08	- end offset

	elseif \type=TYPE_DPCM
		if \sampleRateHz>TYPE_DPCM_MAX_RATE
			inform 2, "Invalid sample rate: \sampleRateHz\. TYPE_DPCM only supports sample rates <= \#TYPE_DPCM_MAX_RATE Hz"
		endif
		dc.b	\flags+0								; $01	- flags (optional)
		dc.b	(\sampleRateHz)*256/TYPE_DPCM_BASE_RATE	; $02	- pitch
		dc.b	0										; $03	- <RESERVED>
		dc.l	\samplePtr								; $04	- start offset
		dc.l	\samplePtr\_End							; $08	- end offset

	elseif \type=TYPE_NONE
		dc.b	0, 0, 0
		dc.l	0, 0

	else
		inform 2, "Unknown sample type. Please use one of: TYPE_PCM, TYPE_DPCM, TYPE_PCM_TURBO, TYPE_NONE"
	endif
	endm

; ------------------------------------------------------------------------------
; Macro to include a sample file
; ------------------------------------------------------------------------------
; ARGUMENTS:
;	name - Name assigned to the sample (label)
;	path - Sample's include path (string)
; ------------------------------------------------------------------------------

incdac:	macro name, path
		even
	\name:
		incbin	\path
	\name\_End:
	endm

; ------------------------------------------------------------------------------
; Macro to stop Z80 and take over its bus
; ------------------------------------------------------------------------------
; ARGUMENTS:
;	opBusReq? - (Optional) Custom operand for Z80_BUSREQ
; ------------------------------------------------------------------------------

MPCM_stopZ80:	macro opBusReq
	pusho
	opt		l-		; make sure "@" marks local labels

	if narg=1
		move.w	#$100, \opBusReq
		@wait\@:
			btst	#0, \opBusReq
			bne.s	@wait\@
	else
		move.w	#$100, MPCM_Z80_BUSREQ
		@wait\@:
			btst	#0, MPCM_Z80_BUSREQ
			bne.s	@wait\@
	endif

	popo
	endm

; ------------------------------------------------------------------------------
; Macro to start Z80 and release its bus
; ------------------------------------------------------------------------------
; ARGUMENTS:
;	opBusReq? - (Optional) Custom operand for Z80_BUSREQ
; ------------------------------------------------------------------------------

MPCM_startZ80:	macro opBusReq
	if narg=1
		move.w	#0, \opBusReq
	else
		move.w	#0, MPCM_Z80_BUSREQ
	endif
	endm

; ------------------------------------------------------------------------------
; Ensures Mega PCM 2 isn't busy writing to YM (other than DAC output obviously)
; ------------------------------------------------------------------------------
; ARGUMENTS:
;	opBusReq? - (Optional) Custom operand for Z80_BUSREQ
; ------------------------------------------------------------------------------

MPCM_ensureYMWriteReady:	macro opBusReq
	pusho
	opt		l-		; make sure "@" marks local labels

	@chk_ready\@:
		tst.b	(MPCM_Z80_RAM+Z_MPCM_DriverReady).l
		bne.s	@ready\@
		MPCM_startZ80 \opBusReq
		move.w	d0, -(sp)
		moveq	#10, d0
		dbf		d0, *						; waste 100+ cycles
		move.w	(sp)+, d0
		MPCM_stopZ80 \opBusReq
		bra.s	@chk_ready\@
	@ready\@:

	popo
	endm

; ==============================================================================
; ------------------------------------------------------------------------------
; Mega PCM API
; ------------------------------------------------------------------------------

	xref	MegaPCM_LoadDriver
	xref	MegaPCM_LoadSampleTable
	xref	MegaPCM_PlaySample
	xref	MegaPCM_PausePlayback
	xref	MegaPCM_UnpausePlayback
	xref	MegaPCM_StopPlayback
	xref	MegaPCM_SetVolume
	xref	MegaPCM_SetSFXVolume
	xref	MegaPCM_SetPan
	xref	MegaPCM_SetSFXPan

	if def(__DEBUG__)
		xref	MPCM_Debugger_LoadSampleTableException
	endif

; ------------------------------------------------------------------------------
; MIT License
;
; Copyright (c) 2012-2024 Vladikcomper
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
; ------------------------------------------------------------------------------
