#import "EAGLView.h"
#import "GameApp.h"

@implementation EAGLView

// You must implement this method
+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder]))
	{
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		_renderer = [[ES1Renderer alloc] init];
		
		if (!_renderer)
		{
            return nil;
		}
        
        _context = [_renderer context];
        
        [_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:eaglLayer];
        
        [[GameApp sharedGameApp] setGlView:self];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
	[_renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    
    [[GameApp sharedGameApp] setScreenSize:[_renderer getScreenSize]];
}

- (void)swapBuffers
{
    [_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [[GameApp sharedGameApp] touchesBegan:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [[GameApp sharedGameApp] touchesMoved:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [[GameApp sharedGameApp] touchesEnd:location];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) dealloc
{
    _renderer = nil;
    _context = nil;
}

@end
