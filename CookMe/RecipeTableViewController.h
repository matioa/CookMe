//
//  MealsViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeTableViewCell.h"
#import "MARecipe.h"
#import "MAHttpRequest.h"
#import "MBPRogressHud.h"
#import "DetailsViewController.h"

@interface RecipeTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mealTableView;

@end
