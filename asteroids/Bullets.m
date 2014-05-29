#import "Bullets.h"
#import "Bullet.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Bullets

- (id)init
{
    if(self = [super init])
    {
        self.bullets = [[NSMutableArray alloc] initWithCapacity:128];
        
        self.bulletVelocity = 10.0f;
        
        self.bulletSize = CGSizeMake(8.0f, 8.0f);
    }
    
    return self;
}

- (void)addBullet:(CGPoint)pos andAngle:(CGFloat)angle
{
    CGFloat dx = self.bulletVelocity * sin(DEGREES_TO_RADIANS(angle));
    CGFloat dy = self.bulletVelocity * cos(DEGREES_TO_RADIANS(angle));
    
    Bullet * bullet = [[Bullet alloc] initWithPos:pos size:self.bulletSize vel:CGVectorMake(dx, dy)];
    
    [self.bullets addObject:bullet];
}

- (void)update:(CGFloat)delta
{
    CGSize screenSize = [[GameApp sharedGameApp] screenSize];
    
    NSMutableArray * deadBullets = [[NSMutableArray alloc] init];
    
    for(Bullet * bullet in self.bullets)
    {
        [bullet update:delta];
        
        CGPoint pos = [bullet position];
        
        if([bullet dead] == YES || pos.x < 0 || pos.x > screenSize.width || pos.y < 0 || pos.y > screenSize.height)
        {
            [deadBullets addObject:bullet];
        }
    }
    
    [self.bullets removeObjectsInArray:deadBullets];

}

- (void)draw
{
    for(Bullet * bullet in self.bullets)
    {
        [bullet draw];
    }
}

- (void)dealloc
{
    self.bullets = nil;
}

@end
