#import "EAGLView.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class AbstractScene;

typedef enum {
    kGameMenuState,
    kGamePlayState,
    kGameOverState
} GameState;

/* This is main class of the game */
@interface GameApp : NSObject

@property (nonatomic, readwrite, weak) EAGLView * glView;

@property (nonatomic, readwrite, assign) CGSize screenSize;

@property (nonatomic, readwrite, strong) AbstractScene * currentScene;

@property (nonatomic, readwrite, assign) GameState state;

@property (nonatomic, readwrite, assign) NSUInteger score;

@property (nonatomic, readwrite, weak) ViewController * controller;

+ (instancetype)sharedGameApp;

- (void) setAnimationFrameInterval:(NSInteger)frameInterval;
- (void) run;
- (void) stop;

- (void)touchesBegan:(CGPoint)location;
- (void)touchesMoved:(CGPoint)location;
- (void)touchesEnd:(CGPoint)location;

- (void)increaseScore:(NSUInteger)value;
- (void)resetScore;

- (void)updateState:(GameState)toState;

@end
