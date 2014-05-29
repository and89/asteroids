#import "GameEntity.h"

@interface Player : GameEntity

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize;

- (void)update:(CGFloat)delta;
- (void)draw;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

@end