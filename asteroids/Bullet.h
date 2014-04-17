@interface Bullet : NSObject

- (id)initWithPos:(CGPoint)newPos andVelocity:(CGVector)vel;

- (void)update:(CGFloat)delta;
- (void)draw;

- (CGPoint)getPos;

@end
