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
| EggmanMonitor.cpp:15: 	switch (routine_id) {
	move.b 36(%a2),%d0	| this_27(D)->D.1168.routine_id, _1
| EggmanMonitor.cpp:15: 	switch (routine_id) {
	cmp.b #1,%d0	|, _1
	jeq .L2		|
	cmp.b #3,%d0	|, _1
	jeq .L3		|
	tst.b %d0	| _1
	jeq .L20		|
| EggmanMonitor.cpp:98: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L20:
| EggmanMonitor.cpp:17: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, this_27(D)->D.1168.render_bits
| EggmanMonitor.cpp:18: 		maps = Map_Monitor;
	move.l #Map_Monitor,4(%a2)	|, this_27(D)->D.1168.maps
| EggmanMonitor.cpp:19: 		art = 0x680;
	move.w #1664,2(%a2)	|, this_27(D)->D.1168.art
| EggmanMonitor.cpp:21: 		collision_flag = 0x46;
	move.b #70,32(%a2)	|, this_27(D)->D.1168.collision_flag
| EggmanMonitor.cpp:22: 		anim_id = 0x01;
	move.b #1,28(%a2)	|, this_27(D)->D.1168.anim_id
| EggmanMonitor.cpp:23: 		sprite_layer = 6;
	move.w #1551,24(%a2)	|, MEM <vector(2) unsigned char> [(unsigned char *)this_27(D) + 24B]
| EggmanMonitor.cpp:24: 		routine_id++;
	move.b #1,36(%a2)	|, this_27(D)->D.1168.routine_id
.L2:
| EggmanMonitor.cpp:31: 			if (explosionTimer) {
	move.b 42(%a2),%d0	| this_27(D)->explosionTimer, _2
| EggmanMonitor.cpp:31: 			if (explosionTimer) {
	jne .L21		|
| EggmanMonitor.cpp:38: 				if (!landedOnFloor) {
	tst.b 40(%a2)	| this_27(D)->landedOnFloor
	jne .L7		|
| EggmanMonitor.cpp:40: 					if (velocity.xf > 0) {	
	move.w 16(%a2),%d0	| this_27(D)->D.1168.velocity.D.1030.xf, _5
| EggmanMonitor.cpp:40: 					if (velocity.xf > 0) {	
	jle .L8		|
| EggmanMonitor.cpp:41: 						velocity.xf -= 0x08;
	subq.w #8,%d0	|, _5
	move.w %d0,16(%a2)	| _5, this_27(D)->D.1168.velocity.D.1030.xf
.L8:
| EggmanMonitor.cpp:43: 					velocity.yf += 0x38;	// make me fall
	add.w #56,18(%a2)	|, this_27(D)->D.1168.velocity.D.1035.yf
.L7:
| EggmanMonitor.cpp:45: 				const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	move.l %a2,-(%sp)	| this,
	jsr objFloorDist__cdecl		|
| EggmanMonitor.cpp:45: 				const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	add.w #-15,%d0	|, floorDist
| EggmanMonitor.cpp:46: 				if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L9		|
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _117
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d1	| this_27(D)->D.1168.velocity.D.1035.yf,
	ext.l %d1	| this_27(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d1	|, _124
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _117, MEM[(struct LevelObject *)this_27(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _124, MEM[(struct LevelObject *)this_27(D)].position.D.1023.yf
.L6:
| EggmanMonitor.cpp:61: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| this_27(D)->D.1168.position.D.1018.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1018.x, screenX
| EggmanMonitor.cpp:62: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L13		|
| EggmanMonitor.cpp:63: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| this,
| EggmanMonitor.cpp:98: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:63: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L13:
| EggmanMonitor.cpp:66: 				animateSprite__cdecl(this, Ani_Monitor);
	pea Ani_Monitor		|
	move.l %a2,-(%sp)	| this,
	jsr animateSprite__cdecl		|
| EggmanMonitor.cpp:67: 				displaySprite__cdecl(this);
	addq.l #8,%sp	|,
	move.l %a2,12(%sp)	| this,
| EggmanMonitor.cpp:98: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:67: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L3:
| EggmanMonitor.cpp:75: 			LevelObject * explosion = (LevelObject *)findFreeObj__cdecl();
	jsr findFreeObj__cdecl		|
	move.l %d0,%a0	| tmp81, explosion
| EggmanMonitor.cpp:76: 			if (explosion) {
	tst.l %d0	| explosion
	jeq .L14		|
| EggmanMonitor.cpp:77: 				explosion->id = 0x3F;
	move.b #63,(%a0)	|, explosion_29->id
| EggmanMonitor.cpp:78: 				explosion->position = position;
	move.l 8(%a2),%d0	| this_27(D)->D.1168.position,
	move.l 12(%a2),%d1	| this_27(D)->D.1168.position,
	move.l %d0,8(%a0)	|, explosion_29->position
	move.l %d1,12(%a0)	|, explosion_29->position
.L14:
| EggmanMonitor.cpp:80: 			LevelObject * contents = (LevelObject *)findFreeObj__cdecl();
	jsr findFreeObj__cdecl		|
	move.l %d0,%a0	| tmp82, contents
| EggmanMonitor.cpp:81: 			if (contents) {
	tst.l %d0	| contents
	jeq .L15		|
| EggmanMonitor.cpp:82: 				contents->id = 0x2E;
	move.b #46,(%a0)	|, contents_33->id
| EggmanMonitor.cpp:83: 				contents->position = position;
	move.l 8(%a2),%d1	| this_27(D)->D.1168.position,
	move.l 12(%a2),%d2	| this_27(D)->D.1168.position,
	move.l %d1,8(%a0)	|, contents_33->position
	move.l %d2,12(%a0)	|, contents_33->position
| EggmanMonitor.cpp:84: 				contents->anim_id = anim_id;
	move.b 28(%a2),28(%a0)	| this_27(D)->D.1168.anim_id, contents_33->anim_id
.L15:
| EggmanMonitor.cpp:88: 			velocity.yf = 0x00;
	clr.w 18(%a2)	| this_27(D)->D.1168.velocity.D.1035.yf
| EggmanMonitor.cpp:89: 			anim_id = 0x09;			// use broken animation
	move.b #9,28(%a2)	|, this_27(D)->D.1168.anim_id
| EggmanMonitor.cpp:90: 			collision_flag = 0x00;	// reset collision
	clr.b 32(%a2)	| this_27(D)->D.1168.collision_flag
| EggmanMonitor.cpp:91: 			routine_id = 0x01;		// => Main
	move.b #1,36(%a2)	|, this_27(D)->D.1168.routine_id
| EggmanMonitor.cpp:92: 			isBroken = true;
	move.b #1,41(%a2)	|, this_27(D)->isBroken
	moveq #14,%d0	|, _126
| EggmanMonitor.cpp:32: 				explosionTimer -= 1;
	move.b %d0,42(%a2)	| _126, this_27(D)->explosionTimer
	jra .L6		|
.L21:
	subq.b #1,%d0	|, _126
	move.b %d0,42(%a2)	| _126, this_27(D)->explosionTimer
	jra .L6		|
.L9:
| EggmanMonitor.cpp:47: 					position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, this_27(D)->D.1168.position.D.1023.y
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	tst.b 41(%a2)	| this_27(D)->isBroken
	jne .L11		|
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	move.w 18(%a2),%d0	| this_27(D)->D.1168.velocity.D.1035.yf, _13
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	cmp.w #256,%d0	|, _13
	jle .L11		|
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	cmp.w #2047,%d0	|, _13
	jgt .L17		|
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d0,%d1	| _13, tmp69
	moveq #15,%d2	|,
	lsr.w %d2,%d1	|, tmp69
	add.w %d1,%d0	| tmp69, tmp70
	asr.w #1,%d0	|, iftmp.0_17
	neg.w %d0	| iftmp.0_17
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w %d0,%d1	| iftmp.0_17,
	ext.l %d1	| iftmp.0_17
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d1	|, _124
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d0,18(%a2)	| iftmp.0_17, this_27(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _117
.L22:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _117, MEM[(struct LevelObject *)this_27(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _124, MEM[(struct LevelObject *)this_27(D)].position.D.1023.yf
	jra .L6		|
.L11:
| EggmanMonitor.cpp:52: 						velocity = { .xf = 0, .yf = 0 };
	clr.w 16(%a2)	| this_27(D)->D.1168.velocity.D.1030.xf
	clr.w 18(%a2)	| this_27(D)->D.1168.velocity.D.1035.yf
| EggmanMonitor.cpp:53: 						landedOnFloor = true;
	move.b #1,40(%a2)	|, this_27(D)->landedOnFloor
	moveq #0,%d1	| _124
	moveq #0,%d0	| _117
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _117, MEM[(struct LevelObject *)this_27(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _124, MEM[(struct LevelObject *)this_27(D)].position.D.1023.yf
	jra .L6		|
.L17:
	moveq #4,%d1	|, _124
	swap %d1	| _124
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w #1024,%d0	|, iftmp.0_17
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d0,18(%a2)	| iftmp.0_17, this_27(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_27(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _117
	jra .L22		|
	.size	_ZN23ObjGHZBossEggmanMonitor7executeEv, .-_ZN23ObjGHZBossEggmanMonitor7executeEv
	.align	2
	.globl	execute_ObjGHZBossEggmanMonitor
	.type	execute_ObjGHZBossEggmanMonitor, @function
execute_ObjGHZBossEggmanMonitor:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| obj, obj
| EggmanMonitor.cpp:15: 	switch (routine_id) {
	move.b 36(%a2),%d0	| obj_2(D)->D.1168.routine_id, _4
| EggmanMonitor.cpp:15: 	switch (routine_id) {
	cmp.b #1,%d0	|, _4
	jeq .L24		|
	cmp.b #3,%d0	|, _4
	jeq .L25		|
	tst.b %d0	| _4
	jeq .L42		|
| EggmanMonitor.cpp:102: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L42:
| EggmanMonitor.cpp:17: 		render_bits = 0x04;
	move.b #4,1(%a2)	|, obj_2(D)->D.1168.render_bits
| EggmanMonitor.cpp:18: 		maps = Map_Monitor;
	move.l #Map_Monitor,4(%a2)	|, obj_2(D)->D.1168.maps
| EggmanMonitor.cpp:19: 		art = 0x680;
	move.w #1664,2(%a2)	|, obj_2(D)->D.1168.art
| EggmanMonitor.cpp:21: 		collision_flag = 0x46;
	move.b #70,32(%a2)	|, obj_2(D)->D.1168.collision_flag
| EggmanMonitor.cpp:22: 		anim_id = 0x01;
	move.b #1,28(%a2)	|, obj_2(D)->D.1168.anim_id
| EggmanMonitor.cpp:23: 		sprite_layer = 6;
	move.w #1551,24(%a2)	|, MEM <vector(2) unsigned char> [(unsigned char *)obj_2(D) + 24B]
| EggmanMonitor.cpp:24: 		routine_id++;
	move.b #1,36(%a2)	|, obj_2(D)->D.1168.routine_id
.L24:
| EggmanMonitor.cpp:31: 			if (explosionTimer) {
	move.b 42(%a2),%d0	| obj_2(D)->explosionTimer, _5
| EggmanMonitor.cpp:31: 			if (explosionTimer) {
	jne .L43		|
| EggmanMonitor.cpp:38: 				if (!landedOnFloor) {
	tst.b 40(%a2)	| obj_2(D)->landedOnFloor
	jne .L29		|
| EggmanMonitor.cpp:40: 					if (velocity.xf > 0) {	
	move.w 16(%a2),%d0	| obj_2(D)->D.1168.velocity.D.1030.xf, _8
| EggmanMonitor.cpp:40: 					if (velocity.xf > 0) {	
	jle .L30		|
| EggmanMonitor.cpp:41: 						velocity.xf -= 0x08;
	subq.w #8,%d0	|, _8
	move.w %d0,16(%a2)	| _8, obj_2(D)->D.1168.velocity.D.1030.xf
.L30:
| EggmanMonitor.cpp:43: 					velocity.yf += 0x38;	// make me fall
	add.w #56,18(%a2)	|, obj_2(D)->D.1168.velocity.D.1035.yf
.L29:
| EggmanMonitor.cpp:45: 				const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	move.l %a2,-(%sp)	| obj,
	jsr objFloorDist__cdecl		|
| EggmanMonitor.cpp:45: 				const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
	add.w #-15,%d0	|, floorDist
| EggmanMonitor.cpp:46: 				if (floorDist <= 0) {
	addq.l #4,%sp	|,
	tst.w %d0	| floorDist
	jle .L31		|
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _118
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d1	| obj_2(D)->D.1168.velocity.D.1035.yf,
	ext.l %d1	| obj_2(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d1	|, _125
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _118, MEM[(struct LevelObject *)obj_2(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _125, MEM[(struct LevelObject *)obj_2(D)].position.D.1023.yf
.L28:
| EggmanMonitor.cpp:61: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%d0	| obj_2(D)->D.1168.position.D.1018.x, screenX
	sub.w -2304.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1018.x, screenX
| EggmanMonitor.cpp:62: 			if (screenX < -0x18) {
	cmp.w #-24,%d0	|, screenX
	jge .L35		|
| EggmanMonitor.cpp:63: 				deleteObject__cdecl(this);
	move.l %a2,12(%sp)	| obj,
| EggmanMonitor.cpp:102: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:63: 				deleteObject__cdecl(this);
	jra deleteObject__cdecl		|
.L35:
| EggmanMonitor.cpp:66: 				animateSprite__cdecl(this, Ani_Monitor);
	pea Ani_Monitor		|
	move.l %a2,-(%sp)	| obj,
	jsr animateSprite__cdecl		|
| EggmanMonitor.cpp:67: 				displaySprite__cdecl(this);
	addq.l #8,%sp	|,
	move.l %a2,12(%sp)	| obj,
| EggmanMonitor.cpp:102: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
| EggmanMonitor.cpp:67: 				displaySprite__cdecl(this);
	jra displaySprite__cdecl		|
.L25:
| EggmanMonitor.cpp:75: 			LevelObject * explosion = (LevelObject *)findFreeObj__cdecl();
	jsr findFreeObj__cdecl		|
	move.l %d0,%a0	| tmp81, explosion
| EggmanMonitor.cpp:76: 			if (explosion) {
	tst.l %d0	| explosion
	jeq .L36		|
| EggmanMonitor.cpp:77: 				explosion->id = 0x3F;
	move.b #63,(%a0)	|, explosion_33->id
| EggmanMonitor.cpp:78: 				explosion->position = position;
	move.l 8(%a2),%d0	| obj_2(D)->D.1168.position,
	move.l 12(%a2),%d1	| obj_2(D)->D.1168.position,
	move.l %d0,8(%a0)	|, explosion_33->position
	move.l %d1,12(%a0)	|, explosion_33->position
.L36:
| EggmanMonitor.cpp:80: 			LevelObject * contents = (LevelObject *)findFreeObj__cdecl();
	jsr findFreeObj__cdecl		|
	move.l %d0,%a0	| tmp82, contents
| EggmanMonitor.cpp:81: 			if (contents) {
	tst.l %d0	| contents
	jeq .L37		|
| EggmanMonitor.cpp:82: 				contents->id = 0x2E;
	move.b #46,(%a0)	|, contents_34->id
| EggmanMonitor.cpp:83: 				contents->position = position;
	move.l 8(%a2),%d1	| obj_2(D)->D.1168.position,
	move.l 12(%a2),%d2	| obj_2(D)->D.1168.position,
	move.l %d1,8(%a0)	|, contents_34->position
	move.l %d2,12(%a0)	|, contents_34->position
| EggmanMonitor.cpp:84: 				contents->anim_id = anim_id;
	move.b 28(%a2),28(%a0)	| obj_2(D)->D.1168.anim_id, contents_34->anim_id
.L37:
| EggmanMonitor.cpp:88: 			velocity.yf = 0x00;
	clr.w 18(%a2)	| obj_2(D)->D.1168.velocity.D.1035.yf
| EggmanMonitor.cpp:89: 			anim_id = 0x09;			// use broken animation
	move.b #9,28(%a2)	|, obj_2(D)->D.1168.anim_id
| EggmanMonitor.cpp:90: 			collision_flag = 0x00;	// reset collision
	clr.b 32(%a2)	| obj_2(D)->D.1168.collision_flag
| EggmanMonitor.cpp:91: 			routine_id = 0x01;		// => Main
	move.b #1,36(%a2)	|, obj_2(D)->D.1168.routine_id
| EggmanMonitor.cpp:92: 			isBroken = true;
	move.b #1,41(%a2)	|, obj_2(D)->isBroken
	moveq #14,%d0	|, _127
| EggmanMonitor.cpp:32: 				explosionTimer -= 1;
	move.b %d0,42(%a2)	| _127, obj_2(D)->explosionTimer
	jra .L28		|
.L43:
	subq.b #1,%d0	|, _127
	move.b %d0,42(%a2)	| _127, obj_2(D)->explosionTimer
	jra .L28		|
.L31:
| EggmanMonitor.cpp:47: 					position.y += floorDist;
	add.w %d0,12(%a2)	| floorDist, obj_2(D)->D.1168.position.D.1023.y
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	tst.b 41(%a2)	| obj_2(D)->isBroken
	jne .L33		|
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	move.w 18(%a2),%d0	| obj_2(D)->D.1168.velocity.D.1035.yf, _17
| EggmanMonitor.cpp:48: 					if (!isBroken && velocity.yf > 0x100) {
	cmp.w #256,%d0	|, _17
	jle .L33		|
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	cmp.w #2047,%d0	|, _17
	jgt .L39		|
	move.w %d0,%d1	| _17, tmp69
	moveq #15,%d2	|,
	lsr.w %d2,%d1	|, tmp69
	add.w %d1,%d0	| tmp69, tmp70
	asr.w #1,%d0	|, iftmp.0_18
	neg.w %d0	| iftmp.0_18
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w %d0,%d1	| iftmp.0_18,
	ext.l %d1	| iftmp.0_18
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d1	|, _125
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d0,18(%a2)	| iftmp.0_18, obj_2(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _118
.L44:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _118, MEM[(struct LevelObject *)obj_2(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _125, MEM[(struct LevelObject *)obj_2(D)].position.D.1023.yf
	jra .L28		|
.L33:
| EggmanMonitor.cpp:52: 						velocity = { .xf = 0, .yf = 0 };
	clr.w 16(%a2)	| obj_2(D)->D.1168.velocity.D.1030.xf
	clr.w 18(%a2)	| obj_2(D)->D.1168.velocity.D.1035.yf
| EggmanMonitor.cpp:53: 						landedOnFloor = true;
	move.b #1,40(%a2)	|, obj_2(D)->landedOnFloor
	moveq #0,%d1	| _125
	moveq #0,%d0	| _118
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| _118, MEM[(struct LevelObject *)obj_2(D)].position.D.1018.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d1,12(%a2)	| _125, MEM[(struct LevelObject *)obj_2(D)].position.D.1023.yf
	jra .L28		|
.L39:
	moveq #4,%d1	|, _125
	swap %d1	| _125
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w #1024,%d0	|, iftmp.0_18
| EggmanMonitor.cpp:49: 						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
	move.w %d0,18(%a2)	| iftmp.0_18, obj_2(D)->D.1168.velocity.D.1035.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1030.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, _118
	jra .L44		|
	.size	execute_ObjGHZBossEggmanMonitor, .-execute_ObjGHZBossEggmanMonitor
	.ident	"GCC: (GNU) 12.2.0"
