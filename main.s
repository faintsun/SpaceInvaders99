	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	updatePause
	.syntax unified
	.arm
	.fpu softvfp
	.type	updatePause, %function
updatePause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L11
	ldr	r3, [r3]
	tst	r3, #8
	bxeq	lr
	ldr	r3, .L11+4
	ldr	r3, [r3]
	tst	r3, #8
	bxne	lr
	push	{r4, lr}
	ldr	r2, .L11+8
	ldr	r1, .L11+12
	mov	r0, #31
	ldr	r3, .L11+16
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L12:
	.align	2
.L11:
	.word	oldButtons
	.word	buttons
	.word	state
	.word	updateGame
	.word	fillScreen
	.size	updatePause, .-updatePause
	.align	2
	.global	updateGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateGame, %function
updateGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L22
	ldr	r3, [r3]
	tst	r3, #8
	bxeq	lr
	ldr	r3, .L22+4
	ldr	r3, [r3]
	tst	r3, #8
	bxne	lr
	push	{r4, lr}
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	mov	r0, #992
	ldr	r3, .L22+16
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L23:
	.align	2
.L22:
	.word	oldButtons
	.word	buttons
	.word	state
	.word	updatePause
	.word	fillScreen
	.size	updateGame, .-updateGame
	.align	2
	.global	updateSplash
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateSplash, %function
updateSplash:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L40
	ldr	r3, [r3]
	tst	r3, #1
	beq	.L25
	ldr	r2, .L40+4
	ldr	r2, [r2]
	tst	r2, #1
	beq	.L26
.L25:
	tst	r3, #8
	bxeq	lr
	ldr	r3, .L40+4
	ldr	r3, [r3]
	tst	r3, #8
	bxne	lr
.L26:
	push	{r4, lr}
	ldr	r2, .L40+8
	ldr	r1, .L40+12
	mov	r0, #31
	ldr	r3, .L40+16
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L41:
	.align	2
.L40:
	.word	oldButtons
	.word	buttons
	.word	state
	.word	updateGame
	.word	fillScreen
	.size	updateSplash, .-updateSplash
	.align	2
	.global	init
	.syntax unified
	.arm
	.fpu softvfp
	.type	init, %function
init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	mov	r2, #4352
	push	{r4, lr}
	ldr	r0, .L44
	strh	r2, [r3]	@ movhi
	ldr	r3, .L44+4
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L45:
	.align	2
.L44:
	.word	32394
	.word	fillScreen
	.size	init, .-init
	.align	2
	.global	gotoSplash
	.syntax unified
	.arm
	.fpu softvfp
	.type	gotoSplash, %function
gotoSplash:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, #67108864
	mov	r0, #7936
	ldr	ip, .L48
	ldr	r2, .L48+4
	push	{r4, lr}
	mov	r3, #16
	str	ip, [r2]
	ldr	r4, .L48+8
	strh	r0, [r1, #8]	@ movhi
	mov	r2, #83886080
	ldr	r1, .L48+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r3, #32
	mov	r2, #100663296
	ldr	r1, .L48+16
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r3, #1024
	ldr	r2, .L48+20
	ldr	r1, .L48+24
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r3, #256
	ldr	r2, .L48+28
	ldr	r1, .L48+32
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r3, #16384
	ldr	r2, .L48+36
	ldr	r1, .L48+40
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L49:
	.align	2
.L48:
	.word	updateSplash
	.word	state
	.word	DMANow
	.word	SplashBackgroundPal
	.word	SplashBackgroundTiles
	.word	100726784
	.word	SplashBackgroundMap
	.word	83886592
	.word	SpriteSheetPal
	.word	100728832
	.word	SpriteSheetTiles
	.size	gotoSplash, .-gotoSplash
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #4352
	mov	r5, #67108864
	push	{r7, lr}
	ldr	r0, .L53
	strh	r3, [r5]	@ movhi
	ldr	r3, .L53+4
	mov	lr, pc
	bx	r3
	ldr	r3, .L53+8
	mov	lr, pc
	bx	r3
	ldr	r7, .L53+12
	ldr	r4, .L53+16
	ldr	r6, .L53+20
.L51:
	ldr	r3, [r4]
	str	r3, [r7]
	ldr	r2, [r5, #304]
	ldr	r3, [r6]
	str	r2, [r4]
	mov	lr, pc
	bx	r3
	b	.L51
.L54:
	.align	2
.L53:
	.word	32394
	.word	fillScreen
	.word	gotoSplash
	.word	oldButtons
	.word	buttons
	.word	state
	.size	main, .-main
	.text
	.align	2
	.global	gotoGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	gotoGame, %function
gotoGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, .L57
	ldr	r1, .L57+4
	mov	r0, #31
	ldr	r3, .L57+8
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L58:
	.align	2
.L57:
	.word	state
	.word	updateGame
	.word	fillScreen
	.size	gotoGame, .-gotoGame
	.align	2
	.global	gotoPause
	.syntax unified
	.arm
	.fpu softvfp
	.type	gotoPause, %function
gotoPause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, .L61
	ldr	r1, .L61+4
	mov	r0, #992
	ldr	r3, .L61+8
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L62:
	.align	2
.L61:
	.word	state
	.word	updatePause
	.word	fillScreen
	.size	gotoPause, .-gotoPause
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.comm	state,4,4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
