//
//  MealsViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeTableViewCell.h"

@interface RecipeViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mealTableView;

@end
