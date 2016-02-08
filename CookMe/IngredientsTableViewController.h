//
//  ViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/3/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAIngredient.h"
#import "Notifications.h"
#import "LocalData.h"
#import "AppDelegate.h"
#import "MAHttpRequest.h"

@interface IngredientsTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong, nonatomic) NSMutableArray *ingredientsAvailable;

@end

