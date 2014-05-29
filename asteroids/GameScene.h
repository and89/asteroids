#import "AbstractScene.h"

@class Player;
@class Asteroids;
@class Bullets;

/* The main game scene */
@interface GameScene : AbstractScene

@property (nonatomic, readwrite, strong) Player * player;

@property (nonatomic, readwrite, strong) Asteroids * asteroids;

@property (nonatomic, readwrite, strong) Bullets * bullets;

- (void)fire;

@end
