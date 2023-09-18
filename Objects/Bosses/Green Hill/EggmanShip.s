	.file	"EggmanShip.cpp"
| GNU C++20 (GCC) version 12.2.0 (m68k-elf)
|	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

| GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
| options passed: -mcpu=68000 -mno-sep-data -mshort -O3 -std=c++20 -ffreestanding -fno-exceptions -fno-rtti -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer
	.text
	.align	2
	.globl	_ZN13ObjEggmanShip19executeMasterScriptEv
	.type	_ZN13ObjEggmanShip19executeMasterScriptEv, @function
_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l %a2,-(%sp)	|,
	move.l 8(%sp),%a2	| this, this
| EggmanShip.cpp:8: 	switch (scriptId) {
	tst.b 40(%a2)	| this_4(D)->scriptId
	jeq .L12		|
| EggmanShip.cpp:15: 		asm("illegal");
#APP
| 15 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
#NO_APP
.L3:
| EggmanShip.cpp:23: 	if (!collision_flag) {
	tst.b 32(%a2)	| this_4(D)->D.1147.collision_flag
	jne .L4		|
| EggmanShip.cpp:24: 		if (!flash_timer) {
	move.b 42(%a2),%d0	| this_4(D)->flash_timer, _21
| EggmanShip.cpp:24: 		if (!flash_timer) {
	jeq .L13		|
| EggmanShip.cpp:28: 		if (--flash_timer) {
	subq.b #1,%d0	|, _23
	move.b %d0,42(%a2)	| _23, this_4(D)->flash_timer
| EggmanShip.cpp:28: 		if (--flash_timer) {
	jne .L6		|
| EggmanShip.cpp:33: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a2)	|, this_4(D)->D.1147.collision_flag
.L4:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp52
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp52, MEM[(struct LevelObject *)this_4(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp54
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp54, MEM[(struct LevelObject *)this_4(D)].position.D.1009.yf
| EggmanShip.cpp:20: };
	move.l (%sp)+,%a2	|,
	rts	
.L13:
| EggmanShip.cpp:28: 		if (--flash_timer) {
	move.b #32,42(%a2)	|, this_4(D)->flash_timer
.L6:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_25
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L8		|
	clr.w %d0	| iftmp.1_25
.L8:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_25, MEM[(uint16_t *)4294966050B]
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp52
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp52, MEM[(struct LevelObject *)this_4(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp54
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp54, MEM[(struct LevelObject *)this_4(D)].position.D.1009.yf
| EggmanShip.cpp:20: };
	move.l (%sp)+,%a2	|,
	rts	
.L12:
| EggmanShip.cpp:10: 		script00_TestSeq();
	move.l %a2,-(%sp)	| this,
	jsr _ZN13ObjEggmanShip16script00_TestSeqEv		|
| EggmanShip.cpp:11: 		break;
	addq.l #4,%sp	|,
	jra .L3		|
	.size	_ZN13ObjEggmanShip19executeMasterScriptEv, .-_ZN13ObjEggmanShip19executeMasterScriptEv
	.align	2
	.globl	_ZN13ObjEggmanShip12handleDamageEv
	.type	_ZN13ObjEggmanShip12handleDamageEv, @function
_ZN13ObjEggmanShip12handleDamageEv:
	move.l 4(%sp),%a0	| this, this
| EggmanShip.cpp:23: 	if (!collision_flag) {
	tst.b 32(%a0)	| this_8(D)->D.1147.collision_flag
	jne .L14		|
| EggmanShip.cpp:24: 		if (!flash_timer) {
	move.b 42(%a0),%d0	| this_8(D)->flash_timer, _2
| EggmanShip.cpp:24: 		if (!flash_timer) {
	jeq .L23		|
| EggmanShip.cpp:28: 		if (--flash_timer) {
	subq.b #1,%d0	|, _4
	move.b %d0,42(%a0)	| _4, this_8(D)->flash_timer
| EggmanShip.cpp:28: 		if (--flash_timer) {
	jne .L17		|
| EggmanShip.cpp:33: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a0)	|, this_8(D)->D.1147.collision_flag
.L14:
| EggmanShip.cpp:36: }
	rts	
.L23:
| EggmanShip.cpp:28: 		if (--flash_timer) {
	move.b #32,42(%a0)	|, this_8(D)->flash_timer
.L17:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_14
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L19		|
	clr.w %d0	| iftmp.1_14
.L19:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_14, MEM[(uint16_t *)4294966050B]
| EggmanShip.cpp:36: }
	rts	
	.size	_ZN13ObjEggmanShip12handleDamageEv, .-_ZN13ObjEggmanShip12handleDamageEv
	.align	2
	.globl	_ZN13ObjEggmanShip16script00_TestSeqEv
	.type	_ZN13ObjEggmanShip16script00_TestSeqEv, @function
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l %d3,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a0	| this, this
| EggmanShip.cpp:39: 	switch (scriptRoutineId) {
	move.b 41(%a0),%d0	| this_12(D)->scriptRoutineId, _1
| EggmanShip.cpp:39: 	switch (scriptRoutineId) {
	jeq .L25		|
	cmp.b #1,%d0	|, _1
	jne .L24		|
| EggmanShip.cpp:59: 			const auto screenX = position.x - camera->x;
	move.w 8(%a0),%a1	| this_12(D)->D.1147.position.D.1004.x, pretmp_9
| EggmanShip.cpp:60: 			const auto screenY = position.y - camera->y;
	move.w 12(%a0),%d1	| this_12(D)->D.1147.position.D.1009.y, pretmp_51
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w 16(%a0),%d2	| this_12(D)->D.1147.velocity.D.1016.xf, pretmp_53
| EggmanShip.cpp:60: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w 18(%a0),%d0	| this_12(D)->D.1147.velocity.D.1021.yf, pretmp_56
| EggmanShip.cpp:59: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%a1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:62: 			if (screenX < 320/2 + 0x50) {
	move.w #239,%d3	|,
	cmp.w %a1,%d3	| screenX,
	jlt .L28		|
.L34:
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %d2,%a1	| pretmp_53, _26
	addq.w #2,%a1	|, _26
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	subq.w #1,%d0	|, _28
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %a1,16(%a0)	| _26, this_12(D)->D.1147.velocity.D.1016.xf
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w %d0,18(%a0)	| _28, this_12(D)->D.1147.velocity.D.1021.yf
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jle .L30		|
.L33:
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	tst.w %d0	| _28
	jle .L24		|
| EggmanShip.cpp:72: 				velocity.yf -= 0x06;
	subq.w #6,%d0	|, _28
	move.w %d0,18(%a0)	| _28, this_12(D)->D.1147.velocity.D.1021.yf
.L24:
| EggmanShip.cpp:95: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%d3	|,
	rts	
.L28:
| EggmanShip.cpp:67: 				velocity.xf -= 0x04/4;
	move.w %d2,%a1	| pretmp_53, _26
	subq.w #1,%a1	|, _26
| EggmanShip.cpp:68: 				velocity.yf += 0x01;
	addq.w #1,%d0	|, _28
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %a1,16(%a0)	| _26, this_12(D)->D.1147.velocity.D.1016.xf
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w %d0,18(%a0)	| _28, this_12(D)->D.1147.velocity.D.1021.yf
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jgt .L33		|
.L30:
| EggmanShip.cpp:74: 			else if (screenY < 224/2 - 0x60 && velocity.yf < 0) {
	cmp.w #15,%d1	|, screenY
	jgt .L24		|
| EggmanShip.cpp:74: 			else if (screenY < 224/2 - 0x60 && velocity.yf < 0) {
	tst.w %d0	| _28
	jge .L24		|
| EggmanShip.cpp:75: 				velocity.yf += 0x04;
	addq.w #4,%d0	|, _28
	move.w %d0,18(%a0)	| _28, this_12(D)->D.1147.velocity.D.1021.yf
| EggmanShip.cpp:95: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%d3	|,
	rts	
.L25:
| EggmanShip.cpp:45: 			position.x = camera->x + 320/2 + 0x30;
	move.w -2304.w,%a1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, pretmp_9
	lea (208,%a1),%a1	|, pretmp_9
| EggmanShip.cpp:45: 			position.x = camera->x + 320/2 + 0x30;
	move.w %a1,8(%a0)	| pretmp_9, this_12(D)->D.1147.position.D.1004.x
| EggmanShip.cpp:46: 			position.y = camera->y + 224/2 - 0x50;
	move.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, pretmp_51
	add.w #32,%d1	|, pretmp_51
| EggmanShip.cpp:46: 			position.y = camera->y + 224/2 - 0x50;
	move.w %d1,12(%a0)	| pretmp_51, this_12(D)->D.1147.position.D.1009.y
| EggmanShip.cpp:49: 			status_bits |= 1;	// turn right
	or.b #1,34(%a0)	|, this_12(D)->D.1147.status_bits
| EggmanShip.cpp:50: 			health = 255;		// ###
	st 33(%a0)		| this_12(D)->D.1147.health
| EggmanShip.cpp:51: 			scriptRoutineId++;
	move.b #1,41(%a0)	|, this_12(D)->scriptRoutineId
	move.w #768,%d2	|, pretmp_53
| EggmanShip.cpp:60: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w 18(%a0),%d0	| this_12(D)->D.1147.velocity.D.1021.yf, pretmp_56
| EggmanShip.cpp:59: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%a1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:62: 			if (screenX < 320/2 + 0x50) {
	move.w #239,%d3	|,
	cmp.w %a1,%d3	| screenX,
	jlt .L28		|
	jra .L34		|
	.size	_ZN13ObjEggmanShip16script00_TestSeqEv, .-_ZN13ObjEggmanShip16script00_TestSeqEv
	.align	2
	.globl	executeMasterScript_ObjEggmanShip
	.type	executeMasterScript_ObjEggmanShip, @function
executeMasterScript_ObjEggmanShip:
	move.l %d3,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a0	| obj, obj
| EggmanShip.cpp:8: 	switch (scriptId) {
	tst.b 40(%a0)	| obj_2(D)->scriptId
	jeq .L51		|
| EggmanShip.cpp:15: 		asm("illegal");
#APP
| 15 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
#NO_APP
.L38:
| EggmanShip.cpp:23: 	if (!collision_flag) {
	tst.b 32(%a0)	| obj_2(D)->D.1147.collision_flag
	jne .L43		|
| EggmanShip.cpp:24: 		if (!flash_timer) {
	move.b 42(%a0),%d0	| obj_2(D)->flash_timer, _41
| EggmanShip.cpp:24: 		if (!flash_timer) {
	jeq .L52		|
| EggmanShip.cpp:28: 		if (--flash_timer) {
	subq.b #1,%d0	|, _43
	move.b %d0,42(%a0)	| _43, obj_2(D)->flash_timer
| EggmanShip.cpp:28: 		if (--flash_timer) {
	jne .L45		|
| EggmanShip.cpp:33: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a0)	|, obj_2(D)->D.1147.collision_flag
.L43:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp73
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a0)	| tmp73, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a0),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp75
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp75, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| EggmanShip.cpp:100: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%d3	|,
	rts	
.L52:
| EggmanShip.cpp:28: 		if (--flash_timer) {
	move.b #32,42(%a0)	|, obj_2(D)->flash_timer
.L45:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_45
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L47		|
	clr.w %d0	| iftmp.1_45
.L47:
| EggmanShip.cpp:30: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_45, MEM[(uint16_t *)4294966050B]
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp73
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a0)	| tmp73, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a0),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp75
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp75, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| EggmanShip.cpp:100: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%d3	|,
	rts	
.L51:
| EggmanShip.cpp:39: 	switch (scriptRoutineId) {
	move.b 41(%a0),%d0	| obj_2(D)->scriptRoutineId, _15
| EggmanShip.cpp:39: 	switch (scriptRoutineId) {
	jeq .L37		|
	cmp.b #1,%d0	|, _15
	jne .L38		|
| EggmanShip.cpp:59: 			const auto screenX = position.x - camera->x;
	move.w 8(%a0),%a1	| obj_2(D)->D.1147.position.D.1004.x, pretmp_102
| EggmanShip.cpp:60: 			const auto screenY = position.y - camera->y;
	move.w 12(%a0),%d1	| obj_2(D)->D.1147.position.D.1009.y, pretmp_104
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w 16(%a0),%d2	| obj_2(D)->D.1147.velocity.D.1016.xf, pretmp_106
.L39:
| EggmanShip.cpp:60: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w 18(%a0),%d0	| obj_2(D)->D.1147.velocity.D.1021.yf, pretmp_117
| EggmanShip.cpp:59: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%a1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:62: 			if (screenX < 320/2 + 0x50) {
	move.w #239,%d3	|,
	cmp.w %a1,%d3	| screenX,
	jlt .L40		|
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %d2,%a1	| pretmp_106, _29
	addq.w #2,%a1	|, _29
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	subq.w #1,%d0	|, _31
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %a1,16(%a0)	| _29, obj_2(D)->D.1147.velocity.D.1016.xf
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w %d0,18(%a0)	| _31, obj_2(D)->D.1147.velocity.D.1021.yf
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jle .L42		|
.L53:
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	tst.w %d0	| _31
	jle .L38		|
| EggmanShip.cpp:72: 				velocity.yf -= 0x06;
	subq.w #6,%d0	|, _31
	move.w %d0,18(%a0)	| _31, obj_2(D)->D.1147.velocity.D.1021.yf
	jra .L38		|
.L40:
| EggmanShip.cpp:67: 				velocity.xf -= 0x04/4;
	move.w %d2,%a1	| pretmp_106, _29
	subq.w #1,%a1	|, _29
| EggmanShip.cpp:68: 				velocity.yf += 0x01;
	addq.w #1,%d0	|, _31
| EggmanShip.cpp:63: 				velocity.xf += 0x08/4;
	move.w %a1,16(%a0)	| _29, obj_2(D)->D.1147.velocity.D.1016.xf
| EggmanShip.cpp:64: 				velocity.yf -= 0x01;
	move.w %d0,18(%a0)	| _31, obj_2(D)->D.1147.velocity.D.1021.yf
| EggmanShip.cpp:71: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jgt .L53		|
.L42:
| EggmanShip.cpp:74: 			else if (screenY < 224/2 - 0x60 && velocity.yf < 0) {
	cmp.w #15,%d1	|, screenY
	jgt .L38		|
| EggmanShip.cpp:74: 			else if (screenY < 224/2 - 0x60 && velocity.yf < 0) {
	tst.w %d0	| _31
	jge .L38		|
| EggmanShip.cpp:75: 				velocity.yf += 0x04;
	addq.w #4,%d0	|, _31
	move.w %d0,18(%a0)	| _31, obj_2(D)->D.1147.velocity.D.1021.yf
	jra .L38		|
.L37:
| EggmanShip.cpp:45: 			position.x = camera->x + 320/2 + 0x30;
	move.w -2304.w,%a1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, pretmp_102
	lea (208,%a1),%a1	|, pretmp_102
| EggmanShip.cpp:45: 			position.x = camera->x + 320/2 + 0x30;
	move.w %a1,8(%a0)	| pretmp_102, obj_2(D)->D.1147.position.D.1004.x
| EggmanShip.cpp:46: 			position.y = camera->y + 224/2 - 0x50;
	move.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, pretmp_104
	add.w #32,%d1	|, pretmp_104
| EggmanShip.cpp:46: 			position.y = camera->y + 224/2 - 0x50;
	move.w %d1,12(%a0)	| pretmp_104, obj_2(D)->D.1147.position.D.1009.y
| EggmanShip.cpp:49: 			status_bits |= 1;	// turn right
	or.b #1,34(%a0)	|, obj_2(D)->D.1147.status_bits
| EggmanShip.cpp:50: 			health = 255;		// ###
	st 33(%a0)		| obj_2(D)->D.1147.health
| EggmanShip.cpp:51: 			scriptRoutineId++;
	move.b #1,41(%a0)	|, obj_2(D)->scriptRoutineId
	move.w #768,%d2	|, pretmp_106
	jra .L39		|
	.size	executeMasterScript_ObjEggmanShip, .-executeMasterScript_ObjEggmanShip
	.ident	"GCC: (GNU) 12.2.0"
