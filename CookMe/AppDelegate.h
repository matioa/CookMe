//
//  AppDelegate.h
//  CookMe
//
//  Created by BackendServTestUser on 2/3/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) LocalData *data;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

