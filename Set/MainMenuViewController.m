//
//  MainMenuViewController.m
//  Set
//
//  Created by Kathleen Kenealy on 5/9/14.
//  Copyright (c) 2014 Yael Goldstein. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.navigationController navigationBar] removeFromSuperview];
    [self setUpDefaults];
	// Do any additional setup after loading the view.
}

-(void)setUpDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *defaultPrefsFile = [[NSBundle mainBundle]
                               URLForResource:@"defaults" withExtension:@"plist"];
    NSDictionary *defaultPrefs =
    [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    [defaults registerDefaults:defaultPrefs]; //not good
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
