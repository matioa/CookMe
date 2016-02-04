//
//  LocalData.m
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "LocalData.h"

@interface LocalData()

@property NSMutableArray *_ingredients;

@end

@implementation LocalData

-(instancetype) init{
    self = [super init];
    if (self) {
        self._ingredients = [NSMutableArray array];
    }
    return self;
}

-(NSArray*) ingredients{
    return [NSArray arrayWithArray:self._ingredients];
}

-(void) addIngredient: (Ingredient *) ingredient{
    [self._ingredients  addObject:ingredient];
}

-(void) removeIngredientAtIndex: (long) index{
    [self._ingredients  removeObjectAtIndex:index];
}

@end
