#import "AbstractScene.h"

@implementation AbstractScene

- (instancetype)init
{
    return [self initWithSize:CGSizeMake(568, 320)];
}

- (instancetype)initWithSize:(CGSize)sceneSize
{
    if(self = [super init])
    {
        self.sceneSize = sceneSize;
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
}

- (void)draw
{
}

- (void)touchesBegan:(CGPoint)location
{
}

- (void)touchesMoved:(CGPoint)location
{
}

- (void)touchesEnd:(CGPoint)location
{
}

- (void)touchesCancelled
{
}

@end
