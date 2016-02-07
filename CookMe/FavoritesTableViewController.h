//
//  FavoritesTableViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/7/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBPRogressHud.h"
#import "MAHttpRequest.h"
#import "LocalData.h"
#import "AppDelegate.h"
#import "RecipeTableViewCell.h"
#import "DetailsViewController.h"

@interface FavoritesTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mealTableView;

@end
