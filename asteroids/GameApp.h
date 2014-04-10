#include "Player.h"

@interface GameApp : NSObject

+ (id)sharedGameApp;

- (void)update:(CGFloat)delta;
- (void)draw;

- (CGSize)getScreenSize;
- (void)setScreenSize:(CGSize)newSize;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch;

@end
