; ======================================================
; ------------------------------------------------------
; VEPS Driver Routines
; 2013-2015, Vladikcomper
; ------------------------------------------------------
; TODO: Rename and organize music/sound files

UpdateMusic:
	lea	SoundDriverRAM, a6
*	jmp	VEPS

; ------------------------------------------------------
VEPS:
	incbin	"Engine\Audio\VEPS\veps.bin"

; ------------------------------------------------------
VEPS_DataPointers:
	dc.l	PSGIndex
	dc.l	MusicIndex
	dc.l	SoundIndex

; ======================================================









; ======================================================
; ------------------------------------------------------
; PSG Instruments
; ------------------------------------------------------

PSGIndex:
	dc.l vPSG1, vPSG2, vPSG3
	dc.l vPSG4, vPSG5, vPSG6
	dc.l vPSG7, vPSG8, vPSG9

vPSG1:	incbin	"Data/Audio/PSG/psg1.bin"
vPSG2:	incbin	"Data/Audio/PSG/psg2.bin"
vPSG3:	incbin	"Data/Audio/PSG/psg3.bin"
vPSG4:	incbin	"Data/Audio/PSG/psg4.bin"
vPSG6:	incbin	"Data/Audio/PSG/psg6.bin"
vPSG5:	incbin	"Data/Audio/PSG/psg5.bin"
vPSG7:	incbin	"Data/Audio/PSG/psg7.bin"
vPSG8:	incbin	"Data/Audio/PSG/psg8.bin"
vPSG9:	incbin	"Data/Audio/PSG/psg9.bin"

; ------------------------------------------------------
; Sound table
; ------------------------------------------------------

SoundIndex:

ptr_sndA0:      dc.l SoundA0
ptr_sndA1:      dc.l SoundA1
ptr_sndA2:      dc.l SoundA2
ptr_sndA3:      dc.l SoundA3
ptr_sndA4:      dc.l SoundA4
ptr_sndA5:      dc.l SoundA5
ptr_sndA6:      dc.l SoundA6
ptr_sndA7:      dc.l SoundA7
ptr_sndA8:      dc.l SoundA8
ptr_sndA9:      dc.l SoundA9
ptr_sndAA:      dc.l SoundAA
ptr_sndAB:      dc.l SoundAB
ptr_sndAC:      dc.l SoundAC
ptr_sndAD:      dc.l SoundAD
ptr_sndAE:      dc.l SoundAE
ptr_sndAF:      dc.l SoundAF
ptr_sndB0:      dc.l SoundB0
ptr_sndB1:      dc.l SoundB1
ptr_sndB2:      dc.l SoundB2
ptr_sndB3:      dc.l SoundB3
ptr_sndB4:      dc.l SoundB4
ptr_sndB5:      dc.l SoundB5
ptr_sndB6:      dc.l SoundB6
ptr_sndB7:      dc.l SoundB7
ptr_sndB8:      dc.l SoundB8
ptr_sndB9:      dc.l SoundB9
ptr_sndBA:      dc.l SoundBA
ptr_sndBB:      dc.l SoundBB
ptr_sndBC:      dc.l SoundBC
ptr_sndBD:      dc.l SoundBD
ptr_sndBE:      dc.l SoundBE
ptr_sndBF:      dc.l SoundBF
ptr_sndC0:      dc.l SoundC0
ptr_sndC1:      dc.l SoundC1
ptr_sndC2:      dc.l SoundC2
ptr_sndC3:      dc.l SoundC3
ptr_sndC4:      dc.l SoundC4
ptr_sndC5:      dc.l SoundC5
ptr_sndC6:      dc.l SoundC6
ptr_sndC7:      dc.l SoundC7
ptr_sndC8:      dc.l SoundC8
ptr_sndC9:      dc.l SoundC9
ptr_sndCA:      dc.l SoundCA
ptr_sndCB:      dc.l SoundCB
ptr_sndCC:      dc.l SoundCC
ptr_sndCD:      dc.l SoundCD
ptr_sndCE:      dc.l SoundCE
ptr_sndCF:      dc.l SoundCF
ptr_sndD0:      dc.l SoundD0
                dc.l SoundD1
                dc.l SoundD2
                dc.l SoundD3
                dc.l SoundD4
