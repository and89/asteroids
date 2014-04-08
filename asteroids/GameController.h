#import <Foundation/Foundation.h>

@interface GameController : NSObject

+ (GameController *) sharedController;

- (void)Update:(float)withDelta;

- (void)Render;

@end
