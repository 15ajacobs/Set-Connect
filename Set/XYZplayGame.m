//
//  XYZplayGame.m
//  Set
//
//  Created by Yael Goldstein on 4/8/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import "XYZplayGame.h"
#import "XYZplayGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "MainMenuViewController.h"

@interface XYZplayGame ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dealtCards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedback;
@property (nonatomic) SetCardDeck *deck;
@property (nonatomic) NSMutableArray *set;
@property (nonatomic) NSNumber *score;
@property (nonatomic) BOOL timerMode;
@property (nonatomic) BOOL timerPaused;
//@property (nonatomic) int *timerModeSetCount;
@property (nonatomic) int setCount;
@property (weak, nonatomic) IBOutlet UILabel *setCountLabel;
@property (nonatomic) UIAlertView *alert;
@end

@implementation XYZplayGame

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setTimer];
    [[self.navigationController navigationBar] removeFromSuperview];
    [self dealCards];
    self.set = [[NSMutableArray alloc] init];
    self.score = 0;
    self.scoreLabel.text = @"SCORE: 0";
//    for (UIButton *button in [self setsLeft]) {
//        NSLog(@"Sets Left: %@", [[button currentAttributedTitle] string]);
//    }
    [self.feedback setText:@""];
    [countdownLabel setText:@""];
    [self.setCountLabel setText: @"SET COUNT: 0"];
    self.setCount = 0;
    
    self.alert = [[UIAlertView alloc] initWithTitle:@"Which Mode?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"PUZZLE", @"SPEED", nil]; //direct buttons to correlated screens, maybe add a see high scores function
    [self.alert show];
    
//    if (self.timerMode) {
//        self.alert = [[UIAlertView alloc] initWithTitle:@"Speed Mode" message:@"Ready???" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Menu", @"Start", nil]; //direct buttons to correlated screens, maybe add a see high scores function
//        [self.alert show];
//    }
}

-(void)dealCards{
    self.deck = [[SetCardDeck alloc] init];
    
    for (UIButton *button in [self dealtCards]) {
        SetCard *randomCard = [self.deck drawRandomCard];
        NSMutableAttributedString *buttonTitle = [randomCard contents];
        [button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    }
}

- (IBAction)clicked:(id)sender {
    if ([[self set] count] < 3) {
        if ([[sender backgroundColor] isEqual: [sender tintColor]]) {
            [self.set removeObject:sender];
            [sender setBackgroundColor:[UIColor whiteColor]];
        } else {
            [self.set addObject:sender];
            [sender setBackgroundColor:[sender tintColor]];
        }
    }
    
    if ([[self set] count] == 3) {
        //add a time delay here!!
        
        BOOL setAchieved = [self isSet:self.set];
        for (UIButton *button in self.set) {
            [button setBackgroundColor:[UIColor whiteColor]];
        }
        
        if (setAchieved) {
            [self rightSet];
        } else {
            [self wrongSet];
        }
        [self.set removeAllObjects];
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [self.score intValue]]];
    }
    
}

-(void)rightSet{
    self.setCount++;
    self.setCountLabel.text = [NSString stringWithFormat: @"SET COUNT: %d", self.setCount];
    self.score = [NSNumber numberWithInt:[self.score intValue] + 5];
    UIColor *green = [UIColor greenColor];
    NSMutableAttributedString *yesFeedback = [[NSMutableAttributedString alloc] initWithString:@"Yes! +5"];
    [yesFeedback addAttribute:NSForegroundColorAttributeName value:green range:NSMakeRange(0, 7)];
    [yesFeedback addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25]  range:NSMakeRange(0, 7)];
    [self.feedback setAttributedText:yesFeedback];
    
    for (UIButton *button in self.set) {
        SetCard *randomCard = [self.deck drawRandomCard];
        if (randomCard == nil) {
            [self endGameWithAlert];
            break;
        } else {
            NSMutableAttributedString *buttonTitle = [randomCard contents];
            [button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
        }
    }
    
    if (self.timerMode) {
        //make sure there is a set left
        //if (self.timerModeSetCount == 5) {
        //alert that you found 5 sets
        //bonus for time
        //stop timer and reset
        //}
        
    }
    
    for (UIButton *button in [self setsLeft]) {
        NSLog(@"Sets Left: %@", [[button currentAttributedTitle] string]);
    }
    if ([self setsLeft] == nil) {
        [self endGameWithAlert];
    }
    //nice sound
    
}

