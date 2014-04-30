#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class Player;
@class Bullet;
@class Asteroid;

@interface ES1Renderer : NSObject
{
	EAGLContext * context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
}

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

- (void)renderPlayer:(Player *)player;

- (void)renderBullet:(Bullet *)bullet;

- (void)renderAsteroid:(Asteroid *)asteroid;

- (void)renderRect:(CGRect)rect;

@end
