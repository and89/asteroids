#import "EAGLView.h"
#import "ES1Renderer.h"
#import "GameApp.h"

@interface EAGLView (Private)

- (void)gameLoop;

@end

@implementation EAGLView
{
    CGFloat maximumFrameRate;
    CGFloat minimumFrameRate;
    CGFloat updateInterval;
    CGFloat maxCyclesPerFrame;
    
    double lastFrameTime;
    double cyclesLeftOver;
}

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id) initWithCoder:(NSCoder*)coder {    
    if ((self = [super initWithCoder:coder]))
	{
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		renderer = [[ES1Renderer alloc] init];
		
		if (!renderer)
		{
            return nil;
		}
        
		animating = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
        
        maximumFrameRate = 60.0f;
        minimumFrameRate = 10.0f;
        updateInterval = 1.0 / maximumFrameRate;
        maxCyclesPerFrame = maximumFrameRate / minimumFrameRate;
        
        lastFrameTime = 0.0;
        cyclesLeftOver = 0.0;
        
        gameApp = [GameApp sharedGameApp];
    }
    
    return self;
}

- (void)gameLoop
{
    double currentTime;
    double updateIterations;
    
    // Apple advises to use CACurrentMediaTime() as CFAbsoluteTimeGetCurrent() is synced with the mobile
	// network time and so could change causing hiccups.
    currentTime = CACurrentMediaTime();
    updateIterations = ((currentTime - lastFrameTime) + cyclesLeftOver);
    
    if(updateIterations > (maxCyclesPerFrame * updateInterval))
        updateIterations = maxCyclesPerFrame * updateInterval;
    
    while(updateIterations >= updateInterval)
    {
        updateIterations -= updateInterval;
        
        [gameApp update:updateInterval];
    }
    
    cyclesLeftOver = updateIterations;
    lastFrameTime = currentTime;
    
    [self drawView:nil];
}

- (void) drawView:(id)sender
{
    [renderer render];
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating)
	{
        // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
        // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
        // not be called in system versions earlier than 3.1.

        displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(gameLoop)];
        [displayLink setFrameInterval:animationFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		animating = TRUE;
        
        lastTime = CFAbsoluteTimeGetCurrent();
	}
}

- (void)stopAnimation
{
	if (animating)
	{
        [displayLink invalidate];
        displayLink = nil;
		animating = FALSE;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [gameApp touchesBegan:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [gameApp touchesMoved:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [gameApp touchesEnd:location];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) dealloc
{
    renderer = nil;
    
    gameApp = nil;
}

@end
