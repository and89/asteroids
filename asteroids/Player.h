@interface Player : NSObject

- (id)init;

- (void)update:(CGFloat)delta;
- (void)draw;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

@end