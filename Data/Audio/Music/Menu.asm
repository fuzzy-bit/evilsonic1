Snd_music_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_music_Voices
	smpsHeaderChan      $07, $03
	smpsHeaderTempo     $80, $80

	smpsHeaderDAC       Snd_music_DAC
	smpsHeaderFM        Snd_music_FM1,	$00, $0C
	smpsHeaderFM        Snd_music_FM2,	$00, $1A
	smpsHeaderFM        Snd_music_FM3,	$00, $1A
	smpsHeaderFM        Snd_music_FM4,	$0C, $14
	smpsHeaderFM        Snd_music_FM5,	$00, $08
	smpsHeaderFM        Snd_music_FM6,	$00, $12
	smpsHeaderPSG       Snd_music_PSG1,	$E8, $06, $00, $0A
	smpsHeaderPSG       Snd_music_PSG2,	$E8, $06, $00, $0A
	smpsHeaderPSG       Snd_music_PSG3,	$00, $05, $00, $0A

; DAC Data
Snd_music_DAC:
	smpsStop

; FM1 Data
Snd_music_FM1:

;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $03, $02

;	dc.b	$FD, $00
;	dc.b	$FC, $00
;	dc.b	$F0, $0C, $01, $03, $02


;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $03, $02
	smpsSetvoice        $05
	smpsAlterNote       $03

Snd_music_Jump02:
	smpsCall            Snd_music_Call0D
	dc.b	nE5, $0C, $0C, $09, nEb5, nCs5, $06, nEb5, $18, nB4, nCs5, $0C
	dc.b	$0C, $09, nEb5, nE5, $06, nFs5, $18, $09, nAb5, nA5, $06, nB5
	dc.b	$18, nEb5, nE5, $24, nFs5, $06, nAb5, nA5, $18, $09, nB5, nCs6
	dc.b	$06, nEb6, $30
	smpsCall            Snd_music_Call0D
	dc.b	nE6, $18, nA6, $09, nAb6, nFs6, $06, nAb6, $18, $09, nA6, nB6
	dc.b	$06, nA6, $18, nCs6, nEb6, $24, nCs6, $06, nEb6, nE6, $09, nEb6
	dc.b	nCs6, $06, $09, nEb6, nE6, $06, nFs6, $09, nE6, nEb6, $06, $09
	dc.b	nE6, nFs6, $06, nG6, $18, $09, nD7, nC7, $06, nB6, $30
	smpsJump            Snd_music_Jump02

Snd_music_Call0D:
	dc.b	nAb4, $0C, nB4, nAb5, $09, nFs5, nE5, $06, nEb5, $0C, nB4, nAb5
	dc.b	$09, nEb5, nAb5, $06, nA5, $0C, nA5, $09, nB5, nA5, $06, nB5
	dc.b	nCs6, nEb6, $03, nCs6, nB5, nEb6, $03, nCs6, nB5, nEb6, nB5, nCs6
	dc.b	$0C, nEb6
	smpsLoop            $02, $02, Snd_music_Call0D
	smpsReturn

; FM2 Data
Snd_music_FM2:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $03, $02


;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $03, $02
	smpsSetvoice        $06
	smpsPan             panLeft, $00

Snd_music_Jump04:
	smpsCall            Snd_music_Call09
	smpsCall            Snd_music_Call0A
	smpsCall            Snd_music_Call0A
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0A
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0A
	smpsCall            Snd_music_Call09
	dc.b	nRst, $0C, nCs5, nCs5, $09, $03, nRst, $06, nCs5
	smpsCall            Snd_music_Call0C
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0A
	smpsCall            Snd_music_Call0B
	smpsCall            Snd_music_Call0B
	dc.b	nRst, $06, nD5, $09, $03, nRst, $06, nD5, $09, $03, nRst, $06
	dc.b	nD5, $06
	smpsCall            Snd_music_Call0C
	smpsJump            Snd_music_Jump04

Snd_music_Call09:
	smpsCall            Snd_music_Call0A
	smpsLoop            $01, $02, Snd_music_Call09
	smpsCall            Snd_music_Call0B
	dc.b	nRst, $06, nEb5, $09, $03, nRst, nEb5, nE5, $06, nE5, nEb5, nEb5
	smpsLoop            $02, $02, Snd_music_Call09
	smpsReturn

