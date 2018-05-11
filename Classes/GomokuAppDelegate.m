//
//  gomokuAppDelegate.m
//  gomoku
//
//  Created by Konstantin Gredeskoul on 5/2/10.
//

#import "GomokuAppDelegate.h"
#import "GomokuViewController.h"
#import "GameBoardViewController.h"

@implementation GomokuAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    CGRect _frame = [UIScreen mainScreen].bounds;
    window.frame = _frame;
    [window setBackgroundColor:[UIColor blueColor]];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GomokuViewController *mainController = [main instantiateInitialViewController];
    GameBoardViewController *gameBoardController = [main instantiateViewControllerWithIdentifier:@"GameBoardViewController"];

    mainController.title = @"New Game";
	mainController.gameBoardController = gameBoardController;
	gameBoardController.mainController = mainController;

    // initialize random number generator
    srand(time(NULL));
	
	navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    [[navController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
    [navController setNavigationBarHidden:YES];
//    [window setRootViewController:navController];
    [window addSubview:navController.view];
    window.rootViewController = navController;
    [window makeKeyAndVisible];
}




@end
