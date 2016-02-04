//
//  ViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/3/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientsTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;

@property (strong, nonatomic) NSMutableArray *ingredientsAvailable;


@end

