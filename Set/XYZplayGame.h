//
//  XYZplayGame.h
//  Set
//
//  Created by Yael Goldstein on 4/8/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZplayGame : UIViewController <UIAlertViewDelegate>


{
    IBOutlet UILabel *countdownLabel;
    NSTimer *countdownTimer;
    int secondsCount;

}
//-(IBAction) showAlert:(id)sender;



@end
