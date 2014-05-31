#import "GameEntity.h"

@implementation GameEntity

- (instancetype)initWithPos:(CGPoint)startPos
{
    return [self initWithPos:startPos size:CGSizeMake(0.0f, 0.0f) vel:CGVectorMake(0.0f, 0.0f) ang:0.0f];
}

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize
{
    return [self initWithPos:startPos size:startSize vel:CGVectorMake(0.0f, 0.0f) ang:0.0f];
}

- (instancetype)initWithPos:(CGPoint)startPos vel:(CGVector)startVel
{
    return [self initWithPos:startPos size:CGSizeMake(0.0f, 0.0f) vel:startVel ang:0.0f];
}

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel
{
    return [self initWithPos:startPos size:startSize vel:startVel ang:0.0f];
}

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel ang:(CGFloat)startAngle
{
    if(self = [super init])
    {
        self.position = startPos;
        self.size = startSize;
        self.velocity = startVel;
        self.accelerate = 1.0f;
        self.angle = startAngle;
        self.dead = NO;
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    /* Move to new position */
    _position.x += _velocity.dx * _accelerate;
    _position.y += _velocity.dy * _accelerate;
}

- (void)draw
{
}

- (BOOL)intersectWith:(GameEntity *)otherEntity
{    
    CGFloat r = MAX(_size.width, _size.height);

    CGPoint otherPos = [otherEntity position];
    
    CGFloat otherR = MAX([otherEntity size].width, [otherEntity size].height);
    
    if(fabsf(self.position.x - otherPos.x) > (r + otherR))
        return NO;
    
    if(fabsf(self.position.y - otherPos.y) > (r + otherR))
        return NO;
    
    return YES;
}

@end
