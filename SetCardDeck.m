//
//  SetCardDeck.m
//  CardGame
//
//  Created by Austin Jacobs on 4/2/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init{
    self = [super init];
    //[self setUpDefaults];
    [self initDefaults];
    self.outlineColors = [NSMutableArray arrayWithArray:@[[UIColor orangeColor], [UIColor blueColor], [UIColor purpleColor]]];
    self.shadedColors = [NSMutableArray arrayWithArray:@[[self shadedColorFrom:[UIColor orangeColor]], [self shadedColorFrom:[UIColor blueColor]], [self shadedColorFrom:[UIColor purpleColor]]]];
    self.chosenColors = [NSMutableArray arrayWithArray:@[[UIColor orangeColor], [UIColor blueColor], [UIColor purpleColor], [self shadedColorFrom:[UIColor orangeColor]], [self shadedColorFrom:[UIColor blueColor]], [self shadedColorFrom:[UIColor purpleColor]]]];
    if (self) {
        for (UIColor *color in self.chosenColors) {
            //UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            for (NSString *symbol in self.chosenSymbols) {
                for (int number = 1; number < 4; number++) {
                    SetCard *card = [[SetCard alloc]init];
                    card.number = [NSNumber numberWithInt:number];
                    card.symbol = symbol;
                    card.color = color;
                    card.outlineColor = color;
                    [self addCard:card];
                }
            }
        }
        
        for (UIColor *color in self.outlineColors) {
            //UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            for (NSString *symbol in self.chosenSymbols) {
                for (int number = 1; number < 4; number++) {
                    SetCard *card = [[SetCard alloc]init];
                    card.number = [NSNumber numberWithInt:number];
                    card.symbol = symbol;
                    card.color = [UIColor whiteColor];
                    card.outlineColor = color;
                    [self addCard:card];
                }
            }
        }
        
        for (SetCard *card in [self deck]) {
            const CGFloat* colors = CGColorGetComponents(card.color.CGColor);
            CGFloat red = colors[0];
            CGFloat green = colors[1];
            CGFloat blue = colors[2];
            CGFloat alpha = colors[3]; //doesn't work
            const CGFloat compare = 0.3;
            NSLog(@"Alpha: %f", alpha);
            if (alpha == compare) { //doesn't work
                NSLog(@"YES!!!!");
                for (UIColor *chosenColor in self.outlineColors) {
                    //UIColor *chosenColor = [NSKeyedUnarchiver unarchiveObjectWithData:chosenColorData];
                    const CGFloat* colors = CGColorGetComponents(chosenColor.CGColor);
                    CGFloat red2 = colors[0];
                    CGFloat green2 = colors[1];
                    CGFloat blue2 = colors[2];
                    if (red == red2 && green == green2 && blue == blue2) {
                        card.outlineColor = chosenColor;
                    }
                }
            }
        }
        
    }
    return self;
}

-(UIColor*)shadedColorFrom:(UIColor*)color{
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    CGFloat red = colors[0];
    CGFloat green = colors[1];
    CGFloat blue = colors[2];
    CGFloat alpha = colors[3];
    return [UIColor colorWithRed:red green:green blue:blue alpha:0.3];
}

-(NSMutableArray *)deck { //modifying getter for cards
    if(!_deck) _deck = [[NSMutableArray alloc] init]; //checks if _cards points to nil and fixes if so
    return _deck;
}

-(SetCard *)drawRandomCard { //method that picks a random card out of deck
    SetCard *randomCard = nil;
    if ([self.deck count]){
        unsigned index = arc4random() % [self.deck count]; //gets a number w/in count of deck
        randomCard = self.deck[index]; //uses random index to pick random card
        [self.deck removeObjectAtIndex: index]; //remove that card from the deck
    }
    return randomCard;
}

-(void)addCard:(SetCard *)card { //method that adds a card to the deck at the top
    [self.deck addObject: card];
}


-(void)initDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *chosen = [NSMutableArray arrayWithArray:@[[UIColor blueColor], [UIColor purpleColor], [UIColor orangeColor]]];
    chosen = [self archiveArray:chosen];
    
    [defaults setObject:chosen forKey:@"chosenColors"];
    //for each check to see if it exists in defaults or not
    //weird bc everything except symbols have nothing
    
    self.chosenColors = [self addChosenValues:[defaults objectForKey:@"chosenColors"]];
    self.chosenSymbols = [self addChosenValues:[defaults objectForKey:@"chosenSymbols"]];
    self.outlineColors = [self addChosenValues:[defaults objectForKey:@"outlineColors"]];
    self.shadedColors = [self addChosenValues:[defaults objectForKey:@"shadedColors"]];
    
    NSLog(@"Default Symbols: %@", [defaults objectForKey:@"chosenSymbols"]);
    NSLog(@"Symbols: %@", self.chosenSymbols);
    NSLog(@"Default Colors: %@", [defaults objectForKey:@"chosenColors"]);
    NSLog(@"Colors: %@", self.chosenColors);
    
    self.chosenColors = [self unencryptData:[self.chosenColors copy]];
    self.shadedColors = [self unencryptData:[self.shadedColors copy]];
    self.outlineColors = [self unencryptData:[self.outlineColors copy]];
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

-(NSMutableArray *)unencryptData:(NSMutableArray *)array{
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for (id object in array) {
        //check if it really is a nsdata
        if ([object isKindOfClass: [NSData class]]) {
            UIColor *newColor = [NSKeyedUnarchiver unarchiveObjectWithData:object];
            //[copy removeObject:object];
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

-(NSArray *)validSymbols {
    return @[@"▲", @"◼︎", @"❤︎", @"●"];
}


@end