ptr_sndD5:      dc.l SoundD5
ptr_sndD6:      dc.l SoundD6
ptr_sndD7:      dc.l SoundD7
ptr_sndD8:      dc.l SoundD8

; ------------------------------------------------------
; Music table
; ------------------------------------------------------

MusicIndex:		
		dc.l Music81
		dc.l Music82
		dc.l Music83
		dc.l Music84
		dc.l Music85
		dc.l Music86
		dc.l Music87
		dc.l Music88
		dc.l Music89
		dc.l Music8A
		dc.l Music8B
		dc.l Music8C
		dc.l Music8D
		dc.l Music8E
		dc.l Music8F
		dc.l Music90
		dc.l Music91
		dc.l Music92
		dc.l Music93
		dc.l Music94
		dc.l Music95
		dc.l Music96
		dc.l Music97
		dc.l Music98
		dc.l Music99
		dc.l Music9A
		dc.l Music9B
		dc.l Music9C
		dc.l Music9D
		dc.l Music9E
		dc.l Music9F



; ===============================================================
; Music data
; ===============================================================


Music81:        incbin  Data\Audio\Music\music81.bin
                even
Music82:        incbin  Data\Audio\Music\music82.bin
                even
Music83:        incbin  Data\Audio\Music\music83.bin
                even
Music84:        incbin  Data\Audio\Music\music84.bin
                even
Music85:        incbin  Data\Audio\Music\music85.bin
                even
Music86:        incbin  Data\Audio\Music\music86.bin
                even
Music87:        incbin  Data\Audio\Music\music87.bin
                even
Music88:        incbin  Data\Audio\Music\music88.bin
                even
Music89:        incbin  Data\Audio\Music\music89.bin
                even         
Music8A:        incbin  Data\Audio\Music\music8A.bin
                even
Music8B:        incbin  Data\Audio\Music\music8B.bin
                even
Music8C:        incbin  Data\Audio\Music\music8C.bin
                even
Music8D:        incbin  Data\Audio\Music\music8D.bin
                even
Music8E:        incbin  Data\Audio\Music\music8E.bin
                even
Music8F:        incbin  Data\Audio\Music\music8F.bin
                even
Music90:        incbin  Data\Audio\Music\music90.bin
                even
Music91:        incbin  Data\Audio\Music\music91.bin
                even
Music92:        incbin  Data\Audio\Music\music92.bin
                even
Music93:        incbin  Data\Audio\Music\music93.bin
                even
Music94:        incbin  Data\Audio\Music\music94.bin
                even
Music95:        incbin  Data\Audio\Music\music95.bin
                even    
Music96:        incbin  Data\Audio\Music\music96.bin
                even
Music97:        incbin  Data\Audio\Music\music97.bin
                even    
Music98:        incbin  Data\Audio\Music\music98.bin
                even    
Music99:        incbin  Data\Audio\Music\music99.bin
                even    
Music9A:        incbin  Data\Audio\Music\music9A.bin
                even    
Music9B:        incbin  Data\Audio\Music\music9B.bin
                even    
Music9C:        incbin  Data\Audio\Music\TFIV_Boss_5.bin
                even    
Music9D:        incbin  Data\Audio\Music\music9D.bin
                even    
Music9E:        incbin  Data\Audio\Music\music9E.bin
                even            
Music9F:        incbin  Data\Audio\Music\music9F.bin
                even


; ===============================================================
; Sound effects data
; ===============================================================

SoundA0:        incbin  Data\Audio\Sound\soundA0.bin
                even
SoundA1:        incbin  Data\Audio\Sound\soundA1.bin
                even
SoundA2:        incbin  Data\Audio\Sound\soundA2.bin
                even
