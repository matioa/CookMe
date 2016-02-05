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

@property (strong, nonatomic) NSMutableArray *meals;

@end

@implementation MealsViewController

@synthesize meals;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Meals";
    meals = [NSMutableArray array];
    
    self.tableView.dataSource = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    self.navigationItem.title = @"Recipe Book";
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    [[self navigationItem] setBackBarButtonItem:backButton];

    
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
        
        for(int i = 0; i< mealsDicts.count; i++){
            NSDictionary *singleMealDict = [mealsDicts objectAtIndex:i];
            MAMeal *meal = [MAMeal mealWithDict:singleMealDict];
            [meals addObject:meal];
            NSLog(@"Meal Name: %@",meal.name);
        }
        [self.tableView reloadData];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return meals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    MAMeal *recipe = [meals objectAtIndex:indexPath.row];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:recipe.image]]];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = img;
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = recipe.name;
    
    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
    recipeDetailLabel.text = [recipe.ingredients objectAtIndex:0];
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    return cell;
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
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
