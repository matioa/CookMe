//
//  LocalData.h
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>
# import "Ingredient.h"

@interface LocalData : NSObject

-(NSArray*) ingredients;

-(void) addIngredient: (Ingredient *) ingredient;

-(void) removeIngredientAtIndex: (long) index;

@end
