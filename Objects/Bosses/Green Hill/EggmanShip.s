	.file	"EggmanShip.cpp"
| GNU C++20 (GCC) version 12.2.0 (m68k-elf)
|	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

| GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
| options passed: -mcpu=68000 -mpcrel -mno-sep-data -mshort -O3 -std=c++20 -ffreestanding -fno-exceptions -fno-rtti -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer
	.text
	.align	2
	.globl	_ZN13ObjEggmanShip19executeMasterScriptEv
	.type	_ZN13ObjEggmanShip19executeMasterScriptEv, @function
_ZN13ObjEggmanShip19executeMasterScriptEv:
	move.l %d2,-(%sp)	|,
	move.l 8(%sp),%a0	| this, this
| EggmanShip.cpp:7: 	switch (scriptId) {
	tst.b 40(%a0)	| this_4(D)->scriptId
	jeq .L13		|
| EggmanShip.cpp:14: 		asm("illegal");
#APP
| 14 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
#NO_APP
	move.w 18(%a0),%d0	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1021.yf, pretmp_98
.L9:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)this_4(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)this_4(D)].position.D.1009.yf
| EggmanShip.cpp:18: };
	move.l (%sp)+,%d2	|,
	rts	
.L13:
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	move.b 41(%a0),%d1	| this_4(D)->scriptRoutineId, _19
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a0),%d0	| this_4(D)->D.1143.velocity.D.1021.yf, pretmp_98
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	tst.b %d1	| _19
	jeq .L3		|
	cmp.b #1,%d1	|, _19
	jne .L9		|
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a0),%d2	| this_4(D)->D.1143.position.D.1004.x, pretmp_87
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	move.w 12(%a0),%d1	| this_4(D)->D.1143.position.D.1009.y, pretmp_89
.L5:
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%d2	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:38: 			if (screenX < 320/2 + 0x20) {
	cmp.w #191,%d2	|, screenX
	jgt .L6		|
| EggmanShip.cpp:39: 				velocity.xf += 0x20;
	add.w #32,16(%a0)	|, this_4(D)->D.1143.velocity.D.1016.xf
.L7:
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d1	|, screenY
	jle .L8		|
.L14:
| EggmanShip.cpp:46: 				velocity.yf -= 0x18;
	add.w #-24,%d0	|, pretmp_98
	move.w %d0,18(%a0)	| pretmp_98, this_4(D)->D.1143.velocity.D.1021.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)this_4(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)this_4(D)].position.D.1009.yf
| EggmanShip.cpp:18: };
	move.l (%sp)+,%d2	|,
	rts	
.L6:
| EggmanShip.cpp:41: 			else if (screenX > 320/2 + 0x30) {
	cmp.w #208,%d2	|, screenX
	jle .L7		|
| EggmanShip.cpp:42: 				velocity.xf -= 0x8;
	subq.w #8,16(%a0)	|, this_4(D)->D.1143.velocity.D.1016.xf
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d1	|, screenY
	jgt .L14		|
.L8:
| EggmanShip.cpp:48: 			else if (screenY < 0x20) {
	cmp.w #31,%d1	|, screenY
	jgt .L9		|
| EggmanShip.cpp:49: 				velocity.yf += 0x0C;
	add.w #12,%d0	|, pretmp_98
	move.w %d0,18(%a0)	| pretmp_98, this_4(D)->D.1143.velocity.D.1021.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)this_4(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)this_4(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)this_4(D)].position.D.1009.yf
| EggmanShip.cpp:18: };
	move.l (%sp)+,%d2	|,
	rts	
.L3:
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w -2304.w,%d2	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, pretmp_87
	add.w #224,%d2	|, pretmp_87
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w %d2,8(%a0)	| pretmp_87, this_4(D)->D.1143.position.D.1004.x
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, pretmp_89
	add.w #176,%d1	|, pretmp_89
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w %d1,12(%a0)	| pretmp_89, this_4(D)->D.1143.position.D.1009.y
| EggmanShip.cpp:27: 			scriptRoutineId++;
	move.b #1,41(%a0)	|, this_4(D)->scriptRoutineId
	jra .L5		|
	.size	_ZN13ObjEggmanShip19executeMasterScriptEv, .-_ZN13ObjEggmanShip19executeMasterScriptEv
	.align	2
	.globl	_ZN13ObjEggmanShip16script00_TestSeqEv
	.type	_ZN13ObjEggmanShip16script00_TestSeqEv, @function
