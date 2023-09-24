
#define _DEBUG_

#include "FakeSignpost.hpp"
#include "Debugger.hpp"
#include "S1Engine.hpp"

extern uint8_t Map_Sign[];
extern uint8_t Map_Ring[];
extern uint8_t Ani_Sign[];

extern LevelObject v_player;
extern uint8_t f_timecount;
extern uint16_t v_limitright2;
extern uint16_t v_limitleft2;

const int8_t ObjFakeSignpost::sparkleData[] = {
	-0x18,-0x10,
		8,   8,
	-0x10,   0,
	 0x18,  -8,
		0,  -8,
	 0x10,   0,
	-0x18,   8,
	 0x18, 0x10,
};

void ObjFakeSignpost::execute() {
	switch (routine_id) {
	case 0x00:	// Init
		render_bits = 0x4;
		art = 0x680;
		maps = Map_Sign;
		visible_width = 0x18;
		sprite_layer = 4;
		anim_id = 3;				// use Sonic's animation
		routine_id++;
		//fallthrough

	case 0x01:	// Wait touch
		if (v_player.position.x - position.x >= 0x20) {
			playSound__cdecl(0xE0);			// fade out music
			v_limitleft2 = v_limitright2;	// lock screen position
			f_timecount = 0x00;				// stop time counter
			routine_id++;
		}
		goto display;

	case 0x02:	// spinning
		if (spintime-- == 0) {
			if (--anim_id) {
				spintime = 60;
			}
			// Spinning complete
			else {
				spintime = 60;
				routine_id++;
			}
		}

		// Do sparkles
		if (!sparkletime--) {
			sparkletime = 0xB;
			LevelObject * sparkle = static_cast<LevelObject*>(findFreeObj__cdecl());
			if (sparkle) {
				sparkle->id = 0x25;
				sparkle->render_bits = 0x4;
				sparkle->art = 0x27B2;
				sparkle->maps = Map_Ring;
				sparkle->sprite_layer = 2;
				sparkle->routine_id = 0x06;	// ring sparkle
				sparkle->position.x = position.x + sparkleData[sparkle_pos];
				sparkle->position.y = position.y + sparkleData[sparkle_pos+1];
				// Debug::kwrite("Made sparkle: x=\x81, y=\x81\xE0", sparkle->position.x, sparkle->position.y);
				sparkle_pos = ((sparkle_pos + 2) & 0xE);
			}
		}
		goto display;

	case 0x03:	// Summon Eggman
		if (!spintime--) {
			LevelObject * eggman = static_cast<LevelObject*>(findFreeObj__cdecl());
			if (eggman) {
				eggman->id = 0x3D;	// that's it, the boss will handle the rest
			}
			routine_id++;
		}
		goto display;

	case 0x04:	// Wait deletion
		if (!(render_bits & 0x80)) {
			addPLC__cdecl(1);	// restore monitor patterns
			deleteObject__cdecl(this);
			return;
		}

	display:
		animateSprite__cdecl(this, Ani_Sign);
		displaySprite__cdecl(this);
		break;

	}
};

void execute_ObjFakeSignpost(ObjFakeSignpost &obj) {
	obj.execute();
}
