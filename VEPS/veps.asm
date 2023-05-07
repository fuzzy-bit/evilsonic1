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
	incbin	"VEPS\veps.bin"

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

vPSG1:	incbin	"VEPS/sound/psg1.bin"
vPSG2:	incbin	"VEPS/sound/psg2.bin"
vPSG3:	incbin	"VEPS/sound/psg3.bin"
vPSG4:	incbin	"VEPS/sound/psg4.bin"
vPSG6:	incbin	"VEPS/sound/psg6.bin"
vPSG5:	incbin	"VEPS/sound/psg5.bin"
vPSG7:	incbin	"VEPS/sound/psg7.bin"
vPSG8:	incbin	"VEPS/sound/psg8.bin"
vPSG9:	incbin	"VEPS/sound/psg9.bin"

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


Music81:        incbin  VEPS\sound\music81.bin
                even
Music82:        incbin  VEPS\sound\music82.bin
                even
Music83:        incbin  VEPS\sound\music83.bin
                even
Music84:        incbin  VEPS\sound\music84.bin
                even
Music85:        incbin  VEPS\sound\music85.bin
                even
Music86:        incbin  VEPS\sound\music86.bin
                even
Music87:        incbin  VEPS\sound\music87.bin
                even
Music88:        incbin  VEPS\sound\music88.bin
                even
Music89:        incbin  VEPS\sound\music89.bin
                even         
Music8A:        incbin  VEPS\sound\music8A.bin
                even
Music8B:        incbin  VEPS\sound\music8B.bin
                even
Music8C:        incbin  VEPS\sound\music8C.bin
                even
Music8D:        incbin  VEPS\sound\music8D.bin
                even
Music8E:        incbin  VEPS\sound\music8E.bin
                even
Music8F:        incbin  VEPS\sound\music8F.bin
                even
Music90:        incbin  VEPS\sound\music90.bin
                even
Music91:        incbin  VEPS\sound\music91.bin
                even
Music92:        incbin  VEPS\sound\music92.bin
                even
Music93:        incbin  VEPS\sound\music93.bin
                even
Music94:        incbin  VEPS\sound\music94.bin
                even
Music95:        incbin  VEPS\sound\music95.bin
                even    
Music96:        incbin  VEPS\sound\music96.bin
                even
Music97:        incbin  VEPS\sound\music97.bin
                even    
Music98:        incbin  VEPS\sound\music98.bin
                even    
Music99:        incbin  VEPS\sound\music99.bin
                even    
Music9A:        incbin  VEPS\sound\music9A.bin
                even    
Music9B:        incbin  VEPS\sound\music9B.bin
                even    
Music9C:        incbin  VEPS\sound\TFIV_Boss_5.bin
                even    
Music9D:        incbin  VEPS\sound\music9D.bin
                even    
Music9E:        incbin  VEPS\sound\music9E.bin
                even            
Music9F:        incbin  VEPS\sound\music9F.bin
                even


; ===============================================================
; Sound effects data
; ===============================================================

SoundA0:        incbin  VEPS\sound\soundA0.bin
                even
SoundA1:        incbin  VEPS\sound\soundA1.bin
                even
SoundA2:        incbin  VEPS\sound\soundA2.bin
                even
SoundA3:        incbin  VEPS\sound\soundA3.bin
                even
SoundA4:        incbin  VEPS\sound\soundA4.bin
                even
SoundA5:        incbin  VEPS\sound\soundA5.bin
                even
SoundA6:        incbin  VEPS\sound\soundA6.bin
                even
SoundA7:        incbin  VEPS\sound\soundA7.bin
                even
SoundA8:        incbin  VEPS\sound\soundA8.bin
                even
SoundA9:        incbin  VEPS\sound\soundA9.bin
                even
SoundAA:        incbin  VEPS\sound\soundAA.bin
                even
SoundAB:        incbin  VEPS\sound\soundAB.bin
                even
SoundAC:        incbin  VEPS\sound\soundAC.bin
                even
SoundAD:        incbin  VEPS\sound\soundAD.bin
                even
SoundAE:        incbin  VEPS\sound\soundAE.bin
                even
SoundAF:        incbin  VEPS\sound\soundAF.bin
                even
SoundB0:        incbin  VEPS\sound\soundB0.bin
                even
SoundB1:        incbin  VEPS\sound\soundB1.bin
                even
SoundB2:        incbin  VEPS\sound\soundB2.bin
                even
SoundB3:        incbin  VEPS\sound\soundB3.bin
                even
SoundB4:        incbin  VEPS\sound\soundB4.bin
                even
SoundB5:        incbin  VEPS\sound\soundB5.bin
                even
SoundB6:        incbin  VEPS\sound\soundB6.bin
                even
SoundB7:        incbin  VEPS\sound\soundB7.bin
                even
SoundB8:        incbin  VEPS\sound\soundB8.bin
                even
SoundB9:        incbin  VEPS\sound\soundB9.bin
                even
SoundBA:        incbin  VEPS\sound\soundBA.bin
                even
SoundBB:        incbin  VEPS\sound\soundBB.bin
                even
SoundBC:        incbin  VEPS\sound\soundBC.bin
                even
SoundBD:        incbin  VEPS\sound\soundBD.bin
                even
SoundBE:        incbin  VEPS\sound\soundBE.bin
                even
SoundBF:        incbin  VEPS\sound\soundBF.bin
                even
SoundC0:        incbin  VEPS\sound\soundC0.bin
                even
SoundC1:        incbin  VEPS\sound\soundC1.bin
                even
SoundC2:        incbin  VEPS\sound\soundC2.bin
                even
SoundC3:        incbin  VEPS\sound\soundC3.bin
                even
SoundC4:        incbin  VEPS\sound\soundC4.bin
                even
SoundC5:        incbin  VEPS\sound\soundC5.bin
                even
SoundC6:        incbin  VEPS\sound\soundC6.bin
                even
SoundC7:        incbin  VEPS\sound\soundC7.bin
                even
SoundC8:        incbin  VEPS\sound\soundC8.bin
                even
SoundC9:        incbin  VEPS\sound\soundC9.bin
                even
SoundCA:        incbin  VEPS\sound\soundCA.bin
                even
SoundCB:        incbin  VEPS\sound\soundCB.bin
                even
SoundCC:        incbin  VEPS\sound\soundCC.bin
                even
SoundCD:        incbin  VEPS\sound\soundCD.bin
                even
SoundCE:        incbin  VEPS\sound\soundCE.bin
                even
SoundCF:        incbin  VEPS\sound\soundCF.bin
                even
SoundD0:        incbin  VEPS\sound\soundD0.bin
                even
SoundD1:        incbin  VEPS\sound\soundD1.bin
                even
SoundD2:        incbin  VEPS\sound\soundD2.bin
                even
SoundD3:        incbin  VEPS\sound\soundD3.bin
                even
SoundD4:        dc.w @0-SoundD4,$0101
                dc.w $8005,@1-SoundD4,$0004
@1:             dc.b $EF,$00,$B0,$06,$80,$06,$B0,$18,$F2
@0:             dc.b $38,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$00,$00,$00
                dc.b $00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$1F,$17,$0C,$00        ; 17-0C swapped


; FIX THESE!

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