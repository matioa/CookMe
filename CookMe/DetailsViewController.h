//
//  DetailsViewController.h
//  CookMe
//
//  Created by BackendServTestUser on 2/6/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalData.h"
#import "AppDelegate.h"
#import "Notifications.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *recipeName;
@property (strong, nonatomic) IBOutlet UITextView *recipeIngredients;
@property (strong, nonatomic) IBOutlet UIImageView *recipeImage;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ingredients;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *mealId;

@end
