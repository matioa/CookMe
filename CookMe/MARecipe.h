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
@property (strong,nonatomic) NSString *shareAs;
@property (strong,nonatomic) NSString *source;
@property double calories;
@property int yield;
@property (strong,nonatomic) NSString *recipeUrl;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong,nonatomic) NSString *image;
@property (strong, nonatomic) NSString *mealId;

-(instancetype) initWithName: (NSString*) name
                     shareAs: (NSString*) shareAs
                      source: (NSString*) source
                    calories: (double) calories
                       yield: (int) yield
                   recipeUrl: (NSString*) recipeUrl
                 ingredients: (NSArray*) ingredients
                       image: (NSString*) image
                   andMealId: (NSString*) mealId;

+(MARecipe*) recipeWithName: (NSString*) name
                    shareAs: (NSString*) shareAs
                     source: (NSString*) source
                   calories: (double) calories
                      yield: (int) yield
                  recipeUrl: (NSString*) recipeUrl
                ingredients: (NSArray*) ingredients
                      image: (NSString*) image
                  andMealId: (NSString*) mealId;

+(MARecipe*) recipeWithDict: (NSDictionary*) dict;

@end
