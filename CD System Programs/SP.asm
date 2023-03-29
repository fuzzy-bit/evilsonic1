; -------------------------------------------------------------------------
; Kind of basic test plan setup program based on my 0.02 disassembly
; -------------------------------------------------------------------------

	include	"_Include/Common.i"
	include	"_Include/Sub CPU.i"
	include	"_Include/System.i"
	include	"_Include/Backup RAM.i"

; -------------------------------------------------------------------------
; Header
; -------------------------------------------------------------------------

	org	SPSTART
SPHeader:
	dc.b	'MAIN       ', 0
	dc.w	0, 0
	dc.l	0
	dc.l	SPEnd-SPHeader
	dc.l	SPHeaderOffsets-SPHeader
	dc.l	0

; -------------------------------------------------------------------------
; Offsets
; -------------------------------------------------------------------------

SPHeaderOffsets:
	dc.w	SPInit-SPHeaderOffsets		; Initialization
	dc.w	SPMain-SPHeaderOffsets		; Main
	dc.w	SPIRQ2_Hard-SPHeaderOffsets	; IRQ2
	dc.w	SPNull-SPHeaderOffsets		; Null
	dc.w	0

; -------------------------------------------------------------------------
; Initialization
; -------------------------------------------------------------------------

SPInit:
        lea     DriveInitParams(pc),a0
        move.w  #DRVINIT,d0         ; Initialize CD drive from BIOS
        jsr     _CDBIOS.w

WaitStatus:

        move.w  #CDBSTAT,d0
        jsr     _CDBIOS.w
        andi.b  #$F0,_CDSTAT.w
        bne.s   WaitStatus
        andi.b  #$FA,GAMEMMODE.w
        move.b  #0,GASUBFLAG.w
        move.w  #0,d0
        jsr     FileFunc.l

SPNull:
        rts

; -------------------------------------------------------------------------

DriveInitParams:
        dc.b    1, $FF

; -------------------------------------------------------------------------
; Main routine
; -------------------------------------------------------------------------

SPMain:
	move.w	#FFUNC_GETFILES,d0		; Get files
	jsr	    FileFunc.l

.Wait:
	jsr	_WAITVSYNC.w			; VSync

	move.w	#FFUNC_STATUS,d0	; Is the operation finished?
	jsr	FileFunc.l
	bcs.s	.Wait				; If not, wait

    cmpi.w  #FSTAT_OK,d0                   ; Was the operation a success?
    bne.w   Error                          ; If not, branch

; -------------------------------------------------------------------------
; System Program main command handler
; -------------------------------------------------------------------------

.WaitCommand:

        move.w  GACOMCMD0.w,d0       ; Pull a command from the MD
        beq.s   .WaitCommand
        add.w   d0,d0                ; Double it
        move.w  .SPCmd(pc,d0.w),d0   ; Use as a pointer into the table
        jsr     .SPCmd(pc,d0.w)
        move.l  #NullIRQ,_LEVEL3+2.w  ; Set interrupt to an empty one
        bra.s   .WaitCommand          ; Loop

; ---------------------------------------------------------------------------

.SPCmd:
        dc.w    SPNull-.SPCmd           ; Invalid
        dc.w    LoadIPX-.SPCmd          ; Load Initial program extension
        dc.w    LoadTitle-.SPCmd        ; Load Titlescreen
        dc.w    LoadEngine-.SPCmd       ; Load main game engine
        dc.w    LoadLevelDat-.SPCmd     ; Load level data

; ---------------------------------------------------------------------------
; Load IPX File into WordRAM
; ---------------------------------------------------------------------------

LoadIPX:
        lea     File_IPX(pc),a0
        bra.s   LoadIntoWordRAM

; ---------------------------------------------------------------------------
; Load Titlescreen File into WordRAM
; ---------------------------------------------------------------------------

LoadTitle:
        lea     File_TitleScreen(pc),a0
        bra.s   LoadIntoWordRAM

; ---------------------------------------------------------------------------
; Load Main game engine into WordRAM
; ---------------------------------------------------------------------------

LoadTitle:
        lea     File_Engine(pc),a0

        ; ...falls into Load Into WordRAM

; ---------------------------------------------------------------------------


LoadIntoWordRAM:
        bsr.w   Wait_GAMEMMODE.w
        lea     WORDRAM2M,a1
        jsr     LoadFile.w
        bra.w   WaitForCommand
        

