//
//  MealTableViewCell.h
//  CookMe
//
//  Created by BackendServTestUser on 2/6/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *mealName;
@property (strong, nonatomic) IBOutlet UILabel *mealDetail;
@property (strong, nonatomic) IBOutlet UIImageView *mealImage;

@end
