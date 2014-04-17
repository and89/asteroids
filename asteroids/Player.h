@interface Player : NSObject

- (id)initWithScreenSize:(CGSize)scrSize;

- (void)update:(CGFloat)delta;
- (void)draw;

- (CGPoint)getPos;
- (CGSize)getSize;
- (CGFloat)getAngle;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

@end