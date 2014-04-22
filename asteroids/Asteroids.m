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
    
    CGPoint startPos = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    
    Asteroid * newAsteroid = [[Asteroid alloc] initWithPos:startPos size:size];
    
    [bigAsteroids addObject:newAsteroid];
}

- (void)update:(CGFloat)delta
{
    NSMutableArray * screenOut = [[NSMutableArray alloc] init];
    
    
    CGRect rect = [[GameApp sharedGameApp] getFieldRect];
    
    for(Asteroid * asteroid in bigAsteroids)
    {
        [asteroid update:delta];
        
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
