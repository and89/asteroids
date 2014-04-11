#import "Player.h"
#import "Misc.h"
#import <OpenGLES/ES1/gl.h>

@implementation Player
{
    CGPoint pos;
    CGPoint scale;
    CGPoint target;
    CGFloat velocity;
    CGFloat angle;
    CGFloat acceleration;
    CGFloat deceleration;
    BOOL needMove;
}

- (id)init
{
    if(self = [super init])
    {
        pos = CGPointMake(284, 160);
        scale = CGPointMake(10.0f, 10.0f);
        target = CGPointZero;
        velocity = 0.1f;
        angle = 0.0f;
        acceleration = 0.01f;
        deceleration = 3.0f;
        needMove = NO;
    }
    return self;
}

- (void)update:(CGFloat)delta
{
    if(!needMove)
        return;
    
    float deltaX = target.x - pos.x;
    float deltaY = target.y - pos.y;
    float dist = distance(deltaX, deltaY);
    
    if(dist > 1.0f)
    {
        if(dist > 15.0f)
        {
            velocity += acceleration;
        }
        else
        {
            velocity /= deceleration;
        }
        pos.x = pos.x + deltaX * velocity;
        pos.y = pos.y + deltaY * velocity;
        deltaX /= dist;
        deltaY /= dist;
        angle = acosf(deltaX) / M_PI * 180.0f;
        if(deltaY < 0.0)
            angle *= -1.0f;
        angle -= 90.0f;
    }
    pos.x = pos.x + deltaX * velocity;
    pos.y = pos.y + deltaY * velocity;
    
    //if(distance(target.x, pos.x) < 0.01f && distance(target.y, pos.y) < 0.01f)
    //{
        //pos.x = target.x;
        //pos.y = target.y;
        //needMove = NO;
    //}
}

- (void)draw
{
    static const int corners = 3;
    
    static const GLfloat vertices[corners * 2] = {
        -1.0f, -1.0f,
        0.0f, 2.0f,
        1.0f, -1.0f,
    };
    
    static const GLubyte colors[corners * 2 * 4] = {
        50, 50, 255, 255,
        50, 50, 255, 255,
        50, 50, 255, 255,
    };
    
    static const GLubyte indices[corners] = {
        0, 1, 2
    };

    glPushMatrix();
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef(pos.x, pos.y, 0.0f);
    glRotatef(angle, 0.0f, 0.0f, 1.0f);
    glScalef(scale.x, scale.y, 1.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)touchesBegan:(CGPoint)location
{
    
}

- (void)touchesMoved:(CGPoint)location
{
    
}

- (void)touchesEnd:(CGPoint)location
{
    target.x = location.x;
    target.y = location.y;
    needMove = true;
}

@end