LoadLevel:
        bsr.w   Wait_GAMEMMODE.w
        lea     WORDRAM2M,a1
        jsr     LoadFile.w
        bsr.w   CDDAVolumeReset
        bra.w   WaitForCommand

; ---------------------------------------------------------------------------
; Load level data
;
; Plan here is for LeveDataOffset to be somewhere in WORDRAM2M.
; We'll have to figure that out later on down the road when we get it to work
; ---------------------------------------------------------------------------

LoadLevelDat:
        move.w  GACOMCMD3, d0   ; Get level ID from gate array
        add.w   d0,d0
        add.w   d0,d0
        movea.l .LevelDataFiles(pc,d0.w),a0
        lea     LevelDataOffset,a1
        jsr     LoadFile.w
        bra.w   WaitForCommand

; ---------------------------------------------------------------------------

.LevelDataFiles:
        dc.l    File_LevelData1
        dc.l    File_LevelData2
        dc.l    File_LevelData3
        
; ---------------------------------------------------------------------------

CDDAVolumeReset:
        move.l  a0,-(sp)
        move.w  #FDRSET,d0
        move.w  #$400,d1
        jsr     _CDBIOS.w

        move.w  #FDRSET,d0
        move.w  #$8400,d1
        jsr     _CDBIOS.w

        movea.l (sp)+,a0
        rts

; ---------------------------------------------------------------------------
; Sends a command to the BIOS to play a CDDA track
; ---------------------------------------------------------------------------

PlayCDDA:
                bsr.w   CDDAVolumeReset
                move.w  #$13,d0
                jsr     _CDBIOS.w
                bra.w   SetStatus

; ---------------------------------------------------------------------------

SPIRQ2_Hard:
                movem.l d0-d7/a0-a6,-(sp)
                move.w  #1,d0
                jsr     FileFunc.l
                movem.l (sp)+,d0-d7/a0-a6
                rts

NullIRQ:
                rte


WaitForCommand:
                
                bset    #0,GAMEMMODE.w

SetStatus:
                move.w  GACOMCMD0.w,GACOMSTAT0.w

.Wait:
                tst.w   GACOMCMD0.w
                bne.s   .Wait
                move.w  #0,GACOMSTAT0.w
                rts

Wait_GAMEMMODE.w:
                btst    #1,GAMEMMODE.w
                beq.s   Wait_GAMEMMODE.w
                rts

; ---------------------------------------------------------------------------
; Error Trap infinite loop
; ---------------------------------------------------------------------------

Error:
                nop
                nop
                bra.s   Error

; -------------------------------------------------------------------------
; Load file
; -------------------------------------------------------------------------
; PARAMETERS:
;	a0.l - Pointer to file name
;	a1.l - File read destination buffer
; -------------------------------------------------------------------------

	ALIGN	LoadFile
	move.w	#FFUNC_LOADFILE,d0		; Start file loading
	jsr	FileFunc.l

.WaitFileLoad:
	move.w	#FFUNC_STATUS,d0		; Is the operation finished?
	jsr	FileFunc.l
	bcs.s	.WaitFileLoad			; If not, wait
	cmpi.w	#FSTAT_OK,d0			; Was the operation a success?
	bne.w	Error			        ; If not, crash
	rts

; -------------------------------------------------------------------------
; Get file name
; -------------------------------------------------------------------------
; PARAMETERS:
;	d0.w - File ID
; RETURNS:
;	a0.l - Pointer to file name
; -------------------------------------------------------------------------

	ALIGN	GetFileName
	mulu.w	#FILENAMESZ+1,d0		; Get file name pointer
	lea	FileTable,a0
	adda.w	d0,a0
	rts
; -------------------------------------------------------------------------
; File engine function
; -------------------------------------------------------------------------
; PARAMETERS:
;	d0.w - File engine function ID
; -------------------------------------------------------------------------

	ALIGN	FileFunc
	lea	FileVars,a5			; Perform function
	add.w	d0,d0
	move.w	.Functions(pc,d0.w),d0
	jsr	.Functions(pc,d0.w)
	rts

; -------------------------------------------------------------------------

.Functions:
	dc.w	FileFunc_EngineInit-.Functions	; Initialize engine
	dc.w	FileFunc_Operation-.Functions	; Perform operation
	dc.w	FileFunc_GetStatus-.Functions	; Get status
	dc.w	FileFunc_GetFiles-.Functions	; Get files
	dc.w	FileFunc_LoadFile-.Functions	; Load file
	dc.w	FileFunc_FindFile-.Functions	; Find file
	dc.w	FileFunc_LoadFMV-.Functions	; Load FMV
	dc.w	FileFunc_EngineReset-.Functions	; Reset engine

