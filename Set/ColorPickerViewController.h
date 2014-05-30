//
//  ColorPickerViewController.h
//  CardGame
//
//  Created by Austin Jacobs on 5/1/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBColorPicker.h"

@interface ColorPickerViewController : UIViewController <VBColorPickerDelegate>

@property (weak, nonatomic) IBOutlet VBColorPicker *colorPicker;

@property (nonatomic) UIColor *colorToReplace;
@property (nonatomic) NSMutableArray *chosenSymbols;
@property (nonatomic) NSMutableArray *chosenColors;


@property(nonatomic) NSMutableArray * outlineColors;
@property(nonatomic) NSMutableArray * shadedColors;

@end