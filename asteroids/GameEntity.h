#import "Misc.h"

@class ES1Renderer;

@interface GameEntity : NSObject

@property (nonatomic, readwrite, assign) CGPoint position;

@property (nonatomic, readwrite, assign) CGSize size;

@property (nonatomic, readwrite, assign) CGVector velocity;

@property (nonatomic, readwrite, assign) CGFloat accelerate;

@property (nonatomic, readwrite, assign) CGFloat angle;

@property (nonatomic, readwrite, assign) BOOL dead;

/* Initializers */
- (instancetype)initWithPos:(CGPoint)startPos;
- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize;
- (instancetype)initWithPos:(CGPoint)startPos vel:(CGVector)startVel;
- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel;
- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel ang:(CGFloat)startAngle;

- (void)update:(CGFloat)delta;
- (void)draw:(ES1Renderer *)renderer;

- (BOOL)intersectWith:(GameEntity *)otherEntity;

@end
