#import "Bullets.h"
#import "Bullet.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Bullets
{
    NSMutableArray * bullets;
    
    CGFloat speed;
    
    CGSize size;
}

- (id)init
{
    if(self = [super init])
    {
        bullets = [[NSMutableArray alloc] initWithCapacity:128];
        
        speed = 10.0f;
        
        size = CGSizeMake(8.0f, 8.0f);
    }
    
    return self;
}

- (void)addBullet:(CGPoint)pos andAngle:(CGFloat)angle
{
    CGFloat dx = speed * sin(DEGREES_TO_RADIANS(angle));
    CGFloat dy = speed * cos(DEGREES_TO_RADIANS(angle));
    
    Bullet * bullet = [[Bullet alloc] initWithPos:pos andSize:size andVelocity:CGVectorMake(dx, dy)];
    
    [bullets addObject:bullet];
}

- (void)update:(CGFloat)delta
{
    CGSize scrSize = [[GameApp sharedGameApp] getScreenSize];
    
    NSMutableArray * outOfScreenObjects = [[NSMutableArray alloc] init];
    
    for(Bullet * bullet in bullets)
    {
        [bullet update:delta];
        
        CGPoint pos = [bullet getPos];
        
        if(pos.x < 0 ||
           pos.x > scrSize.width ||
           pos.y < 0 ||
           pos.y > scrSize.height)
        {
            [outOfScreenObjects addObject:bullet];
        }
    }
    
    [bullets removeObjectsInArray:outOfScreenObjects];

}

- (void)draw:(ES1Renderer *)renderer
{
    for(Bullet * bullet in bullets)
    {
        [bullet draw:renderer];
    }
}

@end
