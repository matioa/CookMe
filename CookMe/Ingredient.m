//
//  Ingredient.m
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize name = _name;

-(instancetype)initWithName: (NSString *) name{
    if(self = [super init]){
        self.name = name;
    }
    
    return self;
}

+(Ingredient *) ingredientWithName: (NSString *) name{
    return [[Ingredient alloc] initWithName:name];
}

-(NSString *) name{
    return _name;
}

-(void)setName:(NSString *)name{
    _name = [name lowercaseString];
}

@end
