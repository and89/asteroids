#import "GameEntity.h"

@interface Bullet : GameEntity

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel;

- (void)update:(CGFloat)delta;
- (void)draw;

@end
