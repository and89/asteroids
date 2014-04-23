#import "Asteroids.h"
#import "Asteroid.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Asteroids
{
    NSMutableArray * bigAsteroids;
    NSMutableArray * smallAsteroids;
    
    CGFloat respawnPeriod;
    CGFloat respawnTime;
    
    NSInteger maxAsteroids;
}

- (id)init
{
    if(self = [super init])
    {
        bigAsteroids = [[NSMutableArray alloc] initWithCapacity:64];
        
        smallAsteroids = [[NSMutableArray alloc] initWithCapacity:128];
        
        respawnPeriod = 4.0f;
        respawnTime = 0.0f;
        
        maxAsteroids = 8;
    }
    
    return self;
}

- (void)addAsteroid
{
    CGSize screenSize = [[GameApp sharedGameApp] getScreenSize];
    
    CGSize size = CGSizeMake(30.0f, 30.0f);
    
    CGFloat minY = screenSize.height;
    CGFloat maxY = screenSize.height + 30.0f;
    
    CGFloat minX = -30.0f;
    CGFloat maxX = 0.0f;
    
    CGFloat randomX = -40.0f + 10.0f * RANDOM_MINUS_1_TO_1();
    CGFloat randomY = screenSize.height + 40.0f + 10.0f * RANDOM_MINUS_1_TO_1();
    
    CGPoint startPos = CGPointMake(randomX, randomY);
    
    Asteroid * newAsteroid = [[Asteroid alloc] initWithPos:startPos size:size];
    
    [bigAsteroids addObject:newAsteroid];
}

- (void)addSmallAsteroid:(CGPoint)startPos vel:(CGVector)velocity
{
    CGSize size = CGSizeMake(15.0f, 15.0f);
    
    Asteroid * newAsteroid1 = [[Asteroid alloc] initWithPos:startPos size:size vel:velocity];
    Asteroid * newAsteroid2 = [[Asteroid alloc] initWithPos:startPos size:size vel:velocity];
    Asteroid * newAsteroid3 = [[Asteroid alloc] initWithPos:startPos size:size vel:velocity];
    
    [bigAsteroids addObject:newAsteroid1];
    [bigAsteroids addObject:newAsteroid2];
    [bigAsteroids addObject:newAsteroid3];
}

- (NSMutableArray *)getArray
{
    return bigAsteroids;
}

- (void)update:(CGFloat)delta
{
    NSMutableArray * screenOut = [[NSMutableArray alloc] init];
    
    for(Asteroid * asteroid in bigAsteroids)
    {
        [asteroid update:delta];
        
        if([asteroid getDead])
            [screenOut addObject:asteroid];
    }
    
    for(Asteroid * asteroid in screenOut)
    {
        CGPoint oldPos = [asteroid getPos];
        CGVector oldVel = [asteroid getVelocity];
        CGSize oldSize = [asteroid getSize];
        if(oldSize.width > 15.0f)
            [self addSmallAsteroid:oldPos vel:oldVel];
    }
    
    [bigAsteroids removeObjectsInArray:screenOut];
    
    respawnTime += delta;
    
    if(respawnTime >= respawnPeriod)
    {
        if([bigAsteroids count] < maxAsteroids)
        {
            [self addAsteroid];
        }
        
        respawnTime = 0.0f;
    }
}

- (void)draw:(ES1Renderer *)renderer
{
    for(Asteroid * asteroid in bigAsteroids)
    {
        [asteroid draw:renderer];
    }
}

@end
