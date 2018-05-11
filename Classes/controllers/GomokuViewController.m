//
//  gomokuViewController.m
//

#import "GomokuViewController.h"
#import "Player.h"
#import "HumanPlayer.h"
#import "Game.h"
#import "AlphaBetaPruner.h"


@implementation GomokuViewController

@synthesize gameBoardController;
@synthesize game;
@synthesize pickerView;
@synthesize boardSizes;
@synthesize config;


- (IBAction) startTwoPlayerGame:(id) sender {
	[self startGameWithPlayers:2];
}

- (void) startGameWithPlayers: (int) playerCount {
	if (game != nil) { 
        game = nil;
	}
	
	game = [[Game alloc] initGameWithConfig:config];
    
	
	[game addPlayer:[[HumanPlayer alloc] initWithGame:game]];
	[game addPlayer:[[AIPlayer alloc] initWithGame:game]];
	[game startGame];
    
	NSLog(@"created game with players: %@", self.game);
//    [gameBoardController initBoardWithGame:game];
    gameBoardController.game = game;
	[self.navigationController pushViewController:gameBoardController animated:YES];
    [gameBoardController initBoardWithGame:self.game];
}

- (void) makeMove: (Move *) move {
    id<Player> player = [self.game currentPlayer];
    if (![player isKindOfClass:[HumanPlayer class]]) {
        NSLog(@"not making a move, current player is not a Human Player, class %@", [player class]);
        return;
    }

    [self.game makeMove:move];
    [self.view setNeedsDisplay];
}

-(void)viewDidLoad {
    if (![self config]) 
        self.config = [[Config alloc] init];
    
    self.config.boardSize = 10;
    
    [super viewDidLoad];
    boardSizes = [[NSMutableArray alloc] initWithCapacity:3];
    [boardSizes addObject:@"10 x 10"];
    [boardSizes addObject:@"15 x 15"];
    [boardSizes addObject:@"19 x 19"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES  animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1 ;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [boardSizes count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [boardSizes objectAtIndex:row];
}

-(NSAttributedString *) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = [boardSizes objectAtIndex:row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return attString;
}


#pragma mark UIPickerViewDelegate methods

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"selected board size: %@. Index of selected color: %i", [boardSizes objectAtIndex:row], row);
    NSString *label = [boardSizes objectAtIndex:row];
    self.config.boardSize = label.intValue;
}


@end
