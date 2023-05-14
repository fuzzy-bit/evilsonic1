; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------
Ani_Sonic:

ptr_Walk:	dc.w SonAni_Walk-Ani_Sonic
ptr_Run:	dc.w SonAni_Run-Ani_Sonic
ptr_Roll:	dc.w SonAni_Roll-Ani_Sonic
ptr_Roll2:	dc.w SonAni_Roll2-Ani_Sonic
ptr_Push:	dc.w SonAni_Push-Ani_Sonic
ptr_Wait:	dc.w SonAni_Wait-Ani_Sonic
ptr_Balance:	dc.w SonAni_Balance-Ani_Sonic
ptr_LookUp:	dc.w SonAni_LookUp-Ani_Sonic
ptr_Duck:	dc.w SonAni_Duck-Ani_Sonic
ptr_Warp1:	dc.w SonAni_Warp1-Ani_Sonic
ptr_Warp2:	dc.w SonAni_Warp2-Ani_Sonic
ptr_Warp3:	dc.w SonAni_Warp3-Ani_Sonic
ptr_Warp4:	dc.w SonAni_Warp4-Ani_Sonic
ptr_Stop:	dc.w SonAni_Stop-Ani_Sonic
ptr_Float1:	dc.w SonAni_Float1-Ani_Sonic
ptr_Float2:	dc.w SonAni_Float2-Ani_Sonic
ptr_Spring:	dc.w SonAni_Spring-Ani_Sonic
ptr_Hang:	dc.w SonAni_Hang-Ani_Sonic
ptr_Leap1:	dc.w SonAni_Leap1-Ani_Sonic
ptr_Leap2:	dc.w SonAni_Leap2-Ani_Sonic
ptr_Surf:	dc.w SonAni_Surf-Ani_Sonic
ptr_GetAir:	dc.w SonAni_GetAir-Ani_Sonic
ptr_Burnt:	dc.w SonAni_Burnt-Ani_Sonic
ptr_Drown:	dc.w SonAni_Drown-Ani_Sonic
ptr_Death:	dc.w SonAni_Death-Ani_Sonic
ptr_Shrink:	dc.w SonAni_Shrink-Ani_Sonic
ptr_Hurt:	dc.w SonAni_Hurt-Ani_Sonic
ptr_WaterSlide:	dc.w SonAni_WaterSlide-Ani_Sonic
ptr_Null:	dc.w SonAni_Null-Ani_Sonic
ptr_Float3:	dc.w SonAni_Float3-Ani_Sonic
ptr_Float4:	dc.w SonAni_Float4-Ani_Sonic
ptr_SpinDash:	dc.w	SonAni_SpinDash-Ani_Sonic

SonAni_Walk:	dc.b $FF,   7,   8,   1,   2,   3,   4,   5,   6, $FF
		even
SonAni_Run:		dc.b $FF, $21, $22, $23, $24, $FF, $FF, $FF, $FF, $FF
		even
SonAni_Roll:	dc.b $FE, $96, $97, $96, $98, $96, $99, $96, $9A, $FF
		even
SonAni_Roll2:	dc.b $FE, $96, $97, $96, $98, $96, $99, $96, $9A, $FF
		even
SonAni_Push:	dc.b $FD, $B6, $B7, $B8, $B9, $FF, $FF, $FF, $FF, $FF
		even
SonAni_Wait:	dc.b 5, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA
				dc.b  $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA
				dc.b  $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA
				dc.b  $BA, $BA, $BA, $BB, $BC, $BC, $BD, $BD, $BE, $BE, $BD, $BD, $BE, $BE, $BD, $BD
				dc.b  $BE, $BE, $BD, $BD, $BE, $BE, $BD, $BD, $BE, $BE, $BD, $BD, $BE, $BE, $BD, $BD
				dc.b  $BE, $BE, $BD, $BD, $BE, $BE, $AD, $AD, $AD, $AD, $AD, $AD, $AE, $AE, $AE, $AE
				dc.b  $AE, $AE, $AF, $D9, $D9, $D9, $D9, $D9, $D9, $AF, $AF, $FE, $35
		even
SonAni_Balance:	dc.b 7, $A4, $A5, $A6, $FF
		even
SonAni_LookUp:	dc.b 5, $C3, $C4, $FE,   1
		even
SonAni_Duck:	dc.b 5, $9B, $9C, $FE,   1
		even
SonAni_Warp1:	dc.b $3F, $33, afEnd
		even
SonAni_Warp2:	dc.b $3F, $34, afEnd
		even
SonAni_Warp3:	dc.b $3F, $35, afEnd
		even