Snd_music_Call0A:
	dc.b	nRst, $06, nB4, $09, $03, nRst, $06, nB4, $09, $03, nRst, $06
	dc.b	nB4, $06
	smpsReturn

Snd_music_Call0B:
	dc.b	nRst, $06, nCs5, $09, $03, nRst, $06, nCs5, $09, $03, nRst, $06
	dc.b	nCs5, $06
	smpsReturn

Snd_music_Call0C:
	dc.b	nRst, $06, nEb5, $09, $03, nRst, $06, nEb5, $09, $03, nRst, $06
	dc.b	nEb5, $06
	smpsReturn

; FM3 Data
Snd_music_FM3:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $03, $02

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $03, $02
	smpsSetvoice        $06
	smpsPan             panRight, $00

Snd_music_Jump03:
	smpsCall            Snd_music_Call04
	smpsCall            Snd_music_Call05
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call05
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call07
	smpsCall            Snd_music_Call04
	dc.b	nRst, $0C, nA4, nA4, $09, $03, nRst, $06, nA4
	smpsCall            Snd_music_Call08
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call07
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call06
	smpsCall            Snd_music_Call08
	smpsCall            Snd_music_Call08
	smpsJump            Snd_music_Jump03

Snd_music_Call04:
	smpsCall            Snd_music_Call05
	smpsCall            Snd_music_Call06
	dc.b	nRst, $06, nB4, $09, $03, nRst, nB4, nA4, $06, nA4, nAb4, nAb4
	smpsLoop            $02, $02, Snd_music_Call04
	smpsReturn

Snd_music_Call05:
	dc.b	nRst, $06, nAb4, $09, $03, nRst, $06, nAb4, $09, $03, nRst, $06
	dc.b	nAb4, $06
	smpsLoop            $01, $02, Snd_music_Call05
	smpsReturn

Snd_music_Call06:
	dc.b	nRst, $06, nA4, $09, $03, nRst, $06, nA4, $09, $03, nRst, $06
	dc.b	nA4, $06
	smpsReturn

Snd_music_Call08:
	dc.b	nRst, $06, nB4, $09, $03, nRst, $06, nB4, $09, $03, nRst, $06
	dc.b	nB4, $06
	smpsReturn

Snd_music_Call07:
	dc.b	nRst, $06, nFs4, $09, $03, nRst, $06, nFs4, $09, $03, nRst, $06
	dc.b	nFs4, $06
	smpsReturn

; FM6 Data
Snd_music_FM6:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $03, $02

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $03, $02
	smpsSetvoice        $05
	dc.b	nRst, $08
	smpsAlterNote       $FD
	smpsJump            Snd_music_Jump02

; PSG1 Data
Snd_music_PSG1:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $01, $04

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $01, $04
	smpsPSGvoice        fTone_01

Snd_music_Jump07:
	smpsCall            Snd_music_Call0F
	dc.b	nB4, $09, nE5, $03, nRst, $06, nB4, $06, $09, $03, nRst, $06
	dc.b	nAb4, $06, nB4, $09, nEb5, $03, nRst, $06, nB4, $06, $09, $03
	dc.b	nRst, $06, nAb4, $06, nA4, $09, nCs5, $03, nRst, $06, nA4, $06
	dc.b	$09, $03, nRst, $06, nCs5, $06, nCs5, $09, $03, nRst, $06, nCs5
	dc.b	$06, $09, nEb5, nE5, $06, nEb5, $09, $03, nRst, $06, nEb5, $06
	dc.b	nB4, $09, $03, nRst, $06, nB4, $06, nCs5, $09, $03, nRst, $06
	dc.b	nCs5, $06, $09, $03, nEb5, $06, nE5, $06, nFs5, $09, $03, nRst
	dc.b	$06, nFs5, $06, nCs5, $09, $03, nRst, $06, nCs5, $06, nB4, $09
	dc.b	$03, nRst, $06, nB4, $06, nCs5, $03, nEb5, nE5, nFs5, nE5, nFs5
	dc.b	nAb5, nA5
	smpsCall            Snd_music_Call0F
	dc.b	nRst, $0C, nCs5, nE5, $09, nEb5, nCs5, $06, nEb5, $18, $09, nE5
	dc.b	$09, nFs5, $06, nE5, $18, nA4, nB4, $24, nA4, $06, nB4, nCs5
	dc.b	$09, nB4, nA4, $06, $09, nB4, nCs5, $06, nCs5, $09, nB4, nA4
	dc.b	$06, $09, nB4, nCs5, $06, nD5, $18, $09, nB5, nA5, $06, nAb5
	dc.b	$30
	smpsJump            Snd_music_Jump07

