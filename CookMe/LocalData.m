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
@property NSMutableArray *_ingredientsCombinations;

@end

@implementation LocalData

-(instancetype) init
{
    self = [super init];
    if (self) {
        self._ingredients = [NSMutableArray array];
        self._ingredientsCombinations = [NSMutableArray array];
    }
    return self;
}

-(NSArray*) ingredients
{
    return [NSArray arrayWithArray:self._ingredients];
}

-(void) addIngredient: (MAIngredient *) ingredient
{
    [self._ingredients  addObject:ingredient];
    [self addIngredientToArray:ingredient];
}

-(void) removeIngredientAtIndex: (long) index
{
    MAIngredient *ingredientToRemove = [self._ingredients objectAtIndex:index];
    [self._ingredients  removeObjectAtIndex:index];
    [self removeIngredientFromArray:ingredientToRemove];
}

-(void) addIngredientToArray: (MAIngredient *) ingredient
{
    NSMutableArray *singleIngredientCombination = [NSMutableArray array];
    [singleIngredientCombination addObject:ingredient];
    [self._ingredientsCombinations addObject:singleIngredientCombination];
    
        int iterations = self._ingredientsCombinations.count-1;
        for (int i=0; i<iterations; i++) {
            NSMutableArray *newCombination = [NSMutableArray arrayWithArray:self._ingredientsCombinations[i]];
            [newCombination addObject:ingredient];
            [self._ingredientsCombinations addObject:newCombination];
        }
    

    
    NSLog(@"%@",self._ingredientsCombinations);
}

-(void) removeIngredientFromArray:(MAIngredient *) ingredient
{
    for (int i=0; i<self._ingredientsCombinations.count; i++) {
        if ([self._ingredientsCombinations[i] containsObject:ingredient]) {
            [self._ingredientsCombinations removeObjectAtIndex:i];
            i--;
        }
    }
    NSLog(@"%@",self._ingredientsCombinations);
}

-(NSArray*) getIngredientCombinations
{
    return [NSArray arrayWithArray:self._ingredientsCombinations];
}

@end
