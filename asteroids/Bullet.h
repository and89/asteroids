#import "GameEntity.h"

@class ES1Renderer;

@interface Bullet : GameEntity

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

@end