Snd_music_Call0F:
	dc.b	nAb4, $03, nB4, nE5, nAb5, nB4, nRst, $09, nE5, nE5, nE5, $06
	dc.b	nAb4, $03, nB4, nEb5, nAb5, nB4, nRst, $09, nEb5, nEb5, nEb5, $06
	dc.b	nA4, $03, nCs5, nE5, nA5, nCs5, nRst, $09, nE5, nE5, nE5, $06
	dc.b	nB5, $03, nA5, nFs5, nB5, nA5, nFs5, nEb6, nB5, nE5, $0C, nAb5
	smpsLoop            $02, $02, Snd_music_Call0F
	smpsReturn

; PSG2 Data
Snd_music_PSG2:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01
;	dc.b	$0C, $01, $01, $04

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

	smpsModSet          $0C, $01, $01, $04
	smpsPSGvoice        fTone_01

Snd_music_Jump06:
	smpsCall            Snd_music_Call0E
	dc.b	nAb4, $09, nB4, $03, nRst, $06, nAb4, $06, $09, $03, nRst, $06
	dc.b	nE4, $06, nAb4, $09, nB4, $03, nRst, $06, nAb4, $06, $09, $03
	dc.b	nRst, $06, nEb4, $06, nE4, $09, nA4, $03, nRst, $06, nE4, $06
	dc.b	$09, $03, nRst, $06, nA4, $06, nA4, $09, $03, nRst, $06, nA4
	dc.b	$06, $09, nB4, nCs5, $06, nB4, $09, $03, nRst, $06, nB4, $06
	dc.b	nAb4, $09, $03, nRst, $06, nAb4, $06, nAb4, $09, $03, nRst, $06
	dc.b	nAb4, $06, $09, $03, nB4, $06, nCs5, $06, nCs5, $09, $03, nRst
	dc.b	$06, nCs5, $06, nA4, $09, $03, nRst, $06, nA4, $06, nFs4, $09
	dc.b	$03, nRst, $06, nFs4, $06, nCs5, $03, nEb5, nE5, nFs5, nCs5, nEb5
	dc.b	nE5, nFs5
	smpsCall            Snd_music_Call0E
	dc.b	nRst, $0C, nA4, nCs5, $09, nB4, nA4, $06, nB4, $18, $09, nCs5
	dc.b	$09, nEb5, $06, nCs5, $18, nE4, nFs4, $24, nE4, $06, nFs4, nA4
	dc.b	$09, nAb4, nE4, $06, $09, nAb4, nA4, $06, nA4, $09, nAb4, nFs4
	dc.b	$06, $09, nAb4, nA4, $06, nB4, $18, $09, nG5, nF5, $06, nEb5
	dc.b	$30
	smpsJump            Snd_music_Jump06

Snd_music_Call0E:
	dc.b	nE4, $03, nAb4, nB4, nE5, nAb4, nRst, $09, nB4, nB4, nB4, $06
	dc.b	nEb4, $03, nAb4, nB4, nEb5, nAb4, nRst, $09, nB4, nB4, nB4, $06
	dc.b	nFs4, $03, nA4, nCs5, nE5, nA4, nRst, $09, nCs5, nCs5, nCs5, $06
	smpsPSGAlterVol     $02
	dc.b	nRst, $08, nB5, $03, nA5, nFs5, nB5, nA5, nFs5, $01
	smpsPSGAlterVol     $FE
	dc.b	nA4, $0C, nB4
	smpsLoop            $02, $02, Snd_music_Call0E
	smpsReturn

; FM4 Data
Snd_music_FM4:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop01

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

