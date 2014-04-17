#import "Bullet.h"
#import <OpenGLES/ES1/gl.h>

@implementation Bullet
{
    CGPoint pos;
    CGSize size;
    CGVector velocity;
}


- (id)initWithPos:(CGPoint)newPos andVelocity:(CGVector)vel
{
    if(self = [super init])
    {
        pos = newPos;
        size = CGSizeMake(8.0f, 8.0f);
        velocity = vel;
    }
    
    return self;
}

- (CGPoint)getPos
{
    return pos;
}

- (void)update:(CGFloat)delta
{
    pos.x = pos.x + velocity.dx;
    pos.y = pos.y + velocity.dy;
}

- (void)draw
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
    
    glTranslatef(pos.x, pos.y, 0.0f);
    glScalef(size.width, size.height, 1.0f);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

@end
