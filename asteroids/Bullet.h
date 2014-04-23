#import "Misc.h"

@class ES1Renderer;

@interface Bullet : NSObject

- (id)initWithPos:(CGPoint)newPos andSize:(CGSize)newSize andVelocity:(CGVector)vel;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (CGPoint)getPos;
- (CGSize)getSize;
- (AABB)getAABB;

- (CGVector)getVector;

- (BOOL)getDead;
- (void)setDead;

@end
