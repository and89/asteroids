#import "Misc.h"

@class ES1Renderer;

@interface Asteroid : NSObject

- (id)initWithPos:(CGPoint)startPos size:(CGSize)newSize;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (CGVector)getVelocity;
- (AABB)getAABB;
- (CGPoint)getPos;
- (CGFloat)getAngle;
- (CGSize)getSize;

@end
