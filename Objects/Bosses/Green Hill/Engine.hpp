
#pragma once

#include <cstdint>

/* ------------------------------------------------------------------------- *
 * Generic structures														 *
 * ------------------------------------------------------------------------- */

struct Vector2_32F {
	union {	// Offset 0x00
		int16_t x;		// X as integer
		int32_t xf;		// X with fractional component
	};
	union {	// Offset 0x04
		int16_t y;		// Y as integer
		int32_t yf;		// Y with fractional component
	};
};

struct Vector2_16F {
	union {	// Offset 0x00
		int8_t x;		// X as integer
		int16_t xf;		// X with fractional component
	};
	union {	// Offset 0x02
		int8_t y;		// Y as integer
		int16_t yf;		// Y with fractional component
	};
};

struct Vector2_W {
	int16_t x;
	int16_t y;
};

struct Vector2_L {
	int32_t x;
	int32_t y;
};

union f16 {	// 16-bit fixed (signed)
	int8_t v;
	int16_t vf;
};

union uf16 {	// 16-bit fixed (unsigned)
	int8_t v;
	int16_t vf;
};

union f32 {	// 32-bit fixed (signed)
	int16_t v;
	int16_t vf;
};

union uf32 {	// 32-bit fixed (unsigned)
	uint16_t v;
	uint16_t vf;
};

/* ------------------------------------------------------------------------- *
 * Global game structures													 *
 * ------------------------------------------------------------------------- */

/* Cameras */

inline Vector2_32F * getFGCamera() {
	return (Vector2_32F*)0xFFFFF700;
}

inline Vector2_32F * getBGCamera() {
	return (Vector2_32F*)0xFFFFF708;
}


/* ------------------------------------------------------------------------- *
 * In-game object															 *
 * ------------------------------------------------------------------------- */

struct LevelObject {

	/* Memory management is not supported, because Sonic 1 doesn't provide `malloc` and `free` */
	LevelObject() = delete;
	LevelObject(const LevelObject&) = delete;
	~LevelObject() = delete;

	static const std::size_t maxSize = 0x40;

	uint8_t 	id;
	uint8_t 	render_bits;
	uint16_t 	art;
	const void *maps;
	Vector2_32F	position;					/* 0x08..0x0F */
	Vector2_16F	velocity;					/* 0x10..0x13 */
	int16_t     inertia;
	uint8_t     height;
	uint8_t     width;
	uint8_t 	sprite_layer;
	uint8_t     visible_width;
	uint8_t  	frame_id;
	uint8_t 	anim_pos;
	uint8_t  	anim_id;
	uint8_t  	anim_id_prev;
	uint8_t   	anim_timer;
	uint8_t  	_reserved;
	uint8_t  	collision_flag;
	uint8_t  	health;
	uint8_t  	status_bits;
	uint8_t 	respawn_index;
	uint8_t 	routine_id;
	uint8_t  	subroutine_id;
	f16 		angle;						/* 0x26..0x27 */

	inline void speedToPos() {
		this->position.xf += ((int32_t)this->velocity.xf) << 8;
		this->position.yf += ((int32_t)this->velocity.yf) << 8;
	}

};
