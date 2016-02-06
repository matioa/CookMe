//
//  Ingredient.m
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "MAIngredient.h"
#import "Validator.h"

@implementation MAIngredient

@synthesize name = _name;

-(instancetype)initWithName: (NSString *) name{
    if(self = [super init]){
        self.name = name;
    }
    
    return self;
}

+(MAIngredient *) ingredientWithName: (NSString *) name{
    return [[MAIngredient alloc] initWithName:name];
}

-(NSString *) name{
    return _name;
}

-(void)setName:(NSString *)name{
    BOOL isValid = [Validator validateStringContainsAlphabetsOnly:name];
    if (!isValid) {
        NSException* myException = [NSException
                                    exceptionWithName:@"WrongInput"
                                    reason:@"Only letters (no spaces) allowed"
                                    userInfo:nil];
        @throw myException;
    }
    if (name == nil || name.length < 4) {
        NSException* myException = [NSException
                                    exceptionWithName:@"WrongInput"
                                    reason:@"Enter at least 3 characters"
                                    userInfo:nil];
        @throw myException;
    }
    
    _name = [name lowercaseString];
}

@end