SoundA3:        incbin  Data\Audio\Sound\soundA3.bin
                even
SoundA4:        incbin  Data\Audio\Sound\soundA4.bin
                even
SoundA5:        incbin  Data\Audio\Sound\soundA5.bin
                even
SoundA6:        incbin  Data\Audio\Sound\soundA6.bin
                even
SoundA7:        incbin  Data\Audio\Sound\soundA7.bin
                even
SoundA8:        incbin  Data\Audio\Sound\soundA8.bin
                even
SoundA9:        incbin  Data\Audio\Sound\soundA9.bin
                even
SoundAA:        incbin  Data\Audio\Sound\soundAA.bin
                even
SoundAB:        incbin  Data\Audio\Sound\soundAB.bin
                even
SoundAC:        incbin  Data\Audio\Sound\soundAC.bin
                even
SoundAD:        incbin  Data\Audio\Sound\soundAD.bin
                even
SoundAE:        incbin  Data\Audio\Sound\soundAE.bin
                even
SoundAF:        incbin  Data\Audio\Sound\soundAF.bin
                even
SoundB0:        incbin  Data\Audio\Sound\soundB0.bin
                even
SoundB1:        incbin  Data\Audio\Sound\soundB1.bin
                even
SoundB2:        incbin  Data\Audio\Sound\soundB2.bin
                even
SoundB3:        incbin  Data\Audio\Sound\soundB3.bin
                even
SoundB4:        incbin  Data\Audio\Sound\soundB4.bin
                even
SoundB5:        incbin  Data\Audio\Sound\soundB5.bin
                even
SoundB6:        incbin  Data\Audio\Sound\soundB6.bin
                even
SoundB7:        incbin  Data\Audio\Sound\soundB7.bin
                even
SoundB8:        incbin  Data\Audio\Sound\soundB8.bin
                even
SoundB9:        incbin  Data\Audio\Sound\soundB9.bin
                even
SoundBA:        incbin  Data\Audio\Sound\soundBA.bin
                even
SoundBB:        incbin  Data\Audio\Sound\soundBB.bin
                even
SoundBC:        incbin  Data\Audio\Sound\soundBC.bin
                even
SoundBD:        incbin  Data\Audio\Sound\soundBD.bin
                even
SoundBE:        incbin  Data\Audio\Sound\soundBE.bin
                even
SoundBF:        incbin  Data\Audio\Sound\soundBF.bin
                even
SoundC0:        incbin  Data\Audio\Sound\soundC0.bin
                even
SoundC1:        incbin  Data\Audio\Sound\soundC1.bin
                even
SoundC2:        incbin  Data\Audio\Sound\soundC2.bin
                even
SoundC3:        incbin  Data\Audio\Sound\soundC3.bin
                even
SoundC4:        incbin  Data\Audio\Sound\soundC4.bin
                even
SoundC5:        incbin  Data\Audio\Sound\soundC5.bin
                even
SoundC6:        incbin  Data\Audio\Sound\soundC6.bin
                even
SoundC7:        incbin  Data\Audio\Sound\soundC7.bin
                even
SoundC8:        incbin  Data\Audio\Sound\soundC8.bin
                even
SoundC9:        incbin  Data\Audio\Sound\soundC9.bin
                even
SoundCA:        incbin  Data\Audio\Sound\soundCA.bin
                even
SoundCB:        incbin  Data\Audio\Sound\soundCB.bin
                even
SoundCC:        incbin  Data\Audio\Sound\soundCC.bin
                even
SoundCD:        incbin  Data\Audio\Sound\soundCD.bin
                even
SoundCE:        incbin  Data\Audio\Sound\soundCE.bin
                even
SoundCF:        incbin  Data\Audio\Sound\soundCF.bin
                even
SoundD0:        incbin  Data\Audio\Sound\soundD0.bin
                even
SoundD1:        incbin  Data\Audio\Sound\soundD1.bin
                even