SonAni_Warp4:	dc.b $3F, $36, afEnd
		even
SonAni_Stop:	dc.b 3, $9D, $9E, $9F, $A0, $FD,   0
		even
SonAni_Float1:	dc.b 7, $C8, $FF
		even
SonAni_Float2:	dc.b 7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF, $FF
		even
SonAni_Spring:	dc.b $2F, $8E, $FD,   0
		even
SonAni_Hang:	dc.b 1, $AA, $AB, $FF
		even
SonAni_Leap1:	dc.b $F, $43, $43, $43, $FE,   1
		even
SonAni_Leap2:	dc.b 7, $B0, $B2, $B2, $B2, $B2, $B2, $B2, $B1, $B2, $B3, $B2, $FE,   4
		even
SonAni_Surf:	dc.b $3F, $49, afEnd
		even
SonAni_GetAir:	dc.b $B, $AC, $AC,   3,   4, $FD,   0
		even
SonAni_Burnt:	dc.b $20, $A8, $FF
		even
SonAni_Drown:	dc.b $20, $A9, $FF
		even
SonAni_Death:	dc.b $20, $A7, $FF
		even
SonAni_Shrink:	dc.b 3,	$4E, $4F, $50, $51, $52, 0, afBack, 1
		even
SonAni_Hurt:	dc.b $40, $8D, $FF
		even
SonAni_WaterSlide:
				dc.b 9, $8C, $8D, $FF
		even
SonAni_Null:	dc.b $77,   0, $FF
		even
SonAni_Float3:	dc.b 3,	$C8, $CA, $CC, $CD, $CF, afEnd
		even
SonAni_Float4:	dc.b 3,	$C8, afChange, id_Walk
		even
SonAni_SpinDash: dc.b 0, $86, $87, $86, $88, $86, $89, $86, $8A, $86, $8B, afEnd
		even

id_Walk:	equ (ptr_Walk-Ani_Sonic)/2	; 0
id_Run:		equ (ptr_Run-Ani_Sonic)/2	; 1
id_Roll:	equ (ptr_Roll-Ani_Sonic)/2	; 2
id_Roll2:	equ (ptr_Roll2-Ani_Sonic)/2	; 3
id_Push:	equ (ptr_Push-Ani_Sonic)/2	; 4
id_Wait:	equ (ptr_Wait-Ani_Sonic)/2	; 5
id_Balance:	equ (ptr_Balance-Ani_Sonic)/2	; 6
id_LookUp:	equ (ptr_LookUp-Ani_Sonic)/2	; 7
id_Duck:	equ (ptr_Duck-Ani_Sonic)/2	; 8
id_Warp1:	equ (ptr_Warp1-Ani_Sonic)/2	; 9
id_Warp2:	equ (ptr_Warp2-Ani_Sonic)/2	; $A
id_Warp3:	equ (ptr_Warp3-Ani_Sonic)/2	; $B
id_Warp4:	equ (ptr_Warp4-Ani_Sonic)/2	; $C
id_Stop:	equ (ptr_Stop-Ani_Sonic)/2	; $D
id_Float1:	equ (ptr_Float1-Ani_Sonic)/2	; $E
id_Float2:	equ (ptr_Float2-Ani_Sonic)/2	; $F
id_Spring:	equ (ptr_Spring-Ani_Sonic)/2	; $10
id_Hang:	equ (ptr_Hang-Ani_Sonic)/2	; $11
id_Leap1:	equ (ptr_Leap1-Ani_Sonic)/2	; $12
id_Leap2:	equ (ptr_Leap2-Ani_Sonic)/2	; $13
id_Surf:	equ (ptr_Surf-Ani_Sonic)/2	; $14
id_GetAir:	equ (ptr_GetAir-Ani_Sonic)/2	; $15
id_Burnt:	equ (ptr_Burnt-Ani_Sonic)/2	; $16
id_Drown:	equ (ptr_Drown-Ani_Sonic)/2	; $17
id_Death:	equ (ptr_Death-Ani_Sonic)/2	; $18
id_Shrink:	equ (ptr_Shrink-Ani_Sonic)/2	; $19
id_Hurt:	equ (ptr_Hurt-Ani_Sonic)/2	; $1A
id_WaterSlide:	equ (ptr_WaterSlide-Ani_Sonic)/2 ; $1B
id_Null:	equ (ptr_Null-Ani_Sonic)/2	; $1C
id_Float3:	equ (ptr_Float3-Ani_Sonic)/2	; $1D
id_Float4:	equ (ptr_Float4-Ani_Sonic)/2	; $1E
id_Spindash:	equ (ptr_SpinDash-Ani_Sonic)/2	; $1F