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
    Player * player;
    
    Bullets * bullets;
    
    Asteroids * asteroids;
    
    CGSize screenSize;
    
    /* Position where user start touch */
    CGPoint startPoint;
    
    /* Position of touch when user move finger on the screen */
    CGPoint currentPoint;
    
    /* Time when user began touch */
    CGFloat currentTime;
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
        screenSize = CGSizeMake(480, 320);
        
        player = [[Player alloc] initWithPos:CGPointMake(screenSize.width / 2, screenSize.height / 2) size:CGSizeMake(10.0f, 10.0f)];
        
        bullets = [[Bullets alloc] init];
        
        asteroids = [[Asteroids alloc] init];
        
        srandomdev();
    }
    
    return self;
}

- (CGSize)getScreenSize
{
    return screenSize;
}

- (void)setScreenSize:(CGSize)newSize
{
    screenSize = newSize;
}

- (void)fire
{
    CGFloat angle = [player angle];
    CGPoint pos = [player position];
    [bullets addBullet:pos andAngle:-angle];
}

- (void)update:(CGFloat)delta
{
    [asteroids update:delta];
    
    [bullets update:delta];
    
    [player update:delta];
    
    NSMutableArray * allAsteroids = [asteroids bigAsteroids];
    
    NSMutableArray * allBullets = [bullets bullets];
    
    for(Asteroid * asteroid in allAsteroids)
    {
        if([asteroid intersectWith:player])
        {
            NSLog(@"GAMEOVER");
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
    
    for(Asteroid * small in [asteroids smallAsteroids])
    {
        if([small intersectWith:player])
        {
            NSLog(@"GAMEVOR");
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
    [asteroids draw:renderer];
    
    [bullets draw:renderer];
    
    [player draw:renderer];
}

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch
{
	CGPoint touchLocation;
    touchLocation.x = aTouch.x;
	touchLocation.y = screenSize.height - aTouch.y;
    
#ifdef DEBUG
    //NSLog(@"tap location: %f,%f", touchLocation.x, touchLocation.y);
#endif
	
	return touchLocation;
}

- (void)touchesBegan:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [player touchesBegan:loc];
}

- (void)touchesMoved:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [player touchesMoved:loc];
}

- (void)touchesEnd:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [player touchesEnd:loc];
}

@end