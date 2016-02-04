//
//  Ingredient.h
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property NSString *name;

-(instancetype)initWithName: (NSString *) name;

+(Ingredient *) ingredientWithName: (NSString *) name;

@end
