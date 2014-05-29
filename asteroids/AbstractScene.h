@interface AbstractScene : NSObject

@property (nonatomic, readwrite, assign) CGSize sceneSize;

- (instancetype)init;
- (instancetype)initWithSize:(CGSize)sceneSize;

- (void)update:(CGFloat)delta;
- (void)draw;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;
- (void)touchesCancelled;

@end
