//
//  VBColorPicker.h
//  CardGame
//
//  Created by Austin Jacobs on 5/1/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBColorPicker : UIImageView

@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly, retain) UIColor* lastSelectedColor;


- (void) showPicker;
- (void) hidePicker;
- (void) showPickerWithDuration:(float)duration;
- (void) hidePickerWithDuration:(float)duration;
- (void) animateColorWheelToShow:(BOOL)show duration:(float)duration;

@end


@protocol VBColorPickerDelegate <NSObject>

- (void) pickedColor:(UIColor *)color;


@end