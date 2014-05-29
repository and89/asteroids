#import "Bullet.h"

@implementation Bullet

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel
{
    if(self = [super initWithPos:startPos size:startSize vel:startVel])
    {
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [super update:delta];
}

- (void)draw
{
    [super draw];
    
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
    
    glTranslatef(self.position.x, self.position.y, 0.0f);
    glScalef(self.size.width, self.size.height, 1.0f);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

@end
