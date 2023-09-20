
#pragma once

#include <cstdint>

extern "C" int16_t objFloorDist__cdecl(void * sprite);

extern "C" uint32_t randomNumber__cdecl();

extern "C" void animateSprite__cdecl(void * sprite, void * animation);

extern "C" void deleteObject__cdecl(void * sprite);

extern "C" void displaySprite__cdecl(void * sprite);

extern "C" void playSound__cdecl(uint8_t id);
