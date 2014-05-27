//
//  XYZhowToPlay.h
//  Set
//
//  Created by Yael Goldstein on 4/11/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZhowToPlay : UIViewController

@property (nonatomic) NSNumber *index;
@property (nonatomic) NSArray *instructions;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
