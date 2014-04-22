#import "Bullet.h"
#import "ES1Renderer.h"

@implementation Bullet
{
    CGPoint pos;
    CGSize size;
    CGVector velocity;
}


- (id)initWithPos:(CGPoint)newPos andSize:(CGSize)newSize andVelocity:(CGVector)vel
{
    if(self = [super init])
    {
        pos = newPos;
        size = newSize;
        velocity = vel;
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
