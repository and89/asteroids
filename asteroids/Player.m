#import "Player.h"
#import "Bullets.h"
#import "Asteroid.h"
#import "GameApp.h"
#import "Misc.h"
#import "ES1Renderer.h"

@implementation Player
{
    /* Current pos if ship */
    CGPoint pos;
    
    /* Size */
    CGSize size;
    
    /* where to go */
    CGPoint target;
    
    CGVector speed;
    CGFloat speedDelta;
    
    /* Speed */
    CGFloat velocity;
    
    /* Current angle */
    CGFloat angle;
    
    CGFloat acceleration;
    CGFloat deceleration;
    
    BOOL needMove;
    
    CGPoint startPos;
    BOOL isMove;
    
    Bullets * bullets;
}

- (id)init
{
    if(self = [super init])
    {
        pos = CGPointMake(284, 160);
        size = CGSizeMake(10.0f, 10.0f);
        speed = CGVectorMake(0.0f, 0.0f);
        speedDelta = 0.9;
        target = CGPointZero;
        velocity = 0.05f;
        angle = 0.0f;
        acceleration = 0.008f;
        deceleration = 1.5f;
        needMove = NO;
        isMove = NO;
        bullets = [[Bullets alloc] init];
    }
    return self;
}

- (void)update:(CGFloat)delta
{
    [bullets update:delta];
    
    if(!needMove)
        return;
    
    float deltaX = target.x - pos.x;
    float deltaY = target.y - pos.y;
    float dist = DISTANCE(deltaX, deltaY);
    
    if(dist > 1.0f)
    {
        if(dist > 15.0f)
        {
            velocity += acceleration;
        }
        else
        {
            velocity /= deceleration;
        }
        pos.x = pos.x + deltaX * velocity;
        pos.y = pos.y + deltaY * velocity;
        deltaX /= dist;
        deltaY /= dist;
        angle = RADIANS_TO_DEGREES(acosf(deltaX));
        if(deltaY < 0.0)
            angle *= -1.0f;
        angle -= 90.0f;
    }
    
    CGSize screenSize = [[GameApp sharedGameApp] getScreenSize];
    
    pos.x = pos.x + deltaX * velocity;
    pos.y = pos.y + deltaY * velocity;
    
    if(pos.x > screenSize.width)
        pos.x = 0.0f;
    if(pos.x < 0)
        pos.x = screenSize.width;
    if(pos.y > screenSize.height)
        pos.y = 0.0f;
    if(pos.y < 0)
        pos.y = screenSize.height;
    
    if(fabsf(target.x - pos.x) < 0.1f && fabsf(target.y - pos.y) < 0.1f)
    {
        pos.x = target.x;
        pos.y = target.y;
        needMove = NO;
    }
    
}

- (CGPoint)getPos
{
    return pos;
}

- (CGSize)getSize
{
    return size;
}

- (CGFloat)getAngle
{
    return angle;
}

- (AABB)getAABB
{
    AABB aabb;
    aabb.c = pos;
    aabb.r = MAX(size.width, size.height);
    return aabb;
}

- (void)collisionAsteroids:(NSMutableArray *)asteroids withBullets:(NSMutableArray *)bullets
{
    /*for(Asteroid * asteroid in asteroids)
    {
        for(Bullet * bullet in bullets)
        {
            if(intersect([asteroid getAABB], [bullet getAABB]))
            {
                
            }
        }
    }*/
}

- (void)draw:(ES1Renderer *)renderer
{
    [bullets draw:renderer];
    
    [renderer renderPlayer:self];
}

- (void)touchesBegan:(CGPoint)location
{
    if(isMove)
        return;
    
    startPos = location;
}

- (void)touchesMoved:(CGPoint)location
{
    isMove = YES;
}

- (void)touchesEnd:(CGPoint)location
{
    if(isMove)
    {
        target.x = location.x;
        target.y = location.y;
        
        needMove = YES;
        
        isMove = NO;
    }
    else
    {
        [bullets addBullet:CGPointMake(pos.x, pos.y) andAngle:-angle];
    }
}

@end