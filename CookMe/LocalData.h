//
//  LocalData.h
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>
# import "MAIngredient.h"

@interface LocalData : NSObject

-(NSArray*) ingredients;

-(void) addIngredient: (MAIngredient *) ingredient;

-(void) removeIngredientAtIndex: (long) index;

-(NSArray*) getIngredientCombinations;

@end
