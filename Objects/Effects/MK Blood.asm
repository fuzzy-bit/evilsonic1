; ---------------------------------------------------------------------------
; Mortal Kombat Blood
; ---------------------------------------------------------------------------
MKBlood:
                moveq   #0,d0
                move.b  $24(a0),d0
                move.w  @Index(pc,d0.w),d0
                jsr     @Index(pc,d0.w)
				
				tst.b 	@ControlDPLC(a0)
				bne.s	@NoUpdate

                lea     (Anim_MKBlood).l,a1
				jsr 	MKBlood_LoadGFX
                jsr     AnimateSprite
				jsr 	UpdateDPLC
                jmp     DisplaySprite

@NoUpdate:
                jsr     AnimateSprite
                jmp     DisplaySprite


@ControlDPLC:		equ $30

; ---------------------------------------------------------------------------
@Index:     
				dc.w @Main-@Index
				dc.w @CheckDown-@Index
                dc.w @CheckFall-@Index

@Main:
				addq.b	#2,$24(a0)
                move.w  #$8580,2(a0)				; VRAM art data		
                move.l  #Map_Blood,4(a0)			; the mappings
                ori.b	#%00000100,1(a0)			; object is placed on playfield
				
@CheckDown:
				tst.b	$12(a0)
				bmi.s	@Return
				move.b	#$1,$1C(a0)

@CheckFall:		; used by blood
				btst	#7,1(a0)
				beq.s	@Delete
				
@Return:	
                jmp     ObjectFall	

@Delete:
				addq	#4,sp
				jmp		DeleteObject
; ---------------------------------------------------------------------------

		include	"Data\Mappings\Objects\Blood\MortalKombat.asm"
		even
		include	"Data\Animations\Blood\MortalKombat.asm"
		even
Art_MKBlood:		
		incbin "Data\Art\Uncompressed\Blood\MortalKombat.bin"
		even
		include "Data\DPLCs\Blood\MortalKombat.asm"

; ---------------------------------------------------------------------------
; Subroutine to create the blood object and handle it
; ---------------------------------------------------------------------------


CreateMKBlood:
                lea     @BloodLUT(pc), a2			; load lookup table
                moveq	#11, d1						; number of values to be read -1
				move.b 	#1, d2						; flag for if the object should update the DPLC

@Loop1:
				jsr     FindFreeObj					; gee i wonder what this does
                bne.s   @Return						; oh noes the object didn't load so sad :(
                move.b  #id_MKBlood, (a1)			; load object into a1
                move.w  obX(a0), obX(a1)			; xpos of item
                move.w  obY(a0), obY(a1)			; ypos of item
				move.b 	d2,	$30(a1)					; move DPLC update flag
				move.b 	#0, d2						; unset d2

                move.l  (a2)+, $10(a1)				; get all speed data
				bpl.s   @NoFlip						; if speed is positive, branch   
				bset    #0, $22(a1)					; else, flip X orientation

@NoFlip:       
                dbf     d1, @Loop1 ; create next object

@Return:
                rts

; ---------------------------------------------------------------------------
@BloodLUT:
				;    x-spd	y-spd
				dc.w $0100, $F800
				dc.w $FF00, $F800
				dc.w $0140, $F880 
				dc.w $FEC0, $F880 
				dc.w $0180, $F900 
				dc.w $FE80, $F900 
				dc.w $01C0, $F980
				dc.w $FE40, $F980 
				dc.w $00C0, $FA00
				dc.w $FF40, $FA00
				dc.w $0120, $FB00
				dc.w $FEE0, $FB00