Snd_music_Jump01:
	smpsModSet          $0C, $01, $03, $02
	smpsSetvoice        $04
	smpsCall            Snd_music_Call03
	dc.b	nE1, $03, nFs1, nAb1, nE1, nRst, $0C, nE1, $06, $03, $06, $03
	dc.b	$06, nAb1, $03, nA1, nB1, nAb1, nRst, $0C, nAb1, $06, $03, $06
	dc.b	$03, $06, nA1, $03, nB1, nCs2, nA1, nRst, $0C, nA1, $06, $03
	dc.b	$06, $03, $06, nFs1, $03, nAb1, nA1, nFs1, nRst, $0C, nFs1, $18
	dc.b	nAb1, $03, nA1, nB1, nAb1, $09, $06, $09, nAb2, $09, nAb1, $06
	dc.b	nCs1, $03, nEb1, nE1, nCs2, $09, $06, $09, nCs3, $09, nCs2, $06
	dc.b	nFs1, $09, nFs2, $06, $03, nFs1, $03, $06, $03, nFs2, nFs1, $06
	dc.b	nFs2, $03, nFs1, $06, nB1, $30
	smpsCall            Snd_music_Call03
	smpsSetvoice        $03
	dc.b	nRst, $0C
	smpsSetvoice        $04
	dc.b	nA1, $0C, $06, nA2, $03, $03, nA1, $06, nA2, $03, $03

Snd_music_Loop02:
	dc.b	nAb1, $06, nAb2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop02

Snd_music_Loop03:
	dc.b	nFs1, $06, nFs2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop03

Snd_music_Loop04:
	dc.b	nB1, $06, nB2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop04

Snd_music_Loop05:
	dc.b	nA1, $06, nA2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop05

Snd_music_Loop06:
	dc.b	nFs1, $06, nFs2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop06
	smpsAlterPitch      $01
	smpsLoop            $01, $03, Snd_music_Loop06
	smpsAlterPitch      $FD
	smpsJump            Snd_music_Jump01

Snd_music_Call03:
	dc.b	nE1, $06, nE2, $03, $03
	smpsLoop            $02, $04, Snd_music_Call03

Snd_music_Loop08:
	dc.b	nAb1, $06, nAb2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop08

Snd_music_Loop09:
	dc.b	nA1, $06, nA2, $03, $03
	smpsLoop            $02, $04, Snd_music_Loop09
	dc.b	nB1, $06, nB2, $03, $03, nB1, $06, nB2, $03, $03, nA1, $06
	dc.b	nA2, nAb1, nAb2
	smpsLoop            $01, $02, Snd_music_Call03
	smpsReturn

; FM5 Data
Snd_music_FM5:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop00

;	smpsAlternameSMPS   $00
;	smpsAlternateSMPS   $00

Snd_music_Jump00:
;	dc.b	$4D, $16

	smpsCall            Snd_music_Call01
	smpsCall            Snd_music_Call00
	smpsCall            Snd_music_Call01
	smpsCall            Snd_music_Call02
	smpsJump            Snd_music_Jump00

Snd_music_Call01:
	smpsCall            Snd_music_Call10
	smpsCall            Snd_music_Call11
	smpsCall            Snd_music_Call10
	smpsCall            Snd_music_Call11
	smpsLoop            $02, $03, Snd_music_Call01
	smpsReturn

Snd_music_Call10:
	smpsModSet          $01, $01, $E2, $30
	smpsPan             panCenter, $00
	smpsSetvoice        $00
	dc.b	nA2, $06

	smpsModChange       $00			; ???

	smpsPan             panRight, $00
	smpsSetvoice        $01
	dc.b	nD6
	smpsReturn

Snd_music_Call11:

	smpsModChange       $00			; ???

	smpsPan             panCenter, $00
	smpsSetvoice        $02
	dc.b	nE2, $06

	smpsModChange       $00			; ???

	smpsPan             panLeft, $00
	smpsSetvoice        $01
	dc.b	nD6
	smpsReturn

Snd_music_Call00:
	smpsCall            Snd_music_Call10
	smpsCall            Snd_music_Call11

	smpsModChange       $00			; ???

	smpsPan             panCenter, $00
	smpsSetvoice        $02
	dc.b	nE2, $0C, $03
	smpsFMAlterVol      $04
	dc.b	$03, $03, $03
	smpsFMAlterVol      $FC
	smpsReturn

Snd_music_Call02:

	smpsModChange       $00			; ???

	smpsPan             panCenter, $00
	smpsSetvoice        $02
	dc.b	nE2, $03
	smpsFMAlterVol      $04
	dc.b	$03, $03, $03
	smpsFMAlterVol      $FC
	smpsLoop            $02, $04, Snd_music_Call02
	smpsReturn

