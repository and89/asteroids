#import "GameApp.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#include <dispatch/dispatch.h>



@interface GameApp (Private)

- (void)mainLoop;

@end

@implementation GameApp
{
    BOOL _animating;
    NSInteger _animationFrameInterval;
    id _displayLink;
    CFTimeInterval _lastTime;
    
    CGFloat _maximumFrameRate;
    CGFloat _minimumFrameRate;
    CGFloat _updateInterval;
    CGFloat _maxCyclesPerFrame;
    
    double _lastFrameTime;
    double _cyclesLeftOver;
}

+ (instancetype)sharedGameApp
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
        _animating = FALSE;
        _animationFrameInterval = 1;
        _displayLink = nil;
        _maximumFrameRate = 60.0f;
        _minimumFrameRate = 10.0f;
        _updateInterval = 1.0 / _maximumFrameRate;
        _maxCyclesPerFrame = _maximumFrameRate / _minimumFrameRate;
        _lastFrameTime = 0.0;
        _cyclesLeftOver = 0.0;
        
        self.screenSize = CGSizeMake(568, 320);
        
        self.currentScene = [[MainMenuScene alloc] initWithSize:self.screenSize andResult:YES];
        
        self.state = kGameMenuState;
        
        srandomdev();
    }
    
    return self;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    // Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		_animationFrameInterval = frameInterval;
		
		if (_animating)
		{
			[self stop];
			[self run];
		}
	}
}

- (void)run
{
    if (!_animating)
	{
        // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
        // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
        // not be called in system versions earlier than 3.1.
        
        _displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(mainLoop)];
        
        [_displayLink setFrameInterval:_animationFrameInterval];
        
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		_animating = TRUE;
        
        _lastTime = CFAbsoluteTimeGetCurrent();
	}
}

- (void)stop
{
    if (_animating)
	{
        [_displayLink invalidate];
        _displayLink = nil;
		_animating = FALSE;
	}
}

- (void)mainLoop
{
    double currentTime;
    double updateIterations;
    
    // Apple advises to use CACurrentMediaTime() as CFAbsoluteTimeGetCurrent() is synced with the mobile
	// network time and so could change causing hiccups.
    currentTime = CACurrentMediaTime();
    updateIterations = ((currentTime - _lastFrameTime) + _cyclesLeftOver);
    
    if(updateIterations > (_maxCyclesPerFrame * _updateInterval))
        updateIterations = _maxCyclesPerFrame * _updateInterval;
    
    while(updateIterations >= _updateInterval)
    {
        updateIterations -= _updateInterval;
        
        /* Update the game */
        [self.currentScene update:_updateInterval];
        [self.controller updateScore];
    }
    
    _cyclesLeftOver = updateIterations;
    _lastFrameTime = currentTime;
    
    /* Draw the game */
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.currentScene draw];
    
    [self.glView swapBuffers];
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
    
    [self.currentScene touchesBegan:loc];
}

- (void)touchesMoved:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];
    
    [self.currentScene touchesMoved:loc];
}

- (void)touchesEnd:(CGPoint)location
{
    CGPoint loc = [self adjustTouchOrientationForTouch:location];

    [self.currentScene touchesEnd:loc];
}

- (void)increaseScore:(NSUInteger)value
{
    self.score += value;
}

- (void)resetScore
{
    self.score = 0;
}

- (void)updateState:(GameState)toState
{
    if(self.state != toState)
    {
        self.currentScene = nil;
        
        if(toState == kGamePlayState)
        {
            [self resetScore];
            self.currentScene = [[GameScene alloc] initWithSize:self.screenSize];
        }
        else if(toState == kGameOverState)
        {
            self.currentScene = [[MainMenuScene alloc] initWithSize:self.screenSize andResult:NO];
            [self.controller goToMainMenu];
        }
        else if(toState == kGameMenuState)
        {
            self.currentScene = [[MainMenuScene alloc] initWithSize:self.screenSize andResult:YES];
        }
        
        self.state = toState;
    }
}

- (void)dealloc
{
    self.currentScene = nil;
}

@end