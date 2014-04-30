@class ES1Renderer;
@class Asteroid;

@interface Asteroids : NSObject

@property (nonatomic, readwrite, assign) CGFloat respawnPeriod;

@property (nonatomic, readwrite, assign) NSInteger numberOfChunks;

@property (nonatomic, readwrite, assign) CGSize bigAsteroidSize;

@property (nonatomic, readwrite, assign) CGSize smallAsteroidSize;

@property (nonatomic, readwrite, assign) NSUInteger maxAsteroidsCount;

@property (nonatomic, readwrite, strong) NSMutableArray * bigAsteroids;

@property (nonatomic, readwrite, strong) NSMutableArray * smallAsteroids;

- (id)init;

- (void)addBigAsteroid;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

@end
