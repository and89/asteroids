#import "Misc.h"

@class ES1Renderer;

@interface Player : NSObject

- (id)init;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (CGPoint)getPos;
- (CGSize)getSize;
- (CGFloat)getAngle;
- (AABB)getAABB;

- (void)collisionAsteroids:(NSMutableArray *)asteroids withBullets:(NSMutableArray *)bullets;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

@end