; -------------------------------------------------------------------------
; Get files
; -------------------------------------------------------------------------

FileFunc_GetFiles:
	move.w	#FMODE_GETFILES,feOperMode(a5)	; Set operation mode to "get files"
	move.b	#1<<FMVF_SECT,feFMV(a5)		; Mark as reading data section 1
	move.l	#0,feFMVFailCount(a5)		; Reset fail counter
	rts

; -------------------------------------------------------------------------
; Initialize file engine
; -------------------------------------------------------------------------

FileFunc_EngineInit:
	move.l	#FileOperation,feOperMark(a5)	; Reset operation bookmark
	move.w	#FMODE_NONE,feOperMode(a5)	; Set operation mode to "none"
	rts

; -------------------------------------------------------------------------
; Perform operation
; -------------------------------------------------------------------------

FileFunc_Operation:
	movea.l	feOperMark(a5),a0		; Go to operation bookmark
	jmp	(a0)

; -------------------------------------------------------------------------
; Handle file engine operation
; -------------------------------------------------------------------------

FileOperation:
	bsr.w	FileEngine_SetOperMark		; Set bookmark
	
	move.w	feOperMode(a5),d0		; Perform operation
	add.w	d0,d0
	move.w	.Opers(pc,d0.w),d0
	jmp	.Opers(pc,d0.w)

; -------------------------------------------------------------------------

.Opers:
	dc.w	FileOperation-.Opers		; None
	dc.w	FileEngine_GetFiles-.Opers	; Get files
	dc.w	FileEngine_LoadFile-.Opers	; Load file
	dc.w	FileEngine_LoadFMV-.Opers	; Load FMV

; -------------------------------------------------------------------------
; Set operation bookmark
; -------------------------------------------------------------------------

FileEngine_SetOperMark:
	move.l	(sp)+,feOperMark(a5)
	rts

; -------------------------------------------------------------------------
; "Get files" operation
; -------------------------------------------------------------------------

FileEngine_GetFiles:
	move.b	#3,feCDC(a5)			; Set CDC device to "Sub CPU"
	move.l	#$10,feSector(a5)		; Read from sector $10 (primary volume descriptor)
	move.l	#1,feSectorCnt(a5)		; Read 1 sector
	lea	feDirReadBuf(a5),a0		; Get read buffer
	move.l	a0,feReadBuffer(a5)
	bsr.w	ReadSectors			; Read sectors
	cmpi.w	#FSTAT_READFAIL,feStatus(a5)	; Was the operation a failure?
	beq.w	.Failed				; If so, branch

	lea	feDirReadBuf(a5),a1		; Primary volume descriptor buffer
	move.l	$A2(a1),feSector(a5)		; Get root directory sector
	move.l	$AA(a1),d0			; Get root directory size
	divu.w	#$800,d0			; Get size in sectors
	swap	d0
	tst.w	d0				; Is the size sector aligned?
	beq.s	.Aligned			; If so, branch
	addi.l	#1<<16,d0			; Align sector count

.Aligned:
	swap	d0				; Set sector count
	move.w	d0,feDirSectors(a5)
	clr.w	feFileCount(a5)			; Reset file count

.GetDirectory:
	move.l	#1,feSectorCnt(a5)		; Read 1 sector
	lea	feDirReadBuf(a5),a1		; Get read buffer
	move.l	a1,feReadBuffer(a5)
	bsr.w	ReadSectors			; Read sector of root directory
	cmpi.w	#FSTAT_READFAIL,feStatus(a5)	; Was the operation a failure?
	beq.w	.Failed				; If so, branch

	lea	feFileList(a5),a0		; Go to file list cursor
	move.w	feFileCount(a5),d0
	mulu.w	#FILEENTRYSZ,d0
	adda.l	d0,a0
	
	lea	feDirReadBuf(a5),a1		; Prepare to get file info
	moveq	#0,d0

.GetFileInfo:
	move.b	0(a1),d0			; Get file entry size
	beq.s	.NoMoreFiles			; If there are no more files left, branch
	move.b	$19(a1),fileFlags(a0)		; Get file flags
	
	moveq	#0,d1				; Prepare to get location and size

