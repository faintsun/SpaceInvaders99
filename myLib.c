#include "myLib.h"

unsigned short *videoBuffer = (u16 *)0x6000000;

unsigned short *frontBuffer = (u16 *)0x6000000;
unsigned short *backBuffer =  (u16 *)0x600A000;

DMA *dma = (DMA *)0x40000B0;

// ****************************
//           GENERAL
// ****************************

void loadPalette(const unsigned short* palette) {
	DMANow(3, (unsigned short*)palette, PALETTE, 256);
}


void DMANow(int channel, volatile const void* source, volatile void* destination, unsigned int control) {
    dma[channel].cnt = 0;
	dma[channel].src = source;
	dma[channel].dst = destination;
	dma[channel].cnt = DMA_ON | control;
}



void waitForVblank() {
	while(SCANLINECOUNTER > 160);
	while(SCANLINECOUNTER < 160);
}

// ****************************
//           MODE 3
// ****************************

void setPixel(int row, int col, unsigned short color) {

    videoBuffer[OFFSET(row, col, 240)] = color;
}

void fillScreen(unsigned short color) {

    volatile unsigned short c = color;
    DMANow(3, &c, videoBuffer, 38400 | DMA_SOURCE_FIXED);
}

void drawRect(int x, int y, int height, int width, unsigned short color) {

    volatile unsigned short c = color;
    for (int y2 = 0; y2 < height; y2++) {
        DMANow(3, &c, &videoBuffer[OFFSET(y + y2, x, 240)], width | DMA_SOURCE_FIXED);
    }
       
}

void drawBackgroundImage3(const unsigned short * image) {

    DMANow(3, (unsigned short*)image, videoBuffer, (240*160));
}


// ****************************
//           MODE 4
// ****************************

void setPixel4(int row, int col, unsigned char index) {

    unsigned short pixel = videoBuffer[OFFSET(row, col, 240) / 2];
    if (col & 1) {
        // left side of short
        pixel &= 0x00FF;
        videoBuffer[OFFSET(row, col, 240) / 2] = pixel | (index << 8);

    } else {
        // right side of short
        pixel &= 0xFF00;
        videoBuffer[OFFSET(row, col, 240) / 2] = pixel | (index);
    }
}

void fillScreen4(unsigned char colorIndex) {
    volatile unsigned short pixels = (colorIndex << 8) | colorIndex;
    DMANow(3, &pixels, videoBuffer, DMA_SOURCE_FIXED | (240 * 160) / 2); 
}

void flipPage() {
    if(REG_DISPCTL & BACKBUFFER)
    {
        REG_DISPCTL &= ~BACKBUFFER;
        videoBuffer = backBuffer;
    }
    else
    {
        REG_DISPCTL |= BACKBUFFER;
        videoBuffer = frontBuffer;
    }
}

void drawBackgroundImage4(volatile const unsigned short* image) {

    DMANow(3, (unsigned short*)image, videoBuffer, (240*160) / 2);
}




