#import "GameApp.h"
#import "Player.h"
#include <dispatch/dispatch.h>

@implementation GameApp
{
    Player * player;
    
    NSUInteger screenWidth;
    NSUInteger screenHeight;
    
    UIInterfaceOrientation interfaceOrientation;
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
    return [self initWidthScreenWidth:480 andHeight:320];
}

- (id)initWidthScreenWidth:(NSUInteger)w andHeight:(NSUInteger)h
{
    if(self = [super init])
    {
        screenWidth = w;
        screenHeight = h;
        
        player = [[Player alloc] init];
        
        interfaceOrientation = UIInterfaceOrientationLandscapeRight;
    }
    
    return self;
}

- (CGSize)getScreenSize
{
    return CGSizeMake(screenWidth, screenHeight);
}

- (void)setScreenSize:(CGSize)newSize
{
    screenWidth = newSize.width;
    screenHeight = newSize.height;
}

- (void)update:(CGFloat)delta
{
    [player update:delta];
}

- (void)draw
{
    [player draw];
}

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch
{
	CGPoint touchLocation;
	
	/*if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
		touchLocation.x = aTouch.y;
		touchLocation.y = aTouch.x;
	}
	else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
		touchLocation.x = 480 - aTouch.y;
		touchLocation.y = 320 - aTouch.x;
	}*/
    touchLocation.x = aTouch.x;
	touchLocation.y = screenHeight - aTouch.y;
    NSLog(@"location: %f,%f", touchLocation.x, touchLocation.y);
	
	return touchLocation;
}

- (void)touchesBegan:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [player touchesBegan:loc];
}

- (void)touchesMoved:(CGPoint)location
{
    
}

- (void)touchesEnd:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    [player touchesEnd:loc];
}

@end