.GetFileLocSize:
	move.b	6(a1,d1.w),fileSector(a0,d1.w)	; Get file sector
	move.b	$E(a1,d1.w),fileLength(a0,d1.w)	; Get file size
	addq.w	#1,d1
	cmpi.w	#4,d1				; Are we done?
	blt.s	.GetFileLocSize			; If not, branch
	
	moveq	#0,d1				; Prepare to get file name

.GetFileName:
	move.b	$21(a1,d1.w),(a0,d1.w)		; Get file name
	addq.w	#1,d1
	cmp.b	$20(a1),d1			; Are we done?
	blt.s	.GetFileName			; If not, branch

.PadFileName:
	cmpi.b	#FILENAMESZ,d1			; Are we at the end of the file name?
	bge.s	.NextFile			; If so, branch
	move.b	#' ',(a0,d1.w)			; If not, pad out with spaces
	addq.w	#1,d1
	bra.s	.PadFileName			; Loop until done

.NextFile:
	addq.w	#1,feFileCount(a5)		; Increment fle count
	adda.l	d0,a1				; Prepare next file
	adda.l	#FILEENTRYSZ,a0
	bra.s	.GetFileInfo

.NoMoreFiles:
	subq.w	#1,feDirSectors(a5)		; Decrement directory sector count
	bne.w	.GetDirectory			; If there are sectors left, branch

	move.w	#FSTAT_OK,feStatus(a5)		; Mark operation as successful

.Done:
	move.w	#FMODE_NONE,feOperMode(a5)	; Set operation mode to "none"
	bra.w	FileOperation			; Loop back

.Failed:
	move.w	#FSTAT_GETFAIL,feStatus(a5)	; Mark operation as successful
	bra.s	.Done

; -------------------------------------------------------------------------
; "Load file" operation
; -------------------------------------------------------------------------

FileEngine_LoadFile:
	move.b	#3,feCDC(a5)			; Set CDC device to "Sub CPU"
	lea	feFileName(a5),a0		; Find file
	bsr.w	FileFunc_FindFile
	bcs.w	.FileNotFound			; If it wasn't found, branch
	
	move.l	fileSector(a0),feSector(a5)	; Get file sector
	move.l	fileLength(a0),d1		; Get file size
	move.l	d1,feFileSize(a5)

	move.l	#1,feSectorCnt(a5)		; Get file size in sectors

.GetSectors:
	subi.l	#$800,d1
	ble.s	.ReadFile
	addq.l	#1,feSectorCnt(a5)
	bra.s	.GetSectors

.ReadFile:
	bsr.w	ReadSectors			; Read file
	cmp.w	#FSTAT_OK,feStatus(a5)		; Was the operation a success?
	beq.s	.Done				; If so, branch
	move.w	#FSTAT_LOADFAIL,feStatus(a5)	; Mark as failed

.Done:
	move.w	#FMODE_NONE,feOperMode(a5)	; Set operation mode to "none"
	bra.w	FileOperation			; Loop back

.FileNotFound:
	move.w	#FSTAT_NOTFOUND,feStatus(a5)	; Mark as not found
	bra.s	.Done

; -------------------------------------------------------------------------
; Get file engine status
; -------------------------------------------------------------------------
; RETURNS:
;	d0.w  - Return code
;	d1.l  - File size if file load was successful
;	        Sectors read if file load failed
;	cc/cs - Inactive/Busy
; -------------------------------------------------------------------------

FileFunc_GetStatus:
	cmpi.w	#FMODE_NONE,feOperMode(a5)	; Is there an operation going on?
	bne.s	.Busy				; If so, branch
	
	move.w	feStatus(a5),d0			; Get status
	cmpi.w	#FSTAT_OK,d0			; Is the status marked as successful?
	bne.s	.Failed				; If not, branch
	move.l	feFileSize(a5),d1		; Return file size
	bra.s	.Inactive

.Failed:
	cmpi.w	#FSTAT_LOADFAIL,d0		; Is the status marked as a failed load?
	bne.s	.Inactive			; If not, branch
	move.w	feSectorsRead(a5),d1		; Return sectors read

.Inactive:
	move	#0,ccr				; Mark as inactive
	rts

.Busy:
	move	#1,ccr				; Mark as busy
	rts

; -------------------------------------------------------------------------
; Load a file
; -------------------------------------------------------------------------
; PARAMETERS:
;	a0.l - File name
;	a1.l - File read destination buffer
; -------------------------------------------------------------------------

