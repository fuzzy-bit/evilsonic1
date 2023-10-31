; ---------------------------------------------------------------------------
; Subroutine to	load tiles as soon as the level	appears
; ---------------------------------------------------------------------------
LoadTilesFromStart:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_screenposx).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$4000,d2
		bsr.s	DrawChunks
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		if Revision=0
		else
			cmpi.w	#(id_SBZ<<8)+0,(v_zone).w
			beq.w	Draw_SBz_Bg
		endc