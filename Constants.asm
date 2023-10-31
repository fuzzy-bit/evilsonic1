; ---------------------------------------------------------------------------
; Constants
; ---------------------------------------------------------------------------

Z80_Space =	$80C			; The amount of space reserved for Z80 driver. The compressor tool may ask you to increase the size...

; VDP addressses
vdp_data_port:		equ $C00000
vdp_control_port:	equ $C00004
vdp_counter:		equ $C00008
vdp_debug:			equ $C0001C

psg_input:		equ $C00011

; Z80 addresses
z80_ram:		equ $A00000	; start of Z80 RAM
z80_ram_end:		equ $A02000	; end of non-reserved Z80 RAM
z80_version:		equ $A10001
z80_port_1_data:	equ $A10002
z80_port_1_control:	equ $A10008
z80_port_2_control:	equ $A1000A
z80_expansion_control:	equ $A1000C
z80_bus_request:	equ $A11100
z80_reset:		equ $A11200
ym2612_a0:		equ $A04000
ym2612_d0:		equ $A04001
ym2612_a1:		equ $A04002
ym2612_d1:		equ $A04003

security_addr:		equ $A14000

; VRAM data
vram_fg:	equ $C000	; foreground namespace
vram_bg:	equ $E000	; background namespace
vram_sonic:	equ $F000	; Sonic graphics
vram_sprites:	equ $F800	; sprite table
vram_hscroll:	equ $FC00	; horizontal scroll table

; Game modes
id_Sega:	equ ptr_GM_Sega-GameModeArray	; $00
id_Title:	equ ptr_GM_Title-GameModeArray	; $04
id_Menu:	equ ptr_GM_Menu-GameModeArray	; $08
id_Demo:	equ ptr_GM_Demo-GameModeArray	; $0C
id_Level:	equ ptr_GM_Level-GameModeArray	; $10
id_Special:	equ ptr_GM_Special-GameModeArray; $14
id_Continue:	equ ptr_GM_Cont-GameModeArray	; $18
id_Ending:	equ ptr_GM_Ending-GameModeArray	; $1C
id_Credits:	equ ptr_GM_Credits-GameModeArray; $20
id_Endscreen:	equ ptr_GM_Endscreen-GameModeArray; $24

; Levels
id_GHZ:		equ 0
id_LZ:		equ 1
id_MZ:		equ 2
id_SLZ:		equ 3
id_SYZ:		equ 4
id_SBZ:		equ 5
id_EndZ:	equ 6
id_SS:		equ 7

; Colours
cBlack:		equ $000		; colour black
cWhite:		equ $EEE		; colour white
cBlue:		equ $E00		; colour blue
cGreen:		equ $0E0		; colour green
cRed:		equ $00E		; colour red
cYellow:	equ cGreen+cRed		; colour yellow
cAqua:		equ cGreen+cBlue	; colour aqua
cMagenta:	equ cBlue+cRed		; colour magenta

; Joypad input
btnStart:	equ %10000000 ; Start button	($80)
btnA:		equ %01000000 ; A		($40)
btnC:		equ %00100000 ; C		($20)
btnB:		equ %00010000 ; B		($10)
btnR:		equ %00001000 ; Right		($08)
btnL:		equ %00000100 ; Left		($04)
btnDn:		equ %00000010 ; Down		($02)
btnUp:		equ %00000001 ; Up		($01)
btnDir:		equ %00001111 ; Any direction	($0F)
btnABC:		equ %01110000 ; A, B or C	($70)
bitStart:	equ 7
bitA:		equ 6
bitC:		equ 5
bitB:		equ 4
bitR:		equ 3
bitL:		equ 2
bitDn:		equ 1
bitUp:		equ 0

; Object variables
obRender:	equ 1	; bitfield for x/y flip, display mode
obGfx:		equ 2	; palette line & VRAM setting (2 bytes)
obMap:		equ 4	; mappings address (4 bytes)
obX:		equ 8	; x-axis position (2-4 bytes)
obScreenY:	equ $A	; y-axis position for screen-fixed items (2 bytes)
obY:		equ $C	; y-axis position (2-4 bytes)
obVelX:		equ $10	; x-axis velocity (2 bytes)
obVelY:		equ $12	; y-axis velocity (2 bytes)
obInertia:	equ $14	; potential speed (2 bytes)
obHeight:	equ $16	; height/2
obWidth:	equ $17	; width/2
obPriority:	equ $18	; sprite stack priority -- 0 is front
obActWid:	equ $19	; action width
obFrame:	equ $1A	; current frame displayed
obAniFrame:	equ $1B	; current frame in animation script
obAnim:		equ $1C	; current animation
obNextAni:	equ $1D	; next animation
obTimeFrame:	equ $1E	; time to next frame
obDelayAni:	equ $1F	; time to delay animation
obColType:	equ $20	; collision response type
obColProp:	equ $21	; collision extra property
obStatus:	equ $22	; orientation or mode
obRespawnNo:	equ $23	; respawn list index number
obRoutine:	equ $24	; routine number
ob2ndRout:	equ $25	; secondary routine number
obAngle:	equ $26	; angle
obSubtype:	equ $28	; object subtype
obSolid:	equ ob2ndRout ; solid status flag

