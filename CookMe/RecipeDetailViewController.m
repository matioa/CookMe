//
//  RecipeDetailViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/6/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

@synthesize recipeName;
@synthesize recipeImage;
@synthesize recipeIngredients;
@synthesize recipeServe;
@synthesize name;
@synthesize imageUrl;
@synthesize ingredients;
@synthesize serves;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recipeName.text = self.name;
    self.recipeIngredients.text = self.ingredients;
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
