//
//  ViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/3/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "IngredientsTableViewController.h"

@interface IngredientsTableViewController()
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation IngredientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Ingredients list";
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Navigation button -Add
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.ingredientsAvailable = [NSMutableArray arrayWithArray:[delegate.data ingredients]];
    //    self.tableView.dataSource = self;
    
    if (self.ingredientsAvailable.count == 0) {
        [Notifications notifyWithMessage:@"Start by entering ingredients" delay:2 andNavigationController:self.navigationController.view];
    }

    
    //Gesture - Swipe Left
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    //Gesture - Swipe Right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    //Gesture - Double tap
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add ingredient"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter ingredient name";
    }];
    
    UIAlertAction* add = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                          {
                              
                              UITextField *temp = alert.textFields.firstObject;
                              @try
                              {
                                  MAIngredient *newIngredient =[MAIngredient ingredientWithName: temp.text];
                                  int iterations = self.ingredientsAvailable.count;
                                  for (int i=0; i<iterations; i++) {
                                      NSString *name = [[self.ingredientsAvailable objectAtIndex:i] name];
                                      NSString *newName = temp.text;
                                      if ([name isEqual:newName]) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ already exists", newIngredient.name] delay:1
                                                       andNavigationController:self.navigationController.view];
                                          });
                                          return;
                                      }
                                  }
                                  
                                  AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                                  [delegate.data addIngredient:newIngredient];
                                  [self.ingredientsAvailable addObject:newIngredient];
                                  [self.tableView reloadData];
                                  
                                  [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ added", temp.text] delay:1
                                           andNavigationController:self.navigationController.view];
                                  
                                  //Check the validity of the entered ingredient
                                  MAHttpRequest *httpRequest = [[MAHttpRequest alloc] init];
                                  
                                  [httpRequest checkIngredientValidity:temp.text withCompletionHandler:^(BOOL result) {
                                      if (result == NO) {
                                          [delegate.data removeIngredientAtIndex:self.ingredientsAvailable.count-1];
                                          [self.ingredientsAvailable removeLastObject];
                                          
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ is not an ingredient", temp.text] delay:3
                                                       andNavigationController:self.navigationController.view];
                                              [self.tableVIew reloadData];
                                          });
                                      }
                                  }];
                                  
                              }
                              @catch(NSException *exception) {
                                  [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@", exception.reason] delay:3
                                           andNavigationController:self.navigationController.view];
                                  return;
                              }
                          }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:cancel];
    [alert addAction:add];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentity";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.ingredientsAvailable[indexPath.row] name];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ingredientsAvailable.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        long num = indexPath.row;
        NSString *ingredientName = [self.ingredientsAvailable[indexPath.row] name];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.data removeIngredientAtIndex:num];
        [self.ingredientsAvailable removeObjectAtIndex:num];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ deleted", ingredientName] delay:1  andNavigationController:self.navigationController.view];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Gestures
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

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self insertNewObject];
    }
}

@end
