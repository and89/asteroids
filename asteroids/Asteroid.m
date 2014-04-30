#import "Asteroid.h"
#import "GameApp.h"
#import "ES1Renderer.h"
#import "Misc.h"

@implementation Asteroid
{
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize
{
    if(self = [super initWithPos:startPos size:startSize])
    {
        self.velocity = CGVectorMake(1.0f * RANDOM_MINUS_1_TO_1(), 1.0f * RANDOM_MINUS_1_TO_1());
        
        self.angVelocity = 5.0f * RANDOM_MINUS_1_TO_1();
        
        self.dead = NO;
    }
    
    return self;
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel
{
    if(self = [super initWithPos:startPos size:startSize])
    {
        CGFloat randomVelX = 0.5f * RANDOM_MINUS_1_TO_1();
        CGFloat randomVelY = 0.5f * RANDOM_MINUS_1_TO_1();
        
        CGVector newVelocity = CGVectorMake(startVel.dx + randomVelX, startVel.dy + randomVelY);
        
        self.velocity = newVelocity;
        
        self.angVelocity = 1.0f * RANDOM_MINUS_1_TO_1();
        
        self.dead = NO;
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [super update:delta];
    
    self.angle += self.angVelocity;
    
    CGSize screenRect = [[GameApp sharedGameApp] screenSize];
    
    CGFloat radius = MAX(self.size.width, self.size.height);
    
    if(self.position.x < 0 - radius)
        [self setPosition:CGPointMake(screenRect.width, self.position.y)];
    
    if(self.position.x > screenRect.width + radius)
        [self setPosition:CGPointMake(0.0f, self.position.y)];
    
    if(self.position.y < 0 - radius)
        [self setPosition:CGPointMake(self.position.x, screenRect.height)];
    
    if(self.position.y > screenRect.height + radius)
        [self setPosition:CGPointMake(self.position.x, 0.0f)];
}

- (void)draw:(ES1Renderer *)renderer
{
    [renderer renderAsteroid:self];
}

@end
