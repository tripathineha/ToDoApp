//
//  DataManager.h
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ToDoItem+CoreDataClass.h"

@interface DataManager : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;

- (void)saveContext;
- (void)deleteToDoItem:(ToDoItem *)toDoItem;

@end
