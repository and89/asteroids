#import "ViewController.h"
#import "GameApp.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[GameApp sharedGameApp] setController:self];
    [[GameApp sharedGameApp] setState:kGameMenuState];
    [[GameApp sharedGameApp] run];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTap:(id)sender
{
    [(UIButton *)sender setHidden:YES];
    
    [[GameApp sharedGameApp] updateState:kGamePlayState];
}

- (void)goToMainMenu
{
    [self.playButton setTitle:@"replay" forState:UIControlStateNormal];
    [self.playButton setHidden:NO];
}

- (void)updateScore
{
    NSUInteger score = [[GameApp sharedGameApp] score];
    [self.scoreLabel setText:[NSString stringWithFormat:@"score: %d", score]];
}

- (void)dealloc
{
    self.scoreLabel = nil;
    self.playButton = nil;
}

@end
