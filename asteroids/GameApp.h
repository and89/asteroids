#include "Player.h"

@class ES1Renderer;

@interface GameApp : NSObject

+ (id)sharedGameApp;

- (void)update:(CGFloat)delta;
- (void)draw;

- (CGSize)getScreenSize;
- (void)setScreenSize:(CGSize)newSize;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

/* Adapt coordinate */
- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch;

@end
