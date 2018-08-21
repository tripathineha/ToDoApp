//
//  AppDelegate.m
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "NotificationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UNUserNotificationCenter.currentNotificationCenter.delegate = NotificationManager.sharedInstance;
    [NotificationManager.sharedInstance requestAuthorization];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
     [DataManager.sharedInstance saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application { 
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
    [DataManager.sharedInstance saveContext];
}

@end
