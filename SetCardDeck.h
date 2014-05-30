//
//  SetCardDeck.h
//  CardGame
//
//  Created by Austin Jacobs on 4/2/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCard.h"

@interface SetCardDeck : NSObject

@property (strong,nonatomic) NSMutableArray *deck;
-(SetCard *)drawRandomCard;
-(void)addCard:(SetCard *)card;




@property (nonatomic) NSMutableArray *chosenSymbols;
@property (nonatomic) NSMutableArray *chosenColors;


@property(nonatomic) NSMutableArray * outlineColors;
@property(nonatomic) NSMutableArray * shadedColors;


//+(NSArray *)defaultSymbols; // + indicates a class object/method
//+(NSArray *)defaultColors;
//+(NSArray *)defaultOutlineColors;
//+(NSArray *)defaultShadedColors;

//+(NSArray *)validSymbols;

//-(void)addValidSymbol:(NSString *)newSymbol inPlaceOf:(NSString*)symbolToReplace;
//-(void)addValidColor:(UIColor *)color inPlaceOf:(UIColor *)replacedColor;

@end
