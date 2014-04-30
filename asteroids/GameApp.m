#import "GameApp.h"
#import "Player.h"
#import "Bullet.h"
#import "Bullets.h"
#import "Asteroid.h"
#import "Asteroids.h"
#import "ES1Renderer.h"
#include <dispatch/dispatch.h>

@implementation GameApp
{
}

+ (id)sharedGameApp
{
    static GameApp * app;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        app = [[self alloc] init];
    });
    
    return app;
}

- (id)init
{
    if(self = [super init])
    {
        self.screenSize = CGSizeMake(480, 320);
        
        self.player = [[Player alloc] initWithPos:CGPointMake(self.screenSize.width / 2, self.screenSize.height / 2) size:CGSizeMake(10.0f, 10.0f)];
        
        self.bullets = [[Bullets alloc] init];
        
        self.asteroids = [[Asteroids alloc] init];
        
        self.gameOver = NO;
        
        srandomdev();
    }
    
    return self;
}

- (void)fire
{
    CGFloat angle = [self.player angle];
    CGPoint pos = [self.player position];
    [self.bullets addBullet:pos andAngle:-angle];
}

- (void)update:(CGFloat)delta
{
    [self.asteroids update:delta];
    
    [self.bullets update:delta];
    
    [self.player update:delta];
    
    NSMutableArray * allAsteroids = [self.asteroids bigAsteroids];
    
    NSMutableArray * allBullets = [self.bullets bullets];
    
    for(Asteroid * asteroid in allAsteroids)
    {
        if([asteroid intersectWith:self.player])
        {
            self.gameOver = YES;
        }
        
        for(Bullet * bullet in allBullets)
        {
            if([bullet intersectWith:asteroid])
            {
                [asteroid setDead:YES];
                [bullet setDead:YES];
            }
        }
    }
    
    for(Asteroid * small in [self.asteroids smallAsteroids])
    {
        if([small intersectWith:self.player])
        {
            self.gameOver = YES;
        }
        
        for(Bullet * bullet in allBullets)
        {
            if([bullet intersectWith:small])
            {
                [small setDead:YES];
                [bullet setDead:YES];
            }
        }
    }
}

- (void)draw:(ES1Renderer *)renderer
{
    [self.asteroids draw:renderer];
    
    [self.bullets draw:renderer];
    
    [self.player draw:renderer];
}

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch
{
	CGPoint touchLocation;
    touchLocation.x = aTouch.x;
	touchLocation.y = self.screenSize.height - aTouch.y;
	
	return touchLocation;
}

- (void)touchesBegan:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [self.player touchesBegan:loc];
}

- (void)touchesMoved:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [self.player touchesMoved:loc];
}

- (void)touchesEnd:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [self.player touchesEnd:loc];
}

@end