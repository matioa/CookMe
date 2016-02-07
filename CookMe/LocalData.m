//
//  LocalData.m
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "LocalData.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "MAIngredient.h"

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
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredients" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    // Fetch the records and handle an error
    NSError *error;
    self._ingredients = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (!self._ingredients) {
        // This is a serious error
        // Handle accordingly
        NSLog(@"Failed to load ingredients from disk");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i=0; i<self._ingredients.count; i++) {
            MAIngredient *newIngredient = [MAIngredient ingredientWithName:[self._ingredients[i] name]];
            [self addIngredientToArray:newIngredient.name];
        }
    });
    
    return self;
}

-(NSArray*) ingredients
{
    return [NSArray arrayWithArray:self._ingredients];
}

-(void) addIngredient: (MAIngredient *) ingredient
{
    [self._ingredients  addObject:ingredient];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addIngredientToArray:ingredient.name];
    });
    
    
    //Store to Core Data
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSManagedObject *ingredientObject = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredients" inManagedObjectContext:moc];
    
    [ingredientObject setValue:ingredient.name forKey:@"name"];
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error saving : %@", [error localizedDescription]);
    }
}

-(void) removeIngredientAtIndex: (long) index
{
    MAIngredient *ingredientToRemove = [self._ingredients objectAtIndex:index];
    [self._ingredients  removeObjectAtIndex:index];
    NSString *name = [ingredientToRemove name];
    [self removeIngredientFromArray:name];
    
    
    //Delete from Core Data
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredients" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSPredicate *p=[NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:p];
    
    NSError *fetchError;
    NSArray *fetchedProducts=[moc executeFetchRequest:request error:&fetchError];
    
    for (NSManagedObject *product in fetchedProducts) {
        [moc deleteObject:product];
    }
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error saving : %@", [error localizedDescription]);
    }
}

-(void) addIngredientToArray: (NSString *) ingredientName
{
    NSMutableArray *singleIngredientCombination = [NSMutableArray array];
    [singleIngredientCombination addObject:ingredientName];
    [self._ingredientsCombinations addObject:singleIngredientCombination];
    
    unsigned long iterations = self._ingredientsCombinations.count-1;
    for (int i=0; i<iterations; i++) {
        NSMutableArray *newCombination = [NSMutableArray arrayWithArray:self._ingredientsCombinations[i]];
        [newCombination addObject:ingredientName];
        [self._ingredientsCombinations addObject:newCombination];
    }
    
    NSLog(@"%@",self._ingredientsCombinations);
}

-(void) removeIngredientFromArray:(NSString *) ingredientName
{
    for (int i=0; i<self._ingredientsCombinations.count; i++) {
        if ([self._ingredientsCombinations[i] containsObject:ingredientName]) {
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
