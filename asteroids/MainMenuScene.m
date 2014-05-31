#import "MainMenuScene.h"
#import "Asteroids.h"

@implementation MainMenuScene
{
    Asteroids * _backgroundAsteroids;
}

- (instancetype)initWithSize:(CGSize)sceneSize
{
    if(self = [super initWithSize:sceneSize])
    {
        _backgroundAsteroids = [[Asteroids alloc] init];
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [_backgroundAsteroids update:delta];
}

- (void)draw
{
    [super draw];
    
    [_backgroundAsteroids draw];
}

- (void)dealloc
{
    _backgroundAsteroids = nil;
}

@end
