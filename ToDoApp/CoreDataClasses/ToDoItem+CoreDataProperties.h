//
//  ToDoItem+CoreDataProperties.h
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//
//

#import "ToDoItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

+ (NSFetchRequest<ToDoItem *> *)fetchRequest;

@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic) BOOL done;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *toDoAt;

@end

NS_ASSUME_NONNULL_END