_ZN13ObjEggmanShip16script00_TestSeqEv:
	move.l 4(%sp),%a0	| this, this
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	move.b 41(%a0),%d0	| this_10(D)->scriptRoutineId, _1
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	jeq .L16		|
	cmp.b #1,%d0	|, _1
	jne .L15		|
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a0),%d1	| this_10(D)->D.1143.position.D.1004.x, pretmp_39
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	move.w 12(%a0),%d0	| this_10(D)->D.1143.position.D.1009.y, pretmp_41
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:38: 			if (screenX < 320/2 + 0x20) {
	cmp.w #191,%d1	|, screenX
	jgt .L19		|
.L25:
| EggmanShip.cpp:39: 				velocity.xf += 0x20;
	add.w #32,16(%a0)	|, this_10(D)->D.1143.velocity.D.1016.xf
.L20:
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d0	|, screenY
	jle .L21		|
.L24:
| EggmanShip.cpp:46: 				velocity.yf -= 0x18;
	add.w #-24,18(%a0)	|, this_10(D)->D.1143.velocity.D.1021.yf
.L15:
| EggmanShip.cpp:55: }
	rts	
.L19:
| EggmanShip.cpp:41: 			else if (screenX > 320/2 + 0x30) {
	cmp.w #208,%d1	|, screenX
	jle .L20		|
| EggmanShip.cpp:42: 				velocity.xf -= 0x8;
	subq.w #8,16(%a0)	|, this_10(D)->D.1143.velocity.D.1016.xf
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d0	|, screenY
	jgt .L24		|
.L21:
| EggmanShip.cpp:48: 			else if (screenY < 0x20) {
	cmp.w #31,%d0	|, screenY
	jgt .L15		|
| EggmanShip.cpp:49: 				velocity.yf += 0x0C;
	add.w #12,18(%a0)	|, this_10(D)->D.1143.velocity.D.1021.yf
| EggmanShip.cpp:55: }
	rts	
.L16:
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w -2304.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, pretmp_39
	add.w #224,%d1	|, pretmp_39
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w %d1,8(%a0)	| pretmp_39, this_10(D)->D.1143.position.D.1004.x
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w -2300.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, pretmp_41
	add.w #176,%d0	|, pretmp_41
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w %d0,12(%a0)	| pretmp_41, this_10(D)->D.1143.position.D.1009.y
| EggmanShip.cpp:27: 			scriptRoutineId++;
	move.b #1,41(%a0)	|, this_10(D)->scriptRoutineId
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d0	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:38: 			if (screenX < 320/2 + 0x20) {
	cmp.w #191,%d1	|, screenX
	jgt .L19		|
	jra .L25		|
	.size	_ZN13ObjEggmanShip16script00_TestSeqEv, .-_ZN13ObjEggmanShip16script00_TestSeqEv
	.align	2
	.globl	executeMasterScript_ObjEggmanShip
	.type	executeMasterScript_ObjEggmanShip, @function
executeMasterScript_ObjEggmanShip:
	move.l %d2,-(%sp)	|,
	move.l 8(%sp),%a0	| obj, obj
| EggmanShip.cpp:7: 	switch (scriptId) {
	tst.b 40(%a0)	| obj_2(D)->scriptId
	jeq .L38		|
| EggmanShip.cpp:14: 		asm("illegal");
#APP
| 14 "EggmanShip.cpp" 1
	illegal
| 0 "" 2
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
#NO_APP
	move.w 18(%a0),%d0	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1021.yf, pretmp_98
.L34:
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| EggmanShip.cpp:60: }
	move.l (%sp)+,%d2	|,
	rts	
.L38:
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	move.b 41(%a0),%d1	| obj_2(D)->scriptRoutineId, _15
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	move.w 18(%a0),%d0	| obj_2(D)->D.1143.velocity.D.1021.yf, pretmp_98
| EggmanShip.cpp:21: 	switch (scriptRoutineId) {
	tst.b %d1	| _15
	jeq .L28		|
	cmp.b #1,%d1	|, _15
	jne .L34		|
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	move.w 8(%a0),%d2	| obj_2(D)->D.1143.position.D.1004.x, pretmp_87
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	move.w 12(%a0),%d1	| obj_2(D)->D.1143.position.D.1009.y, pretmp_89
.L30:
| EggmanShip.cpp:35: 			const auto screenX = position.x - camera->x;
	sub.w -2304.w,%d2	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, screenX
| EggmanShip.cpp:36: 			const auto screenY = position.y - camera->y;
	sub.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, screenY
| EggmanShip.cpp:38: 			if (screenX < 320/2 + 0x20) {
	cmp.w #191,%d2	|, screenX
	jgt .L31		|
| EggmanShip.cpp:39: 				velocity.xf += 0x20;
	add.w #32,16(%a0)	|, obj_2(D)->D.1143.velocity.D.1016.xf
.L32:
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d1	|, screenY
	jle .L33		|
.L39:
| EggmanShip.cpp:46: 				velocity.yf -= 0x18;
	add.w #-24,%d0	|, pretmp_98
	move.w %d0,18(%a0)	| pretmp_98, obj_2(D)->D.1143.velocity.D.1021.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| EggmanShip.cpp:60: }
	move.l (%sp)+,%d2	|,
	rts	
.L31:
| EggmanShip.cpp:41: 			else if (screenX > 320/2 + 0x30) {
	cmp.w #208,%d2	|, screenX
	jle .L32		|
| EggmanShip.cpp:42: 				velocity.xf -= 0x8;
	subq.w #8,16(%a0)	|, obj_2(D)->D.1143.velocity.D.1016.xf
| EggmanShip.cpp:45: 			if (screenY > 0x30) {
	cmp.w #48,%d1	|, screenY
	jgt .L39		|
.L33:
| EggmanShip.cpp:48: 			else if (screenY < 0x20) {
	cmp.w #31,%d1	|, screenY
	jgt .L34		|
| EggmanShip.cpp:49: 				velocity.yf += 0x0C;
	add.w #12,%d0	|, pretmp_98
	move.w %d0,18(%a0)	| pretmp_98, obj_2(D)->D.1143.velocity.D.1021.yf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	move.w 16(%a0),%d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf,
	ext.l %d1	| MEM[(struct LevelObject *)obj_2(D)].velocity.D.1016.xf
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	lsl.l #8,%d1	|, tmp61
| Engine.hpp:116: 		this->position.xf += ((int32_t)this->velocity.xf) << 8;
	add.l %d1,8(%a0)	| tmp61, MEM[(struct LevelObject *)obj_2(D)].position.D.1004.xf
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	ext.l %d0	| pretmp_98
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	lsl.l #8,%d0	|, tmp63
| Engine.hpp:117: 		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	add.l %d0,12(%a0)	| tmp63, MEM[(struct LevelObject *)obj_2(D)].position.D.1009.yf
| EggmanShip.cpp:60: }
	move.l (%sp)+,%d2	|,
	rts	
.L28:
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w -2304.w,%d2	| MEM[(struct Vector2_32F *)4294964992B].D.1004.x, pretmp_87
	add.w #224,%d2	|, pretmp_87
| EggmanShip.cpp:25: 			position.x = camera->x + 320/2 + 0x40;
	move.w %d2,8(%a0)	| pretmp_87, obj_2(D)->D.1143.position.D.1004.x
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w -2300.w,%d1	| MEM[(struct Vector2_32F *)4294964992B].D.1009.y, pretmp_89
	add.w #176,%d1	|, pretmp_89
| EggmanShip.cpp:26: 			position.y = camera->y + 224/2 + 0x40;
	move.w %d1,12(%a0)	| pretmp_89, obj_2(D)->D.1143.position.D.1009.y
| EggmanShip.cpp:27: 			scriptRoutineId++;
	move.b #1,41(%a0)	|, obj_2(D)->scriptRoutineId
	jra .L30		|
	.size	executeMasterScript_ObjEggmanShip, .-executeMasterScript_ObjEggmanShip
	.ident	"GCC: (GNU) 12.2.0"