FileFunc_LoadFile:
	move.w	#FMODE_LOADFILE,feOperMode(a5)	; Set operation mode to "load file"
	move.l	a1,feReadBuffer(a5)		; Set read buffer
	
	movea.l	a0,a1				; Copy file name
	lea	feFileName(a5),a2
	move.w	#FILENAMESZ-1,d1

.CopyFileName:
	move.b	(a1)+,(a2)+
	dbf	d1,.CopyFileName
	rts

; -------------------------------------------------------------------------
; Find a file
; -------------------------------------------------------------------------
; PARAMETERS
;	a0.l  - File name
; RETURNS:
;	a0.l  - Found file information
;	cc/cs - Found/Not found
; -------------------------------------------------------------------------

FileFunc_FindFile:
	move.l	a2,-(sp)			; Save a2
	moveq	#0,d1				; Prepare to find file
	movea.l	a0,a1
	move.w	#FILENAMESZ-1,d0

.GetNameLength:
	tst.b	(a1)				; Is this character a termination character?
	beq.s	.GotNameLength			; If so, branch
	cmpi.b	#';',(a1)			; Is this character a semicolon?
	beq.s	.GotNameLength			; If so, branch
	cmpi.b	#' ',(a1)			; Is this character a space?
	beq.s	.GotNameLength			; If so, branch

	addq.w	#1,d1				; Increment length
	addq.w	#1,a1				; Next character
	dbf	d0,.GetNameLength		; Loop until finished

.GotNameLength:
	move.w	feFileCount(a5),d0		; Prepare to scan file list
	movea.l	a0,a1
	lea	feFileList(a5),a0

	lea	.FirstFile(pc),a2		; Are we retrieving the first file?
	bsr.w	CompareStrings
	beq.w	.Done				; If so, branch

	movea.l	a0,a2				; Start scanning list
	subq.w	#1,d0

.FindFile:
	bsr.w	CompareStrings			; Is this file entry the one we are looking for?
	beq.s	.FileFound			; If so, branch
	adda.w	#FILEENTRYSZ,a2		; Go to next file
	dbf	d0,.FindFile			; Loop until file is found or until all files are scanned
	bra.s	.FileNotFound			; File not found

.FileFound:
	moveq	#1,d0				; Mark as found
	movea.l	a2,a0				; Get file entry

.Done:
	movea.l	(sp)+,a2			; Restore a2
	rts

.FileNotFound:
	move	#1,ccr				; Mark as not found
	bra.s	.Done

; -------------------------------------------------------------------------

.FirstFile:
	dc.b	"\          ", 0
	even

; -------------------------------------------------------------------------
; Read sectors from CD
; -------------------------------------------------------------------------

ReadSectors:
	move.l	(sp)+,feReturnAddr(a5)		; Save return address
	move.w	#0,feSectorsRead(a5)		; Reset sectors read count
	move.w	#10,feRetries(a5)		    ; Set retry counter

.StartRead:
	move.b	feCDC(a5),GACDCDEVICE&$FFFFFF	; Set CDC device
	
	lea	feSector(a5),a0			; Get sector information
	move.l	(a0),d0				; Get sector frame (in BCD)
	divu.w	#75,d0
	swap	d0
	ext.l	d0
	divu.w	#10,d0
	move.b	d0,d1
	lsl.b	#4,d1
	swap	d0
	move	#0,ccr
	abcd	d1,d0
	move.b	d0,feSectorFrame(a5)

	move.w	#ROMREADN,d0			; Start reading
	jsr	_CDBIOS.w
	move.w	#600,feWaitTime(a5)		; Set wait timer

.Bookmark:
	bsr.w	FileEngine_SetOperMark		; Set bookmark

.CheckReady:
	move.w	#CDCSTAT,d0			; Check if data is ready
	jsr	_CDBIOS.w
	bcc.s	.ReadData			; If so, branch
	subq.w	#1,feWaitTime(a5)		; Decrement wait time
	bge.s	.Bookmark			; If we are still waiting, branch
	subq.w	#1,feRetries(a5)		; If we waited too long, decrement retry counter
	bge.s	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.ReadData:
	move.w	#CDCREAD,d0			; Read data
	jsr	_CDBIOS.w
	bcs.w	.ReadRetry			; If the data isn't read, branch
	move.l	d0,feReadTime(a5)		; Get time of sector read
	move.b	feSectorFrame(a5),d0		; Does the read sector match the sector we want?
	cmp.b	feReadFrame(a5),d0
	beq.s	.WaitDataSet			; If so, branch

.ReadRetry:
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.WaitDataSet:
	move.w	#$800-1,d0			; Wait for data set

