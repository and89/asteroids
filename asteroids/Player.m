#import "Player.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Player
{
    /* where to go */
    CGPoint _target;
    
    CGPoint _startPos;
    CGPoint _currPos;
    
    BOOL _isMove;
    
    BOOL _needMove;
}

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize
{
    if(self = [super initWithPos:startPos size:startSize])
    {
        self.accelerate = 1.0f;
        
        _target = startPos;
        
        _startPos = CGPointZero;
        _currPos = CGPointZero;
        
        _isMove = NO;
        _needMove = NO;
    }
    return self;
}

- (void)update:(CGFloat)delta
{
    if(!_needMove)
        return;
    
    [super update:delta];
    
    CGVector deltaPos = CGVectorMake(_target.x - self.position.x, _target.y - self.position.y);
    
    float dist = DISTANCE(deltaPos.dx, deltaPos.dy);
    
    self.accelerate = dist / 8.0f;
    
    CGVector normalized = CGVectorMake(deltaPos.dx / dist, deltaPos.dy / dist);
    
    self.velocity = normalized;
    
    self.angle = RADIANS_TO_DEGREES(acosf(normalized.dx));
    
    if(normalized.dy < 0.0)
        self.angle *= -1.0f;
    
    self.angle = self.angle - 90.0f;
    
    if(fabsf(_target.x - self.position.x) < 1.0f && fabsf(_target.y - self.position.y) < 1.0f)
    {
        self.position = _target;
        _needMove = NO;
    }
}

- (void)draw
{
    [super draw];
    
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
    
    glTranslatef(self.position.x, self.position.y, 0.0f);
    glRotatef(self.angle, 0.0f, 0.0f, 1.0f);
    glScalef(self.size.width, self.size.height, 1.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

- (void)touchesBegan:(CGPoint)location
{
    if(_isMove)
        return;
    
    _startPos = location;
}

- (void)touchesMoved:(CGPoint)location
{
    _isMove = YES;
    
    _currPos = location;
}

- (void)touchesEnd:(CGPoint)location
{
    if(_isMove)
    {
        _target.x = location.x;
        _target.y = location.y;
        
        _needMove = YES;
        
        _isMove = NO;
    }
}

@end