//
//  ColorPickerViewController.m
//  CardGame
//
//  Created by Austin Jacobs on 5/1/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "VBColorPicker.h"
#import "SetCard.h"

@interface ColorPickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *outlinedSample;
@property (weak, nonatomic) IBOutlet UILabel *shadedSample;
@property (weak, nonatomic) IBOutlet UILabel *solidSample;
@property (nonatomic) NSUserDefaults *defaults;

@end

@implementation ColorPickerViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.colorToReplace = [UIColor blueColor];
    self.defaults = [NSUserDefaults standardUserDefaults];
    UIColor *color = [self.colorToReplace copy];
    
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    CGFloat red     = colors[0];
    CGFloat green = colors[1];
    CGFloat blue   = colors[2];
    
    NSString *stringTitle1 = [self.solidSample text];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:stringTitle1];
    [string1 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle1.length)];
    [self.solidSample setAttributedText:string1];
    
    
    NSString *stringTitle2 = [self.shadedSample text];
    UIColor *shadedColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:0.3];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:stringTitle2];
    [string2 addAttribute:NSForegroundColorAttributeName value:shadedColor range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle2.length)];
    [self.shadedSample setAttributedText:string2];
    
    
    NSString *stringTitle3 = [self.outlinedSample text];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:stringTitle3];
    [string3 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle3.length)];
    [self.outlinedSample setAttributedText:string3];
    //[self.navigationController.navigationBar ]
    
    // Do any additional setup after loading the view, typically from a nib.
}

// set color from picker
- (void) pickedColor:(UIColor *)color {
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    CGFloat red     = colors[0];
    CGFloat green = colors[1];
    CGFloat blue   = colors[2];
    //CGFloat alpha = colors[3];
    
    NSString *stringTitle1 = [self.solidSample text];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:stringTitle1];
    [string1 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle1.length)];
    [string1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle1.length)];
    [self.solidSample setAttributedText:string1];
    
    
    NSString *stringTitle2 = [self.shadedSample text];
    UIColor *shadedColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:0.3];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:stringTitle2];
    [string2 addAttribute:NSForegroundColorAttributeName value:shadedColor range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle2.length)];
    [string2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle2.length)];
    [self.shadedSample setAttributedText:string2];
    
    
    NSString *stringTitle3 = [self.outlinedSample text];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:stringTitle3];
    [string3 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, stringTitle3.length)];
    [string3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60]  range:NSMakeRange(0, stringTitle3.length)];
    [self.outlinedSample setAttributedText:string3];
    
    
}


//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
////    if (![_cPicker isHidden]) {
////        [_cPicker hidePicker];
////    }
//}

// show picker by double touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.colorPicker touchesBegan:touches withEvent:event];
    [self.colorPicker touchesMoved:touches withEvent:event];
    [self.colorPicker touchesEnded:touches withEvent:event];
    [self pickedColor:self.colorPicker.lastSelectedColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (IBAction)saveNewColors:(id)sender {
    //pickedColors = color, shaded color
    UIColor *color = [[self.solidSample attributedText] attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
    UIColor *shadedColor = [[self.shadedSample attributedText] attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
    NSArray *pickedColors = @[color,shadedColor];
    
    self.chosenColors = [self addChosenValues:[self.defaults objectForKey:@"chosenColors"]];
    NSLog(@"Colors: %@", self.chosenColors); //nothing in colors - problem w/ NSUserDefaults
    self.outlineColors = [self addChosenValues:[self.defaults objectForKey:@"outlineColors"]];
    self.shadedColors = [self addChosenValues:[self.defaults objectForKey:@"shadedColors"]];
    
    self.chosenColors = [self unarchiveArray:self.chosenColors];
    self.shadedColors = [self unarchiveArray:self.shadedColors];
    self.outlineColors = [self unarchiveArray:self.outlineColors];
    
    ////////
    [self addValidColors:pickedColors inPlaceOf:self.colorToReplace];
    [self updateOutlineAndShadedColors];
    [self.defaults setObject:[self archiveArray:self.chosenColors] forKey:@"chosenColors"];
    [self.defaults setObject:[self archiveArray:self.outlineColors] forKey:@"outlineColors"];
    [self.defaults setObject:[self archiveArray:self.shadedColors]forKey:@"shadedColors"];
}

-(NSMutableArray*)addChosenValues:(NSArray*)defaultList {
    NSLog(@"Num: %d", [defaultList count]);
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if ([defaultList count] > 3) {
        for (int i = [defaultList count]-1; i>[defaultList count]-4; i--) {
            [array addObject:[defaultList objectAtIndex:i]];
        }
    }
    return array;
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

-(void)addValidColors:(NSArray *)colors inPlaceOf:(UIColor *)replacedColor{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    const CGFloat* colorComp = CGColorGetComponents(replacedColor.CGColor);
    //////
    CGFloat red     = colorComp[0];
    CGFloat green = colorComp[1];
    CGFloat blue   = colorComp[2];
    UIColor *shadedReplacedColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.3];
    
    for (UIColor *color in self.chosenColors) {
        if ([color isEqual:replacedColor]) {
            [copy addObject:[colors objectAtIndex:0]];
        } else if ([color isEqual:shadedReplacedColor]){
            [copy addObject:[colors objectAtIndex:1]];
        } else {
            [copy addObject:color];
        }
    }
    self.chosenColors = copy;
}

-(void)updateOutlineAndShadedColors{
    [self.shadedColors removeAllObjects];
    [self.outlineColors removeAllObjects];
    
    for (UIColor *color in self.chosenColors) {
        const CGFloat* colors = CGColorGetComponents(color.CGColor);
        CGFloat alpha = colors[3];
        const CGFloat compare = 0.3;
        if (alpha == compare) {
            [self.shadedColors addObject:color];
        } else {
            [self.outlineColors addObject:color];
        }
    }
}

@end

