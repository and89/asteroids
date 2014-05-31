#import "GameScene.h"
#import "Player.h"
#import "Bullets.h"
#import "Bullet.h"
#import "Asteroids.h"
#import "Asteroid.h"
#import "GameApp.h"

@implementation GameScene
{
    BOOL _wasMove;
}

- (instancetype)initWithSize:(CGSize)sceneSize
{
    if(self = [super initWithSize:sceneSize])
    {
        self.player = [[Player alloc] initWithPos:CGPointMake(self.sceneSize.width / 2, self.sceneSize.height / 2) size:CGSizeMake(10.0f, 10.0f)];
        
        self.bullets = [[Bullets alloc] init];
        
        self.asteroids = [[Asteroids alloc] init];
        
        _wasMove = NO;
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [self.asteroids update:delta];
    
    [self.bullets update:delta];
    
    [self.player update:delta];
    
    NSMutableArray * allBullets = [self.bullets bullets];
    
    for(Asteroid * asteroid in [self.asteroids bigAsteroids])
    {
        if([asteroid dead] == YES)
            continue;
        
        if([asteroid intersectWith:self.player])
        {
            [self.player setDead:YES];
            [[GameApp sharedGameApp] updateState:kGameOverState];
            break;
        }
        
        for(Bullet * bullet in allBullets)
        {
            if([bullet dead] == YES)
                continue;
            
            if([bullet intersectWith:asteroid])
            {
                [asteroid setDead:YES];
                [bullet setDead:YES];
                [[GameApp sharedGameApp] increaseScore:10];
            }
        }
    }
    
    for(Asteroid * small in [self.asteroids smallAsteroids])
    {
        if([small dead] == YES)
            continue;
        
        if([small intersectWith:self.player])
        {
            [self.player setDead:YES];
            [[GameApp sharedGameApp] updateState:kGameOverState];
            break;
        }
        
        for(Bullet * bullet in allBullets)
        {
            if([small dead] == YES)
                continue;
            
            if([bullet intersectWith:small])
            {
                [small setDead:YES];
                [bullet setDead:YES];
                [[GameApp sharedGameApp] increaseScore:10];
            }
        }
    }
}

- (void)fire
{
    CGFloat angle = [self.player angle];
    CGPoint pos = [self.player position];
    [self.bullets addBullet:pos andAngle:-angle];
}

- (void)draw
{
    [super draw];
    
    [self.asteroids draw];
    
    [self.bullets draw];
    
    [self.player draw];
}

- (void)touchesBegan:(CGPoint)location
{
    [self.player touchesBegan:location];
}

- (void)touchesMoved:(CGPoint)location
{
    _wasMove = YES;
    
    [self.player touchesMoved:location];
}

- (void)touchesEnd:(CGPoint)location
{
    [self.player touchesEnd:location];
    
    if(!_wasMove)
        [self fire];
    
    _wasMove = NO;
}

- (void)dealloc
{
    self.player = nil;
    self.asteroids = nil;
    self.bullets = nil;
}

@end
