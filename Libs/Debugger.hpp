
#pragma once

extern "C" void raiseError__cdecl(const char * message, ...);
extern "C" void kwrite_cdecl(const char * message, ...);


namespace Debug {
	#ifdef _DEBUG_
		[[noreturn]] inline void raiseError(const char * message) {
			raiseError__cdecl(message);
		    __builtin_unreachable();
		}

		template<typename... Args> inline void kwrite(const char * message, Args... args) {
			kwrite_cdecl(message, args...);
		}

	#else
		inline void raiseError(const char * _) {
			;
		}

		inline void kwrite(const char * _) {
			;
		}
	#endif
}
