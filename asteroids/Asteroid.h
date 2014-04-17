@interface Asteroid : NSObject

- (void)update:(CGFloat)delta;
- (void)draw;

- (CGSize)getBounds;
- (CGPoint)getPos;

@end
