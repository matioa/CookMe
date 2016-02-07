//
//  Meal.h
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARecipe : NSObject

@property (strong,nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *ingredients;

@property (strong,nonatomic) NSString *image;

@property (strong, nonatomic) NSString *mealId;

-(instancetype) initWithName: (NSString*) name
                 ingredients: (NSArray*) ingredients
                       image: (NSString*) image
                   andMealId: (NSString*) mealId;

+(MARecipe*) mealWithName: (NSString*) name
              ingredients: (NSArray*) ingredients
                    image: (NSString*) image
                andMealId: (NSString*) mealId;

+(MARecipe*) mealWithDict: (NSDictionary*) dict;

@end
