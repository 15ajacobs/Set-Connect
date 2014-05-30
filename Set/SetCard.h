//
//  SetCard.h
//  CardGame
//
//  Created by Austin Jacobs on 4/2/14.
//  Copyright (c) 2014 Austin Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetCard : NSObject

@property (strong,nonatomic) NSString *symbol;
@property (nonatomic) NSNumber *number;
@property (nonatomic) UIColor *color;
@property (nonatomic) UIColor *outlineColor;
@property (nonatomic) NSMutableAttributedString *contents;

@end
