#import "Bullet.h"
#import "ES1Renderer.h"

@implementation Bullet
{
    CGPoint pos;
    CGSize size;
    CGVector velocity;
    
    BOOL dead;
}


- (id)initWithPos:(CGPoint)newPos andSize:(CGSize)newSize andVelocity:(CGVector)vel
{
    if(self = [super init])
    {
        pos = newPos;
        size = newSize;
        velocity = vel;
        dead = NO;
    }
    
    return self;
}

- (CGPoint)getPos
{
    return pos;
}

- (CGSize)getSize
{
    return size;
}

- (CGVector)getVector
{
    return velocity;
}

- (BOOL)getDead
{
    return dead;
}

- (void)setDead
{
    dead = YES;
}

- (AABB)getAABB
{
    AABB aabb;
    aabb.c = pos;
    aabb.r = MAX(size.width, size.height);
    return aabb;
}

- (void)update:(CGFloat)delta
{
    pos.x = pos.x + velocity.dx;
    pos.y = pos.y + velocity.dy;
}

- (void)draw:(ES1Renderer *)renderer
{
    [renderer renderBullet:self];
}

@end
