#import "AbstractScene.h"

@interface MainMenuScene : AbstractScene

@property (nonatomic, readwrite, assign) BOOL win;

@property (nonatomic, readwrite, assign) CGRect playButtonRect;

- (instancetype)initWithSize:(CGSize)sceneSize andResult:(BOOL)win;

@end
