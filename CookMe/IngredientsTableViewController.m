//
//  ViewController.m
//  CookMe
//
//  Created by BackendServTestUser on 2/3/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import "Ingredient.h"
#import "Notifications.h"
#import "LocalData.h"
#import "AppDelegate.h"


@implementation IngredientsTableViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.tableView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Ingredients list";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;


    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.ingredientsAvailable = [NSMutableArray arrayWithArray:[delegate.data ingredients]];
//    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add ingredient"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter ingredient name";
    }];
    
    UIAlertAction* add = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   UITextField *temp = alert.textFields.firstObject;
                                                   if (temp.text.length != 0) {
//                                                       
                                                       AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                                                       [delegate.data addIngredient:[Ingredient ingredientWithName:temp.text]];
                                                       [self.ingredientsAvailable addObject:[Ingredient ingredientWithName: temp.text]];
                                                       [self.tableView reloadData];
                                                       
                                                       [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ added", temp.text]
                                                                andNavigationController:self.navigationController.view];
  
                                                   }
                                               }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
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
        
        [Notifications notifyWithMessage:[NSString stringWithFormat:@"%@ deleted", ingredientName]
                 andNavigationController:self.navigationController.view];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
