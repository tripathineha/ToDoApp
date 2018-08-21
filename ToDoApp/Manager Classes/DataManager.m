//
//  DataManager.m
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()

- (instancetype)init;

@end

@implementation DataManager

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
        @synchronized(self) {
            if (_persistentContainer == nil) {
                _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ToDoApp"];
                NSPersistentStoreDescription *description = _persistentContainer.persistentStoreDescriptions[0];
                description.shouldInferMappingModelAutomatically = YES;
                description.shouldMigrateStoreAutomatically = YES;
                _persistentContainer.persistentStoreDescriptions = @[description];
                [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
                NSPersistentStoreCoordinator *coordinator = _persistentContainer.persistentStoreCoordinator;
                
                // The main MOC initialised using the NSMainQueueConcurrencyType
                
                NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
                [context setPersistentStoreCoordinator:coordinator];
                _managedObjectContext = context;
                
            }
        }
        
    }
    
    return self;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = _managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)deleteToDoItem:(ToDoItem *)toDoItem {
    [_managedObjectContext deleteObject:toDoItem];
    [self saveContext];
}

@end
