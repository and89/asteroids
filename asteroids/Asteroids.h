@class ES1Renderer;

@class Asteroid;

@interface Asteroids : NSObject

- (id)init;

- (void)addAsteroid;
- (void)collide:(NSUInteger)i;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (NSMutableArray *)getArray;

@end
