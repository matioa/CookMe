//
//  MealTableViewCell.h
//  CookMe
//
//  Created by BackendServTestUser on 2/6/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *mealName;
@property (strong, nonatomic) IBOutlet UILabel *mealDetail;
@property (strong, nonatomic) IBOutlet UIImageView *mealImage;

@end