; Object variables used by Sonic
spindash_charger:	equ $2E	; spindash charge value
flashtime:	equ $30	; time between flashes after getting hit
invtime:	equ $32	; time left for invincibility
shoetime:	equ $34	; time left for speed shoes
deathtime:	equ	$39	; time before reseting the level after dying
f_spindash:	equ $39

; Object variables used by objects with DPLC support (Sonic, Spin Dust)
obDPLCFrame:	equ	$3A

; Object variables used by "DynamicObject"
obCodePtr:	equ	$3C	; code pointer (4 bytes)

; Object variables (Sonic 2 disassembly nomenclature)
render_flags:	equ 1	; bitfield for x/y flip, display mode
art_tile:	equ 2	; palette line & VRAM setting (2 bytes)
mappings:	equ 4	; mappings address (4 bytes)
x_pos:		equ 8	; x-axis position (2-4 bytes)
y_pos:		equ $C	; y-axis position (2-4 bytes)
x_vel:		equ $10	; x-axis velocity (2 bytes)
y_vel:		equ $12	; y-axis velocity (2 bytes)
y_radius:	equ $16	; height/2
x_radius:	equ $17	; width/2
priority:	equ $18	; sprite stack priority -- 0 is front
width_pixels:	equ $19	; action width
mapping_frame:	equ $1A	; current frame displayed
anim_frame:	equ $1B	; current frame in animation script
anim:		equ $1C	; current animation
next_anim:	equ $1D	; next animation
anim_frame_duration: equ $1E ; time to next frame
collision_flags: equ $20 ; collision response type
collision_property: equ $21 ; collision extra property
status:		equ $22	; orientation or mode
respawn_index:	equ $23	; respawn list index number
routine:	equ $24	; routine number
routine_secondary: equ $25 ; secondary routine number
angle:		equ $26	; angle
subtype:	equ $28	; object subtype

; Animation flags
afEnd:		equ $FF	; return to beginning of animation
afBack:		equ $FE	; go back (specified number) bytes
afChange:	equ $FD	; run specified animation
afRoutine:	equ $FC	; increment routine counter
afReset:	equ $FB	; reset animation and 2nd object routine counter
af2ndRoutine:	equ $FA	; increment 2nd routine counter

; ---------------------------------------------------------------
; Vladikcomper's global constants
; ---------------------------------------------------------------

; VRAM Offsets

_VRAM_PlaneA	equ	$C000
_VRAM_PlaneB	equ	$E000
_VRAM_BG	equ	$0020
_VRAM_BG_T	equ	(_VRAM_BG/$20)
_VRAM_Emer	equ	$0120
_VRAM_Emer_T	equ	(_VRAM_Emer/$20)
_VRAM_Font	equ	$840
_VRAM_Font_T	equ	(_VRAM_Font/$20)
_VRAM_CArt	equ	$4000
_VRAM_CArt_T	equ	(_VRAM_CArt/$20)

; VRAM flags

_pal0		equ	0	; palette select
_pal1		equ	1<<13	;
_pal2		equ	2<<13	;
_pal3		equ	3<<13	;
_pr		equ	$8000	; high priority flag
_fvh		equ	3<<11	; flip
_fv		equ	2<<11	;
_fh		equ	1<<11	;

; Joypads Setup

Held		equ	0
Press		equ	1

iStart		equ 	7
iA		equ 	6
iC		equ 	5
iB		equ 	4
iRight		equ 	3
iLeft		equ 	2
iDown		equ 	1
iUp		equ 	0

Start		equ 	1<<7
A		equ 	1<<6
C		equ 	1<<5
B		equ 	1<<4
Right		equ 	1<<3
Left		equ 	1<<2
Down		equ 	1<<1
Up		equ 	1

; ---------------------------------------------------------------
; SRAM Map
; ---------------------------------------------------------------
	rsset	0

Kino:               rs.w 4
ZoneSave:           rs.w 1
LivesSave:          rs.w 1
DifficultySave:     rs.w 1
SecretProgression:  rs.w 1
SecretEnabled:      rs.w 1
GameCompleted:      rs.w 1
ShakeDisabled:      rs.w 1
SRAMLength:         rs.w 0