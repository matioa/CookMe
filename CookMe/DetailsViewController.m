//
//  DetailsViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/6/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize recipeName;
@synthesize recipeIngredients;
@synthesize recipeImage;

@synthesize name;
@synthesize ingredients;
@synthesize imageUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Recipe detials";
    self.recipeName.text = self.name;
    self.recipeIngredients.text = self.ingredients;
    
    NSURL *url = [NSURL URLWithString:self.imageUrl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.recipeImage.image = image;
                });
            }
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
