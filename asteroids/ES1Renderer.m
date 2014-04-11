#import "ES1Renderer.h"
#import "GameApp.h"

@implementation ES1Renderer

// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            return nil;
        }
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
        
        gameApp = [GameApp sharedGameApp];
	}
	
	return self;
}

- (void) render {
    
    // Clear the color buffer which clears the screen
    glClear(GL_COLOR_BUFFER_BIT);
    
    [gameApp draw];
    
	// Present the renderbuffer to the screen
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    [gameApp setScreenSize:CGSizeMake(backingWidth, backingHeight)];
    
    // Initialize OpenGL now that the necessary buffers have been created and bound
	[self initOpenGL];
    
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	context = nil;
}

- (void)initOpenGL
{
    // Switch to GL_PROJECTION matrix mode and reset the current matrix with the identity matrix
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    glOrthof(0, backingWidth, 0, backingHeight, -1, 1);
    
    // Set the viewport
    glViewport(0, 0, backingWidth, backingHeight);
    
    // Switch to GL_MODELVIEW so we can now draw our objects
	glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    //glTranslatef(-backingWidth/2.0f, -backingHeight/2.0f, 0.0f);
    
	// Set the colour to use when clearing the screen with glClear
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
	// We are not using the depth buffer in our 2D game so depth testing can be disabled.  If depth
	// testing was required then a depth buffer would need to be created as well as enabling the depth
	// test
	glDisable(GL_DEPTH_TEST);
    
    // Enable the OpenGL states we are going to be using when rendering
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
}

@end