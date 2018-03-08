# 1 "myLib.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "myLib.c"
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
# 2 "myLib.c" 2

unsigned short *videoBuffer = (u16 *)0x6000000;

unsigned short *frontBuffer = (u16 *)0x6000000;
unsigned short *backBuffer = (u16 *)0x600A000;

DMA *dma = (DMA *)0x40000B0;





void loadPalette(const unsigned short* palette) {
 DMANow(3, (unsigned short*)palette, ((u16 *)0x5000000), 256);
}


void DMANow(int channel, volatile const void* source, volatile void* destination, unsigned int control) {
    dma[channel].cnt = 0;
 dma[channel].src = source;
 dma[channel].dst = destination;
 dma[channel].cnt = (1 << 31) | control;
}



void waitForVblank() {
 while(*(volatile u16 *)0x4000006 > 160);
 while(*(volatile u16 *)0x4000006 < 160);
}





void setPixel(int row, int col, unsigned short color) {

    videoBuffer[((row)*(240)+(col))] = color;
}

void fillScreen(unsigned short color) {

    volatile unsigned short c = color;
    DMANow(3, &c, videoBuffer, 38400 | (2 << 23));
}

void drawRect(int x, int y, int height, int width, unsigned short color) {

    volatile unsigned short c = color;
    for (int y2 = 0; y2 < height; y2++) {
        DMANow(3, &c, &videoBuffer[((y + y2)*(240)+(x))], width | (2 << 23));
    }

}

void drawBackgroundImage3(const unsigned short * image) {

    DMANow(3, (unsigned short*)image, videoBuffer, (240*160));
}






void setPixel4(int row, int col, unsigned char index) {

    unsigned short pixel = videoBuffer[((row)*(240)+(col)) / 2];
    if (col & 1) {

        pixel &= 0x00FF;
        videoBuffer[((row)*(240)+(col)) / 2] = pixel | (index << 8);

    } else {

        pixel &= 0xFF00;
        videoBuffer[((row)*(240)+(col)) / 2] = pixel | (index);
    }
}

void fillScreen4(unsigned char colorIndex) {
    volatile unsigned short pixels = (colorIndex << 8) | colorIndex;
    DMANow(3, &pixels, videoBuffer, (2 << 23) | (240 * 160) / 2);
}

void flipPage() {
    if(*(unsigned short *)0x4000000 & (1<<4))
    {
        *(unsigned short *)0x4000000 &= ~(1<<4);
        videoBuffer = backBuffer;
    }
    else
    {
        *(unsigned short *)0x4000000 |= (1<<4);
        videoBuffer = frontBuffer;
    }
}

void drawBackgroundImage4(volatile const unsigned short* image) {

    DMANow(3, (unsigned short*)image, videoBuffer, (240*160) / 2);
}
