#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ES1Renderer : NSObject
{
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
}

@property (nonatomic, readonly, strong) EAGLContext * context;

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

- (CGSize)getScreenSize;

@end
