//
//  SettingsViewController.m
//  CardGame
//
//  Created by Austin Jacobs on 5/1/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import "SettingsViewController.h"
#import "ColorPickerViewController.h"

@interface SettingsViewController ()


@property (nonatomic) int symbolCount;
@property (weak, nonatomic) IBOutlet UIButton *triangle;
@property (weak, nonatomic) IBOutlet UIButton *square;
@property (weak, nonatomic) IBOutlet UIButton *heart;
@property (weak, nonatomic) IBOutlet UIButton *circle;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorFields;
@property (nonatomic) NSUserDefaults *defaults;

@property (nonatomic) UIColor *pickedColor;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)pickColor:(id)sender {
    UIColor *color = [sender backgroundColor];
    self.pickedColor = color;
    //ColorPickerViewController *vc = [[ColorPickerViewController alloc]init];
    //vc.colorToReplace = color;
    [self performSegueWithIdentifier:@"pickColor" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pickColor"]){
        ColorPickerViewController *controller = (ColorPickerViewController *)segue.destinationViewController;
        controller.colorToReplace = self.pickedColor;
    }
}
- (IBAction)menu:(id)sender {
    if (self.symbolCount != 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait a Minute." message:@"Please pick 3 symbols." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"menu" sender:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.symbolCount = 3;
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    //[self.defaults removeObjectForKey:@"chosenSymbols"];
    //[self.defaults setObject:@[@"▲",@"◼︎", @"❤︎"] forKey:@"chosenSymbols"];
    NSMutableArray *chosenSymbols = [self.defaults objectForKey:@"chosenSymbols"];
    NSLog(@"Symbols: %@", chosenSymbols);
    //defaults doesn't have anything in outlineColors or chosenColors
    NSMutableArray *outlineColors = [self unarchiveArray:[self.defaults objectForKey:@"outlineColors"]];
    
    UIImage *checked = [UIImage imageNamed:@"checked.png"];
    
    //only doing the last 3
    for (int i = [chosenSymbols count]-1; i > [chosenSymbols count]-4; i--) {
        id object = [chosenSymbols objectAtIndex:i];
        if ([object isEqualToString:@"▲"]) {
            [self.triangle setImage:checked forState:UIControlStateNormal];
        } else if ([object isEqualToString:@"◼︎"]) {
            [self.square setImage:checked  forState:UIControlStateNormal];
        } else if ([object isEqualToString:@"❤︎"]) {
            [self.heart setImage:checked  forState:UIControlStateNormal];
        } else if ([object isEqualToString:@"●"]) {
            [self.circle setImage:checked  forState:UIControlStateNormal];
        }
    }
    //    int count = 0;
    //    for (UIButton *button in self.colorFields) {
    //        [button setBackgroundColor:[outlineColors objectAtIndex:count]];//problem = outlineColors doesn't have anything in it
    //        count++;
    //    }
    
	// Do any additional setup after loading the view.
}

- (IBAction)symbol:(id)sender {
    BOOL checked = [self updateChecks:sender];
    
    NSString *symbol = @"";
    if ([sender isEqual:self.triangle]) {
        symbol = @"▲";
    } else if ([sender isEqual:self.square]) {
        symbol = @"◼︎";
    } else if ([sender isEqual:self.heart]) {
        symbol = @"❤︎";
    } else if ([sender isEqual:self.circle]) {
        symbol = @"●";
    }
    
    if (checked) {
        self.symbolCount++;
        [self addValidSymbol:symbol];
    } else {
        self.symbolCount--;
        [self removeValidSymbol:symbol];
    }
    
}

-(BOOL)updateChecks:(id)sender {
    if ([[sender imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"unchecked.png"]]) {
        [sender setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        return YES;
    } else {
        [sender setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        return NO;
    }
}

-(void)addValidSymbol:(NSString *)newSymbol{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *symbols = [[defaults objectForKey:@"chosenSymbols"] mutableCopy];
    //NSMutableArray *chosenSymbols = [[NSMutableArray alloc] initWithArray:symbols];
    [symbols addObject:newSymbol];
    [defaults removeObjectForKey:@"chosenSybmols"];
    [defaults setObject:symbols forKey:@"chosenSymbols"];
}

-(void)removeValidSymbol:(NSString *)symbol{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *chosenSymbols = [defaults objectForKey:@"chosenSymbols"];
    NSMutableArray *symbols = [[defaults objectForKey:@"chosenSymbols"] mutableCopy];
    //NSMutableArray *chosenSymbols = [[NSMutableArray alloc] initWithArray:symbols];
    for (id object in chosenSymbols) {
        if (![object isEqualToString:symbol]) {
            [symbols addObject:object];
        }
    }
    [defaults removeObjectForKey:@"chosenSymbols"];
    [defaults setObject:symbols forKey:@"chosenSymbols"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
}

-(NSMutableArray*)unarchiveArray:(NSMutableArray*)array{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for (id object in array) {
        if ([object isKindOfClass: [NSData class]]) {
            UIColor *newColor = [NSKeyedUnarchiver unarchiveObjectWithData:object];
            [copy addObject: newColor];
        }
    }
    return copy;
}

-(NSMutableArray*)archiveArray:(NSMutableArray*)array{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for (id object in array) {
        if ([object isKindOfClass: [NSData class]]) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
            [copy addObject: data];
        }
    }
    return copy;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
