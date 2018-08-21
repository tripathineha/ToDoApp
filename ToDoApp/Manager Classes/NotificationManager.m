//
//  NotificationManager.m
//  ToDoApp
//
//  Created by GlobalLogic on 21/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "NotificationManager.h"
#import "ToDoItem+CoreDataClass.h"
#import "NSDate+LocalizedDate.h"

@interface NotificationManager()

@property UNUserNotificationCenter* center;
- (instancetype)init;

@end

@implementation NotificationManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _center = [UNUserNotificationCenter currentNotificationCenter];
        });
    }
    return self;
}

- (void)requestAuthorization {
    [_center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (error) {
                                  NSLog(@"%@",error.localizedDescription);
                              }
                          }];
}

- (void)createNotificationWithToDoItem:(ToDoItem *)toDoItem {
    __block NSString *message = @"Not Created!";
    
    [_center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            message = @"notification_denied";
            [self requestAuthorization];
        } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
            message = @"notification_denied";
        } if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.body = toDoItem.title;
            content.badge = @1;
            content.title = NSLocalizedString(@"toDo", "");
            content.categoryIdentifier = @"GENERAL";
            
            UNNotificationAction *repeatAction = [UNNotificationAction
                                                  actionWithIdentifier:@"repeatAction"
                                                  title:@"Repeat after 5 minutes"
                                                  options:UNNotificationActionOptionAuthenticationRequired];
            UNNotificationAction *okayAction = [UNNotificationAction
                                                actionWithIdentifier:UNNotificationDismissActionIdentifier
                                                title:@"Okay"
                                                options:UNNotificationActionOptionDestructive];
            
            UNNotificationCategory* generalCategory = [UNNotificationCategory
                                                       categoryWithIdentifier:@"GENERAL"
                                                       actions:@[okayAction,
                                                                 repeatAction]
                                                       intentIdentifiers:@[]
                                                       options:UNNotificationCategoryOptionCustomDismissAction];
            
            [_center setNotificationCategories:[NSSet setWithObjects: generalCategory,
                                                nil]];
            
            UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[toDoItem.toDoAt getDateComponents]  repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:toDoItem.createdAt.description content:content trigger:trigger];
            
            [_center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@",error.localizedDescription);
                    return;
                }
                message = @"reminder_created";
                //NSLog(@"%@",message);
            }];
        }
        
    }];
     NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)removeNotificationForToDoItem:(ToDoItem *)toDoItem {
    [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:@[toDoItem.createdAt.description]];
    
}

# pragma mark - UNUSerNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    if ([response.notification.request.content.categoryIdentifier isEqualToString:@"GENERAL"]) {
        
        // Handle the actions for the expired timer.
        if ([response.actionIdentifier isEqualToString:@"repeatAction"])
        {
            [center removeAllDeliveredNotifications];
            UNNotificationContent *content = response.notification.request.content;
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:(300) repeats:NO];
            UNNotificationRequest *newRequest = [UNNotificationRequest requestWithIdentifier:@"Repeat" content:content trigger:trigger];
            [center addNotificationRequest:newRequest withCompletionHandler:nil];
             NSLog(@"RepeatAction");
            
        }
        else if ([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier])
        {
            NSLog(@"OkayAction");
        }
        
    }
    NSLog(@"%s",__PRETTY_FUNCTION__);
    completionHandler();
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
    
}
@end
