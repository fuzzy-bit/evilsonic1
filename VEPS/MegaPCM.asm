
; ===============================================================
; Mega PCM Driver Include File
; (c) 2012, Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables used in DAC table
; ---------------------------------------------------------------

; flags
panLR	= $C0
panL	= $80
panR	= $40
pcm		= 0
dpcm	= 4
loop	= 2
pri		= 1

; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

z80word macro Value
		dc.w	((\Value)&$FF)<<8|((\Value)&$FF00)>>8
		endm

DAC_Entry macro Pitch,Offset,Flags
		dc.b	\Flags					; 00h	- Flags
		dc.b	\Pitch					; 01h	- Pitch
		dc.b	(\Offset>>15)&$FF		; 02h	- Start Bank
		dc.b	(\Offset\_End>>15)&$FF	; 03h	- End Bank
		z80word (\Offset)|$8000			; 04h	- Start Offset (in Start bank)
		z80word (\Offset\_End-1)|$8000	; 06h	- End Offset (in End bank)
		endm
		
IncludeDAC macro Name,Extension
\Name:
		if strcmp('\extension','wav')
				incbin	'VEPS\dac/\Name\.\Extension\',$3A
		else
				incbin	'VEPS\dac/\Name\.\Extension\'
		endc
\Name\_End:
		endm

; ---------------------------------------------------------------
; Driver's code
; ---------------------------------------------------------------

MegaPCM:
		incbin	'VEPS\MegaPCM.z80'

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

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
		DAC_Entry		$01, GreatSuccess, pcm			; $9D	- Borat
		DAC_Entry		$01, Uni, pcm+loop				; $9E	- Uni

MegaPCM_End:

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
		IncludeDAC		GreatSuccess, wav
		IncludeDAC		Uni, wav
		even
