@class ES1Renderer;

@interface Bullets : NSObject

@property (nonatomic, readwrite, strong) NSMutableArray * bullets;

@property (nonatomic, readwrite, assign) CGSize bulletSize;

@property (nonatomic, readwrite, assign) CGFloat bulletVelocity;

- (id)init;

- (void)addBullet:(CGPoint)pos andAngle:(CGFloat)angle;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

@end
