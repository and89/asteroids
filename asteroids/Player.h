#import "GameEntity.h"

@class ES1Renderer;

@interface Player : GameEntity

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

@end