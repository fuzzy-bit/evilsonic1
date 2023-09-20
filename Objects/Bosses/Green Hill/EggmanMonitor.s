	.file	"EggmanMonitor.cpp"
| GNU C++20 (GCC) version 12.2.0 (m68k-elf)
|	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

| GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
| options passed: -mcpu=68000 -mno-sep-data -mshort -O3 -std=c++20 -ffreestanding -fno-exceptions -fno-rtti -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer
	.text
	.align	2
	.globl	_ZN23ObjGHZBossEggmanMonitor7executeEv
	.type	_ZN23ObjGHZBossEggmanMonitor7executeEv, @function
_ZN23ObjGHZBossEggmanMonitor7executeEv:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| this, this
| EggmanMonitor.cpp:13: 	switch (routine_id) {
	move.b 36(%a2),%d0	| this_6(D)->D.1151.routine_id, _1
| EggmanMonitor.cpp:13: 	switch (routine_id) {
	jeq .L2		|
	cmp.b #1,%d0	|, _1
	jeq .L3		|
| EggmanMonitor.cpp:60: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L2:
| EggmanMonitor.cpp:15: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, this_6(D)->D.1151.render_bits
| EggmanMonitor.cpp:16: 		maps = Map_Monitor;
	move.l #Map_Monitor,4(%a2)	|, this_6(D)->D.1151.maps
| EggmanMonitor.cpp:17: 		art = 0x680;
	move.w #1664,2(%a2)	|, this_6(D)->D.1151.art
| EggmanMonitor.cpp:19: 		anim_id = 0x01;
	move.b #1,28(%a2)	|, this_6(D)->D.1151.anim_id
| EggmanMonitor.cpp:20: 		sprite_layer = 6;
	move.w #1551,24(%a2)	|, MEM <vector(2) unsigned char> [(unsigned char *)this_6(D) + 24B]
| EggmanMonitor.cpp:21: 		routine_id++;
	move.b #1,36(%a2)	|, this_6(D)->D.1151.routine_id
.L3:
| EggmanMonitor.cpp:26: 			if (velocity.xf > 0) {	// air friction
	move.w 16(%a2),%d0	| this_6(D)->D.1151.velocity.D.1028.xf, _14
| EggmanMonitor.cpp:26: 			if (velocity.xf > 0) {	// air friction
	jle .L5		|
| EggmanMonitor.cpp:27: 				velocity.xf -= 0x08;
	subq.w #8,%d0	|, _14
	move.w %d0,16(%a2)	| _14, this_6(D)->D.1151.velocity.D.1028.xf
.L5:
| EggmanMonitor.cpp:31: 			if (!landedOnFloor) {
	tst.b 40(%a2)	| this_6(D)->landedOnFloor
	jne .L6		|
| EggmanMonitor.cpp:32: 				velocity.yf += 0x38;	// make me fall
	add.w #56,18(%a2)	|, this_6(D)->D.1151.velocity.D.1033.yf
.L6:
| EggmanMonitor.cpp:34: 			const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	move.l %a2,-(%sp)	| this,
	jsr objFloorDist__cdecl		|
| EggmanMonitor.cpp:34: 			const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	add.w #-15,%d0	|, floorDist
| EggmanMonitor.cpp:35: 			if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L15		|
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_6(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L10		|
.L16:
| EggmanMonitor.cpp:50: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| this,
| EggmanMonitor.cpp:60: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:50: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L10:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1028.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1028.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp64
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp64, MEM[(struct LevelObject *)this_6(D)].position.D.1016.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1033.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1033.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp66
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp66, MEM[(struct LevelObject *)this_6(D)].position.D.1021.yf
| EggmanMonitor.cpp:54: 				animateSprite__cdecl(this, Ani_Monitor);
	pea Ani_Monitor		|
	move.l %a2,-(%sp)	| this,
	jsr animateSprite__cdecl		|
| EggmanMonitor.cpp:55: 				displaySprite__cdecl(this);
	addq.l #8,%sp	|,
	move.l %a2,12(%sp)	| this,
| EggmanMonitor.cpp:60: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:55: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L15:
| EggmanMonitor.cpp:36: 				position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, this_6(D)->D.1151.position.D.1021.y
| EggmanMonitor.cpp:37: 				if (velocity.yf > 0x100) {
	move.w 18(%a2),%d0	| this_6(D)->D.1151.velocity.D.1033.yf, _23
| EggmanMonitor.cpp:37: 				if (velocity.yf > 0x100) {
	cmp.w #256,%d0	|, _23
	jle .L8		|
| EggmanMonitor.cpp:38: 					velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w #1024,%d1	|, iftmp.0_24
	cmp.w #2047,%d0	|, _23
	jgt .L9		|
	move.w %d0,%d1	| _23, tmp58
	moveq #15,%d2	|,
	lsr.w %d2,%d1	|, tmp58
	add.w %d0,%d1	| _23, tmp59
	asr.w #1,%d1	|, tmp60
	neg.w %d1	| iftmp.0_24
.L9:
| EggmanMonitor.cpp:38: 					velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d1,18(%a2)	| iftmp.0_24, this_6(D)->D.1151.velocity.D.1033.yf
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_6(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L10		|
	jra .L16		|
.L8:
| EggmanMonitor.cpp:41: 					velocity.yf = 0;
	clr.w 18(%a2)	| this_6(D)->D.1151.velocity.D.1033.yf
| EggmanMonitor.cpp:42: 					landedOnFloor = true;
	move.b #1,40(%a2)	|, this_6(D)->landedOnFloor
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_6(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L10		|
	jra .L16		|
	.size	_ZN23ObjGHZBossEggmanMonitor7executeEv, .-_ZN23ObjGHZBossEggmanMonitor7executeEv
	.align	2
	.globl	execute_ObjGHZBossEggmanMonitor
	.type	execute_ObjGHZBossEggmanMonitor, @function
execute_ObjGHZBossEggmanMonitor:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| obj, obj
| EggmanMonitor.cpp:13: 	switch (routine_id) {
	move.b 36(%a2),%d0	| obj_2(D)->D.1151.routine_id, _4
| EggmanMonitor.cpp:13: 	switch (routine_id) {
	jeq .L18		|
	cmp.b #1,%d0	|, _4
	jeq .L19		|
| EggmanMonitor.cpp:64: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L18:
| EggmanMonitor.cpp:15: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, obj_2(D)->D.1151.render_bits
| EggmanMonitor.cpp:16: 		maps = Map_Monitor;
	move.l #Map_Monitor,4(%a2)	|, obj_2(D)->D.1151.maps
| EggmanMonitor.cpp:17: 		art = 0x680;
	move.w #1664,2(%a2)	|, obj_2(D)->D.1151.art
| EggmanMonitor.cpp:19: 		anim_id = 0x01;
	move.b #1,28(%a2)	|, obj_2(D)->D.1151.anim_id
| EggmanMonitor.cpp:20: 		sprite_layer = 6;
	move.w #1551,24(%a2)	|, MEM <vector(2) unsigned char> [(unsigned char *)obj_2(D) + 24B]
| EggmanMonitor.cpp:21: 		routine_id++;
	move.b #1,36(%a2)	|, obj_2(D)->D.1151.routine_id
.L19:
| EggmanMonitor.cpp:26: 			if (velocity.xf > 0) {	// air friction
	move.w 16(%a2),%d0	| obj_2(D)->D.1151.velocity.D.1028.xf, _5
| EggmanMonitor.cpp:26: 			if (velocity.xf > 0) {	// air friction
	jle .L21		|
| EggmanMonitor.cpp:27: 				velocity.xf -= 0x08;
	subq.w #8,%d0	|, _5
	move.w %d0,16(%a2)	| _5, obj_2(D)->D.1151.velocity.D.1028.xf
.L21:
| EggmanMonitor.cpp:31: 			if (!landedOnFloor) {
	tst.b 40(%a2)	| obj_2(D)->landedOnFloor
	jne .L22		|
| EggmanMonitor.cpp:32: 				velocity.yf += 0x38;	// make me fall
	add.w #56,18(%a2)	|, obj_2(D)->D.1151.velocity.D.1033.yf
.L22:
| EggmanMonitor.cpp:34: 			const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	move.l %a2,-(%sp)	| obj,
	jsr objFloorDist__cdecl		|
| EggmanMonitor.cpp:34: 			const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	add.w #-15,%d0	|, floorDist
| EggmanMonitor.cpp:35: 			if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L31		|
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L26		|
.L32:
| EggmanMonitor.cpp:50: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| obj,
| EggmanMonitor.cpp:64: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:50: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L26:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1028.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1028.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp64
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp64, MEM[(struct LevelObject *)obj_2(D)].position.D.1016.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1033.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1033.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp66
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp66, MEM[(struct LevelObject *)obj_2(D)].position.D.1021.yf
| EggmanMonitor.cpp:54: 				animateSprite__cdecl(this, Ani_Monitor);
	pea Ani_Monitor		|
	move.l %a2,-(%sp)	| obj,
	jsr animateSprite__cdecl		|
| EggmanMonitor.cpp:55: 				displaySprite__cdecl(this);
	addq.l #8,%sp	|,
	move.l %a2,12(%sp)	| obj,
| EggmanMonitor.cpp:64: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:55: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L31:
| EggmanMonitor.cpp:36: 				position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, obj_2(D)->D.1151.position.D.1021.y
| EggmanMonitor.cpp:37: 				if (velocity.yf > 0x100) {
	move.w 18(%a2),%d0	| obj_2(D)->D.1151.velocity.D.1033.yf, _14
| EggmanMonitor.cpp:37: 				if (velocity.yf > 0x100) {
	cmp.w #256,%d0	|, _14
	jle .L24		|
| EggmanMonitor.cpp:38: 					velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w #1024,%d1	|, iftmp.0_15
	cmp.w #2047,%d0	|, _14
	jgt .L25		|
	move.w %d0,%d1	| _14, tmp58
	moveq #15,%d2	|,
	lsr.w %d2,%d1	|, tmp58
	add.w %d0,%d1	| _14, tmp59
	asr.w #1,%d1	|, tmp60
	neg.w %d1	| iftmp.0_15
.L25:
| EggmanMonitor.cpp:38: 					velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d1,18(%a2)	| iftmp.0_15, obj_2(D)->D.1151.velocity.D.1033.yf
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L26		|
	jra .L32		|
.L24:
| EggmanMonitor.cpp:41: 					velocity.yf = 0;
	clr.w 18(%a2)	| obj_2(D)->D.1151.velocity.D.1033.yf
| EggmanMonitor.cpp:42: 					landedOnFloor = true;
	move.b #1,40(%a2)	|, obj_2(D)->landedOnFloor
| EggmanMonitor.cpp:48: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1151.position.D.1016.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1016.x, screenX
| EggmanMonitor.cpp:49: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L26		|
	jra .L32		|
	.size	execute_ObjGHZBossEggmanMonitor, .-execute_ObjGHZBossEggmanMonitor
	.ident	"GCC: (GNU) 12.2.0"
