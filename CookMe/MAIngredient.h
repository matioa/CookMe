//
//  Ingredient.h
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAIngredient : NSObject

@property NSString *name;
@property BOOL *isValid;

-(instancetype)initWithName: (NSString *) name;

+(MAIngredient *) ingredientWithName: (NSString *) name;

@end
