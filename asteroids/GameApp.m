#import "GameApp.h"
#import "Player.h"
#import "Asteroids.h"
#import "ES1Renderer.h"
#include <dispatch/dispatch.h>

@implementation GameApp
{
    Player * player;
    
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
        
        player = [[Player alloc] initWithScreenSize:screenSize];
        
        asteroids = [[Asteroids alloc] init];
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

- (void)update:(CGFloat)delta
{
    //[asteroids update:delta];
    
    [player update:delta];
}

- (void)draw
{
    //[asteroids draw];
    
    [player draw];
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