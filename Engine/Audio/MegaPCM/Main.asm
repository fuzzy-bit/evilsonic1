
; ---------------------------------------------------------------

FLAGS_SFX:		equ	$01
FLAGS_LOOP:		equ	$02

FLAGS_PANR:		equ	$40
FLAGS_PANL:		equ	$80
FLAGS_PANLR:		equ	$C0

TYPE_PCM:		equ	'P'
TYPE_PCM_TURBO:		equ	'T'

; ---------------------------------------------------------------
z80word macro Value
	dc.w	((\Value)&$FF)<<8|((\Value)&$FF00)>>8
	endm

; ---------------------------------------------------------------
dcSample:	macro	type, samplePtr, sampleRate, flags
	dc.b	\type							; $00	- type
	dc.b	\flags+0						; $01	- flags
	dc.b	(\sampleRate)*256/24686					; $02	- pitch
	dc.b	((\samplePtr)>>15)&$FF					; $03	- start bank
	dc.b	((\samplePtr\_End)>>15)&$FF				; $04	- end bank
	z80word ((\samplePtr)|$8000)					; $05	- start offset
	z80word ((\samplePtr\_End)|$8000)				; $07	- end length
	endm

; ---------------------------------------------------------------
IncludeDAC macro Name,Extension
\Name:
	if strcmp('\extension','wav')
		incbin	'Data\Audio\DAC/\Name\.\Extension\',$3A
		even
	else
		incbin	'Data\Audio\DAC/\Name\.\Extension\'
		even
	endc
\Name\_End:
	endm

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

SampleTable:
		dcSample	TYPE_PCM, Kick, 			20454, 					; $81	- Kick
		dcSample	TYPE_PCM, Snare, 		12258, 					; $82	- Snare
		dcSample	TYPE_PCM, KSnare, 		14148, 					; $83	- Kick+Snare
		dcSample	TYPE_PCM, Tom, 			11736, 					; $84	- Hi Tom
		dcSample	TYPE_PCM, Tom, 			9346, 					; $85	- Mid Tom
		dcSample	TYPE_PCM, Tom, 			7764, 					; $86	- Low Tom
		dcSample	TYPE_PCM, Clap, 			15768, 					; $87	- Hand Clap
		dcSample	TYPE_PCM, Timpani, 		7551, 					; $88	- Hi-Timpani
		dcSample	TYPE_PCM, Timpani, 		6484, 					; $89	- Mid-Timpani
		dcSample	TYPE_PCM, Timpani, 		5801, 					; $8A	- Low-Timpani
		dcSample	TYPE_PCM, Tamb, 			10026, 					; $8B	- Tambourine
		dcSample	TYPE_PCM, Snare, 		11256, 					; $8C	- Pitched Snare
		dcSample	TYPE_PCM, Muted_Tamb, 	10026, 					; $8D	- Muted Tamb
		dcSample	TYPE_PCM, HSL_Kick, 		9674, 					; $8E	- HSL Kick (pitch)
		dcSample	TYPE_PCM, SegaPCM, 		15768, 					; $8F	- SEGA scream
		dcSample	TYPE_PCM, HSL_HH, 		10026, 					; $90	- HSL Hit Hat
		dcSample	TYPE_PCM, HSL_Kick, 		10026, 					; $91	- HSL Kick
		dcSample	TYPE_PCM, HSL_Snare, 	10026, 					; $92	- HSL Snare
		dcSample	TYPE_PCM, HSL_KS, 		10026, 					; $93	- HSL KickSnare
		dcSample	TYPE_PCM, FallSFX, 		10814, 					; $94	- Fall SFX
		dcSample	TYPE_PCM, BassCymbal, 	12829, 					; $95	- Bass Cymbal
		dcSample	TYPE_PCM, MashKick, 		23950, 					; $96	- Mash Kick
		dcSample	TYPE_PCM, SplatterSnare, 23950, 					; $97	- Splatter Snare
		dcSample	TYPE_PCM, Tom2, 			22095, 					; $98	- Tom-2 Hi
		dcSample	TYPE_PCM, Tom2, 			17808, 					; $99	- Tom-2 Hi-Mid
		dcSample	TYPE_PCM, Tom2, 			14914, 					; $9A	- Tom-2 Lo-Mid
		dcSample	TYPE_PCM, Tom2, 			11256, 					; $9B	- Tom-2 Low
		dcSample	TYPE_PCM, SonicCD_Yes, 	22095, FLAGS_SFX 	; $9C	- Sonic CD Yes
		dcSample	TYPE_PCM, Winrar, 		22050, FLAGS_SFX			; $9D	- Winrar
		dcSample	TYPE_PCM, Invalid, 		15768, FLAGS_SFX			; $9E	- oops
		dcSample	TYPE_PCM, ChillToTheMax, 22050, FLAGS_SFX				; $9F	- Lightning_Splash - Chill To The Max
		dcSample	TYPE_PCM, Mogege, 		7551, FLAGS_SFX	; $A0	- Mogege~
		dcSample	TYPE_PCM, Minnaaa, 		7551, FLAGS_SFX	; $A1	- Minnaaa!
		dcSample	TYPE_PCM, Mogegegege, 	7551, FLAGS_SFX	; $A2	- Mogegegege
		dcSample	TYPE_PCM, Strike, 		20454, FLAGS_SFX	; $A3	- Strike
		dcSample	TYPE_PCM, Scream, 		20454, FLAGS_SFX	; $A4	- Scream
		dcSample	TYPE_PCM, Ground, 		20454, FLAGS_SFX	; $A5   - Ground Wave
		dcSample	TYPE_PCM, ThankYou, 	22050, FLAGS_SFX	; $A6   - Thank you <3
SampleTable_End:

; ---------------------------------------------------------------
; DAC Sample Files
; ---------------------------------------------------------------

		IncludeDAC		Tom, raw
		IncludeDAC		Kick, raw
		IncludeDAC		Snare, raw
		IncludeDAC		KSnare, raw
		IncludeDAC		Clap, raw
		IncludeDAC		Timpani, raw
		IncludeDAC		Tamb, raw
		IncludeDAC		Muted_Tamb, raw

		; Jet --------------------------------
		IncludeDAC		MashKick,snd
		IncludeDAC		SplatterSnare,snd

		IncludeDAC		HSL_Kick, raw
		IncludeDAC		HSL_HH, raw
		IncludeDAC		HSL_KS, raw
		IncludeDAC		HSL_Snare, raw

		; S_T_D ------------------------------
		IncludeDAC		BassCymbal, snd
		IncludeDAC		Tom2, snd

		; Vladikcomper -----------------------
		IncludeDAC		FallSFX, snd
		IncludeDAC		SegaPCM, bin
		IncludeDAC		SonicCD_Yes, snd

		; Fuzzy ------------------------------
		IncludeDAC		Winrar, wav
		IncludeDAC		Invalid, bin
		IncludeDAC		ChillToTheMax, wav
		IncludeDAC		Mogege, wav
		IncludeDAC		Minnaaa, wav
		IncludeDAC		Mogegegege, wav
		IncludeDAC		Strike, wav
		IncludeDAC		Scream, wav
		IncludeDAC		Ground, raw
		IncludeDAC		ThankYou, wav
		even
