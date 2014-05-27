//
//  XYZhowToPlay.m
//  Set
//
//  Created by Yael Goldstein on 4/11/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import "XYZhowToPlay.h"

@implementation XYZhowToPlay

-(void)viewDidLoad  {
    self.index = [NSNumber numberWithInt:0];
    [self.backButton setTitle:@"" forState:UIControlStateNormal];
    self.instructions = [NSArray arrayWithObjects:@"Each card in Set has 4 features: COLOR, SYMBOL, SHADING, and NUMBER of symbols.", @"Each feature has 3 options. For example, the SHADING of a card can be one of 3 things: solid, shaded, or outlined.", @"To make a set you must choose 3 cards in which each feature is either all the same, or all different on each card.", nil];
}

- (IBAction)next:(id)sender {
    if ([self.index integerValue] == 0) {
        [self.backButton setTitle:@"BACK" forState:UIControlStateNormal];
    }
    self.index = [NSNumber numberWithInt:[self.index integerValue] + 1];
    if ([self.index integerValue] == self.instructions.count -1) {
        [self.nextButton setTitle:@"" forState:UIControlStateNormal];
    }
    [self updateInstructions];
}


- (IBAction)back:(id)sender {
    if ([self.index integerValue] == self.instructions.count -1) {
        [self.nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
    }
    self.index = [NSNumber numberWithInt:[self.index integerValue] - 1];
    if ([self.index integerValue] == 0) {
        [self.backButton setTitle:@"" forState:UIControlStateNormal];
    }
    [self updateInstructions];
}

-(void)updateInstructions{
    [self.textField setText:[self.instructions objectAtIndex: [self.index integerValue]]];
}






@end
