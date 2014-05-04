#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class GameEntity;

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

- (void)renderPlayer:(GameEntity *)player;
- (void)renderBullet:(GameEntity *)bullet;
- (void)renderAsteroid:(GameEntity *)asteroid;
- (void)renderRect:(GameEntity *)entity;
- (void)renderLine:(GameEntity *)chunk;

@end
