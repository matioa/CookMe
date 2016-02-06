//
//  MAHttpRequest.m
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "MAHttpRequest.h"

@implementation MAHttpRequest

- (void)getRequest:(NSString *)urlStr withCompletionHandler:(void (^)(NSDictionary * __nullable dict))completionHandler
{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        completionHandler(dict);
        
    }]
     resume];

}

+(NSString*)urlStringWithQuery: (NSString*)query
                             from:(int) from
                            andTo:(int) to
{
    NSString *appId = @"a59f1e83";
    NSString *appKey = @"a5564ce4d5d3669027e28477164dd0ef";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.edamam.com/search?q=%@&from=%d&to=%d&app_id=%@&app_key=%@", query, from, to, appId, appKey];
    
    return urlStr;
}

-(void) checkIngredientValidity:(NSString *)ingredientName withCompletionHandler:(void (^)(BOOL result))completionHandler
{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.edamam.com/search?q=%@", ingredientName];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        
        int resultCount = [[dict objectForKey:@"count"] intValue];
        NSLog(@"Number of results: %d", resultCount);
        
        if (resultCount == 0) {
            completionHandler(NO);
            return;
        }else{
            completionHandler(YES);
        }
      
//      
//        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//            
//            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
//            
//            if (statusCode != 200) {
//                NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
//                completionHandler(NO);
//                return;
//            }else{
//                NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
//                completionHandler(YES);
//            }
//        }
        
    }]
     resume];
    
}

//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//            return;
//        }
//
//        //Check the status code of the response
//        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//
//            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
//
//            if (statusCode != 200) {
//                NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
//                return;
//            }else{
//                NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
//            }
//        }
//
//        //Convert data to dictionary
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
//                                                             options:nil
//                                                               error:nil];
//        NSArray *mealsDicts = [dict objectForKey:@"hits"];
//        NSMutableArray *meals = [NSMutableArray array];
//
//        for(int i = 0; i< mealsDicts.count; i++){
//            NSDictionary *singleMealDict = [mealsDicts objectAtIndex:i];
//            MAMeal *meal = [MAMeal mealWithDict:singleMealDict];
//            [meals addObject:meal];
//                    NSLog(@"Meal Name: %@",meal.name);
//        }
//
//    }]
//     resume];

@end
