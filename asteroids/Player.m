#import "Player.h"
#import "GameApp.h"
#import "Misc.h"
#import "ES1Renderer.h"

@implementation Player
{
    /* where to go */
    CGPoint _target;
    
    CGPoint _startPos;
    CGPoint _currPos;
    
    BOOL _isMove;
    
    BOOL _needMove;
}

- (id)initWithPos:(CGPoint)startPos size:(CGSize)startSize
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
    //TODO: refactoring!
    
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
    
    if(fabsf(_target.x - self.position.x) < 0.1f && fabsf(_target.y - self.position.y) < 0.1f)
    {
        self.position = _target;
        _needMove = NO;
    }
    
    
    
    /*
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
        angle = RADIANS_TO_DEGREES(acosf(deltaX));
        if(deltaY < 0.0)
            angle *= -1.0f;
        angle -= 90.0f;
    }
    
    CGSize screenSize = [[GameApp sharedGameApp] getScreenSize];
    
    pos.x = pos.x + deltaX * velocity;
    pos.y = pos.y + deltaY * velocity;
    
    if(pos.x > screenSize.width)
        pos.x = 0.0f;
    if(pos.x < 0)
        pos.x = screenSize.width;
    if(pos.y > screenSize.height)
        pos.y = 0.0f;
    if(pos.y < 0)
        pos.y = screenSize.height;
    
    if(fabsf(target.x - pos.x) < 0.1f && fabsf(target.y - pos.y) < 0.1f)
    {
        pos.x = target.x;
        pos.y = target.y;
        needMove = NO;
    }*/
}

- (void)draw:(ES1Renderer *)renderer
{
    [renderer renderPlayer:self];
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
    else
    {
        [[GameApp sharedGameApp] fire];
    }
}

@end