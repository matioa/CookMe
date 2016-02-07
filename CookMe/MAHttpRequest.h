//
//  MAHttpRequest.h
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAHttpRequest : NSObject

- (void)getRequest:(NSString *)urlStr withCompletionHandler:(void (^)(NSDictionary * __nullable dict))completionHandler;

-(void) checkIngredientValidity:(NSString *)ingredientName withCompletionHandler:(void (^)(BOOL result))completionHandler;

+(NSString *)urlStringWithQuery: (NSString *)query
                           from:(int) from
                          andTo:(int) to;

+(NSString *)urlStringWithId: (NSString *)mealId;

- (void)getRequestFromId:(NSString *)urlStr withCompletionHandler:(void (^)(NSDictionary * __nullable dict))completionHandler;
@end