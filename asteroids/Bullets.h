@interface Bullets : NSObject

- (id)init;

- (void)addBullet:(CGPoint)pos andAngle:(CGFloat)angle;

- (void)update:(CGFloat)delta;
- (void)draw;

@end