; PSG3 Data
Snd_music_PSG3:
;	smpsAlternameSMPS   $00
;	smpsContinuousLoop  Snd_music_Loop07
;	smpsSetVol          $E8

	smpsPSGform         $E4

Snd_music_Jump05:
	smpsNoteFill        $02
	dc.b	nC3, $03
	smpsNoteFill        $01
	dc.b	$03, $03, $03
	smpsJump            Snd_music_Jump05

Snd_music_Voices:
;	Voice $00
;	$3D
;	$30, $71, $40, $01, 	$1E, $1E, $5E, $1E, 	$18, $10, $10, $10
;	$00, $11, $00, $11, 	$CF, $6F, $CF, $6F, 	$00, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $04, $07, $03
	smpsVcCoarseFreq    $01, $00, $01, $00
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1E, $1E, $1E, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $10, $10, $18
	smpsVcDecayRate2    $11, $00, $11, $00
	smpsVcDecayLevel    $06, $0C, $06, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

;	Voice $01
;	$22
;	$34, $14, $08, $1C, 	$1E, $1F, $1F, $1F, 	$13, $1F, $0B, $1D
;	$00, $00, $00, $0E, 	$1C, $1A, $1B, $19, 	$10, $02, $00, $81
	smpsVcAlgorithm     $02
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $01, $03
	smpsVcCoarseFreq    $0C, $08, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1D, $0B, $1F, $13
	smpsVcDecayRate2    $0E, $00, $00, $00
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $09, $0B, $0A, $0C
	smpsVcTotalLevel    $01, $00, $02, $10

;	Voice $02
;	$34
;	$55, $76, $20, $20, 	$1F, $1F, $1F, $1F, 	$02, $00, $10, $0A
;	$00, $0D, $0F, $12, 	$0F, $0F, $0F, $0C, 	$05, $80, $03, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $02, $07, $05
	smpsVcCoarseFreq    $00, $00, $06, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $10, $00, $02
	smpsVcDecayRate2    $12, $0F, $0D, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0C, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $03, $00, $05

;	Voice $03
;	$07
;	$01, $01, $01, $01, 	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F
;	$1F, $1F, $1F, $1F, 	$FF, $FF, $FF, $FF, 	$FF, $FF, $FF, $FF
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $00, $00, $00, $00
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $1F, $1F, $1F
	smpsVcDecayRate2    $1F, $1F, $1F, $1F
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $7F, $7F, $7F, $7F

;	Voice $04
;	$35
;	$70, $32, $20, $51, 	$1F, $1F, $1F, $1F, 	$01, $0C, $08, $06
;	$05, $10, $09, $09, 	$46, $8A, $7A, $7A, 	$12, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $02, $03, $07
	smpsVcCoarseFreq    $01, $00, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $08, $0C, $01
	smpsVcDecayRate2    $09, $09, $10, $05
	smpsVcDecayLevel    $07, $07, $08, $04
	smpsVcReleaseRate   $0A, $0A, $0A, $06
	smpsVcTotalLevel    $00, $00, $00, $12

;	Voice $05
;	$37
;	$32, $74, $0E, $40, 	$1F, $1F, $5F, $1F, 	$14, $14, $10, $14
;	$07, $0B, $15, $07, 	$27, $27, $F6, $27, 	$83, $80, $83, $83
	smpsVcAlgorithm     $07
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $00, $07, $03
	smpsVcCoarseFreq    $00, $0E, $04, $02
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $14, $10, $14, $14
	smpsVcDecayRate2    $07, $15, $0B, $07
	smpsVcDecayLevel    $02, $0F, $02, $02
	smpsVcReleaseRate   $07, $06, $07, $07
	smpsVcTotalLevel    $03, $03, $00, $03

;	Voice $06
;	$35
;	$73, $34, $06, $44, 	$1F, $14, $1F, $14, 	$03, $00, $00, $00
;	$05, $04, $05, $04, 	$C7, $77, $77, $77, 	$1E, $80, $82, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $00, $03, $07
	smpsVcCoarseFreq    $04, $06, $04, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $1F, $14, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $03
	smpsVcDecayRate2    $04, $05, $04, $05
	smpsVcDecayLevel    $07, $07, $07, $0C
	smpsVcReleaseRate   $07, $07, $07, $07
	smpsVcTotalLevel    $00, $02, $00, $1E

