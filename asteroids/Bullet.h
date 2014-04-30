#import "GameEntity.h"

@class ES1Renderer;

@interface Bullet : GameEntity

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

@end
