#import "GameController.h"
#include "GameApplication.h"
#include <dispatch/dispatch.h>

@interface GameController ()
{
    GameApplication gameApp;
}
@end

@implementation GameController

+ (GameController *)sharedController
{
    static GameController * sharedInstance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GameController alloc] init];
    });
    
    return sharedInstance;
}

- (void)Update:(float)withDelta
{
    gameApp.Update(withDelta);
}

- (void)Render
{
    gameApp.Draw();
}

@end
