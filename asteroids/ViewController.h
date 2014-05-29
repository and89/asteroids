#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel * scoreLabel;

@property (strong, nonatomic) IBOutlet UIButton * playButton;

- (IBAction)playButtonTap:(id)sender;

- (void)goToMainMenu;
- (void)updateScore;

@end
