#include "myLib.h"
#include "SplashBackground.h"
#include "SpriteSheet.h"

// function pointer - state
void (*state)();

unsigned int buttons;
unsigned int oldButtons;

extern OBJ_ATTR shadowOAM[128];

// prototypes
void init();
void gotoSplash();
void updateSplash();
void gotoGame();
void updateGame();
void gotoPause();
void updatePause();

// -------------------------

// Main loop
int main() {

	init();
	gotoSplash();

	while(1) {

		// update buttons
		oldButtons = buttons;
		buttons = BUTTONS;

		// run game state
		state();
	}
}

// -------------------------

void init() {
	REG_DISPCTL = MODE0 | BG0_ENABLE | SPRITE_ENABLE;
	fillScreen(BLUE);
}

// ---- STATE MACHINE ------

void gotoSplash() {
	state = updateSplash;

	REG_BG0CNT = BG_SIZE0 | CBB(0) | SBB(31);

	DMANow(3, SplashBackgroundPal, PALETTE, SplashBackgroundPalLen/2);
	DMANow(3, SplashBackgroundTiles, &CHARBLOCKBASE[0], SplashBackgroundTilesLen/2);	
	DMANow(3, SplashBackgroundMap, &SCREENBLOCKBASE[31], SplashBackgroundMapLen/2);

	DMANow(3, SpriteSheetPal, SPRITE_PALETTE, 256);
	DMANow(3, SpriteSheetTiles, &CHARBLOCKBASE[4], SpriteSheetTilesLen/2);
}

void updateSplash() {

	if (BUTTON_PRESSED(BUTTON_A) || BUTTON_PRESSED(BUTTON_START)) {
		gotoGame();
	}

}

void gotoGame() {
	state = updateGame;

	fillScreen(RED);
}

void updateGame() {

	if (BUTTON_PRESSED(BUTTON_START)) {
		gotoPause();
	}

}

void gotoPause() {
	state = updatePause;

	fillScreen(GREEN);
}

void updatePause() {


	if (BUTTON_PRESSED(BUTTON_START)) {
		gotoGame();
	}

}
