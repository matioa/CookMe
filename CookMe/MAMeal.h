//
//  Meal.h
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAMeal : NSObject

@property (strong,nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *ingredients;

@property (strong,nonatomic) NSString *image;

@property (strong, nonatomic) NSString *mealId;

-(instancetype) initWithName: (NSString*) name
                 ingredients: (NSArray*) ingredients
                       image: (NSString*) image
                   andMealId:(NSString*) mealId;

+(MAMeal*) mealWithName: (NSString*) name
            ingredients: (NSArray*) ingredients
                  image: (NSString*) image
              andMealId:(NSString*) mealId;

+(MAMeal*) mealWithDict: (NSDictionary*) dict;

@end
