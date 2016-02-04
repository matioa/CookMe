//
//  Notifications.h
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBPRogressHud.h"

@interface Notifications : UINavigationController

+(void) notifyWithMessage: (NSString*) message andNavigationController:(UIView*) controller;

@end