-(void)endGameWithAlert{
    NSString *title = @"";
    if (self.timerMode) {
        title = @"Time's Up!\n\n";
    } else {
        title = @"You've reached the end of the deck!\n\n";
    }
    if ([self addHighScore:self.score]) {
        title = [title stringByAppendingString:@"☆☆☆HIGHSCORE☆☆☆\n"];
    }
    title = [title stringByAppendingString:[NSString stringWithFormat: @"Score:%d", [self.score intValue]]];
    self.alert = [[UIAlertView alloc] initWithTitle:@"Score" message:title delegate:self cancelButtonTitle:nil otherButtonTitles:@"Menu", @"Play Again", nil]; //direct buttons to correlated screens, maybe add a see high scores function
    [self.alert show];
}

-(BOOL)addHighScore:(NSNumber *)newScore{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *highScores =[defaults mutableArrayValueForKey:@"High Scores"];
    int index = -1;
    
    for (int i = 0; i < [highScores count]; i++) {
        if ([highScores objectAtIndex:i] > newScore) {
            index = i-1;
            break;
        } else {
            index = i;
        }
    }
    
    if (index != -1 || [highScores count] == 0) {
        NSNumber *placeholder1 = newScore;
        NSNumber *placeholder2 = nil;
        for (int i = index; i >= 0; i--) {
            placeholder2 = [highScores objectAtIndex:i];
            [highScores setObject:placeholder1 atIndexedSubscript:i];
            placeholder1 = placeholder2;
        }
        [defaults removeObjectForKey:@"High Scores"];
        [defaults setObject:highScores forKey:@"High Scores"];
        [defaults synchronize];
        return YES;
    } else {
        return NO;
    }
    
}

-(void)wrongSet{
    self.score = [NSNumber numberWithInt:[self.score intValue] -2];
    
    UIColor *red = [UIColor redColor];
    NSMutableAttributedString *noFeedback = [[NSMutableAttributedString alloc] initWithString:@"No! -2"];
    [noFeedback addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(0, 6)];
    [noFeedback addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25]  range:NSMakeRange(0, 6)];
    [self.feedback setAttributedText:noFeedback];
    //bad sound
    
}

-(BOOL)isSet:(NSArray *)array{
    BOOL verdict = NO;
    
    NSMutableArray *symbols = [NSMutableArray array];
    NSMutableArray *shading = [NSMutableArray array];
    NSMutableArray *number = [NSMutableArray array];
    NSMutableArray *colors = [NSMutableArray array];
    
    
    for (UIButton *button in array) {
        //Symbol
        //NSLog([[button currentAttributedTitle] string]);
        //NSLog([[[button currentAttributedTitle] string] substringToIndex:1]);
        [symbols addObject:[[[button currentAttributedTitle] string] substringToIndex:1]];
        
        //Number
        if ([[[[button currentAttributedTitle] string] substringToIndex:1] isEqualToString: @"▲"]) {
            [number addObject:[NSNumber numberWithInt:[[[button currentAttributedTitle] string] length]]];
        } else {
            NSNumber *newNumber = [NSNumber numberWithInt:([[[button currentAttributedTitle] string] length]/2)]; // divide by 2 to get rid of extra spaces
            [number addObject:newNumber];
        }
        
        
        //collecting "button" length????
        //Shading
        [shading addObject: [[button currentAttributedTitle] attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil]];
        
        //Color
        [colors addObject: [[button currentAttributedTitle] attribute:NSStrokeColorAttributeName atIndex:0 effectiveRange:nil]];
    }
    
    if (([self allSame:symbols] || [self allDiff:symbols]) && ([self allSame:number] || [self allDiff:number]) && ([self allSame:colors] || [self allDiff:colors]) && ([self allSameShading:shading] || [self allDiffShading:shading])) {
        verdict = YES;
    }
    return verdict;
}

-(BOOL)allSame:(NSArray *)array{
    if ([[array objectAtIndex:0] isEqual: [array objectAtIndex:1]] && [[array objectAtIndex:0] isEqual: [array objectAtIndex:2]]) {
        return YES;
    }
    if (([array objectAtIndex:0] == [array objectAtIndex:1]) && ([array objectAtIndex:0] == [array objectAtIndex:2])) {
        return YES;
    }
    return NO;
}