SoundD2:        incbin  Data\Audio\Sound\soundD2.bin
                even
SoundD3:        incbin  Data\Audio\Sound\soundD3.bin
                even
SoundD4:        dc.w @0-SoundD4,$0101
                dc.w $8005,@1-SoundD4,$0004
@1:             dc.b $EF,$00,$B0,$06,$80,$06,$B0,$18,$F2
@0:             dc.b $38,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$00,$00,$00
                dc.b $00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$1F,$17,$0C,$00        ; 17-0C swapped
SoundD5:        incbin  Data\Audio\Sound\soundD5.bin
                even
SoundD6:        incbin  Data\Audio\Sound\soundD6.bin
                even
SoundD7:        incbin  Data\Audio\Sound\soundD7.bin
                even
SoundD8:        incbin  Data\Audio\Sound\soundD8.bin
                even

; Music
mus_ghz: equ		$81
mus_lz: equ		$82
mus_mz: equ		$83
mus_syz: equ		$84
mus_slz: equ		$85
mus_sbz: equ		$86
mus_invincibility: equ	$87
mus_unused: equ	$88 ; unused slot for now
mus_ss: equ		$89
mus_title: equ		$8A
mus_ending: equ		$8B
mus_boss: equ		$8C
mus_fz: equ		$8D
mus_zone7pre: equ	$96
mus_zone7: equ	$97 

mus_gotthroughact: equ	$8E
mus_gameover: equ	$8F
mus_continue: 	equ	$90
mus_credits: 	equ	$91
mus_drowning: 	equ	$92
mus_emerald: 	equ	$93

mus_model: equ		$94
mus_retro: equ		$95

; Control
mus_fadeout: equ	$E4 ; the stupidest fix ever
mus_sega: equ		$E1
mus_shoeson: equ	$E2
mus_shoesoff: equ	$E3
mus_stop: equ		$E0

; Sound Effects
sfx_jump: equ		$A0
sfx_lamppost: equ	$A1
; UNUSED: A2
sfx_death: equ		$A3
sfx_skid: equ		$A4
; UNUSED: A5
sfx_hitspikes: equ	$A6
sfx_pushblock: equ	$A7
sfx_goal: equ		$A8
sfx_actionblock: equ	$A9 ; special stage UP/DOWN block
sfx_splash: equ		$AA
; UNUSED: AB
sfx_bosshit: equ	$AC
sfx_bubble: equ		$AD
sfx_lavaball: equ	$AE
sfx_shield: equ		$AF
sfx_saw: equ		$B0
sfx_electricity: equ	$B1
sfx_drown: equ		$B2
sfx_flame: equ 		$B3
sfx_bumper: equ		$B4
sfx_ringright: equ	$B5
sfx_spikemove: equ	$B6
sfx_rumble: equ		$B7
; UNUSED: B8
sfx_collapse: equ	$B9
sfx_diamonds: equ	$BA
sfx_door: equ		$BB
sfx_dash: equ		$BC
sfx_stomp: equ		$BD
sfx_roll: equ		$BE
sfx_continue: equ 	$BF
sfx_basaran: equ	$C0
sfx_break: equ		$C1
sfx_airding: equ	$C2
sfx_bigring: equ	$C3
sfx_explode: equ	$C4
sfx_register: equ	$C5
sfx_ringloss: equ 	$C6
sfx_chain: equ		$C7
sfx_lava: equ		$C8
sfx_bonus: equ		$C9
sfx_enterss: equ	$CA
sfx_smash: equ		$CB
sfx_spring: equ		$CC
sfx_switch: equ		$CD
; Ring - Would be duplicate
sfx_signpost: equ	$CF
sfx_buzzexplode: equ	$a9 ; ignore, for now
sfx_waterfall: equ	$D0
sfxcount: equ		$D1
sfxoff: equ		$D2
sfx_violence: equ		$D6
sfx_bouncy: equ		$D7
sfx_superexplosion: equ		$D8