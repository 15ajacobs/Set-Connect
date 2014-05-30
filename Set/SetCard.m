//
//  SetCard.m
//  CardGame
//
//  Created by Austin Jacobs on 4/2/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(NSMutableAttributedString *)contents {
    NSString *stringTitle = @"";
    for (int i=0; i< [self.number integerValue]; i++) {
        stringTitle = [stringTitle stringByAppendingString:self.symbol];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:stringTitle];
    [string addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, stringTitle.length)];
    [string addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle.length)];
    [string addAttribute:NSStrokeColorAttributeName value:self.outlineColor range:NSMakeRange(0, stringTitle.length)];
    
    if ([self.symbol isEqualToString:@"●"]) {
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:35]  range:NSMakeRange(0, stringTitle.length)];
    } else {
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25]  range:NSMakeRange(0, stringTitle.length)];
    }
    return string;
}

@end
