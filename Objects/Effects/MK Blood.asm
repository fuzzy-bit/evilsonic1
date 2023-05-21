; =============== S U B R O U T I N E =======================================


MKBlood:
                moveq   #0,d0
                move.b  $24(a0),d0
                move.w  bloodshow_index(pc,d0.w),d0
                jsr     bloodshow_index(pc,d0.w)
                lea     (Anim_MKBlood).l,a1
                jsr     AnimateSprite
				jsr 	MKBlood_LoadGFX
                jmp     DisplaySprite

; ---------------------------------------------------------------------------
bloodshow_index:     
				dc.w bloodshow_main-bloodshow_index
				dc.w bloodshow_chkdown-bloodshow_index
                dc.w bloodshow_checkfall_checkremove-bloodshow_index

bloodshow_main:
				addq.b	#2,$24(a0)
                move.w  #$8580,2(a0)				; VRAM art data		
                move.l  #Map_Blood,4(a0)			; the mappings
                ori.b	#%00000100,1(a0)			; object is placed on playfield
				
bloodshow_chkdown:
				tst.b	$12(a0)
				bmi.s	bloodshow_locret
				move.b	#$1,$1C(a0)

bloodshow_checkfall_checkremove:		; used by blood
				btst	#7,1(a0)
				beq.s	bloodshow_delete
				
bloodshow_locret:	
                jmp     ObjectFall	

bloodshow_delete:
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
                lea     @BloodLUT(pc),a2			; lookup table
                moveq	#11,d1						; number of values to be read -1

@Loop1:
				jsr     FindFreeObj					; gee i wonder what this does
                bne.s   @Return						; oh noes the object didn't load so sad :(
                move.b  #id_MKBlood,(a1)			; load object into a1
                move.w  8(a0),8(a1)					; xpos of item
                move.w  $C(a0),$C(a1)				; ypos of item
                move.l  (a2)+,$10(a1)				; get all speed data
				bpl.s   @NoFlip						; if speed is positive, branch   
				bset    #0,$22(a1)					; else, flip X orientation

@NoFlip:       
                dbf     d1,@Loop1 ; create next object

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