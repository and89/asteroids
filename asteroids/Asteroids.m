#import "Asteroids.h"
#import "Asteroid.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Asteroids
{
    CGFloat _respawnTime;
}

- (id)init
{
    if(self = [super init])
    {
        self.bigAsteroids = [[NSMutableArray alloc] initWithCapacity:64];
        
        self.smallAsteroids = [[NSMutableArray alloc] initWithCapacity:128];
        
        self.respawnPeriod = 4.0f;
        
        self.numberOfChunks = 3;
        
        self.maxAsteroidsCount = 8;
        
        _respawnTime = 0.0f;
        
        self.bigAsteroidSize = CGSizeMake(30.0f, 30.0f);
        
        self.smallAsteroidSize = CGSizeMake(15.0f, 15.0f);
    }
    
    return self;
}

- (void)addBigAsteroid
{
    CGFloat randomPosX = -self.bigAsteroidSize.width;
    CGFloat randomPosY = -self.bigAsteroidSize.height;
    
    CGPoint startPos = CGPointMake(randomPosX, randomPosY);
    
    Asteroid * newAsteroid = [[Asteroid alloc] initWithPos:startPos size:self.bigAsteroidSize];
    
    [self.bigAsteroids addObject:newAsteroid];
}

- (void)addChunks:(CGPoint)ownerPos vel:(CGVector)ownerVel
{
    for(int i=0; i<self.numberOfChunks; ++i)
    {
        Asteroid * chunk = [[Asteroid alloc] initWithPos:ownerPos size:self.smallAsteroidSize vel:ownerVel];
        
        [self.smallAsteroids addObject:chunk];
    }
}

- (void)update:(CGFloat)delta
{
    NSMutableArray * deadBigAsteroids = [[NSMutableArray alloc] init];
    
    NSMutableArray * deadSmallAsteroids = [[NSMutableArray alloc] init];
    
    for(Asteroid * asteroid in self.bigAsteroids)
    {
        [asteroid update:delta];
        
        if([asteroid dead])
            [deadBigAsteroids addObject:asteroid];
    }
    
    for(Asteroid * asteroid in self.smallAsteroids)
    {
        [asteroid update:delta];
        
        if([asteroid dead])
            [deadSmallAsteroids addObject:asteroid];
    }
    
    [self.smallAsteroids removeObjectsInArray:deadSmallAsteroids];
    
    /* Create chunks for every big asteroi */
    for(Asteroid * bigAsteroid in deadBigAsteroids)
    {
        [self addChunks:[bigAsteroid position] vel:[bigAsteroid velocity]];
    }
    
    [self.bigAsteroids removeObjectsInArray:deadBigAsteroids];
    
    _respawnTime += delta;
    
    if((_respawnTime >= self.respawnPeriod) && ([self.bigAsteroids count] < self.maxAsteroidsCount))
    {
        [self addBigAsteroid];
        
        _respawnTime = 0.0f;
    }
}

- (void)draw:(ES1Renderer *)renderer
{
    for(Asteroid * bigAsteroid in self.bigAsteroids)
    {
        [bigAsteroid draw:renderer];
    }
    
    for (Asteroid * smallAsteroid in self.smallAsteroids)
    {
        [smallAsteroid draw:renderer];
    }
}

@end
