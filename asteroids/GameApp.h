@class Asteroid;
@class Bullet;
@class ES1Renderer;

@interface GameApp : NSObject

+ (id)sharedGameApp;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (CGSize)getScreenSize;
- (void)setScreenSize:(CGSize)newSize;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

/* Adapt coordinate */
- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch;

- (void)fire;

- (BOOL)collide:(Asteroid *)asteroid withBullet:(Bullet *)bullet;

@end
