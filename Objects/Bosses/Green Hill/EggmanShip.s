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
| EggmanShip.cpp:14: 	switch (scriptId) {
	tst.b 40(%a2)	| this_4(D)->scriptId
	jeq .L11		|
| EggmanShip.cpp:21: 		asm("illegal");
#APP
| 21 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
#NO_APP
.L3:
| EggmanShip.cpp:29: 	if (!collision_flag) {
	tst.b 32(%a2)	| this_4(D)->D.1363.collision_flag
	jne .L4		|
| EggmanShip.cpp:30: 		if (!flash_timer) {
	move.b 42(%a2),%d0	| this_4(D)->flash_timer, _21
| EggmanShip.cpp:30: 		if (!flash_timer) {
	jeq .L12		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _23
	move.b %d0,42(%a2)	| _23, this_4(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L6		|
.L13:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_25
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L7		|
	clr.w %d0	| iftmp.1_25
.L7:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_25, MEM[(uint16_t *)4294966050B]
.L4:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1224.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1224.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp53
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp53, MEM[(struct LevelObject *)this_4(D)].position.D.1212.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1229.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1229.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp55
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp55, MEM[(struct LevelObject *)this_4(D)].position.D.1217.yf
| EggmanShip.cpp:26: };
	move.l (%sp)+,%a2	|,
	rts	
.L6:
| EggmanShip.cpp:40: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a2)	|, this_4(D)->D.1363.collision_flag
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1224.xf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1224.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp53
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp53, MEM[(struct LevelObject *)this_4(D)].position.D.1212.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1229.yf,
	ext.l %d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1229.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp55
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp55, MEM[(struct LevelObject *)this_4(D)].position.D.1217.yf
| EggmanShip.cpp:26: };
	move.l (%sp)+,%a2	|,
	rts	
.L11:
| EggmanShip.cpp:16: 		script00_TestSeq();
	move.l %a2,-(%sp)	| this,
	jsr _ZN13ObjEggmanShip16script00_TestSeqEv		|
| EggmanShip.cpp:17: 		break;
	addq.l #4,%sp	|,
	jra .L3		|
.L12:
| EggmanShip.cpp:31: 			flash_timer = 0x21;
	move.b #33,42(%a2)	|, this_4(D)->flash_timer
| EggmanShip.cpp:32: 			playSound__cdecl(0xAC);	// play boss damage sound
	move.w #172,-(%sp)	|,
	jsr playSound__cdecl		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	move.b 42(%a2),%d0	| this_4(D)->flash_timer, _21
	addq.l #2,%sp	|,
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _23
	move.b %d0,42(%a2)	| _23, this_4(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L6		|
	jra .L13		|
	.size	_ZN13ObjEggmanShip19executeMasterScriptEv, .-_ZN13ObjEggmanShip19executeMasterScriptEv
	.align	2
	.globl	_ZN13ObjEggmanShip12handleDamageEv
	.type	_ZN13ObjEggmanShip12handleDamageEv, @function
_ZN13ObjEggmanShip12handleDamageEv:
	move.l %a2,-(%sp)	|,
	move.l 8(%sp),%a2	| this, this
| EggmanShip.cpp:29: 	if (!collision_flag) {
	tst.b 32(%a2)	| this_8(D)->D.1363.collision_flag
	jne .L14		|
| EggmanShip.cpp:30: 		if (!flash_timer) {
	move.b 42(%a2),%d0	| this_8(D)->flash_timer, _2
| EggmanShip.cpp:30: 		if (!flash_timer) {
	jeq .L22		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _4
	move.b %d0,42(%a2)	| _4, this_8(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L17		|
.L23:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_15
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L18		|
	clr.w %d0	| iftmp.1_15
.L18:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_15, MEM[(uint16_t *)4294966050B]
.L14:
| EggmanShip.cpp:43: }
	move.l (%sp)+,%a2	|,
	rts	
.L17:
| EggmanShip.cpp:40: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a2)	|, this_8(D)->D.1363.collision_flag
| EggmanShip.cpp:43: }
	move.l (%sp)+,%a2	|,
	rts	
.L22:
| EggmanShip.cpp:31: 			flash_timer = 0x21;
	move.b #33,42(%a2)	|, this_8(D)->flash_timer
| EggmanShip.cpp:32: 			playSound__cdecl(0xAC);	// play boss damage sound
	move.w #172,-(%sp)	|,
	jsr playSound__cdecl		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	move.b 42(%a2),%d0	| this_8(D)->flash_timer, _2
	addq.l #2,%sp	|,
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _4
	move.b %d0,42(%a2)	| _4, this_8(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L17		|
	jra .L23		|
	.size	_ZN13ObjEggmanShip12handleDamageEv, .-_ZN13ObjEggmanShip12handleDamageEv
	.align	2
	.globl	_ZN13ObjEggmanShip16script00_TestSeqEv
	.type	_ZN13ObjEggmanShip16script00_TestSeqEv, @function
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l %a2,-(%sp)	|,
	move.l %d2,-(%sp)	|,
	move.l 12(%sp),%a2	| this, this
| EggmanShip.cpp:46: 	switch (scriptRoutineId) {
	move.b 41(%a2),%d0	| this_12(D)->scriptRoutineId, _1
| EggmanShip.cpp:46: 	switch (scriptRoutineId) {
	jeq .L25		|
	cmp.b #1,%d0	|, _1
	jne .L24		|
| EggmanShip.cpp:66: 			const auto screenX = position.x - camera->x;
	move.w 8(%a2),%a0	| this_12(D)->D.1363.position.D.1212.x, prephitmp_64
| EggmanShip.cpp:67: 			const auto screenY = position.y - camera->y;
	move.w 12(%a2),%d1	| this_12(D)->D.1363.position.D.1217.y, prephitmp_62
| EggmanShip.cpp:71: 				velocity.xf += 0x08/4;
	move.w 16(%a2),%a1	| this_12(D)->D.1363.velocity.D.1224.xf, pretmp_9
| EggmanShip.cpp:67: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1217.y, screenY
| EggmanShip.cpp:72: 				velocity.yf -= 0x01;
	move.w 18(%a2),%d0	| this_12(D)->D.1363.velocity.D.1229.yf, pretmp_74
| EggmanShip.cpp:66: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%a0	| MEM[(struct Vector2_32F *)4294964992B].D.1212.x, screenX
| EggmanShip.cpp:70: 			if (screenX < 320/2 + 0x50) {
	move.w #239,%d2	|,
	cmp.w %a0,%d2	| screenX,
	jlt .L28		|
.L40:
| EggmanShip.cpp:71: 				velocity.xf += 0x08/4;
	move.w %a1,%a0	| pretmp_9, _26
	addq.w #2,%a0	|, _26
| EggmanShip.cpp:72: 				velocity.yf -= 0x01;
	subq.w #1,%d0	|, _28
| EggmanShip.cpp:71: 				velocity.xf += 0x08/4;
	move.w %a0,16(%a2)	| _26, this_12(D)->D.1363.velocity.D.1224.xf
| EggmanShip.cpp:72: 				velocity.yf -= 0x01;
	move.w %d0,18(%a2)	| _28, this_12(D)->D.1363.velocity.D.1229.yf
| EggmanShip.cpp:80: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jle .L30		|
.L39:
| EggmanShip.cpp:80: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	tst.w %d0	| _28
	jle .L31		|
| EggmanShip.cpp:81: 				velocity.yf -= 0x06;
	subq.w #6,%d0	|, _28
	move.w %d0,18(%a2)	| _28, this_12(D)->D.1363.velocity.D.1229.yf
.L31:
| EggmanShip.cpp:88: 			if (throwCooldown) {
	move.b 43(%a2),%d0	| this_12(D)->throwCooldown, _37
| EggmanShip.cpp:88: 			if (throwCooldown) {
	jeq .L34		|
.L32:
| EggmanShip.cpp:89: 				throwCooldown--;
	subq.b #1,%d0	|, _38
	move.b %d0,43(%a2)	| _38, this_12(D)->throwCooldown
| EggmanShip.cpp:91: 			if (!throwCooldown 
	jeq .L34		|
.L24:
| EggmanShip.cpp:105: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L28:
| EggmanShip.cpp:75: 				velocity.xf -= 0x04/4;
	move.w %a1,%a0	| pretmp_9, _26
	subq.w #1,%a0	|, _26
| EggmanShip.cpp:76: 				velocity.yf += 0x01;
	addq.w #1,%d0	|, _28
| EggmanShip.cpp:71: 				velocity.xf += 0x08/4;
	move.w %a0,16(%a2)	| _26, this_12(D)->D.1363.velocity.D.1224.xf
| EggmanShip.cpp:72: 				velocity.yf -= 0x01;
	move.w %d0,18(%a2)	| _28, this_12(D)->D.1363.velocity.D.1229.yf
| EggmanShip.cpp:80: 			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
	cmp.w #40,%d1	|, screenY
	jgt .L39		|
.L30:
| EggmanShip.cpp:83: 			else if (screenY < 224/2 - 0x64 && velocity.yf < 0) {
	cmp.w #11,%d1	|, screenY
	jgt .L31		|
| EggmanShip.cpp:83: 			else if (screenY < 224/2 - 0x64 && velocity.yf < 0) {
	tst.w %d0	| _28
	jge .L31		|
| EggmanShip.cpp:84: 				velocity.yf += 0x08;
	addq.w #8,%d0	|, _28
	move.w %d0,18(%a2)	| _28, this_12(D)->D.1363.velocity.D.1229.yf
| EggmanShip.cpp:88: 			if (throwCooldown) {
	move.b 43(%a2),%d0	| this_12(D)->throwCooldown, _37
| EggmanShip.cpp:88: 			if (throwCooldown) {
	jne .L32		|
.L34:
| EggmanShip.cpp:95: 					randomNumber__cdecl() & 1 
	jsr randomNumber__cdecl		|
| EggmanShip.cpp:94: 				throwObject(
	btst #0,%d0	|, tmp65
	jeq .L36		|
	lea BGHZ_CreateEggmanMonitor__cdecl,%a0	|, iftmp.2_43
.L33:
| EggmanShip.cpp:108: 	LevelObject * spikedBall = createObject(this);
	move.l %a2,-(%sp)	| this,
	jsr (%a0)		| iftmp.2_43
	move.l %d0,%a0	| tmp66, spikedBall
| EggmanShip.cpp:109: 	if (spikedBall != nullptr) {
	addq.l #4,%sp	|,
	tst.l %d0	| spikedBall
	jeq .L35		|
| EggmanShip.cpp:110: 		spikedBall->velocity = velocity;	// transfer velocity vector
	move.l 16(%a2),16(%a0)	| this_12(D)->D.1363.velocity, spikedBall_44->velocity
| EggmanShip.cpp:111: 		spikedBall->position = position;	// transfer position vector
	move.l 8(%a2),%d0	| this_12(D)->D.1363.position,
	move.l 12(%a2),%d1	| this_12(D)->D.1363.position,
	move.l %d0,8(%a0)	|, spikedBall_44->position
	move.l %d1,12(%a0)	|, spikedBall_44->position
.L35:
| EggmanShip.cpp:99: 				throwCooldown = 90;
	move.b #90,43(%a2)	|, this_12(D)->throwCooldown
| EggmanShip.cpp:105: }
	move.l (%sp)+,%d2	|,
	move.l (%sp)+,%a2	|,
	rts	
.L25:
| EggmanShip.cpp:52: 			position.x = camera->x + 320/2 + 0x30;
	move.w -2304.w,%a0	| MEM[(struct Vector2_32F *)4294964992B].D.1212.x, prephitmp_64
	lea (208,%a0),%a0	|, prephitmp_64
| EggmanShip.cpp:52: 			position.x = camera->x + 320/2 + 0x30;
	move.w %a0,8(%a2)	| prephitmp_64, this_12(D)->D.1363.position.D.1212.x
| EggmanShip.cpp:53: 			position.y = camera->y + 224/2 - 0x50;
	move.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1217.y, prephitmp_62
	add.w #32,%d1	|, prephitmp_62
| EggmanShip.cpp:53: 			position.y = camera->y + 224/2 - 0x50;
	move.w %d1,12(%a2)	| prephitmp_62, this_12(D)->D.1363.position.D.1217.y
| EggmanShip.cpp:56: 			status_bits |= 1;	// turn right
	or.b #1,34(%a2)	|, this_12(D)->D.1363.status_bits
| EggmanShip.cpp:57: 			health = 255;		// ###
	st 33(%a2)		| this_12(D)->D.1363.health
| EggmanShip.cpp:58: 			scriptRoutineId++;
	move.b #1,41(%a2)	|, this_12(D)->scriptRoutineId
	move.w #768,%a1	|, pretmp_9
| EggmanShip.cpp:67: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1217.y, screenY
| EggmanShip.cpp:72: 				velocity.yf -= 0x01;
	move.w 18(%a2),%d0	| this_12(D)->D.1363.velocity.D.1229.yf, pretmp_74
| EggmanShip.cpp:66: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%a0	| MEM[(struct Vector2_32F *)4294964992B].D.1212.x, screenX
| EggmanShip.cpp:70: 			if (screenX < 320/2 + 0x50) {
	move.w #239,%d2	|,
	cmp.w %a0,%d2	| screenX,
	jlt .L28		|
	jra .L40		|
.L36:
| EggmanShip.cpp:94: 				throwObject(
	lea BGHZ_CreateSpikedBall__cdecl,%a0	|, iftmp.2_43
	jra .L33		|
	.size	_ZN13ObjEggmanShip16script00_TestSeqEv, .-_ZN13ObjEggmanShip16script00_TestSeqEv
	.align	2
	.globl	_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E
	.type	_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E, @function
_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E:
	move.l %a2,-(%sp)	|,
	move.l 8(%sp),%a2	| this, this
| EggmanShip.cpp:108: 	LevelObject * spikedBall = createObject(this);
	move.l %a2,-(%sp)	| this,
	move.l 16(%sp),%a0	| createObject, createObject
	jsr (%a0)		| createObject
	move.l %d0,%a0	| tmp35, spikedBall
| EggmanShip.cpp:109: 	if (spikedBall != nullptr) {
	addq.l #4,%sp	|,
	tst.l %d0	| spikedBall
	jeq .L41		|
| EggmanShip.cpp:110: 		spikedBall->velocity = velocity;	// transfer velocity vector
	move.l 16(%a2),16(%a0)	| this_4(D)->D.1363.velocity, spikedBall_7->velocity
| EggmanShip.cpp:111: 		spikedBall->position = position;	// transfer position vector
	move.l 8(%a2),%d0	| this_4(D)->D.1363.position,
	move.l 12(%a2),%d1	| this_4(D)->D.1363.position,
	move.l %d0,8(%a0)	|, spikedBall_7->position
	move.l %d1,12(%a0)	|, spikedBall_7->position
.L41:
| EggmanShip.cpp:113: }
	move.l (%sp)+,%a2	|,
	rts	
	.size	_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E, .-_ZN13ObjEggmanShip11throwObjectEPFP11LevelObjectS1_E
	.align	2
	.globl	executeMasterScript_ObjEggmanShip
	.type	executeMasterScript_ObjEggmanShip, @function
executeMasterScript_ObjEggmanShip:
	move.l %a2,-(%sp)	|,
	move.l 8(%sp),%a2	| obj, obj
| EggmanShip.cpp:14: 	switch (scriptId) {
	tst.b 40(%a2)	| obj_2(D)->scriptId
	jeq .L55		|
| EggmanShip.cpp:21: 		asm("illegal");
#APP
| 21 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
#NO_APP
.L47:
| EggmanShip.cpp:29: 	if (!collision_flag) {
	tst.b 32(%a2)	| obj_2(D)->D.1363.collision_flag
	jne .L48		|
| EggmanShip.cpp:30: 		if (!flash_timer) {
	move.b 42(%a2),%d0	| obj_2(D)->flash_timer, _16
| EggmanShip.cpp:30: 		if (!flash_timer) {
	jeq .L56		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _18
	move.b %d0,42(%a2)	| _18, obj_2(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L50		|
.L57:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w #3822,%d0	|, iftmp.1_20
	tst.w -1246.w	| MEM[(uint16_t *)4294966050B]
	jeq .L51		|
	clr.w %d0	| iftmp.1_20
.L51:
| EggmanShip.cpp:37: 			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
	move.w %d0,-1246.w	| iftmp.1_20, MEM[(uint16_t *)4294966050B]
.L48:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1224.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1224.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp53
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp53, MEM[(struct LevelObject *)obj_2(D)].position.D.1212.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1229.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1229.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp55
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp55, MEM[(struct LevelObject *)obj_2(D)].position.D.1217.yf
| EggmanShip.cpp:118: }
	move.l (%sp)+,%a2	|,
	rts	
.L50:
| EggmanShip.cpp:40: 			collision_flag = 0xF;	// restore collision
	move.b #15,32(%a2)	|, obj_2(D)->D.1363.collision_flag
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1224.xf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1224.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d0	|, tmp53
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d0,8(%a2)	| tmp53, MEM[(struct LevelObject *)obj_2(D)].position.D.1212.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a2),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1229.yf,
	ext.l %d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1229.yf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp55
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a2)	| tmp55, MEM[(struct LevelObject *)obj_2(D)].position.D.1217.yf
| EggmanShip.cpp:118: }
	move.l (%sp)+,%a2	|,
	rts	
.L55:
| EggmanShip.cpp:16: 		script00_TestSeq();
	move.l %a2,-(%sp)	| obj,
	jsr _ZN13ObjEggmanShip16script00_TestSeqEv		|
| EggmanShip.cpp:17: 		break;
	addq.l #4,%sp	|,
	jra .L47		|
.L56:
| EggmanShip.cpp:31: 			flash_timer = 0x21;
	move.b #33,42(%a2)	|, obj_2(D)->flash_timer
| EggmanShip.cpp:32: 			playSound__cdecl(0xAC);	// play boss damage sound
	move.w #172,-(%sp)	|,
	jsr playSound__cdecl		|
| EggmanShip.cpp:35: 		if (--flash_timer) {
	move.b 42(%a2),%d0	| obj_2(D)->flash_timer, _16
	addq.l #2,%sp	|,
| EggmanShip.cpp:35: 		if (--flash_timer) {
	subq.b #1,%d0	|, _18
	move.b %d0,42(%a2)	| _18, obj_2(D)->flash_timer
| EggmanShip.cpp:35: 		if (--flash_timer) {
	jeq .L50		|
	jra .L57		|
	.size	executeMasterScript_ObjEggmanShip, .-executeMasterScript_ObjEggmanShip
	.ident	"GCC: (GNU) 12.2.0"
