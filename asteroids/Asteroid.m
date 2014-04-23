#import "Asteroid.h"
#import "Misc.h"
#import "GameApp.h"
#import "ES1Renderer.h"

@implementation Asteroid
{
    CGPoint pos;
    CGSize size;
    CGFloat angle;
    
    CGVector velocity;
    CGFloat angularVelocity;
    
    BOOL dead;
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)newSize
{
    if(self = [super init])
    {
        pos = startPos;
        
        size = newSize;
        
        angle = 0.0f;
        
        dead = NO;
        
        angularVelocity = 5.0f * RANDOM_MINUS_1_TO_1();
        
        velocity = CGVectorMake(2.0f * RANDOM_MINUS_1_TO_1(), 2.0f * RANDOM_MINUS_1_TO_1());
    }
    
    return self;
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)newSize vel:(CGVector)newVel
{
    if(self = [super init])
    {
        pos = startPos;
        
        size = newSize;
        
        angle = 0.0f;
        
        dead = NO;
        
        angularVelocity = 2.0f * RANDOM_MINUS_1_TO_1();
        
        velocity = CGVectorMake(1.0f * RANDOM_MINUS_1_TO_1(), 1.0f * RANDOM_MINUS_1_TO_1());
        
        velocity.dx += newVel.dx;
        velocity.dy += newVel.dy;
    }
    
    return self;
}

- (BOOL)getDead
{
    return dead;
}

- (void)setDead
{
    dead = YES;
}

- (CGVector)getVelocity

{
    return velocity;
}

- (AABB)getAABB
{
    AABB aabb;
    
    aabb.c = pos;
    aabb.r = MAX(size.width, size.height);
    
    return aabb;
}

- (CGPoint)getPos
{
    return pos;
}

- (CGFloat)getAngle
{
    return angle;
}

- (CGSize)getSize
{
    return size;
}

- (void)update:(CGFloat)delta
{
    pos.x += velocity.dx;
    pos.y += velocity.dy;
    
    angle += angularVelocity;
    
    CGSize rect = [[GameApp sharedGameApp] getScreenSize];
    
    if(pos.x < 0)
        pos.x = rect.width;
    if(pos.x > rect.width)
        pos.x = 0;
    if(pos.y < 0)
        pos.y = rect.height;
    if(pos.y > rect.height)
        pos.y = 0;
}

- (void)draw:(ES1Renderer *)renderer
{
    if(!dead)
        [renderer renderAsteroid:self];
}

@end
