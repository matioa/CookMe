//
//  MealsViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "RecipeTableViewController.h"

@interface RecipeTableViewController ()
@property (strong, nonatomic) NSMutableArray *meals;
@property (nonatomic, strong) MBProgressHUD *hud;
@property int index;
@property (nonatomic,strong) UILongPressGestureRecognizer *lpgr;
@property (strong,nonatomic) NSMutableArray *searchCombinations;
@property int combinationIndex;
@end

@implementation RecipeTableViewController

@synthesize meals;

-(void)viewWillAppear:(BOOL)animated{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.searchCombinations = [NSMutableArray arrayWithArray:[delegate.data getIngredientCombinations]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Recipe suggestions";
    
    UIBarButtonItem *newSuggestion = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(makeNewSuggestion)];
    self.navigationItem.rightBarButtonItem = newSuggestion;
    
    self.meals = [NSMutableArray array];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.searchCombinations = [NSMutableArray arrayWithArray:[delegate.data getIngredientCombinations]];
    self.combinationIndex = 0;
    
    self.mealTableView.dataSource = self;
    [self.mealTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.index = 0;
    
    [self getMealsFrom:self.index andTo:self.index+20];
    self.index +=20;
    

    
    //Long press Gesture
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.5; //seconds
    lpgr.delegate = self;
    [self.mealTableView addGestureRecognizer:lpgr];
    
    //Swipe Left Gesture
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    //Swipe Rigth Gesture
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getMealsFrom: (int) from andTo: (int) to{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading...";
    
    NSArray *searchArray =[self.searchCombinations objectAtIndex:self.combinationIndex];
    NSString *searchString = [[searchArray valueForKey:@"description"] componentsJoinedByString:@","];
    NSString *urlStr = [MAHttpRequest urlStringWithQuery:searchString from:from andTo:to];
    MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
    
    [httpRequest getRequest:urlStr withCompletionHandler:^(NSDictionary * _Nullable dict) {
        NSArray *mealsDicts = [dict objectForKey:@"hits"];
        
        for(int i = 0; i< mealsDicts.count; i++){
            NSDictionary *singleMealDict = [mealsDicts objectAtIndex:i];
            MARecipe *meal = [MARecipe recipeWithDict:singleMealDict];
            [meals addObject:meal];
            NSLog(@"Recipe name: %@",meal.name);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.hud.isHidden) {
                [self.hud hide:YES];
            }
            
            [self.mealTableView reloadData];
        });
    }];
}

- (void)makeNewSuggestion {
    int cases = self.searchCombinations.count;
    int currentCase = self.combinationIndex;
    int nextCase = (currentCase+1) % cases;
    NSLog(@"Index: %d",nextCase);
        self.combinationIndex = nextCase;
    [self.meals removeAllObjects];
        [self getMealsFrom:self.index andTo:self.index+20];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MARecipe *recipe = [self.meals objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[RecipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
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
    
    if (indexPath.row >= self.index-5) {
        [self getMealsFrom:self.index+1 andTo:self.index+20];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = [self.mealTableView indexPathForSelectedRow];
        
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.name = [[self.meals objectAtIndex:indexPath.row] name];
        
        NSArray *ingredientsArray = [[self.meals objectAtIndex:indexPath.row] ingredients];
        NSString *ingredientsString = [[ingredientsArray valueForKey:@"description" ] componentsJoinedByString:@"\n"];
        destViewController.ingredients = ingredientsString;
        NSString *url =[[self.meals objectAtIndex:indexPath.row] image];
        destViewController.imageUrl = url;
        NSString *mealId =[[self.meals objectAtIndex:indexPath.row] mealId];
        destViewController.mealId = mealId;
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:destViewController action:@selector(addToFavorites:)];
        destViewController.self.navigationItem.rightBarButtonItem = addButton;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.mealTableView];
    NSIndexPath *indexPath = [self.mealTableView indexPathForRowAtPoint:p];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long press on table view at row %ld", indexPath.row);
        NSString *wrongUrl = [[self.meals objectAtIndex:indexPath.row] mealId];
        NSString *correctedUrl = [wrongUrl stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.data addToFavorite:correctedUrl];
        NSLog(@"added to favorites");
        [Notifications notifyWithMessage:@"Recipe added to favorites" delay:1 andNavigationController:self.navigationController.view];
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
