//
//  MealsViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "MealsViewController.h"
#import "MAMeal.h"
#import "MAHttpRequest.h"

@interface MealsViewController ()

@end

@implementation MealsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Meals";
    
    [self getMeals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getMeals{
    NSString *urlStr =@"https://api.edamam.com/search?q=chicken&app_id=a59f1e83&app_key=a5564ce4d5d3669027e28477164dd0ef";
    
    MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
    
    [httpRequest getRequest:urlStr withCompletionHandler:^(NSDictionary * _Nullable dict) {
        NSArray *mealsDicts = [dict objectForKey:@"hits"];
        NSMutableArray *meals = [NSMutableArray array];
        
        for(int i = 0; i< mealsDicts.count; i++){
            NSDictionary *singleMealDict = [mealsDicts objectAtIndex:i];
            MAMeal *meal = [MAMeal mealWithDict:singleMealDict];
            [meals addObject:meal];
            NSLog(@"Meal Name: %@",meal.name);
        }

    }];
    
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
