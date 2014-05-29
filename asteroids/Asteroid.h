#import "GameEntity.h"

@interface Asteroid : GameEntity

/* Angular velocity */
@property (nonatomic, readwrite, assign) CGFloat angVelocity;

/* Start with random velocity */
- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize;

/* Start chunk after big asteroid crash */
- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel;

- (void)update:(CGFloat)delta;
- (void)draw;

@end
