//
//  XYZSettings.m
//  Set
//
//  Created by Yael Goldstein on 4/7/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import "XYZSettings.h"

@implementation XYZSettings

//@property NSMutableArray *checkImageArray;

-(IBAction)Checked:(id)sender
{
    if ([checkImageView.image  isEqual: @"unchecked.png"]) {
        
        checkImageView.image = [UIImage imageNamed: @"checked.png"];
    }
    
    else {
        checkImageView.image = [UIImage imageNamed: @"unchecked.png"];
    }
//    _checkImageArray = [[NSMutableArray alloc]init];
//    _checkImageArray = [NSMutableArray arrayWithObjects:@"checked.png",@"unchecked.png" ,nil];
}



@end
