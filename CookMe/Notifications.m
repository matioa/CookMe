//
//  Notifications.m
//  CookMe
//
//  Created by BackendServTestUser on 2/4/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "Notifications.h"

@implementation Notifications

+(void) notifyWithMessage:(NSString *)message
                    delay:(float) delay
  andNavigationController:(UIView *)controller
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
}

@end
