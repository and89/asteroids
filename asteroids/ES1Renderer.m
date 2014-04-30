#import "ES1Renderer.h"
#import "GameApp.h"
#import "Player.h"
#import "Bullet.h"
#import "Asteroid.h"
#import "Misc.h"

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
    
    [gameApp draw:self];
    
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

- (void)renderPlayer:(Player *)player
{
    static const int corners = 3;
    
    static const GLfloat vertices[corners * 2] = {
        -1.0f, -1.0f,
        0.0f, 1.0f,
        1.0f, -1.0f,
    };
    
    static const GLubyte colors[corners * 2 * 4] = {
        200, 50, 50, 255,
        200, 200, 50, 255,
        200, 50, 50, 255,
    };
    
    static const GLubyte indices[corners] = {
        0, 1, 2
    };
    
    glPushMatrix();
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef([player position].x, [player position].y, 0.0f);
    glRotatef([player angle], 0.0f, 0.0f, 1.0f);
    glScalef([player size].width, [player size].height, 1.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)renderBullet:(Bullet *)bullet
{
    static const int corners = 4;
    
    static const GLfloat vertices[corners * 2] = {
        -0.1f, -0.1f,
        -0.1f, 0.1f,
        0.1f, 0.1f,
        0.1f, -0.1f,
    };
    
    static const GLubyte colors[corners * 4] = {
        255, 50, 50, 255,
        255, 50, 50, 255,
        255, 50, 50, 255,
        255, 50, 50, 255,
    };
    
    static const GLubyte indices[corners] = {
        0, 1, 2, 3
    };
    
    glPushMatrix();
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef([bullet position].x, [bullet position].y, 0.0f);
    glScalef([bullet size].width, [bullet size].height, 1.0f);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)renderAsteroid:(Asteroid *)asteroid
{
    static const int corners = 6;
    
    static GLfloat vertices[corners * 2];
    
    static const GLubyte colors[corners * 4] = {
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
    };
    
    static GLubyte indices[corners];
    
    static BOOL verticesInited = NO;
    
    if(!verticesInited)
    {
        float angle = 0.0f;
        for(unsigned int i=0; i<corners; ++i)
        {
            vertices[i * 2] = cosf(angle);
            vertices[i * 2 + 1] = sinf(angle);
            indices[i] = i;
            angle += 2.0 * M_PI / corners;
        }
        verticesInited = YES;
    }
    
    glPushMatrix();
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef([asteroid position].x, [asteroid position].y, 0.0f);
    glRotatef([asteroid angle], 0.0f, 0.0f, 1.0f);
    glScalef([asteroid size].width, [asteroid size].height, 1.0f);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)renderRect:(CGRect)rect
{
    static const int corners = 4;
    
    static GLfloat vertices[corners * 2];
    
    vertices[0] = rect.origin.x;
    vertices[1] = rect.origin.y;
    vertices[2] = rect.size.width;
    vertices[3] = rect.origin.y;
    vertices[4] = rect.size.width;
    vertices[5] = rect.size.height;
    vertices[6] = rect.origin.x;
    vertices[7] = rect.size.height;
    
    static const GLubyte colors[corners * 4] = {
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
    };
    
    static const GLubyte indices[corners] = {
        0,1,2,3,
    };
    
    glPushMatrix();
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(1.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    glPopMatrix();
}

@end