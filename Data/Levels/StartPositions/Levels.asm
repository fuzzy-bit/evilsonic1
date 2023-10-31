; ---------------------------------------------------------------------------
; Sonic start location array
; ---------------------------------------------------------------------------

		incbin	"Data\Levels\StartPositions\Levels\ghz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\ghz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\ghz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\Levels\lz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\lz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\lz3.bin"
		incbin	"Data\Levels\StartPositions\Levels\sbz3.bin"

		incbin	"Data\Levels\StartPositions\Levels\mz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\mz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\mz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\Levels\slz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\slz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\slz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\Levels\syz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\syz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\syz3.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\Levels\sbz1.bin"
		incbin	"Data\Levels\StartPositions\Levels\sbz2.bin"
		incbin	"Data\Levels\StartPositions\Levels\fz.bin"
		dc.w	$80,$A8

		incbin	"Data\Levels\StartPositions\Levels\end1.bin"
		incbin	"Data\Levels\StartPositions\Levels\end2.bin"
		dc.w	$80,$A8
		dc.w	$80,$A8

		zonewarning StartLocArray,$10 ; Note:

		incbin	"Data\Levels\StartPositions\Levels\zone7.bin"
		dc.w	$80,$A8	; you said you didn't want to use the acts so i'm just making the one file
		dc.w	$80,$A8
		dc.w	$80,$A8
		even
