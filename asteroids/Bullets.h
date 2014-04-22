@class ES1Renderer;

@interface Bullets : NSObject

- (id)init;

- (void)addBullet:(CGPoint)pos andAngle:(CGFloat)angle;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

@end
