; ---------------------------------------------------------------
; CIS Screen
; ---------------------------------------------------------------
CISSplash:
		jsr    PaletteFadeOut
		jsr    ClearScreen
		
		lea     $FFFF0000, a0
		move.l  #(($FFFF/2)/4)-1, d0
		moveq   #0, d1

@ClearRAM:
		move.l  d1, (a0)+
		dbra    d0, @ClearRAM

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

		lea	(vdp_control_port).l, a6
        move.w  #$8004,(a6)
        move.w  #$8230,(a6)
        move.w  #$8407,(a6)
        move.w  #$8700,(a6)
        move.w  #$8C81,(a6)
        move.w  #$9001,(a6)
        move.w  #$8B00,(a6)
		
        music  	mus_stop
        move.w  #$5A0, (v_demolength).w
        
        ; Art
        locVRAM $0
        lea     @Art, a0
        jsr     NemDec

        ; Mappings
		lea    ($FF0000), a1
		lea    @Mappings, a0
        move.w #0, d0
		move.w #$7FF, d1
		jsr    EniDec
        
        move.l  #$40000003, d0
        moveq   #39, d1
        moveq   #30, d2
        jsr     TilemapToVRAM

        ; Palette
		lea 	@Palette, a0
		lea 	($FFFFFB80), a1
		move.w  #$1F, d0

        music   mus_cis

@PaletteLoop:
		move.l  (a0)+, (a1)+
		dbf 	d0, @PaletteLoop

		jsr 	PaletteFadeIn

@Loop:
        move.b  #2, (v_vbla_routine).w
        jsr     WaitForVBla

        tst.b   (v_jpadpress1).w
        bmi.s   @Exit
        
        tst.w   (v_demolength).w
        bne.s   @Loop

@Exit:
		move.b	#id_Level,(v_gamemode).w ; set screen mode to $0C (level)
        jmp     MainGameLoop

@Art: incbin "Data/Art/Nemesis/CIS.bin"
	even
@Mappings: incbin "Data/Mappings/TileMaps/CIS.bin"
	even
@Palette: incbin "Data/Palette/Misc/CIS.bin"
	even