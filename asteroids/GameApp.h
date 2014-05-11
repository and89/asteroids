@class Player;
@class Asteroids;
@class Bullets;
@class ES1Renderer;

@interface GameApp : NSObject

@property (nonatomic, readwrite, assign) CGSize screenSize;

@property (nonatomic, readwrite, strong) Player * player;

@property (nonatomic, readwrite, strong) Asteroids * asteroids;

@property (nonatomic, readwrite, strong) Bullets * bullets;

@property (nonatomic, readwrite, assign) BOOL gameOver;

+ (instancetype)sharedGameApp;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

- (void)fire;

@end
