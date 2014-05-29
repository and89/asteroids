#import "MainMenuScene.h"
#import "Asteroids.h"
#import "GameApp.h"

@implementation MainMenuScene
{
    Asteroids * _backgroundAsteroids;
}

- (instancetype)initWithSize:(CGSize)sceneSize andResult:(BOOL)win
{
    if(self = [super initWithSize:sceneSize])
    {
        self.win = win;
        
        self.playButtonRect = CGRectMake(196, 259, 177, 41);
        
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

- (void)touchesEnd:(CGPoint)location
{
    if(CGRectContainsPoint(self.playButtonRect, location))
    {
        [[GameApp sharedGameApp] updateState:kGamePlayState];
    }
}

- (void)dealloc
{
    _backgroundAsteroids = nil;
}

@end
