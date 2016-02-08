//
//  FavoritesTableViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/7/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "FavoritesTableViewController.h"

@interface FavoritesTableViewController ()
@property (strong, nonatomic) NSMutableArray *favoriteMealIds;
@property (strong, nonatomic) NSMutableArray *recipies;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation FavoritesTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.favoriteMealIds.count == 0) {
        [Notifications notifyWithMessage:@"No saved favorite recipe" delay:1 andNavigationController:self.navigationController.view];
    }else{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        int currentItems = self.favoriteMealIds.count;
        NSArray *items =[NSMutableArray arrayWithArray:[delegate.data favorites]];
        int totalItems = items.count;
        for (int i=currentItems+1; i<totalItems; i++) {
            [self.favoriteMealIds addObject:items[i]];
            NSString *urlStr = [MAHttpRequest urlStringWithId:[items[i] mealId]];
            MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
            [httpRequest getRequestFromId:urlStr withCompletionHandler:^(NSDictionary * _Nullable dict) {
                NSString *label = [dict objectForKey:@"label"];
                
                MARecipe *meal = [MARecipe recipeWithDictFromId:dict];
                [self.recipies addObject:meal];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mealTableView reloadData];
                });
            }];
        }
        
//        self.favoriteMealIds = [NSMutableArray arrayWithArray:[delegate.data favorites]];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favorite recipies";
    self.recipies = [NSMutableArray array];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.favoriteMealIds = [NSMutableArray arrayWithArray:[delegate.data favorites]];
    
  
    if (!self.favoriteMealIds.count==0) {
        [self getFavorites];
    }
    
    self.mealTableView.dataSource = self;
    [self.mealTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //Gestures - Swipe Left
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    //Gestures - Swipe Right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipies count];
}

-(void)getFavorites {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading...";
    
    for (int i=0; i<self.favoriteMealIds.count; i++) {
        NSString *urlStr = [MAHttpRequest urlStringWithId:[self.favoriteMealIds[i] mealId]];
        MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
        [httpRequest getRequestFromId:urlStr withCompletionHandler:^(NSDictionary * _Nullable dict) {
            NSString *label = [dict objectForKey:@"label"];

            MARecipe *meal = [MARecipe recipeWithDictFromId:dict];
            [self.recipies addObject:meal];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!self.hud.isHidden) {
                    [self.hud hide:YES];
                }
                
                [self.mealTableView reloadData];
            });
        }];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell2";
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[RecipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    MARecipe *recipe = [self.recipies objectAtIndex:indexPath.row];
    
    //Set cell title and description from array
    cell.mealName.text = recipe.name;
    cell.mealDetail.text = recipe.source;
    cell.mealCalories.text = [@(recipe.calories) stringValue];
    cell.mealServes.text = [@(recipe.yield) stringValue];
    cell.mealImage.image = nil;
    
    //Set cell background
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    //Get images with http request
    NSURL *url = [NSURL URLWithString:recipe.image];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    RecipeTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell){
                        updateCell.mealImage.image = image;
                    }
                });
            }
        }
    }];
    [task resume];
    
    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetailsFromFavorites" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailsFromFavorites"]) {
        NSIndexPath *indexPath = [self.mealTableView indexPathForSelectedRow];
        
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.name = [[self.recipies objectAtIndex:indexPath.row] name];
        
        NSArray *ingredientsArray = [[self.recipies objectAtIndex:indexPath.row] ingredients];
        NSString *ingredientsString = [[ingredientsArray valueForKey:@"description" ] componentsJoinedByString:@"\n"];
        destViewController.ingredients = ingredientsString;
        NSString *url =[[self.recipies objectAtIndex:indexPath.row] image];
        destViewController.imageUrl = url;
    }
}

- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
}

@end
