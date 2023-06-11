; ============================================================================================
; Sega Screen example - This code only works as a replacement for the SEGA screen
; For regular Splash screens, read the guide this code comes with!
; 2014, Hitaxas
; Ported to Sonic 1 2005 Hivebrain Thanks to ProjectFM
; ============================================================================================
TextReader: ; Stop previous music, clear vram and screen to set up this new screen
    move.b  #mus_stop,d0            ; set music ID to stop
    jsr    PlaySound_Special        ; play music ID
    jsr    PaletteFadeOut           ; fade palette out
	lea		(vdp_data_port).l,a6
	move.w	#$8004,4(a6)	; 8-colour mode
	move.w	#$8200+(vram_fg>>10),4(a6) ; set foreground nametable address
	move.w	#$8400+(vram_bg>>13),4(a6) ; set background nametable address
	move.w	#$9001,4(a6)				; 64-cell hscroll size
	move.w	#$9200,4(a6)				; window vertical position
	move.w	#$8B03,4(a6)				
	move.w	#$8720,4(a6)				; set background colour (palette line 2, entry 0)	
    disable_ints	
    move.w (v_vdp_buffer1).w,d0     ; load VDP register 81XX data
    andi.b #%10111111,d0            ; set display to "disable"
    move.w d0,4(a6)  				; save to VDP
    jsr    ClearPLC                 ; clear pattern load cues
    jsr    ClearScreen              ; clear VRAM planes, sprite buffer and scroll buffer
    ; lea    ($FF0000).l,a1           ; load dump location
    ; lea    MAPS_SEGA.l,a0           ; load compressed mappings address
    ; move.w #320,d0                  ; prepare pattern index value to patch to mappings
    ; jsr    EniDec.w                 ; decompress and dump
    ; move.l #$60000003,d0            ; prepare VRAM write mode address (Plane B E000)
    ; moveq  #$28-$01,d1              ; set map box draw width
    ; moveq  #$1E-$01,d2              ; set map box draw height
    ; bsr.w  ShowVDPGraphics          ; flush mappings to VRAM
	; lea    (vdp_control_port).l,a6    ; load VDP control port
    ; move.l #$68000000,(a6)          ; set VDP to VRAM write mode (Address 2800)
    ; lea    ART_SEGA.l,a0            ; load compressed art address
    ; jsr    NemDec.w                 ; decompress and dump to VDP memory
	
; Get text graphics
	move.l	#$50000003,4(a6)		; set VRAM write address	
	lea	(Art_Font).l,a5				; fetch the text graphics
	moveq	#0,d1
	move.w	#Art_FontEnd-Art_Font-1,d1		; amount of data to be loaded

TextReader_LoadText:
	move.w	(a5)+,(a6)				; load the text
	dbf	d1,TextReader_LoadText 		; repeat until done	
	
    lea    Pal_TextReader.l,a0      ; load palette address
    lea    (v_pal_dry_dup).w,a1         ; load palette buffer address
    moveq  #$F,d0                   ; set repeat times
 
TextReader_PalLoop:
    move.l (a0)+,(a1)+              ; copy colours to buffer
    move.l (a0)+,(a1)+              ; ''
    dbf    d0,TextReader_PalLoop    ; repeat until done
	
    move.w (v_vdp_buffer1).w,d0     ; load VDP register 81XX data
    ori.b  #%01000000,d0            ; set display to "enable"
    move.w d0,4(a6)                  ; save to VDP

; Initialize all text strings
	bsr.w  TextReader_Test
	
    jsr    PaletteFadeIn            ; fade palette in
;   move.w #3*60,($FFFFF614).w      ; set delay time (3 seconds on a 60hz system)
 
TextReader_MainLoop:
    move.b #6,(v_vbla_routine).w    ; set V-blank routine to run
    jsr    WaitForVBla           	; wait for V-blank (decreases "Demo_Time_left")
    tst.b  (v_jpadpress1).w            ; has player 1 pressed start button?
    bpl.s  TextReader_MainLoop            ; if not, branch
 
TextReader_GotoTitle:
    move.b #id_Title,(v_gamemode).w       ; set the screen mode to Title Screen
    rts                             ; return   
	
TextReader_Test:
	moveq	#0,d1
	lea		(TextData_Test).l,a1	; Find text
	lea		(vdp_data_port).l,a6			; point to VDP
	move.l	#$41040003,4(a6)	; position of first line on screen
	move.w	#$A680,d3			; which palette the font should use and where it is in VRAM
	moveq	#24,d2		; number of characters to be rendered in a line -1	
	bra.w	SingleLineRender	
; ===========================================================================

TextData_Test:
	dc.b	"THIS IS A TEST. FUCK YOU."
	even