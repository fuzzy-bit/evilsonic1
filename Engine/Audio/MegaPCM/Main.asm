
SampleTable:
		dcSample	TYPE_PCM, Kick, 		20454, 					; $81	- Kick
		dcSample	TYPE_PCM, Snare, 		12258, 					; $82	- Snare
		dcSample	TYPE_PCM, KSnare, 		14148, 					; $83	- Kick+Snare
		dcSample	TYPE_PCM, Tom, 			11736, 					; $84	- Hi Tom
		dcSample	TYPE_PCM, Tom, 			9346, 					; $85	- Mid Tom
		dcSample	TYPE_PCM, Tom, 			7764, 					; $86	- Low Tom
		dcSample	TYPE_PCM, Clap, 		15768, 					; $87	- Hand Clap
		dcSample	TYPE_PCM, Timpani, 		7551, 					; $88	- Hi-Timpani
		dcSample	TYPE_PCM, Timpani, 		6484, 					; $89	- Mid-Timpani
		dcSample	TYPE_PCM, Timpani, 		5801, 					; $8A	- Low-Timpani
		dcSample	TYPE_PCM, Tamb, 		10026, 					; $8B	- Tambourine
		dcSample	TYPE_PCM, Snare, 		11256, 					; $8C	- Pitched Snare
		dcSample	TYPE_PCM, Muted_Tamb, 	10026, 					; $8D	- Muted Tamb
		dcSample	TYPE_PCM, HSL_Kick, 	9674, 					; $8E	- HSL Kick (pitch)
		dcSample	TYPE_PCM, SegaPCM, 		15768, 					; $8F	- SEGA scream
		dcSample	TYPE_PCM, HSL_HH, 		10026, 					; $90	- HSL Hit Hat
		dcSample	TYPE_PCM, HSL_Kick, 	10026, 					; $91	- HSL Kick
		dcSample	TYPE_PCM, HSL_Snare, 	10026, 					; $92	- HSL Snare
		dcSample	TYPE_PCM, HSL_KS, 		10026, 					; $93	- HSL KickSnare
		dcSample	TYPE_PCM, FallSFX, 		10814, 					; $94	- Fall SFX
		dcSample	TYPE_PCM, BassCymbal, 	12829, 					; $95	- Bass Cymbal
		dcSample	TYPE_PCM, MashKick, 	23950, 					; $96	- Mash Kick
		dcSample	TYPE_PCM, SplatterSnare, 23950, 				; $97	- Splatter Snare
		dcSample	TYPE_PCM, Tom2, 		22095, 					; $98	- Tom-2 Hi
		dcSample	TYPE_PCM, Tom2, 		17808, 					; $99	- Tom-2 Hi-Mid
		dcSample	TYPE_PCM, Tom2, 		14914, 					; $9A	- Tom-2 Lo-Mid
		dcSample	TYPE_PCM, Tom2, 		11256, 					; $9B	- Tom-2 Low
		dcSample	TYPE_PCM, GenesisDoes, 	11256, FLAGS_SFX 		; $9C	- Sonic CD Yes
		dcSample	TYPE_PCM, Winrar, 		22050, FLAGS_SFX		; $9D	- Winrar
		dcSample	TYPE_PCM, Tom2,         22050, FLAGS_SFX		; $9E	- Nah
		dcSample	TYPE_PCM, ChillToTheMax,22050, FLAGS_SFX 		; $9F	- Lightning_Splash - Chill To The Max
		dcSample	TYPE_PCM, Mogege, 		7551, FLAGS_SFX			; $A0	- Mogege~
		dcSample	TYPE_PCM, IiKotoShiyo, 	8000, FLAGS_SFX			; $A1	- IiKotoShiyo
		dcSample	TYPE_PCM, OhJeez, 		22050, FLAGS_SFX		; $A2	- OhJeez
		dcSample	TYPE_PCM, Strike, 		20454, FLAGS_SFX		; $A3	- Strike
		dcSample	TYPE_PCM, Scream, 		20454, FLAGS_SFX		; $A4	- Scream
		dcSample	TYPE_PCM, TheOneAndOnly,22050, FLAGS_SFX		; $A5   - TheOneAndOnly
		dcSample	TYPE_PCM, ThankYou, 	22050, FLAGS_SFX		; $A6   - Thank you <3
		dc.w	-1			; end marker

; ---------------------------------------------------------------
; DAC Sample Files
; ---------------------------------------------------------------

		incdac	Tom, "Data\Audio\DAC\Tom.raw"
		incdac	Kick, "Data\Audio\DAC\Kick.raw"
		incdac	Snare, "Data\Audio\DAC\Snare.raw"
		incdac	KSnare, "Data\Audio\DAC\KSnare.raw"
		incdac	Clap, "Data\Audio\DAC\Clap.raw"
		incdac	Timpani, "Data\Audio\DAC\Timpani.raw"
		incdac	Tamb, "Data\Audio\DAC\Tamb.raw"
		incdac	Muted_Tamb, "Data\Audio\DAC\Muted_Tamb.raw"

		; Jet --------------------------------
		incdac	MashKick, "Data\Audio\DAC\MashKick.snd"
		incdac	SplatterSnare, "Data\Audio\DAC\SplatterSnare.snd"

		incdac	HSL_Kick, "Data\Audio\DAC\HSL_Kick.raw"
		incdac	HSL_HH, "Data\Audio\DAC\HSL_HH.raw"
		incdac	HSL_KS, "Data\Audio\DAC\HSL_KS.raw"
		incdac	HSL_Snare, "Data\Audio\DAC\HSL_Snare.raw"

		; S_T_D ------------------------------
		incdac	BassCymbal, "Data\Audio\DAC\BassCymbal.snd"
		incdac	Tom2, "Data\Audio\DAC\Tom2.snd"

		; Vladikcomper -----------------------
		incdac	FallSFX, "Data\Audio\DAC\FallSFX.snd"
		incdac	SegaPCM, "Data\Audio\DAC\SegaPCM.bin"
		incdac	GenesisDoes, "Data\Audio\DAC\GenesisDoes.raw"

		; Fuzzy ------------------------------
		incdac	Winrar, "Data\Audio\DAC\Winrar.wav"
		incdac	ChillToTheMax, "Data\Audio\DAC\ChillToTheMax.wav"
		incdac	Mogege, "Data\Audio\DAC\Mogege.wav"
		incdac	IiKotoShiyo, "Data\Audio\DAC\IiKotoShiyo.wav"
		incdac	OhJeez, "Data\Audio\DAC\OhJeez.wav"
		incdac	Strike, "Data\Audio\DAC\Strike.wav"
		incdac	Scream, "Data\Audio\DAC\Scream.wav"
		incdac	TheOneAndOnly, "Data\Audio\DAC\TheOneAndOnly.wav"
		incdac	ThankYou, "Data\Audio\DAC\ThankYou.wav"

		even
