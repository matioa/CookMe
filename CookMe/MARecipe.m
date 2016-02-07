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
                 ingredients: (NSArray*) ingredients
                       image: (NSString*) image
                   andMealId:(NSString*) mealId
{
    if(self = [super init]){
        self.name = name;
        self.ingredients = [NSArray arrayWithArray:ingredients];
        self.image = image;
        self.mealId = mealId;
    }
    return self;
}

+(MARecipe*) mealWithName: (NSString*) name
              ingredients: (NSArray*) ingredients
                    image: (NSString*) image
                andMealId:(NSString*) mealId
{
    return [[MARecipe alloc] initWithName:name ingredients:ingredients image:image andMealId:mealId];
}

+(MARecipe*) mealWithDict: (NSDictionary*) dict
{
    NSString *name = [([dict objectForKey:@"recipe"]) objectForKey:@"label"];
    NSString *image = [([dict objectForKey:@"recipe"]) objectForKey:@"image"];
    NSString *mealId = [([dict objectForKey:@"recipe"]) objectForKey:@"uri"];
    NSArray *ingredients = [([dict objectForKey:@"recipe"]) objectForKey:@"ingredientLines"];
    
    return [[MARecipe alloc] initWithName:name ingredients:ingredients image:image andMealId:mealId];
}

@end