-(BOOL)allDiff:(NSArray *)array{
    if ([[array objectAtIndex:0] isEqual: [array objectAtIndex:1]] || [[array objectAtIndex:0] isEqual: [array objectAtIndex:2]] || [[array objectAtIndex:1] isEqual: [array objectAtIndex:2]]) {
        return NO;
    }
    if (([array objectAtIndex:0] == [array objectAtIndex:1]) || ([array objectAtIndex:0] == [array objectAtIndex:2]) || ([array objectAtIndex:1] == [array objectAtIndex:2])) {
        return NO;
    }
    return YES;
}

-(BOOL)allDiffShading:(NSArray *)array{
    if (!([self allDiff:array])) {
        return NO;
    }
    
    if (!([self.deck.outlineColors containsObject:[array objectAtIndex:0]] || [self.deck.outlineColors containsObject:[array objectAtIndex:1]] || [self.deck.outlineColors containsObject:[array objectAtIndex:2]])) {
        return NO;
    }
    
    if (!([self.deck.shadedColors containsObject:[array objectAtIndex:0]] || [self.deck.shadedColors containsObject:[array objectAtIndex:1]] || [self.deck.shadedColors containsObject:[array objectAtIndex:2]])) {
        return NO;
    }
    return YES;
    
}

-(BOOL)allSameShading:(NSArray *)array {
    if ([self allSame:array]) {
        return YES;
    }
    if ([self.deck.outlineColors containsObject:[array objectAtIndex:0]] && [self.deck.outlineColors containsObject:[array objectAtIndex:1]] && [self.deck.outlineColors containsObject:[array objectAtIndex:2]]) {
        return YES;
    }
    if ([self.deck.shadedColors containsObject:[array objectAtIndex:0]] && [self.deck.shadedColors containsObject:[array objectAtIndex:1]] && [self.deck.shadedColors containsObject:[array objectAtIndex:2]]) {
        return YES;
    }
    return NO;
}

-(NSMutableArray*)setsLeft {
    BOOL verdict = NO;
    NSMutableArray *potentialSet = [[NSMutableArray alloc] init];
    for (UIButton *button1 in [self dealtCards]) {
        for (UIButton *button2 in [self dealtCards]) {
            for (UIButton *button3 in self.dealtCards) {
                if (!verdict && (![button1 isEqual:button2] || ![button1 isEqual:button3] || ![button2 isEqual:button3])) {
                    [potentialSet removeAllObjects];
                    [potentialSet addObject:button1];
                    [potentialSet addObject:button2];
                    [potentialSet addObject:button3];
                    verdict = [self isSet:potentialSet];
                }
            }
        }
    }
    if (verdict) {
        return potentialSet;
    } else {
        return nil;
    }
}

- (IBAction)pause:(id)sender {
    self.timerPaused = YES;
    //pause timer
    self.alert = [[UIAlertView alloc] initWithTitle:@"Paused" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Menu", @"Resume", nil]; //direct buttons to correlated screens, maybe add a see high scores function
    [self.alert show];
}

-(void) timerRun {
    if (!self.timerPaused) {
        secondsCount = secondsCount - 1;
        int minutes = secondsCount/60;
        int seconds = secondsCount - (minutes * 60);
    
        NSString *timerOutput = [NSString stringWithFormat:@"%2d:%.2d", minutes, seconds];
        countdownLabel.text = timerOutput;
    
        if (secondsCount == 0){
            [countdownTimer invalidate];
            countdownTimer = nil;
            [self endGameWithAlert];
        }
    }
}

-(void) setTimer {
    secondsCount = 300; // 5 min
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"PUZZLE"]) {
        self.timerMode = NO;
    } else if ([title isEqualToString:@"SPEED"]) {
        [countdownLabel setText:@"5:00"];
        self.timerMode = YES;
        self.timerPaused = NO;
        [self setTimer];
    } else if([title isEqualToString:@"Menu"])
    {
        [self performSegueWithIdentifier:@"menu" sender:self];
    } else if ([title isEqualToString:@"Resume"]){
        //start timer
        self.timerPaused = NO;
    } else {
        [self viewDidLoad];
    }

    [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end