	.file	"SpikedBall.cpp"
| GNU C++20 (GCC) version 12.2.0 (m68k-elf)
|	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

| GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
| options passed: -mcpu=68000 -mno-sep-data -mshort -O3 -std=c++20 -ffreestanding -fno-exceptions -fno-rtti -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer
	.text
	.align	2
	.globl	_ZN20ObjGHZBossSpikedBall7executeEv
	.type	_ZN20ObjGHZBossSpikedBall7executeEv, @function
_ZN20ObjGHZBossSpikedBall7executeEv:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| this, this
| SpikedBall.cpp:9: 	switch (routine_id) {
	move.b 36(%a2),%d0	| this_6(D)->D.1138.routine_id, _1
| SpikedBall.cpp:9: 	switch (routine_id) {
	jeq .L2		|
	cmp.b #1,%d0	|, _1
	jeq .L3		|
| SpikedBall.cpp:45: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L2:
| SpikedBall.cpp:11: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, this_6(D)->D.1138.render_bits
| SpikedBall.cpp:12: 		art = 0xA300 / 0x20;
	move.w #1304,2(%a2)	|, this_6(D)->D.1138.art
| SpikedBall.cpp:13: 		maps = Map_SSawBall_internal;
	move.l #Map_SSawBall_internal,4(%a2)	|, this_6(D)->D.1138.maps
| SpikedBall.cpp:14: 		sprite_layer = 6;
	move.b #6,24(%a2)	|, this_6(D)->D.1138.sprite_layer
| SpikedBall.cpp:15: 		collision_flag = 0x80 | 0x18;
	move.b #-104,32(%a2)	|, this_6(D)->D.1138.collision_flag
| SpikedBall.cpp:16: 		routine_id++;	// => Main
	move.b #1,36(%a2)	|, this_6(D)->D.1138.routine_id
.L3:
| SpikedBall.cpp:21: 			velocity.yf += 0x28;	// make me fall
	add.w #40,18(%a2)	|, this_6(D)->D.1138.velocity.D.1021.yf
| SpikedBall.cpp:22: 			if (velocity.xf > -0x80) {	// air friction
	move.w 16(%a2),%d0	| this_6(D)->D.1138.velocity.D.1016.xf, _15
| SpikedBall.cpp:22: 			if (velocity.xf > -0x80) {	// air friction
	cmp.w #-127,%d0	|, _15
	jlt .L5		|
| SpikedBall.cpp:23: 				velocity.xf -= 0x08;
	subq.w #8,%d0	|, _15
	move.w %d0,16(%a2)	| _15, this_6(D)->D.1138.velocity.D.1016.xf
.L5:
| SpikedBall.cpp:27: 			const auto floorDist = objFloorDist__cdecl(this) - 0x08;
	move.l %a2,-(%sp)	| this,
	jsr objFloorDist__cdecl		|
| SpikedBall.cpp:27: 			const auto floorDist = objFloorDist__cdecl(this) - 0x08;
	subq.w #8,%d0	|, floorDist
| SpikedBall.cpp:28: 			if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L13		|
| SpikedBall.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_6(D)->D.1138.position.D.1004.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| SpikedBall.cpp:36: 			if (screenX < -0x8) {
	cmp.w #-8,%d0	|, screenX
	jge .L8		|
.L14:
| SpikedBall.cpp:37: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| this,
| SpikedBall.cpp:45: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| SpikedBall.cpp:37: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L8:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp69
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp69, MEM[(struct LevelObject *)this_6(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_6(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp71
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp71, MEM[(struct LevelObject *)this_6(D)].position.D.1009.yf
| SpikedBall.cpp:41: 				displaySprite__cdecl(this);
	move.l %a2,12(%sp)	| this,
| SpikedBall.cpp:45: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| SpikedBall.cpp:41: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L13:
| SpikedBall.cpp:29: 				position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, this_6(D)->D.1138.position.D.1009.y
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w 18(%a2),%d0	| this_6(D)->D.1138.velocity.D.1021.yf, tmp60
	neg.w %d0	| tmp60
	add.w %d0,%d0	| tmp60, tmp61
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w #-1024,%d1	|, iftmp.0_23
	cmp.w #-3071,%d0	|, tmp61
	jlt .L7		|
	move.w %d0,%d1	| tmp61,
	muls.w #21846,%d1	|, tmp62
	clr.w %d1	| tmp64
	swap %d1	| tmp64
	moveq #15,%d2	|,
	asr.w %d2,%d0	|, tmp65
	sub.w %d0,%d1	| tmp65, iftmp.0_23
.L7:
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w %d1,18(%a2)	| iftmp.0_23, this_6(D)->D.1138.velocity.D.1021.yf
| SpikedBall.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_6(D)->D.1138.position.D.1004.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| SpikedBall.cpp:36: 			if (screenX < -0x8) {
	cmp.w #-8,%d0	|, screenX
	jge .L8		|
	jra .L14		|
	.size	_ZN20ObjGHZBossSpikedBall7executeEv, .-_ZN20ObjGHZBossSpikedBall7executeEv
	.align	2
	.globl	execute_ObjGHZBossSpikedBall
	.type	execute_ObjGHZBossSpikedBall, @function
execute_ObjGHZBossSpikedBall:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| obj, obj
| SpikedBall.cpp:9: 	switch (routine_id) {
	move.b 36(%a2),%d0	| obj_2(D)->D.1138.routine_id, _4
| SpikedBall.cpp:9: 	switch (routine_id) {
	jeq .L16		|
	cmp.b #1,%d0	|, _4
	jeq .L17		|
| SpikedBall.cpp:49: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L16:
| SpikedBall.cpp:11: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, obj_2(D)->D.1138.render_bits
| SpikedBall.cpp:12: 		art = 0xA300 / 0x20;
	move.w #1304,2(%a2)	|, obj_2(D)->D.1138.art
| SpikedBall.cpp:13: 		maps = Map_SSawBall_internal;
	move.l #Map_SSawBall_internal,4(%a2)	|, obj_2(D)->D.1138.maps
| SpikedBall.cpp:14: 		sprite_layer = 6;
	move.b #6,24(%a2)	|, obj_2(D)->D.1138.sprite_layer
| SpikedBall.cpp:15: 		collision_flag = 0x80 | 0x18;
	move.b #-104,32(%a2)	|, obj_2(D)->D.1138.collision_flag
| SpikedBall.cpp:16: 		routine_id++;	// => Main
	move.b #1,36(%a2)	|, obj_2(D)->D.1138.routine_id
.L17:
| SpikedBall.cpp:21: 			velocity.yf += 0x28;	// make me fall
	add.w #40,18(%a2)	|, obj_2(D)->D.1138.velocity.D.1021.yf
| SpikedBall.cpp:22: 			if (velocity.xf > -0x80) {	// air friction
	move.w 16(%a2),%d0	| obj_2(D)->D.1138.velocity.D.1016.xf, _7
| SpikedBall.cpp:22: 			if (velocity.xf > -0x80) {	// air friction
	cmp.w #-127,%d0	|, _7
	jlt .L19		|
| SpikedBall.cpp:23: 				velocity.xf -= 0x08;
	subq.w #8,%d0	|, _7
	move.w %d0,16(%a2)	| _7, obj_2(D)->D.1138.velocity.D.1016.xf
.L19:
| SpikedBall.cpp:27: 			const auto floorDist = objFloorDist__cdecl(this) - 0x08;
	move.l %a2,-(%sp)	| obj,
	jsr objFloorDist__cdecl		|
| SpikedBall.cpp:27: 			const auto floorDist = objFloorDist__cdecl(this) - 0x08;
	subq.w #8,%d0	|, floorDist
| SpikedBall.cpp:28: 			if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L27		|
| SpikedBall.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1138.position.D.1004.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| SpikedBall.cpp:36: 			if (screenX < -0x8) {
	cmp.w #-8,%d0	|, screenX
	jge .L22		|
.L28:
| SpikedBall.cpp:37: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| obj,
| SpikedBall.cpp:49: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| SpikedBall.cpp:37: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L22:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp69
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp69, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp71
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp71, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| SpikedBall.cpp:41: 				displaySprite__cdecl(this);
	move.l %a2,12(%sp)	| obj,
| SpikedBall.cpp:49: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| SpikedBall.cpp:41: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L27:
| SpikedBall.cpp:29: 				position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, obj_2(D)->D.1138.position.D.1009.y
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w 18(%a2),%d0	| obj_2(D)->D.1138.velocity.D.1021.yf, tmp60
	neg.w %d0	| tmp60
	add.w %d0,%d0	| tmp60, tmp61
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w #-1024,%d1	|, iftmp.0_15
	cmp.w #-3071,%d0	|, tmp61
	jlt .L21		|
	move.w %d0,%d1	| tmp61,
	muls.w #21846,%d1	|, tmp62
	clr.w %d1	| tmp64
	swap %d1	| tmp64
	moveq #15,%d2	|,
	asr.w %d2,%d0	|, tmp65
	sub.w %d0,%d1	| tmp65, iftmp.0_15
.L21:
| SpikedBall.cpp:30: 				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
	move.w %d1,18(%a2)	| iftmp.0_15, obj_2(D)->D.1138.velocity.D.1021.yf
| SpikedBall.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1138.position.D.1004.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| SpikedBall.cpp:36: 			if (screenX < -0x8) {
	cmp.w #-8,%d0	|, screenX
	jge .L22		|
	jra .L28		|
	.size	execute_ObjGHZBossSpikedBall, .-execute_ObjGHZBossSpikedBall
	.ident	"GCC: (GNU) 12.2.0"
