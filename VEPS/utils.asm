
; ---------------------------------------------------------------------------
; Subroutine to load the sound driver
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


SoundDriverLoad:                        ; XREF: GameClrRAM; TitleScreen
        move.w  #$100,d0
        move.w  d0,($A11100).l
        move.w  d0,($A11200).l
        lea     (MegaPCM).l,a0
        lea     ($A00000).l,a1
        move.w  #(MegaPCM_End-MegaPCM)-1,d1

@Load:  move.b  (a0)+,(a1)+
        dbf     d1,@Load
        moveq   #0,d1
        move.w  d1,($A11200).l
        nop
        nop
        nop
        nop
        move.w  d0,($A11200).l
        move.w  d1,($A11100).l
        rts
; End of function SoundDriverLoad


; ======================================================
; ------------------------------------------------------
; Subroutine to play sound
; ------------------------------------------------------

PlaySound:
PlaySound_Special:
        move.l  a1, -(sp)
        lea     SoundQueue, a1
        tst.b   (a1)+           ; slot 0 empty?
        beq.s   @AddToQueue     ; if yes, branch
        tst.b   (a1)+           ; slot 1 empty?
        beq.s   @AddToQueue     ; if yes, branch
        tst.b   (a1)+           ; slot 2 empty?
        beq.s   @AddToQueue     ; if yes, branch
        tst.b   (a1)+           ; slot 3 empty?
        bne.s   @Quit           ; if not, branch

@AddToQueue:
        move.b  d0, -(a1)

@Quit:
        move.l  (sp)+, a1
        rts
        
; ======================================================
; ------------------------------------------------------
; Subroutine to play DAC sample
; ------------------------------------------------------

PlaySample:
        stopZ80
        move.b  d0,$A01FFF
        startZ80
        rts

; ======================================================