.WaitDataSetLoop:
	btst	#6,GACDCDEVICE&$FFFFFF
	dbne	d0,.WaitDataSetLoop		; Loop until ready or until it takes too long
	bne.s	.TransferData			; If the data is ready to be transfered, branch
	
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.TransferData:
	cmpi.b	#2,feCDC(a5)			; Is the CDC device set to "Main CPU"
	beq.w	.MainCPUTransfer		; If so, branch

	move.w	#CDCTRN,d0			; Transfer data
	movea.l	feReadBuffer(a5),a0
	lea	feReadTime(a5),a1
	jsr	_CDBIOS.w
	bcs.s	.CopyRetry			; If it wasn't successful, branch
	
	move.b	feSectorFrame(a5),d0		; Does the read sector match the sector we want?
	cmp.b	feReadFrame(a5),d0
	beq.s	.IncSectorFrame			; If so, branch

.CopyRetry:
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.IncSectorFrame:
	move	#0,ccr				; Next sector frame
	moveq	#1,d1
	abcd	d1,d0
	move.b	d0,feSectorFrame(a5)
	cmpi.b	#$75,feSectorFrame(a5)		; Should we wrap it?
	bcs.s	.FinishSectorRead		; If not, branch
	move.b	#0,feSectorFrame(a5)		; If so, wrap it

.FinishSectorRead:
	move.w	#CDCACK,d0			; Finish data read
	jsr	_CDBIOS.w

	move.w	#6,feWaitTime(a5)		; Set new wait time
	move.w	#10,feRetries(a5)		; Set new retry counter
	addi.l	#$800,feReadBuffer(a5)		; Advance read buffer
	addq.w	#1,feSectorsRead(a5)		; Increment sectors read counter
	addq.l	#1,feSector(a5)			; Next sector
	subq.l	#1,feSectorCnt(a5)		; Decrement sectors to read
	bgt.w	.CheckReady			; If there are still sectors to read, branch
	move.w	#FSTAT_OK,feStatus(a5)		; Mark as successful

.Done:
	move.b	feCDC(a5),GACDCDEVICE&$FFFFFF	; Set CDC device
	movea.l	feReturnAddr(a5),a0		; Go to saved return address
	jmp	(a0)

.ReadFailed:
	move.w	#FSTAT_READFAIL,feStatus(a5)	; Mark as failed
	bra.s	.Done

.MainCPUTransfer:
	move.w	#6,feWaitTime(a5)		; Set new wait time

.WaitMainCopy:
	bsr.w	FileEngine_SetOperMark		; Set bookmark
	btst	#7,GACDCDEVICE&$FFFFFF		; Has the data been transferred?
	bne.s	.FinishSectorRead		; If so, branch
	subq.w	#1,feWaitTime(a5)		; Decrement wait time
	bge.s	.WaitMainCopy			; If we are still waiting, branch
	bra.s	.ReadFailed			; If we have waited too long, branch

; -------------------------------------------------------------------------
; Compare two strings
; -------------------------------------------------------------------------
; PARAMETERS:
;	d1.w  - Number of characters to compare
;	a1.l  - Pointer to string 1
;	a2.l  - Pointer to string 2
; RETURNS:
;	eq/ne - Same/Different
; -------------------------------------------------------------------------

CompareStrings:
	movem.l	d1/a1-a2,-(sp)			; Save registers

.Compare:
	cmpm.b	(a1)+,(a2)+			; Compare characters
	bne.s	.Done				; If they aren't the same branch
	dbf	d1,.Compare			; Loop until all characters are scanned

	moveq	#0,d1				; Mark strings as the same

.Done:
	movem.l	(sp)+,d1/a1-a2			; Restore registers
	rts

; -------------------------------------------------------------------------
; Load an FMV
; -------------------------------------------------------------------------
; PARAMETERS:
;	a0.l - File name
; -------------------------------------------------------------------------

FileFunc_LoadFMV:
	move.w	#FMODE_LOADFMV,feOperMode(a5)	; Set operation mode to "load FMV"
	move.l	#FMVPCMBUF,feReadBuffer(a5)	; Prepare to read PCM data
	move.w	#0,feFMVSectFrame(a5)		; Reset FMV sector frame
	bset	#FMVF_SECT,feFMV(a5)		; Mark as reading data section 1

	movea.l	a0,a1				; Copy file name
	lea	feFileName(a5),a2
	move.w	#FILENAMESZ-1,d1

