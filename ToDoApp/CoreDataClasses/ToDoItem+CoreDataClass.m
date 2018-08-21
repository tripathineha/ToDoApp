//
//  ToDoItem+CoreDataClass.m
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//
//

#import "ToDoItem+CoreDataClass.h"

@implementation ToDoItem

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setCreatedAt:[NSDate date]];
    [self setDone:false];
}

@end
