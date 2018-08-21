//
//  NotificationManager.h
//  ToDoApp
//
//  Created by GlobalLogic on 21/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@class ToDoItem;

@interface NotificationManager : NSObject<UNUserNotificationCenterDelegate>

+ (instancetype)sharedInstance;

- (void)requestAuthorization;
- (void)createNotificationWithToDoItem:(ToDoItem *)toDoItem;
- (void)removeNotificationForToDoItem:(ToDoItem *)_toDoItem;
@end
