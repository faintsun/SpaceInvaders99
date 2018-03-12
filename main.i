# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 1 "myLib.h" 1



typedef unsigned short u16;
# 45 "myLib.h"
extern unsigned short *videoBuffer;

extern unsigned short *frontBuffer;
extern unsigned short *backBuffer;



void loadPalette(const unsigned short* palette);
void initialize();

void waitForVblank();
void flipPage();

void fillScreen(unsigned short color);
void setPixel(int, int, unsigned short);


void drawBackgroundImage3(const unsigned short * image);
# 83 "myLib.h"
extern unsigned int oldButtons;
extern unsigned int buttons;
# 93 "myLib.h"
void DMANow(int channel, volatile const void *src, volatile void *dst, unsigned int cnt);






typedef volatile struct
{
        volatile const void *src;
        volatile void *dst;
        volatile unsigned int cnt;
} DMA;

extern DMA *dma;
# 222 "myLib.h"
typedef struct { u16 tileimg[8192]; } charblock;
typedef struct { u16 tilemap[1024]; } screenblock;
# 279 "myLib.h"
typedef struct{
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
}OBJ_ATTR;

typedef struct {
    int row;
    int col;
} Sprite;
# 2 "main.c" 2
# 1 "SplashBackground.h" 1
# 22 "SplashBackground.h"
extern const unsigned short SplashBackgroundTiles[32];


extern const unsigned short SplashBackgroundMap[1024];


extern const unsigned short SplashBackgroundPal[16];
# 3 "main.c" 2
# 1 "SpriteSheet.h" 1
# 21 "SpriteSheet.h"
extern const unsigned short SpriteSheetTiles[16384];


extern const unsigned short SpriteSheetPal[16];
# 4 "main.c" 2


void (*state)();

unsigned int buttons;
unsigned int oldButtons;

extern OBJ_ATTR shadowOAM[128];


void init();
void gotoSplash();
void updateSplash();
void gotoGame();
void updateGame();
void gotoPause();
void updatePause();




int main() {

 init();
 gotoSplash();

 while(1) {


  oldButtons = buttons;
  buttons = *(volatile unsigned int *)0x04000130;


  state();
 }
}



void init() {
 *(unsigned short *)0x4000000 = 0 | (1<<8) | (1 << 12);
 fillScreen(((10) | (20)<<5 | (31)<<10));
}



void gotoSplash() {
 state = updateSplash;

 *(volatile unsigned short*)0x4000008 = 0<<14 | 0 << 2 | 31 << 8;

 DMANow(3, SplashBackgroundPal, ((u16 *)0x5000000), 32/2);
 DMANow(3, SplashBackgroundTiles, &((charblock *)0x6000000)[0], 64/2);
 DMANow(3, SplashBackgroundMap, &((screenblock *)0x6000000)[31], 2048/2);

 DMANow(3, SpriteSheetPal, ((unsigned short*)(0x5000200)), 256);
 DMANow(3, SpriteSheetTiles, &((charblock *)0x6000000)[4], 32768/2);
}

void updateSplash() {

 if ((!(~(oldButtons)&((1<<0))) && (~buttons & ((1<<0)))) || (!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3))))) {
  gotoGame();
 }

}

void gotoGame() {
 state = updateGame;

 fillScreen(((31) | (0)<<5 | (0)<<10));
}

void updateGame() {

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3))))) {
  gotoPause();
 }

}

void gotoPause() {
 state = updatePause;

 fillScreen(((0) | (31)<<5 | (0)<<10));
}

void updatePause() {


 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3))))) {
  gotoGame();
 }

}
