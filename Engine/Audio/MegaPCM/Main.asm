
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
		DAC_Entry		$04, Kick, pcm					; $81	- Kick
		DAC_Entry		$0D, Snare, pcm					; $82	- Snare
		DAC_Entry		$0A, KSnare, pcm				; $83	- Kick+Snare
		DAC_Entry		$0E, Tom, pcm					; $84	- Hi Tom
		DAC_Entry		$14, Tom, pcm					; $85	- Mid Tom
		DAC_Entry		$1A, Tom, pcm					; $86	- Low Tom
		DAC_Entry		$08, Clap, pcm					; $87	- Hand Clap
		DAC_Entry		$1B, Timpani, pcm				; $88	- Hi-Timpani
		DAC_Entry		$21, Timpani, pcm				; $89	- Mid-Timpani
		DAC_Entry		$26, Timpani, pcm				; $8A	- Low-Timpani
		DAC_Entry		$12, Tamb, pcm					; $8B	- Tambourine
		DAC_Entry		$0F, Snare, pcm					; $8C	- Pitched Snare
		DAC_Entry		$12, Muted_Tamb, pcm			; $8D	- Muted Tamb
		DAC_Entry		$13, HSL_Kick, pcm				; $8E	- HSL Kick (pitch)
		DAC_Entry		$08, SegaPCM, pcm				; $8F	- SEGA scream
		DAC_Entry		$12, HSL_HH, pcm				; $90	- HSL Hit Hat
		DAC_Entry		$12, HSL_Kick, pcm				; $91	- HSL Kick
		DAC_Entry		$12, HSL_Snare, pcm				; $92	- HSL Snare
		DAC_Entry		$12, HSL_KS, pcm				; $93	- HSL KickSnare
		DAC_Entry		$10, FallSFX, pcm				; $94	- Fall SFX
		DAC_Entry		$0C, BassCymbal, pcm			; $95	- Bass Cymbal
		DAC_Entry		$02, MashKick, pcm				; $96	- Mash Kick
		DAC_Entry		$02, SplatterSnare, pcm			; $97	- Splatter Snare
		DAC_Entry		$03, Tom2, pcm					; $98	- Tom-2 Hi
		DAC_Entry		$06, Tom2, pcm					; $99	- Tom-2 Hi-Mid
		DAC_Entry		$09, Tom2, pcm					; $9A	- Tom-2 Lo-Mid
		DAC_Entry		$0F, Tom2, pcm					; $9B	- Tom-2 Low
		DAC_Entry		$03, SonicCD_Yes, pcm+pri+panLR ; $9C	- Sonic CD Yes
		DAC_Entry		$04, Winrar, pcm				; $9D	- Winrar
		DAC_Entry		$08, Invalid, pcm				; $9E	- oops
		DAC_Entry		$04, ChillToTheMax, pcm			; $9F	- Lightning_Splash - Chill To The Max
		DAC_Entry		$1B, Mogege, pcm+pri			; $A0	- Mogege~
		DAC_Entry		$1B, Minnaaa, pcm				; $A1	- Minnaaa!
		DAC_Entry		$1B, Mogegegege, pcm			; $A2	- Mogegegege
		DAC_Entry		$04, Strike, pcm				; $A3	- Strike
		DAC_Entry		$04, Scream, pcm				; $A4	- Scream
		DAC_Entry       $04, Ground, pcm+panLR+pri		; $A5   - Ground Wave


MegaPCM_End:

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
		even