.CopyFileName:
	move.b	(a1)+,(a2)+
	dbf	d1,.CopyFileName
	rts

; -------------------------------------------------------------------------
; "Load FMV" operation
; -------------------------------------------------------------------------

FileEngine_LoadFMV:
	move.b	#3,feCDC(a5)			; Set CDC device to "Sub CPU"
	lea	feFileName(a5),a0		; Find file
	bsr.w	FileFunc_FindFile
	bcs.w	.FileNotFound			; If it wasn't found, branch
	
	move.l	fileSector(a0),feSector(a5)	; Get file sector
	move.l	fileLength(a0),d1		; Get file size
	move.l	d1,feFileSize(a5)

	move.l	#1,feSectorCnt(a5)		; Get file size in sectors

.GetSectors:
	subi.l	#$800,d1
	ble.s	.ReadFile
	addq.l	#1,feSectorCnt(a5)
	bra.s	.GetSectors

.ReadFile:
	bsr.w	ReadFMVSectors			; Read FMV file data
	cmp.w	#FSTAT_OK,feStatus(a5)		; Was the operation a success?
	beq.s	.Done				; If so, branch
	move.w	#FSTAT_LOADFAIL,feStatus(a5)	; Mark as failed

.Done:
	move.w	#FMODE_NONE,feOperMode(a5)	; Set operation mode to "none"
	bra.w	FileOperation			; Loop back

.FileNotFound:
	move.w	#FSTAT_NOTFOUND,feStatus(a5)	; Mark as not found
	bra.s	.Done

; -------------------------------------------------------------------------
; Read FMV file data from CD
; -------------------------------------------------------------------------

ReadFMVSectors:
	move.l	(sp)+,feReturnAddr(a5)		; Save return address
	move.w	#0,feSectorsRead(a5)		; Reset sectors read count
	move.w	#10,feRetries(a5)		; Set retry counter

.StartRead:
	move.b	feCDC(a5),GACDCDEVICE&$FFFFFF	; Set CDC device
	
	lea	feSector(a5),a0			; Get sector information
	move.l	(a0),d0				; Get sector frame (in BCD)
	divu.w	#75,d0
	swap	d0
	ext.l	d0
	divu.w	#10,d0
	move.b	d0,d1
	lsl.b	#4,d1
	swap	d0
	move	#0,ccr
	abcd	d1,d0
	move.b	d0,feSectorFrame(a5)

	move.w	#ROMREADN,d0			; Start reading
	jsr	_CDBIOS.w
	move.w	#600,feWaitTime(a5)		; Set wait timer

.Bookmark:
	bsr.w	FileEngine_SetOperMark		; Set bookmark

.CheckReady:
	move.w	#CDCSTAT,d0			; Check if data is ready
	jsr	_CDBIOS.w
	bcc.s	.ReadData			; If so, branch
	subq.w	#1,feWaitTime(a5)		; Decrement wait time
	bge.s	.Bookmark			; If we are still waiting, branch
	subq.w	#1,feRetries(a5)		; If we waited too long, decrement retry counter
	bge.s	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.ReadData:
	move.w	#CDCREAD,d0			; Read data
	jsr	_CDBIOS.w
	bcs.w	.ReadRetry			; If the data isn't read, branch
	move.l	d0,feReadTime(a5)		; Get time of sector read
	move.b	feSectorFrame(a5),d0		; Does the read sector match the sector we want?
	cmp.b	feReadFrame(a5),d0
	beq.s	.WaitDataSet			; If so, branch

.ReadRetry:
	addq.l	#1,feFMVFailCount(a5)		; Increment fail counter
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.WaitDataSet:
	move.w	#$800-1,d0			; Wait for data set

.WaitDataSetLoop:
	btst	#6,GACDCDEVICE&$FFFFFF
	dbne	d0,.WaitDataSetLoop		; Loop until ready or until it takes too long
	bne.s	.TransferData			; If the data is ready to be transfered, branch
	
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.TransferData:
	cmpi.b	#2,feCDC(a5)			; Is the CDC device set to "Main CPU"
	beq.w	.MainCPUTransfer		; If so, branch

	move.w	#CDCTRN,d0			; Transfer data
	movea.l	feReadBuffer(a5),a0
	lea	feReadTime(a5),a1
	jsr	_CDBIOS.w
	bcs.s	.CopyRetry			; If it wasn't successful, branch
	
	move.b	feSectorFrame(a5),d0		; Does the read sector match the sector we want?
	cmp.b	feReadFrame(a5),d0
	beq.s	.IncSectorFrame			; If so, branch

