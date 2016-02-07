//
//  Meal.m
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "MARecipe.h"

@implementation MARecipe

-(instancetype) initWithName: (NSString*) name
                     shareAs: (NSString*) shareAs
                      source: (NSString*) source
                    calories: (double) calories
                       yield: (int) yield
                   recipeUrl: (NSString*) recipeUrl
                 ingredients: (NSArray*) ingredients
                       image: (NSString*) image
                   andMealId:(NSString*) mealId
{
    if(self = [super init]){
        self.name = name;
        self.shareAs = shareAs;
        self.source = source;
        self.calories = calories;
        self.yield = yield;
        self.recipeUrl = recipeUrl;
        self.ingredients = [NSArray arrayWithArray:ingredients];
        self.image = image;
        self.mealId = mealId;
    }
    
    return self;
}

+(MARecipe*) recipeWithName: (NSString*) name
                    shareAs: (NSString*) shareAs
                     source: (NSString*) source
                   calories: (double) calories
                      yield: (int) yield
                  recipeUrl: (NSString*) recipeUrl
                ingredients: (NSArray*) ingredients
                      image: (NSString*) image
                  andMealId:(NSString*) mealId
{
    return [[MARecipe alloc] initWithName:name
                                  shareAs:shareAs
                                   source:source
                                 calories:calories
                                    yield:yield
                                recipeUrl:recipeUrl
                              ingredients:ingredients
                                    image:image
                                andMealId:mealId];
}

+(MARecipe*) recipeWithDict: (NSDictionary*) dict
{
    NSString *name = [([dict objectForKey:@"recipe"]) objectForKey:@"label"];
    NSString *shareAs = [([dict objectForKey:@"recipe"]) objectForKey:@"shareAs"];
    NSString *source = [([dict objectForKey:@"recipe"]) objectForKey:@"source"];
    int calories = [[([dict objectForKey:@"recipe"]) objectForKey:@"calories"] integerValue];
    int yield = [[([dict objectForKey:@"recipe"]) objectForKey:@"yield"] integerValue];
    NSString *recipeUrl = [([dict objectForKey:@"recipe"]) objectForKey:@"url"];
    NSArray *ingredients = [([dict objectForKey:@"recipe"]) objectForKey:@"ingredientLines"];
    NSString *image = [([dict objectForKey:@"recipe"]) objectForKey:@"image"];
    NSString *mealId = [([dict objectForKey:@"recipe"]) objectForKey:@"uri"];
    
    return [MARecipe recipeWithName:name shareAs:shareAs source:source calories:calories yield:yield recipeUrl:recipeUrl ingredients:ingredients image:image andMealId:mealId];
}

+(MARecipe*) recipeWithDictFromId: (NSDictionary*) dict
{
    NSString *name = [dict objectForKey:@"label"];
    NSString *shareAs = [dict objectForKey:@"shareAs"];
    NSString *source = [dict objectForKey:@"source"];
    int calories = [[dict objectForKey:@"calories"] integerValue];
    int yield = [[dict objectForKey:@"yield"] integerValue];
    NSString *recipeUrl = [dict objectForKey:@"url"];
    NSArray *ingredients = [dict objectForKey:@"ingredientLines"];
    NSString *image = [dict objectForKey:@"image"];
    NSString *mealId = [dict objectForKey:@"uri"];
    
    return [MARecipe recipeWithName:name shareAs:shareAs source:source calories:calories yield:yield recipeUrl:recipeUrl ingredients:ingredients image:image andMealId:mealId];
}

@end
