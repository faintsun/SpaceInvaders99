
//{{BLOCK(SplashBackground)

//======================================================================
//
//	SplashBackground, 256x256@4, 
//	+ palette 16 entries, not compressed
//	+ 2 tiles (t|f|p reduced) not compressed
//	+ regular map (in SBBs), not compressed, 32x32 
//	Total size: 32 + 64 + 2048 = 2144
//
//	Time-stamp: 2018-03-12, 14:12:56
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_SPLASHBACKGROUND_H
#define GRIT_SPLASHBACKGROUND_H

#define SplashBackgroundTilesLen 64
extern const unsigned short SplashBackgroundTiles[32];

#define SplashBackgroundMapLen 2048
extern const unsigned short SplashBackgroundMap[1024];

#define SplashBackgroundPalLen 32
extern const unsigned short SplashBackgroundPal[16];

#endif // GRIT_SPLASHBACKGROUND_H

//}}BLOCK(SplashBackground)