.CopyRetry:
	addq.l	#1,feFMVFailCount(a5)		; Increment fail counter
	subq.w	#1,feRetries(a5)		; Decrement retry counter
	bge.w	.StartRead			; If we can still retry, do it
	bra.w	.ReadFailed			; Give up

.IncSectorFrame:
	move	#0,ccr				; Next sector frame
	moveq	#1,d1
	abcd	d1,d0
	move.b	d0,feSectorFrame(a5)
	cmpi.b	#$75,feSectorFrame(a5)		; Should we wrap it?
	bcs.s	.FinishSectorRead		; If not, branch
	move.b	#0,feSectorFrame(a5)		; If so, wrap it

.FinishSectorRead:
	move.w	#CDCACK,d0			; Finish data read
	jsr	    _CDBIOS.w

	move.w	#6,feWaitTime(a5)		; Set new wait time
	move.w	#10,feRetries(a5)		; Set new retry counter
	
	move.w	feFMVSectFrame(a5),d0		; Get current sector frame
	cmpi.w	#15,d0				; Is it time to load graphics data now?
	beq.s	.PCMDone			; If so, branch
	cmpi.w	#74,d0				; Are we done loading graphics data?
	beq.s	.GfxDone			; If so, branch
	addi.l	#$800,feReadBuffer(a5)		; Advance read buffer
	bra.s	.Advance

.PCMDone:
	move.b	#FMVT_GFX,feFMVDataType	        ; Set graphics data type
	bclr	#FMVF_SECT,feFMV(a5)		; Mark as reading data section 2
	move.l	#FMVGFXBUF,feReadBuffer(a5)	; Set read buffer for graphics data
	bra.s	.Advance

.GfxDone:
	bset	#0,GASUBFLAG.w			; Sync with Main CPU

.WaitMain:
	btst	#0,GAMAINFLAG.w			; Wait for Main CPU
	beq.s	.WaitMain
	bclr	#0,GASUBFLAG.w
	
	eori.b  #1,GAMEMMODE.w

.WaitWordRAM:
	btst	#1,GAMEMMODE.w
	bne.s	.WaitWordRAM
	
	move.b	#FMVT_PCM,feFMVDataType  	; Set PCM data type
	move.l	#FMVPCMBUF,feReadBuffer(a5)	; Set read buffer for PCM data
	bset	#FMVF_SECT,feFMV(a5)		; Mark as reading data section 1
    bclr    #5,$1A03(a5)

.Advance:
	addq.w	#1,feSectorsRead(a5)		; Increment sectors read counter
	addq.l	#1,feSector(a5)			; Next sector
	addq.w	#1,feFMVSectFrame(a5)		; Increment FMV sector frame
	cmpi.w	#75,feFMVSectFrame(a5)		; Should we wrap it?
	bcs.s	.CheckSectorsLeft		; If not, branch
	move.w	#0,feFMVSectFrame(a5)		; If so, wrap it

.CheckSectorsLeft:
	subq.l	#1,feSectorCnt(a5)		; Decrement sectors to read
	bgt.w	.CheckReady			; If there are still sectors to read, branch
	move.w	#FSTAT_OK,feStatus(a5)		; Mark as successful

.Done:
	move.b	feCDC(a5),GACDCDEVICE&$FFFFFF	; Set CDC device
	movea.l	feReturnAddr(a5),a0		; Go to saved return address
	jmp	(a0)

.ReadFailed:
        move.w	#FSTAT_READFAIL,feStatus(a5)	; Mark as failed
	bra.s	.Done

.MainCPUTransfer:
	move.w	#6,feWaitTime(a5)		; Set new wait time

.WaitMainCopy:
	bsr.w	FileEngine_SetOperMark		; Set bookmark
	btst	#7,GACDCDEVICE&$FFFFFF		; Has the data been transferred?
	bne.w	.FinishSectorRead		; If so, branch
	subq.w	#1,feWaitTime(a5)		; Decrement wait time
	bge.s	.WaitMainCopy			; If we are still waiting, branch
	bra.s	.ReadFailed			; If we have waited too long, branch


FileFunc_EngineReset:

        move.w  #0,$1C(a5)
        bra.w   FileOperation

; -------------------------------------------------------------------------
; Files
; -------------------------------------------------------------------------

FileTable:
    include   "CD System Programs/File list.asm"

; -------------------------------------------------------------------------
SPEnd:

