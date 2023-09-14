
; ---------------------------------------------------------------

FLAGS_LOOP:	equ	$40
FLAGS_PRIORITY:	equ	$80

TYPE_PCM:	equ	'P'

; ---------------------------------------------------------------
dcSample:	macro	type, samplePtr, sampleRate, flags
	dc.b	\type						; $00	- type
	dc.b	\sampleRate*256/24000				; $01	- pitch
	dc.l	\samplePtr					; $02	- start offset
	dc.l	\samplePtr\_End					; $06	- end offset
	dc.b	\flags+0					; $0A	- flags
	dc.b	0						; $0B	- reserved
	endm

; ---------------------------------------------------------------
IncludeDAC macro Name,Extension
\Name:
	if strcmp('\extension','wav')
		incbin	'Data\Audio\DAC/\Name\.\Extension\',$3A
	else
		incbin	'Data\Audio\DAC/\Name\.\Extension\'
	endc
\Name\_End:
	endm

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

SampleTable:
	dcSample	TYPE_PCM, Kick, 22000, 				; $81	- Kick
	dcSample	TYPE_PCM, Snare, 22000, 				; $82	- Snare
	dcSample	TYPE_PCM, KSnare, 22000, 				; $83	- Kick+Snare
	dcSample	TYPE_PCM, Tom, 22000, 				; $84	- Hi Tom
	dcSample	TYPE_PCM, Tom, 22000, 				; $85	- Mid Tom
	dcSample	TYPE_PCM, Tom, 22000, 				; $86	- Low Tom
	dcSample	TYPE_PCM, Clap, 22000, 				; $87	- Hand Clap
	dcSample	TYPE_PCM, Timpani, 22000, 			; $88	- Hi-Timpani
	dcSample	TYPE_PCM, Timpani, 22000, 			; $89	- Mid-Timpani
	dcSample	TYPE_PCM, Timpani, 22000, 			; $8A	- Low-Timpani
	dcSample	TYPE_PCM, Tamb, 22000, 				; $8B	- Tambourine
	dcSample	TYPE_PCM, Snare, 22000, 				; $8C	- Pitched Snare
	dcSample	TYPE_PCM, Muted_Tamb, 22000, 			; $8D	- Muted Tamb
	dcSample	TYPE_PCM, HSL_Kick, 22000, 			; $8E	- HSL Kick (pitch)
	dcSample	TYPE_PCM, SegaPCM, 22000, 			; $8F	- SEGA scream
	dcSample	TYPE_PCM, HSL_HH, 22000, 				; $90	- HSL Hit Hat
	dcSample	TYPE_PCM, HSL_Kick, 22000, 			; $91	- HSL Kick
	dcSample	TYPE_PCM, HSL_Snare, 22000, 			; $92	- HSL Snare
	dcSample	TYPE_PCM, HSL_KS, 22000, 				; $93	- HSL KickSnare
	dcSample	TYPE_PCM, FallSFX, 22000, 			; $94	- Fall SFX
	dcSample	TYPE_PCM, BassCymbal, 22000, 			; $95	- Bass Cymbal
	dcSample	TYPE_PCM, MashKick, 22000, 			; $96	- Mash Kick
	dcSample	TYPE_PCM, SplatterSnare, 22000, 			; $97	- Splatter Snare
	dcSample	TYPE_PCM, Tom2, 22000, 				; $98	- Tom-2 Hi
	dcSample	TYPE_PCM, Tom2, 22000, 				; $99	- Tom-2 Hi-Mid
	dcSample	TYPE_PCM, Tom2, 22000, 				; $9A	- Tom-2 Lo-Mid
	dcSample	TYPE_PCM, Tom2, 22000, 				; $9B	- Tom-2 Low
	dcSample	TYPE_PCM, SonicCD_Yes, 22000, FLAGS_PRIORITY	; $9C	- Sonic CD Yes
	dcSample	TYPE_PCM, Winrar, 22000, 				; $9D	- Winrar
	dcSample	TYPE_PCM, Tails, 22000, FLAGS_LOOP		; $9E	- Tails
	dcSample	TYPE_PCM, ChillToTheMax, 22000, 			; $9F	- Lightning_Splash - Chill To The Max
	dcSample	TYPE_PCM, Mogege, 22000, FLAGS_PRIORITY		; $A0	- Mogege~
	dcSample	TYPE_PCM, Minnaaa, 22000, 			; $A1	- Minnaaa!
	dcSample	TYPE_PCM, Mogegegege, 22000, 			; $A2	- Mogegegege
	dcSample	TYPE_PCM, Strike, 22000, 				; $A3	- Strike
	dcSample	TYPE_PCM, Scream, 22000, 				; $A4	- Scream
	dcSample	TYPE_PCM, Ground, 22000, FLAGS_PRIORITY		; $A5   - Ground Wave
