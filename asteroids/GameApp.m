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
    
    NSInteger marginLeft;
    NSInteger marginRight;
    NSInteger marginTop;
    NSInteger marginBottom;
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
        
        marginLeft = 30;
        marginRight = 30;
        marginTop = 30;
        marginBottom = 30;
        
        player = [[Player alloc] init];
        
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

- (BOOL)collide:(Asteroid *)asteroid withBullet:(Bullet *)bullet
{
    if(intersect([asteroid getAABB], [bullet getAABB]))
        return YES;
    else
        return NO;
}

- (void)fire
{
    CGFloat angle = [player getAngle];
    CGPoint pos = [player getPos];
    [bullets addBullet:pos andAngle:-angle];
}

- (void)update:(CGFloat)delta
{
    [asteroids update:delta];
    
    [bullets update:delta];
    
    [player update:delta];
    
    NSMutableArray * allAsteroids = [asteroids getArray];
    
    NSMutableArray * allBullets = [bullets getArray];
    
    for(Asteroid * asteroid in allAsteroids)
    {
        if(intersect([player getAABB], [asteroid getAABB]))
        {
            NSLog(@"GAMEOVER");
        }
        
        for(Bullet * bullet in allBullets)
        {
            if(intersect([asteroid getAABB], [bullet getAABB]))
            {
                [asteroid setDead];
                [bullet setDead];
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