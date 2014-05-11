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

- (void)draw:(ES1Renderer *)renderer
{
    [super draw:renderer];
    
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