#import "Bullet.h"
#import "ES1Renderer.h"

@implementation Bullet
{
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel
{
    if(self = [super initWithPos:startPos size:startSize vel:startVel])
    {
        
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [super update:delta];
}

- (void)draw:(ES1Renderer *)renderer
{
    [renderer renderBullet:self];
}

@end
