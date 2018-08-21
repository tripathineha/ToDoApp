//
//  ToDoItem+CoreDataProperties.m
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//
//

#import "ToDoItem+CoreDataProperties.h"

@implementation ToDoItem (CoreDataProperties)

+ (NSFetchRequest<ToDoItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ToDoItem"];
}

@dynamic createdAt;
@dynamic done;
@dynamic title;
@dynamic toDoAt;

@end
