; ---------------------------------------------------------------------------
; Sonic start location array
; ---------------------------------------------------------------------------

		incbin	"Data\Levels\StartPositions\ghz1.bin"
		incbin	"Data\Levels\StartPositions\ghz2.bin"
		incbin	"Data\Levels\StartPositions\ghz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\lz1.bin"
		incbin	"Data\Levels\StartPositions\lz2.bin"
		incbin	"Data\Levels\StartPositions\lz3.bin"
		incbin	"Data\Levels\StartPositions\sbz3.bin"

		incbin	"Data\Levels\StartPositions\mz1.bin"
		incbin	"Data\Levels\StartPositions\mz2.bin"
		incbin	"Data\Levels\StartPositions\mz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\slz1.bin"
		incbin	"Data\Levels\StartPositions\slz2.bin"
		incbin	"Data\Levels\StartPositions\slz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\syz1.bin"
		incbin	"Data\Levels\StartPositions\syz2.bin"
		incbin	"Data\Levels\StartPositions\syz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\sbz1.bin"
		incbin	"Data\Levels\StartPositions\sbz2.bin"
		incbin	"Data\Levels\StartPositions\fz.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\end1.bin"
		incbin	"Data\Levels\StartPositions\end2.bin"
		dc.w	$80,$A8
		dc.w	$80,$A8

		zonewarning StartLocArray,$10 ; Note:

		incbin	"Data\Levels\StartPositions\zone7.bin"
		dc.w	$80,$A8	; you said you didn't want to use the acts so i'm just making the one file
		dc.w	$80,$A8
		dc.w	$80,$A8
		even