SampleTable_End:

;	DAC_Entry		$04, Kick, pcm					; $81	- Kick
;	DAC_Entry		$0D, Snare, pcm					; $82	- Snare
;	DAC_Entry		$0A, KSnare, pcm				; $83	- Kick+Snare
;	DAC_Entry		$0E, Tom, pcm					; $84	- Hi Tom
;	DAC_Entry		$14, Tom, pcm					; $85	- Mid Tom
;	DAC_Entry		$1A, Tom, pcm					; $86	- Low Tom
;	DAC_Entry		$08, Clap, pcm					; $87	- Hand Clap
;	DAC_Entry		$1B, Timpani, pcm				; $88	- Hi-Timpani
;	DAC_Entry		$21, Timpani, pcm				; $89	- Mid-Timpani
;	DAC_Entry		$26, Timpani, pcm				; $8A	- Low-Timpani
;	DAC_Entry		$12, Tamb, pcm					; $8B	- Tambourine
;	DAC_Entry		$0F, Snare, pcm					; $8C	- Pitched Snare
;	DAC_Entry		$12, Muted_Tamb, pcm			; $8D	- Muted Tamb
;	DAC_Entry		$13, HSL_Kick, pcm				; $8E	- HSL Kick (pitch)
;	DAC_Entry		$08, SegaPCM, pcm				; $8F	- SEGA scream
;	DAC_Entry		$12, HSL_HH, pcm				; $90	- HSL Hit Hat
;	DAC_Entry		$12, HSL_Kick, pcm				; $91	- HSL Kick
;	DAC_Entry		$12, HSL_Snare, pcm				; $92	- HSL Snare
;	DAC_Entry		$12, HSL_KS, pcm				; $93	- HSL KickSnare
;	DAC_Entry		$10, FallSFX, pcm				; $94	- Fall SFX
;	DAC_Entry		$0C, BassCymbal, pcm			; $95	- Bass Cymbal
;	DAC_Entry		$02, MashKick, pcm				; $96	- Mash Kick
;	DAC_Entry		$02, SplatterSnare, pcm			; $97	- Splatter Snare
;	DAC_Entry		$03, Tom2, pcm					; $98	- Tom-2 Hi
;	DAC_Entry		$06, Tom2, pcm					; $99	- Tom-2 Hi-Mid
;	DAC_Entry		$09, Tom2, pcm					; $9A	- Tom-2 Lo-Mid
;	DAC_Entry		$0F, Tom2, pcm					; $9B	- Tom-2 Low
;	DAC_Entry		$03, SonicCD_Yes, pcm+pri+panLR ; $9C	- Sonic CD Yes
;	DAC_Entry		$04, Winrar, pcm				; $9D	- Winrar
;	DAC_Entry		$08, Tails, pcm+loop			; $9E	- Tails
;	DAC_Entry		$04, ChillToTheMax, pcm			; $9F	- Lightning_Splash - Chill To The Max
;	DAC_Entry		$1B, Mogege, pcm+pri			; $A0	- Mogege~
;	DAC_Entry		$1B, Minnaaa, pcm				; $A1	- Minnaaa!
;	DAC_Entry		$1B, Mogegegege, pcm			; $A2	- Mogegegege
;	DAC_Entry		$04, Strike, pcm				; $A3	- Strike
;	DAC_Entry		$04, Scream, pcm				; $A4	- Scream
;	DAC_Entry       	$04, Ground, pcm+panLR+pri		; $A5   - Ground Wave


; ---------------------------------------------------------------
; DAC Samples Files
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
		IncludeDAC		Tails, wav
		IncludeDAC		ChillToTheMax, wav
		IncludeDAC		Mogege, wav
		IncludeDAC		Minnaaa, wav
		IncludeDAC		Mogegegege, wav
		IncludeDAC		Strike, wav
		IncludeDAC		Scream, wav
		IncludeDAC		Ground, raw
		even
