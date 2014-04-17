#import "Player.h"
#import "Bullets.h"
#import "GameApp.h"
#import "Misc.h"
#import <OpenGLES/ES1/gl.h>

@implementation Player
{
    /* Current pos if ship */
    CGPoint pos;
    
    /* Size */
    CGSize size;
    
    /* where to go */
    CGPoint target;
    
    CGVector speed;
    CGFloat speedDelta;
    
    /* Speed */
    CGFloat velocity;
    
    /* Current angle */
    CGFloat angle;
    
    CGFloat acceleration;
    CGFloat deceleration;
    
    BOOL needMove;
    
    CGPoint startPos;
    BOOL isMove;
    
    CGSize screenSize;
    
    Bullets * bullets;
}

- (id)initWithScreenSize:(CGSize)scrSize
{
    if(self = [super init])
    {
        pos = CGPointMake(284, 160);
        size = CGSizeMake(10.0f, 10.0f);
        speed = CGVectorMake(0.0f, 0.0f);
        speedDelta = 0.9;
        target = CGPointZero;
        velocity = 0.1f;
        angle = 0.0f;
        acceleration = 0.008f;
        deceleration = 1.5f;
        needMove = NO;
        isMove = NO;
        screenSize = scrSize;
        bullets = [[Bullets alloc] init];
    }
    return self;
}

- (void)update:(CGFloat)delta
{
    [bullets update:delta];
    
    if(!needMove)
        return;
    
    float deltaX = target.x - pos.x;
    float deltaY = target.y - pos.y;
    float dist = DISTANCE(deltaX, deltaY);
    
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
    
    if(fabsf(target.x - pos.x) < 0.1f && fabsf(target.y - pos.y) < 0.1f)
    {
        pos.x = target.x;
        pos.y = target.y;
        needMove = NO;
    }
    
}

- (CGPoint)getPos
{
    return pos;
}

- (CGSize)getSize
{
    return size;
}

- (CGFloat)getAngle
{
    return angle;
}

- (void)draw
{
    [bullets draw];
    
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
    
    glTranslatef(pos.x, pos.y, 0.0f);
    glRotatef(angle, 0.0f, 0.0f, 1.0f);
    glScalef(size.width, size.height, 1.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)touchesBegan:(CGPoint)location
{
    if(isMove)
        return;
    
    startPos = location;
}

- (void)touchesMoved:(CGPoint)location
{
    isMove = YES;
}

- (void)touchesEnd:(CGPoint)location
{
    if(isMove)
    {
        float deltaX = location.x - startPos.x;
        float deltaY = location.y - startPos.y;
        
        target.x = pos.x + deltaX;
        target.y = pos.y + deltaY;
        
        needMove = YES;
        
        isMove = NO;
    }
    else
    {
        [bullets addBullet:CGPointMake(pos.x, pos.y) andAngle:-angle];
    }
}

@end