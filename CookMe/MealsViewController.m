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
#import "MBPRogressHud.h"

@interface MealsViewController ()

@property (strong, nonatomic) NSMutableArray *meals;
@property (nonatomic, strong) MBProgressHUD *hud;
@property int index;

@end

@implementation MealsViewController

@synthesize meals;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Recipe suggestions";
    self.meals = [NSMutableArray array];
    
    self.mealTableView.dataSource = self;
    [self.mealTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.index = 0;
    
    [self getMealsFrom:self.index andTo:self.index+20];
    self.index +=20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getMealsFrom: (int) from andTo: (int) to{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading...";
    
    
    NSString *urlStr = [MAHttpRequest urlStringWithQuery:@"chicken" from:from andTo:to];
    MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
    
    [httpRequest getRequest:urlStr withCompletionHandler:^(NSDictionary * _Nullable dict) {
        NSArray *mealsDicts = [dict objectForKey:@"hits"];
        
        for(int i = 0; i< mealsDicts.count; i++){
            NSDictionary *singleMealDict = [mealsDicts objectAtIndex:i];
            MAMeal *meal = [MAMeal mealWithDict:singleMealDict];
            [meals addObject:meal];
            NSLog(@"Meal Name: %@",meal.name);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.hud.isHidden) {
                [self.hud hide:YES];
            }

            [self.mealTableView reloadData];
        });
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *moreCellId = @"moreCell";
    MAMeal *recipe = [self.meals objectAtIndex:indexPath.row];
    
    MealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MealTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.mealName.text = recipe.name;
        cell.mealDetail.text = [recipe.ingredients objectAtIndex:0];
    }
    
    cell.mealName.text = recipe.name;
    cell.mealDetail.text = [recipe.ingredients objectAtIndex:0];
    cell.mealImage.image = nil;
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
   
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    NSURL *url = [NSURL URLWithString:recipe.image];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    MealTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.mealImage.image = image;
                });
            }
        }
    }];
    [task resume];
    
    if (indexPath.row >= self.index-3) {
        [self getMealsFrom:self.index andTo:self.index+20];
        self.index +=20;
    }
    
    return cell;
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"images/cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"images/cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"images/cell_middle.png"];
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
